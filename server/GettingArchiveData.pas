{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit GettingArchiveData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, bsSkinCtrls, ComCtrls, Mask, DB, bsSkinBoxCtrls,
  ExtCtrls, bsdbctrls, ZAbstractRODataset, ZDataset, DateUtils, Grids, DBGrids,
  RxMemDS, DBCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, SPData, dm_general;

type

  EGettingArchiveData = class(Exception);

  TFGettingArchiveData = class(TForm)
    BtnGetData: TBitBtn;
    dtbMeters: TZReadOnlyQuery;
    dtsMeters: TDataSource;
    dtbMetersmeter_id: TLargeintField;
    dtbMetersname: TStringField;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    SBChooserMeter: TSpeedButton;
    ChDate: TDateTimePicker;
    BitBtn7: TBitBtn;
    RbTime: TRadioButton;
    RbDay: TRadioButton;
    RbMonth: TRadioButton;
    ChTime: TDateTimePicker;
    ChDay: TDateTimePicker;
    ChMonth: TComboBox;
    EditMeter: TEdit;
    Label2: TLabel;
    LabelInfo: TLabel;
    dtbMetersdescription: TStringField;
    Panel1: TPanel;
    BtnShowLog: TBitBtn;
    procedure SBChooserMeterClick(Sender: TObject);
    procedure RbTimeClick(Sender: TObject);
    procedure RbDayClick(Sender: TObject);
    procedure RbMonthClick(Sender: TObject);
    procedure BtnGetDataClick(Sender: TObject);
    procedure BtnShowLogClick(Sender: TObject);
  private
    FChoosedMeterId : Longword;
    FIniConfig: TIniConfig;
    procedure RefreshCh;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FGettingArchiveData: TFGettingArchiveData;

implementation

uses QuerySearchList, DBdata, Log, globalvars, SPServer, ShellAPI,
  globalmethods;

{$R *.dfm}

procedure TFGettingArchiveData.BtnShowLogClick(Sender: TObject);
begin
  if Shellexecute(Handle, 'Open', PChar(GetLogFilePath), nil, nil, SW_SHOWNORMAL) <= 32 then
  begin
    MessageBeep(MB_ICONERROR);
    ShowMessage('Не удается открыть файл ' + GetLogFilePath);
  end;
end;

procedure TFGettingArchiveData.BtnGetDataClick(Sender: TObject);
var aTopicName, qStr : string;
    aSPData : TSPData;
    aRequest, aResponse : TDesParams;
    i, tryN : Integer;
    aDate, aDateTime : TDateTime;
begin
  if FChoosedMeterId = 0 then
    raise EGettingArchiveData.Create('Вы забыли указать прибор');
  WriteToLog('GETTING_THE_ARCHIVE=START');
  aRequest := UDBData.GetArrayParamsQuery(FChoosedMeterId);
  aTopicName := 'G' + FIniConfig.GetIniStr(SETTING_KEY, DDE_QUERY_TOPIC_VAL, EmptyStr);
  aSPData := TSPData.Create(aTopicName);
  try
    //disable all
    EditMeter.Enabled := False;
    SBChooserMeter.Enabled := False;
    
    ChDate.Enabled := False;
    ChTime.Enabled := False;
    ChDay.Enabled := False;
    ChMonth.Enabled := False;
    LabelInfo.Visible := True;

    tryN := FIniConfig.GetIniInt(SETTING_KEY, DDE_RELIABILITY_OF_READING_VAL, 0);
    for i := 0 to Length(aRequest) - 1 do
    begin
      if not SPServerIsRunning then
        if not StartSPServer then
          raise EGettingArchiveData.Create('Не удалось запустить СП-Сервер')
        else
          aSPData.ReConnectDde;
      if RbTime.Checked then
      begin

        // **************** ЧТЕНИЕ ЧАСОВЫХ ЗНАЧЕНИЙ ****************

        if aRequest[i].Code = ARRAY_HOUR then
        begin
          try
            aDateTime := DateOf(ChDate.DateTime) + TimeOf(ChTime.Time);
            if HourOf(aDateTime) = 0 then
              aDateTime := IncDay(aDateTime, 1);  //новые сутки
            //R(60, 13371, 28051300, 28051300, 2010, 2010)
            qStr := FormatDateTime('ddmmhh00, ddmmhh00, yyyy, yyyy', aDateTime);
            SetLength(aResponse, 0);
            aResponse := aSPData.GetArray(FChoosedMeterId, aRequest[i], qStr, tryN);
          except
            on E : Exception do
                      raise EGettingArchiveData.Create(
                        'E: Archive.GetArray() ARRAY_HOUR ' + E.Message
                      );
          end;
          if Length(aResponse) > 0 then
          try
            if HourOf(aDateTime) = 0 then
              aDateTime := IncDay(aDateTime, -1);  //новые сутки
            UDBData.WriteHourValueToArchive(
              aResponse[0].id, aResponse[0].Value, aDateTime
            );
          except
             on E : Exception do
                raise EGettingArchiveData.Create(
                  'E: Archive.WriteHour() ARRAY_HOUR ' + E.Message
                );
          end;
        end;
      end else
      if RbDay.Checked then
      begin
        try

          // **************** ЧТЕНИЕ СУТОЧНЫХ ЗНАЧЕНИЙ ****************

          if aRequest[i].Code = ARRAY_DAY then
          begin
            qStr := FormatDateTime('ddmm0000, ddmm0000, yyyy, yyyy', DateOf(ChDay.DateTime));
            SetLength(aResponse, 0);
            //R(60, 13372, 06070000, 06070000)
            aResponse := aSPData.GetArray(FChoosedMeterId, aRequest[i], qStr, tryN);
          end;
        except
          on E : Exception do
             raise EGettingArchiveData.Create('E: Archive.GetArray() ARRAY_DAY ' + E.Message);
        end;
        if Length(aResponse) > 0 then
        try
           UDBData.WriteDayValueToArchive(aResponse[0].id, aResponse[0].Value, DateOf(ChDay.DateTime));
        except
           on E : Exception do
              raise EGettingArchiveData.Create(
                'E: Archive.WriteDayArchiveValue() ARRAY_DAY ' + E.Message
              );
        end;
      end else
      if RbMonth.Checked then
      begin

        // **************** ЧТЕНИЕ МЕСЯЧНЫХ ЗНАЧЕНИЙ ****************

        if aRequest[i].Code = ARRAY_MONTH then
        begin
          try
            aDate := StartOfAMonth(YearOf(UDBData.GetServerDateTime), ChMonth.ItemIndex + 1);
            qStr := FormatDateTime('01mm0000, 01mm0000, yyyy, yyyy', aDate);
            SetLength(aResponse, 0);
            //R(60, 13315, 01060000, 01060000, 2010, 2010)
            aResponse := aSPData.GetArray(FChoosedMeterId, aRequest[i], qStr, tryN);
          except
            on E : Exception do
                  raise EGettingArchiveData.Create('E: Archive.GetArray() ARRAY_MONTH ' + E.Message);
          end;
          if Length(aResponse) > 0 then
          try
            UDBData.WriteMonthValueToArchive(aResponse[0].id, aResponse[0].Value, aDate);
          except
             on E : Exception do
                raise EGettingArchiveData.Create(
                  'E: Archive.WriteMonthArchiveValue() ARRAY_MONTH ' + E.Message
                );
          end;
        end;
      end;
    end;
    if UDBData.InTransaction then
      UDBData.ComitTransaction;
    LabelInfo.Visible := False;
    MessageBeep(MB_ICONWARNING);
    WriteToLog('GETTING_THE_ARCHIVE=FINISH');
    MessageBeep(MB_ICONINFORMATION);
    ShowMessage('Извлечение архива завершено ...');
  finally
    aSPData.Free;
    EditMeter.Enabled := True;
    SBChooserMeter.Enabled := True;
    RefreshCh;
    LabelInfo.Visible := False;
  end;
end;

constructor TFGettingArchiveData.Create(AOwner: TComponent);
var aCurrentGroupCode : Integer;
begin
  inherited Create(AOwner);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  LabelInfo.Visible := False;
  dtbMeters.Connection := UDM.MySQLConnection;
  ChDate.Date := UDBData.GetServerDateTime;
  ChTime.Time := UDBData.GetServerDateTime;
  ChDay.Date := UDBData.GetServerDateTime;
  ChMonth.ItemIndex := MonthOf(UDBData.GetServerDateTime) - 1;
  RefreshCh;
end;

destructor TFGettingArchiveData.Destroy;
begin
  FIniConfig.Free;
  inherited Destroy;
end;

procedure TFGettingArchiveData.RbDayClick(Sender: TObject);
begin
  RefreshCh;
end;

procedure TFGettingArchiveData.RbMonthClick(Sender: TObject);
begin
  RefreshCh;
end;

procedure TFGettingArchiveData.RbTimeClick(Sender: TObject);
begin
  RefreshCh;
end;

procedure TFGettingArchiveData.RefreshCh;
begin
  ChDate.Enabled := RbTime.Checked;
  ChTime.Enabled := RbTime.Checked;
  ChDay.Enabled := RbDay.Checked;
  ChMonth.Enabled := RbMonth.Checked;
end;

procedure TFGettingArchiveData.SBChooserMeterClick(Sender: TObject);
var aCurrentGroupCode : Integer;
begin
  FQuerySearchList := TFQuerySearchList.Create(nil, dtbMeters, 'meter_id');
  try
    FQuerySearchList.Caption := 'Выбор прибора';
    aCurrentGroupCode := FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_TOPIC_VAL, 0);
    dtbMeters.ParamByName('codegroup').AsInteger := aCurrentGroupCode;
    dtbMeters.Open;
    if FQuerySearchList.Execute then
    begin
      EditMeter.Text := dtbMeters.FieldByName('name').AsString;
      FChoosedMeterId := dtbMeters.FieldByName('meter_id').AsInteger;
    end;
    dtbMeters.Close;
  finally
    FQuerySearchList.Free;
  end;
end;

end.
