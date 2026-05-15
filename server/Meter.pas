{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Meter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dxCntner, dxEditor, dxEdLib, dxDBELib,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, dxExEdtr, dxTL, dxDBCtrl,
  dxDBGrid, pdbGrid, ActnList, bsSkinCtrls, Mask, DBCtrls, ExtCtrls,
  ZAbstractTable, SPADO, ADODB, DBdata, dxTLClms, bsSkinBoxCtrls,
  bsdbctrls, dxDBTLCl, dxGrClms, ZSqlUpdate, dm_general;

type
  TFMeter = class(TForm)
    ActionList: TActionList;
    ActionOk: TAction;
    ActionAddParam: TAction;
    ActionDeleteParam: TAction;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    dtsTypesMeters: TDataSource;
    dtbTypesMeters: TZReadOnlyQuery;
    dtbMeters: TZQuery;
    dtsMeters: TDataSource;
    dtbParamsQueries: TZQuery;
    dtsParamsQueries: TDataSource;
    dtbParams: TZReadOnlyQuery;
    dtbGroupsParams: TZReadOnlyQuery;
    dtsGroupsParams: TDataSource;
    dtsParams: TDataSource;
    Label7: TLabel;
    dtbMetersmeter_id: TLargeintField;
    dtbMetersenabled: TLargeintField;
    dtbMetersname: TStringField;
    dtbMetersuser_id: TLargeintField;
    dtbMeterstypemeter_id: TLargeintField;
    dtbGroupsParamsgroupparams_id: TLargeintField;
    dtbGroupsParamsname: TStringField;
    dtbGroupsParamsuser_id: TLargeintField;
    dtbGroupsParamstypemeter_id: TLargeintField;
    dtbTypesMeterstypemeter_id: TLargeintField;
    dtbTypesMetersname: TStringField;
    dtbParamsparam_id: TLargeintField;
    dtbParamsspparam: TLargeintField;
    dtbParamscanal: TLargeintField;
    dtbParamsdescription: TStringField;
    bsSkinDBEdit1: TbsSkinDBEdit;
    bsSkinDBEdit2: TbsSkinDBEdit;
    DBMeterType: TbsSkinDBLookupComboBox;
    bsSkinDBMemo1: TbsSkinDBMemo;
    dtbParamsQueriesparamquery_id: TLargeintField;
    dtbParamsQueriesparamquery_name: TStringField;
    dtbParamsQueriesspparam: TLargeintField;
    dtbParamsQueriescanal: TLargeintField;
    dtbParamsQueriesdescription: TStringField;
    dtbParamsQueriesarray_name: TStringField;
    dtbMetersdevice: TLargeintField;
    dtbMetersdescription: TStringField;
    dtbParamsunitSN: TStringField;
    dtbParamsQueriesunitSN: TStringField;
    dtbArraies: TZReadOnlyQuery;
    dtbUnitsparams: TZReadOnlyQuery;
    dtbUnitsparamsunitparam_id: TLargeintField;
    dtbUnitsparamsunitSN: TStringField;
    dtbUnitsparamsunitPR: TStringField;
    LabelTest: TLabel;
    BtnTestInfo: TBitBtn;
    ActionTest: TAction;
    GroupBox3: TGroupBox;
    Splitter1: TSplitter;
    Panel1: TPanel;
    dxDBGrid2: TdxDBGrid;
    dxDBGrid2param_id: TdxDBGridColumn;
    dxDBGrid2spparam: TdxDBGridColumn;
    dxDBGrid2canal: TdxDBGridColumn;
    dxDBGrid2description: TdxDBGridMaskColumn;
    dxDBGrid2unitSN: TdxDBGridMaskColumn;
    Panel3: TPanel;
    Label2: TLabel;
    Label6: TLabel;
    EditFilter: TbsSkinEdit;
    DBListHeader: TbsSkinComboBox;
    Panel6: TPanel;
    LabelCountListHeaders: TLabel;
    Panel2: TPanel;
    DBGridChoosedParams: TdxDBGrid;
    DBGridChoosedParamsparamquery_id: TdxDBGridColumn;
    DBGridChoosedParamsparamquery_name: TdxDBGridButtonColumn;
    DBGridChoosedParamsspparam: TdxDBGridColumn;
    DBGridChoosedParamscanal: TdxDBGridColumn;
    DBGridChoosedParamsdescription: TdxDBGridMaskColumn;
    DBGridChoosedParamsarray_name: TPdxDBGridComboColumn;
    DBGridChoosedParamsunitSN: TPdxDBGridComboColumn;
    Panel4: TPanel;
    SpeedButton8: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Label5: TLabel;
    Panel5: TPanel;
    LabelCountListParamq: TLabel;
    CBActiveMeter: TDBCheckBox;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    procedure ActionOkExecute(Sender: TObject);
    procedure ActionOkUpdate(Sender: TObject);
    procedure ActionDeleteParamUpdate(Sender: TObject);
    procedure ActionAddParamExecute(Sender: TObject);
    procedure ActionDeleteParamExecute(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure ActionAddParamUpdate(Sender: TObject);
    procedure DBListHeader1KeyPress(Sender: TObject; var Key: Char);
    procedure DBListHeader1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBMeterTypeCloseUp(Sender: TObject);
    procedure dtbMetersAfterEdit(DataSet: TDataSet);
    procedure dtbParamsAfterRefresh(DataSet: TDataSet);
    procedure EditFilterChange(Sender: TObject);
    procedure DBListHeaderCloseUp(Sender: TObject);
    procedure DBGridChoosedParamsparamquery_nameButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure DBGridChoosedParamsarray_nameCloseUp(Sender: TObject;
      var Value: Variant; var Accept: Boolean);
    procedure dtbParamsQueriesAfterRefresh(DataSet: TDataSet);
    procedure DBGridChoosedParamsunitSNCloseUp(Sender: TObject;
      var Value: Variant; var Accept: Boolean);
    procedure ActionTestExecute(Sender: TObject);
    procedure ActionTestUpdate(Sender: TObject);
  private
    FMeterId : LongWord;
    FChanged : Boolean;
    FStringListLog : TStringList;
    FIniConfig: TIniConfig;
  public
    function Execute : Boolean;
    constructor Create(AOwner: TComponent; const MeterId : LongWord); reintroduce;
    destructor Destroy; override;
  end;

var
  FMeter: TFMeter;

implementation

uses QuerySearchList, DialogsEx, globalvars, SPData, SPServer, DateUtils,
  Log, ShellAPI, globalmethods;

{$R *.dfm}

constructor TFMeter.Create(AOwner: TComponent; const MeterId: LongWord);
var AZQuery : TZQuery;
begin
  inherited Create(AOwner);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  FStringListLog := TStringList.Create;
  LabelTest.Visible := False;
  FChanged := False;
  FMeterId := MeterId;
  dtbParams.Connection := UDM.MySQLConnection;
  dtbMeters.Connection := UDM.MySQLConnection;
  dtbTypesMeters.Connection := UDM.MySQLConnection;
  dtbParamsQueries.Connection := UDM.MySQLConnection;
  dtbGroupsParams.Connection := UDM.MySQLConnection;
  dtbArraies.Connection := UDM.MySQLConnection;
  dtbUnitsparams.Connection := UDM.MySQLConnection;
  dtbMeters.ParamByName('meter_id').AsInteger := FMeterId;
  DBGridChoosedParamsparamquery_name.OnButtonClick := DBGridChoosedParamsparamquery_nameButtonClick;
  DBGridChoosedParamsarray_name.OnCloseUp := DBGridChoosedParamsArray_nameCloseUp;
  DBGridChoosedParamsparamquery_name.OnButtonClick := DBGridChoosedParamsparamquery_nameButtonClick;
  dtbParams.Open;
  dtbMeters.Open;
  dtbParamsQueries.Open;
  dtbGroupsParams.Open;
  dtbTypesMeters.Open;
  DBListHeader.Items.Clear;
  while not dtbGroupsParams.Eof do
  begin
    DBListHeader.Items.AddObject(dtbGroupsParams.FieldByName('name').AsString,
        Pointer(dtbGroupsParams.FieldByName('groupparams_id').AsInteger));
    dtbGroupsParams.Next;
  end;
  DBListHeader.Text := EmptyStr;
  LabelCountListHeaders.Caption := '0';
  if not dtbParamsQueries.IsEmpty then
    LabelCountListParamq.Caption := IntToStr(dtbParamsQueries.RecordCount)
  else
    LabelCountListParamq.Caption := '0';
  DBMeterType.Enabled := dtbParamsQueries.IsEmpty;
  //загрузка массивов
  dtbArraies.Open;
  DBGridChoosedParamsArray_name.Items.Add(EmptyStr);
  DBGridChoosedParamsArray_name.Values.Add(EmptyStr);
  while not dtbArraies.Eof do
  begin
    DBGridChoosedParamsArray_name.Items.Add(dtbArraies.FieldByName('name').AsString);
    DBGridChoosedParamsArray_name.Values.Add(dtbArraies.FieldByName('array_id').AsString);
    dtbArraies.Next;
  end;
  dtbArraies.Close;
  //загрузка измерений
  dtbUnitsparams.Open;
  while not dtbUnitsparams.Eof do
  begin
    DBGridChoosedParamsunitSN.Items.Add(dtbUnitsparams.FieldByName('unitSN').AsString);
    DBGridChoosedParamsunitSN.Values.Add(dtbUnitsparams.FieldByName('unitparam_id').AsString);
    dtbUnitsparams.Next;
  end;
  dtbUnitsparams.Close;
end;

procedure TFMeter.ActionAddParamExecute(Sender: TObject);
begin
  UDBData.AddParamQuery(FMeterId, dtbParams.FieldByName('param_id').AsInteger, PARAMQUERY_ENABLE);
  dtbParams.Refresh;
  dtbParamsQueries.Refresh; 
  DBMeterType.Enabled := dtbParamsQueries.IsEmpty;
  FChanged := True;
end;

procedure TFMeter.ActionAddParamUpdate(Sender: TObject);
begin
  ActionAddParam.Enabled := not dtbParams.IsEmpty;
end;

procedure TFMeter.ActionDeleteParamExecute(Sender: TObject);
begin
  UDBData.DeleteParamQuery(dtbParamsQueries.FieldByName('paramquery_id').AsInteger);
  dtbParams.Refresh;
  dtbParamsQueries.Refresh;
  DBMeterType.Enabled := dtbParamsQueries.IsEmpty;
  FChanged := True;
end;

procedure TFMeter.ActionDeleteParamUpdate(Sender: TObject);
begin
  ActionDeleteParam.Enabled := not dtbParamsQueries.IsEmpty;
end;

procedure TFMeter.ActionOkExecute(Sender: TObject);
begin
  if dtbMeters.FieldByName('typemeter_id').IsNull then
  begin
    MessageBeep(MB_ICONINFORMATION);
    ShowMessage('Счетчик не может быть активным. Вы не указали тип прибора.');
    DBMeterType.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;
  if (dtbParamsQueries.IsEmpty) and (CBActiveMeter.Checked) then
  begin
     MessageBeep(MB_ICONWARNING);
     if MessageBox(Handle, 'Счетчик не может быть задействован без указания параметров.' +
        #13#10'Вы согласны?', 'Предупреждение', MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
        if (dtbMeters.State <> dsEdit) and (dtbMeters.State <> dsInsert) then
            dtbMeters.Edit;
        dtbMeters.FieldByName('enabled').AsInteger := 0;
     end else begin
        ModalResult := mrNone;
        Exit;
     end;
  end;
  if (dtbMeters.State = dsEdit) or (dtbMeters.State = dsInsert) then dtbMeters.Post;
  if UDBData.InTransaction then
   UDBData.ComitTransaction;
end;

procedure TFMeter.ActionOkUpdate(Sender: TObject);
begin
  ActionOk.Enabled := FChanged;
end;

procedure TFMeter.ActionTestExecute(Sender: TObject);
var aRequest, aResponse : TDesParams;
    aTopicName, qStr : string;
    aSPData : TSPData;
    i : Integer;
    aHourOk, aDayOk, aMonthOk, isOk : Boolean;

begin
  FStringListLog.Clear;
  LabelTest.Visible := True;
  aTopicName := 'G' + FIniConfig.GetIniStr(SETTING_KEY, DDE_QUERY_TOPIC_VAL, EmptyStr);
  aSPData := TSPData.Create(aTopicName);
  WriteToLog('TESTING');
  try
    if not SPServerIsRunning then
       if not StartSPServer then
         raise ESPServer.Create('Не удалось запустить СП-Сервер')
       else
         aSPData.ReConnectDde;
    //проверяю параметры
    aRequest := UDBData.GetParamsQuery(dtbMeters.FieldByName('meter_id').AsInteger);
    isOk := True;
    if Length(aRequest) > 0 then
    begin
      aResponse := aSPData.GetParams(dtbMeters.FieldByName('meter_id').AsInteger, aRequest);
      isOk := Length(aRequest) = Length(aResponse);  //сколько запросили, столько же должно вернуться
    end;
    //проверию массивы
    aRequest := UDBData.GetArrayParamsQuery(dtbMeters.FieldByName('meter_id').AsInteger);
    for i := 0 to Length(aRequest) - 1 do
    begin
      aHourOk := True;
      aDayOk := True;
      aMonthOk := True;
      SetLength(aResponse, 0);
      if aRequest[i].Code = ARRAY_HOUR then
      begin
         qStr := FormatDateTime('ddmmhh00, ddmmhh00, yyyy, yyyy', UDBData.GetServerDateTime);
         aResponse :=  aSPData.GetArray(
                    dtbMeters.FieldByName('meter_id').AsInteger,
                    aRequest[i], qStr, 1);
         aHourOk := Length(aResponse) > 0;
      end else
      if aRequest[i].Code = ARRAY_DAY then
      begin
         qStr := FormatDateTime('ddmm0000, ddmm0000, yyyy, yyyy', IncDay(UDBData.GetServerDateTime, -1));
         aResponse := aSPData.GetArray(
                    dtbMeters.FieldByName('meter_id').AsInteger,
                    aRequest[i], qStr, 1);
         aDayOk := Length(aResponse) > 0;
      end else
      if aRequest[i].Code = ARRAY_MONTH then
      begin
         qStr := FormatDateTime('01mm0000, 01mm0000, yyyy, yyyy', IncMonth(UDBData.GetServerDateTime, -1));
         aResponse := aSPData.GetArray(
                   dtbMeters.FieldByName('meter_id').AsInteger,
                   aRequest[i], qStr, 1);
         aMonthOk := Length(aResponse) > 0;
      end;
      isOk := isOk and (aHourOk and aDayOk and aMonthOk);
    end;
    if isOk then
       WriteToLog('TESTING=GOOD')
    else
       WriteToLog('TESTING=BAD');
    if Shellexecute(Handle, 'Open', PChar(GetLogFilePath), nil, nil, SW_SHOWNORMAL) <= 32 then
    begin
      MessageBeep(MB_ICONERROR);
      ShowMessage('Не удается открыть файл ' + GetLogFilePath);
    end;
  finally
    aSPData.Free;
    LabelTest.Visible := False;
  end;
end;

procedure TFMeter.ActionTestUpdate(Sender: TObject);
begin
  ActionTest.Enabled := not dtbParamsQueries.IsEmpty; 
end;

procedure TFMeter.BtnCancelClick(Sender: TObject);
begin
 if UDM.MySQLConnection.InTransaction then
   UDM.MySQLConnection.Rollback;
end;

procedure TFMeter.DBListHeader1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TFMeter.DBListHeader1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFMeter.DBListHeaderCloseUp(Sender: TObject);
begin
  if dtbParams.Active then dtbParams.Close;
  if DBListHeader.ItemIndex >= 0 then
  begin
     dtbParams.ParamByName('groupparams_id').AsInteger :=
        Integer(DBListHeader.Items.Objects[DBListHeader.ItemIndex]);
     dtbParams.Open;
     LabelCountListHeaders.Caption := IntToStr(dtbParams.RecordCount);
  end;
end;

procedure TFMeter.DBMeterTypeCloseUp(Sender: TObject);
begin
  dtbGroupsParams.Close;
  dtbGroupsParams.Open;
  DBListHeader.Items.Clear;
  while not dtbGroupsParams.Eof do
  begin
    DBListHeader.Items.AddObject(dtbGroupsParams.FieldByName('name').AsString,
        Pointer(dtbGroupsParams.FieldByName('groupparams_id').AsInteger)
    );
    dtbGroupsParams.Next;
  end;
  DBListHeader.Text := EmptyStr;
  LabelCountListHeaders.Caption := EmptyStr;
  dtbGroupsParams.Close;
end;

destructor TFMeter.Destroy;
begin
  FIniConfig.Free;
  FStringListLog.Free;
  dtbMeters.Close;
  dtbTypesMeters.Close;
  dtbParamsQueries.Close;
  dtbGroupsParams.Close;
  inherited Destroy;
end;

procedure TFMeter.dtbParamsAfterRefresh(DataSet: TDataSet);
begin
  LabelCountListHeaders.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TFMeter.dtbParamsQueriesAfterRefresh(DataSet: TDataSet);
begin
  LabelCountListParamq.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TFMeter.DBGridChoosedParamsarray_nameCloseUp(Sender: TObject;
  var Value: Variant; var Accept: Boolean);
var aValue : Variant;
    aRecNo : Integer;
begin
  aValue := Value;
  if VarAsType(aValue, varString) = EmptyStr then aValue := 0;
  UDBData.UpdateArrayIdOfParamQuery(
      dtbParamsQueries.FieldByName('paramquery_id').AsInteger,
      dtbMeters.FieldByName('meter_id').AsInteger,
      aValue
  );
  aRecNo := dtbParamsQueries.RecNo;
  dtbParamsQueries.Refresh;
  dtbParamsQueries.RecNo := aRecNo;
  FChanged := True;
end;

procedure TFMeter.DBGridChoosedParamsunitSNCloseUp(Sender: TObject;
  var Value: Variant; var Accept: Boolean);
var aValue : Variant;
    aRecNo : Integer;
begin
  aValue := Value;
  if VarAsType(aValue, varString) = EmptyStr then aValue := 0;
  UDBData.UpdateUnitIdOfParamQuery(
      dtbParamsQueries.FieldByName('paramquery_id').AsInteger,
      dtbMeters.FieldByName('meter_id').AsInteger,
      aValue
  );
  aRecNo := dtbParamsQueries.RecNo;
  dtbParamsQueries.Refresh;
  dtbParamsQueries.RecNo := aRecNo;
  FChanged := True;
end; 

procedure TFMeter.DBGridChoosedParamsparamquery_nameButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
var S : string;
    aRecNo : Integer;
begin
  S := DialogsEx._InputBox('Название параметра', 'Название',
    dtbParamsQueries.FieldByName('paramquery_name').AsString);
  if dtbParamsQueries.FieldByName('paramquery_name').AsString <> S then
  begin
    UDBData.UpdateNameOfParamQuery(
        dtbParamsQueries.FieldByName('paramquery_id').AsInteger,
        dtbMeters.FieldByName('meter_id').AsInteger,
        S
    );
    aRecNo := dtbParamsQueries.RecNo;
    dtbParamsQueries.Refresh;
    dtbParamsQueries.RecNo := aRecNo;
    FChanged := True;
  end;
end;

procedure TFMeter.dtbMetersAfterEdit(DataSet: TDataSet);
begin
  FChanged := True;
end;

procedure TFMeter.EditFilterChange(Sender: TObject);
begin
  if Trim(EditFilter.Text) = EmptyStr then
    dtbParams.Filter := EmptyStr
  else
    dtbParams.Filter := Format('spparam=%s', [EditFilter.Text]);
    if dtbParams.Active then
       LabelCountListHeaders.Caption := IntToStr(dtbParams.RecordCount);
end;

function TFMeter.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

end.
