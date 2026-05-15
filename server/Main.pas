{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, WebAdapt, WebComp, ComCtrls,
  ExtCtrls, ActnList, CheckLst, dxExEdtr, dxCntner,
  dxTL, dxDBCtrl, dxDBGrid, ButtonGroup, dxEditor, dxEdLib, ImgList, DB,
  DBTables, Menus, dxTLClms, dbdata, SPData, SPQuery, ShellApi, dm_general,
  Registry, ADODB, ZAbstractRODataset, ZAbstractDataset, ZDataset, DdeMan,
  AppEvnts, ActnMan, ActnColorMaps, DateUtils, dxBar, bsSkinCtrls, BusinessSkinForm,
  bsSkinBoxCtrls, Mask, XPStyleActnCtrls, ToolWin, TeEngine, Series, TeeProcs,
  Chart, Gauges;

const
  IMG_ENB = 0;
  IMG_DIS = 1;
  SC_RESTORE_FROM_TRAY = WM_USER + 1;

type
  EMain = class(Exception);

  TMeterRequest = class
    //MeterData : TMeterData;
    MeterData: TDevice;
    Request : TDesParams;
  end;

  EHreadInquiry = class (Exception);
  THreadInquiry = class(TThread)
  private
    FEvent: THandle;
    FTopicName : string;
    FIniConfig: TIniConfig;
  public
    destructor Destroy; override;
  protected
    procedure Execute; override;
    constructor Create(CreateSuspended: Boolean); reintroduce;
  end;

  TFMain = class(TForm)
    Panel2: TPanel;
    Panel4: TPanel;
    ImageList: TImageList;
    dtsparamsqueries: TDataSource;
    dtbparamsqueries: TZReadOnlyQuery;
    Panel3: TPanel;
    dxTL: TdxTreeList;
    dxTLName: TdxTreeListColumn;
    dxDBGridParamsq: TdxDBGrid;
    Splitter1: TSplitter;
    LabelState: TLabel;
    TrayIcon: TTrayIcon;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ImageListHotToolBar: TImageList;
    ToolButton8: TToolButton;
    ImageListDisableToolBar: TImageList;
    ActionList: TActionList;
    ActionSynchronization: TAction;
    ImageListToolBar: TImageList;
    ToolButton10: TToolButton;
    dxTLImg: TdxTreeListImageColumn;
    TrayPopupMenu: TPopupMenu;
    MenuRestore: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ActionClose1: TMenuItem;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    LabelLastTQ: TLabel;
    LabelLastLQ: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ActionSettings: TAction;
    ActionAbout: TAction;
    ActionHelp: TAction;
    ToolButton7: TToolButton;
    ActionGetArchive: TAction;
    dtbparamsqueriesparamquery_id: TLargeintField;
    dtbparamsqueriesparamquery_name: TStringField;
    dtbparamsqueriescanal: TLargeintField;
    dtbparamsqueriesdescription: TStringField;
    dtbparamsqueriesvalue: TFloatField;
    dtbparamsqueriesunitSN: TStringField;
    Label10: TLabel;
    dxDBGridParamsqparamquery_id: TdxDBGridColumn;
    dxDBGridParamsqparamquery_name: TdxDBGridMaskColumn;
    dxDBGridParamsqcanal: TdxDBGridColumn;
    dxDBGridParamsqdescription: TdxDBGridMaskColumn;
    dxDBGridParamsqvalue: TdxDBGridMaskColumn;
    dxDBGridParamsqunitSN: TdxDBGridMaskColumn;
    dxTLDescription: TdxTreeListColumn;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ActionLock: TAction;
    dxTLModify: TdxTreeListButtonColumn;
    ToolButton5: TToolButton;
    ActionStatistic: TAction;
    ToolButton9: TToolButton;
    ActionCleanDB: TAction;
    LabelCleanDB: TLabel;
    procedure dxTLChangeNode(Sender: TObject; OldNode, Node: TdxTreeListNode);
    procedure ActionSynchronizationExecute(Sender: TObject);
    procedure dtbparamsqueriesAfterOpen(DataSet: TDataSet);
    procedure ActionSynchronizationUpdate(Sender: TObject);
    procedure MenuRestoreClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure ActionSettingsExecute(Sender: TObject);
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionHelpExecute(Sender: TObject);
    procedure ActionGetArchiveExecute(Sender: TObject);
    procedure ActionLockExecute(Sender: TObject);
    procedure ActionLockUpdate(Sender: TObject);
    procedure ActionSettingsUpdate(Sender: TObject);
    procedure ActionGetArchiveUpdate(Sender: TObject);
    procedure dxTLModifyEditButtonClick(Sender: TObject);
    procedure ActionStatisticExecute(Sender: TObject);
    procedure ActionStatisticUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionCleanDBExecute(Sender: TObject);
    procedure ActionCleanDBUpdate(Sender: TObject);
  private
    FHreadInquiry : THreadInquiry;
    FIsRunning : Boolean;
    FListMeters : TObjectList;
    FListMeterRequest : TObjectList;
    FLockProgram : Boolean;
    FIniConfig: TIniConfig;
    procedure RefreshAnalogDisplayParams;
    function MeterRequestIndexOf(const AMeterId : LongWord) : Integer;
    procedure CreateMeters;
    function BaseSizeIsOK : Boolean;
  protected
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

var
  FMain: TFMain;

implementation

uses Meter, About, IntervalArchive, Log, Settings, PasswordDialog, SPServer,
  GettingArchiveData, globalvars, globalclasses, 
  TablesSynchronization, Progress, DialogsEx, Statistic, globalmethods;

{$R *.dfm}

constructor TFMain.Create(AOwner: TComponent);
var bFindNS : Boolean;
    n, BoxResult, aFlags : Integer;
begin
  inherited Create(AOwner);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  WriteToLog('DO START APPLICATION');
  FLockProgram := FIniConfig.GetIniStr(SETTING_KEY, LOCK_SECRET_VAL, EmptyStr) <> EmptyStr;
  dxTLModify.Visible := not FLockProgram;
  FListMeterRequest := TObjectList.Create;
  FListMeters := TObjectList.Create;
  dtbParamsQueries.Connection := UDM.MySQLConnection;
  CreateMeters;   //создаю счетчики
  LabelCleanDB.Visible := not BaseSizeIsOK;
  if DialogsEx._MessageBoxTimeOut('Вы желаете запустить опрос приборов?', 'Предупреждение',
    MB_YESNO + MB_ICONQUESTION, 10000) = IDYES then
  begin
    FIsRunning := True;
    WriteToLog('DO START INQUERY');
    if not SPServerInstall then  //проверяю установлен ли сп серевре на компьютере
      raise EMain.Create('СП-Сеть на данном компьютере не установлена.' +
        #13#10 + 'Установите СП-Сеть и попробуйте снова.');
    FHreadInquiry := THreadInquiry.Create(True);
    FHreadInquiry.Resume;
    LabelState.Font.Color := clGreen;
    LabelState.Caption := Format('Приборы опрашиваются. Подкл=%s; Пользов=%s', [UDM.HostDes, UDM.User]);
  end else begin
    LabelState.Font.Color := clRed;
    LabelState.Caption := Format('Приборы не опрашиваются. Подкл=%s; Пользов=%s', [UDM.HostDes, UDM.User]);
  end;
  RefreshAnalogDisplayParams;
end;

destructor TFMain.Destroy;
var MeterNode : TdxTreeListNode;
    i : Integer;
begin
   FIniConfig.Free;
  if FHreadInquiry <> nil then
    FHreadInquiry.Terminate;
  MeterNode := dxTL.TopNode;
  while MeterNode <> nil  do
  begin
    if TDevice(MeterNode.Data) <> nil then
      TDevice(MeterNode.Data).Free;
    MeterNode := MeterNode.GetNextNode;
  end;
  FListMeterRequest.Clear;
  FListMeters.Clear;
  FListMeterRequest.Free;
  FListMeters.Free;
  inherited Destroy;
end;

procedure TFMain.ActionAboutExecute(Sender: TObject);
begin
  TFAbout.ShowFormAbout(Application.Title);
end;

procedure TFMain.ActionGetArchiveExecute(Sender: TObject);
begin
  FGettingArchiveData := TFGettingArchiveData.Create(nil);
  try
    FGettingArchiveData.ShowModal;
    WriteToLog('DO ARCHIVE');
  finally
    FGettingArchiveData.Free;
  end;
end;

procedure TFMain.ActionGetArchiveUpdate(Sender: TObject);
begin
  ActionGetArchive.Enabled := not FLockProgram;
end;

procedure TFMain.ActionHelpExecute(Sender: TObject);
var aFile : string;
begin
  aFile := ExtractFilePath(Application.ExeName) + 'archdata.hlp';
  if ShellExecute(Handle, 'open', PChar(aFile), nil, nil, SW_SHOWNORMAL) <= 32 then
  begin
    MessageBeep(MB_ICONERROR);
    MessageDlg('Файл помощи не найден.', mtError, [mbOK], 0);
  end;
end;

procedure TFMain.ActionLockExecute(Sender: TObject);
var aPswd, aReadIniPswd : string;
begin
  aReadIniPswd := FIniConfig.GetIniStr(SETTING_KEY, LOCK_SECRET_VAL, EmptyStr);
  if FLockProgram then
  begin
    aPswd := DialogsEx._InputBoxPassword('Разблокировка', 'Введите текущий пароль', EmptyStr);
    FLockProgram := not ((aPswd <> EmptyStr) and (aPswd = aReadIniPswd));
    if not FLockProgram then
      WriteToLog('DO UNLOCK PROGRAM');    
  end else begin
    aPswd := aReadIniPswd;
    if aReadIniPswd = EmptyStr then
      repeat
        aPswd := DialogsEx._InputBoxPassword('Блогировка', 'Введите пароль', EmptyStr);
      until aPswd <> EmptyStr;
    FIniConfig.SetIniStr(SETTING_KEY, LOCK_SECRET_VAL, aPswd);
    FLockProgram := True;
    WriteToLog('DO LOCK PROGRAM');
  end;
  dxTLModify.Visible := not FLockProgram;
end;

procedure TFMain.ActionLockUpdate(Sender: TObject);
begin
  if FLockProgram then
    ActionLock.ImageIndex := 8
  else
    ActionLock.ImageIndex := 9;
end;

procedure TFMain.ActionCleanDBExecute(Sender: TObject);
var
  sql : string;
  zDataSet : TZQuery;
begin
  if MessageBox(Handle, 'Вы действительно хотите оставить архив аналоговых показаний за три последних месяца?',
      'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
  if MessageBox(Handle, 'Данная операция может занять некоторое время. Дождитесь её выполнения. Продолжить?',
      'Предупреждение', MB_YESNO + MB_ICONWARNING) = IDNO then Exit;
    sql := 'DELETE FROM anlarchive WHERE date < NOW() - INTERVAL 3 MONTH';
    zDataSet := UDM.CreateDataSet(sql) as TZQuery;
    try
      zDataSet.ExecSQL;
      if UDBData.InTransaction then
        UDBData.ComitTransaction;
      MessageBox(Handle, 'Очистка архива аналоговых показаний завершена. В базе остался архив аналоговых показаний за три последних месяца.',
        'Предупреждение', MB_OK + MB_ICONINFORMATION);
      LabelCleanDB.Visible := False;  
    finally
      zDataSet.Free;
    end;
  end;
end;

procedure TFMain.ActionCleanDBUpdate(Sender: TObject);
begin
  ActionCleanDB.Enabled := not FLockProgram;
end;

procedure TFMain.ActionSettingsExecute(Sender: TObject);
begin
  FSettings := TSettings.Create(nil);
  try
    if FSettings.Execute then
      WriteToLog('DO SETTINGS');
  finally
    FSettings.Free;
  end;
end;

procedure TFMain.ActionSettingsUpdate(Sender: TObject);
begin
  ActionSettings.Enabled := not FLockProgram;
end;

procedure TFMain.ActionStatisticExecute(Sender: TObject);
begin
  FStatistic := TFStatistic.Create(nil);
  try
    FStatistic.ShowModal;
    WriteToLog('DO STATISTICS');
  finally
    FStatistic.Free;
  end;
end;

procedure TFMain.ActionStatisticUpdate(Sender: TObject);
begin
  ActionStatistic.Enabled := not FLockProgram;
end;

procedure TFMain.CreateMeters;
var DSMeters : TZQuery;
    MeterData : TDevice;
    MeterNode : TdxTreeListNode;
    aCurrentGroupCode : Integer;
begin
  aCurrentGroupCode := FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_TOPIC_VAL, 0);
  DSMeters := UDBData.GetDevices(False, aCurrentGroupCode) as TZQuery;
  try
    DSMeters.Open;
    while not DSMeters.Eof do
    begin
      MeterData := TDevice.Create;
      UDBData.FillMetData(DSMeters, MeterData);
      MeterNode := dxTL.Add;
      FListMeters.Add(MeterNode);
      MeterNode.Strings[1] := MeterData.Name;
      MeterNode.Strings[2] := MeterData.Description;
      MeterNode.Data := MeterData;
      if MeterData.Enabled then
         MeterNode.Strings[0] := IntToStr(IMG_ENB)
      else
         MeterNode.Strings[0] := IntToStr(IMG_DIS);
      DSMeters.Next;
    end;
    dxTL.Bands[0].Caption := Format('Приборы: %d', [FListMeters.Count]);
    DSMeters.Close;
  finally
    DSMeters.Free;
  end;
  if dxTL.TopNode <> nil then
    dxTL.TopNode.Focused := True;

//  dxTL.GotoNodeByNavigation(tlnmFirst, False);
//  dxTLChangeNode(dxTL, nil, dxTL.TopNode);
end;

procedure TFMain.WMSysCommand(var Message: TWMSysCommand);
begin
  //если: заблок. - сворачивается в трэй; разблок. - закрывается
  if FIsRunning then
  begin
    case Message.CmdType of
      SC_CLOSE :
        begin
          if not FLockProgram then
            inherited
          else begin
            TrayIcon.Visible := True;
            Hide;
          end;
        end;
      SC_MINIMIZE :
        begin
          TrayIcon.Visible := True;
          Hide;
        end;
      SC_RESTORE_FROM_TRAY :
        begin
          TrayIcon.Visible := False;
          FMain.TrayIcon.IconIndex := 0;
          FMain.TrayIcon.Animate := False;
          Show;
        end;
      else inherited;
    end;
  end else inherited;
end;

procedure TFMain.dtbparamsqueriesAfterOpen(DataSet: TDataSet);
begin
  dxDBGridParamsq.Bands[0].Caption := Format('Параметры / %d', [dtbParamsQueries.RecordCount]);
end;

procedure TFMain.RefreshAnalogDisplayParams;
var MeterData : TDevice;
begin
  if dxTL.FocusedNode = nil then Exit;
  MeterData := dxTL.FocusedNode.Data;
  dtbParamsQueries.Close;
  dtbParamsQueries.ParamByName('meter_id').AsInteger := MeterData.Id;
  dtbParamsQueries.Open;
end;

procedure TFMain.dxTLChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  RefreshAnalogDisplayParams;
end;

procedure TFMain.TrayIconClick(Sender: TObject);
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE_FROM_TRAY, 0);
  RefreshAnalogDisplayParams;
end;

procedure TFMain.MenuRestoreClick(Sender: TObject);
begin
  SendMessage(Handle, WM_SYSCOMMAND, SC_RESTORE_FROM_TRAY, 0);
  RefreshAnalogDisplayParams;
end;

procedure TFMain.dxTLModifyEditButtonClick(Sender: TObject);
var MeterNode : TdxTreeListNode;
    MeterData : TDevice;
    MeterInfo : TFMeter;
    k : Integer;
    MeterRequest : TMeterRequest;
    DSMeter : TZQuery;
begin
  if FLockProgram then Exit;
  MeterNode := dxTL.FocusedNode;
  if MeterNode <> nil then
  begin
    MeterData := MeterNode.Data;
    MeterInfo := TFMeter.Create(nil, MeterData.Id);
    try
      if MeterInfo.Execute then
      begin
        WriteToLog('DO MODIFY DEVICE');
        DSMeter := UDBData.GetDevice(MeterData.Id) as TZQuery;
        try
          DSMeter.Open;
          UDBData.FillMetData(DSMeter, MeterData);
          DSMeter.Close;
        finally
          DSMeter.Free;
        end;
        if MeterData.Enabled then
          MeterNode.Strings[0] := IntToStr(IMG_ENB)
        else
          MeterNode.Strings[0] := IntToStr(IMG_DIS);
        MeterNode.Strings[1] := MeterData.Name;
        MeterNode.Strings[2] := MeterData.Description;
        RefreshAnalogDisplayParams;
        k := MeterRequestIndexOf(MeterData.Id);
        if k <> -1 then
        begin
          MeterRequest := FListMeterRequest[k] as TMeterRequest;
          SetLength(MeterRequest.Request, 0);
        end;
      end;
    finally
       MeterInfo.Free;
    end;
  end;
end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  if FIsRunning then
  begin
    if not FLockProgram then
      CanClose := MessageBox(Handle, 'Вы действительно хотите закрыть программу?', 'Предупреждение', MB_YESNO + MB_ICONWARNING) = IDYES
    else
      MessageBox(Handle, 'У вас недостаточно прав чтобы закрыть программу!', 'Предупреждение', MB_OK + MB_ICONERROR);
  end else
      CanClose := True;
end;

procedure TFMain.ActionSynchronizationExecute(Sender: TObject);
var ТипыПриборов, СписокЗаголовки, ЕдиницыСправ, СписокСтроки, Приборы : TADOQuery;
    dtbTypeMeters, dtbListHeaders, dtbParamUnits, dtbListPatams,
      dtbMeters : TZQuery;
    N : Integer;
begin
  ТипыПриборов := nil; СписокЗаголовки := nil; ЕдиницыСправ := nil;
  СписокСтроки := nil; Приборы := nil;
  dtbTypeMeters := nil; dtbListHeaders := nil; dtbParamUnits := nil;
  dtbListPatams := nil; dtbMeters := nil;
  FProgress := TFProgress.Create(nil, 'Синхронизация');
  ТипыПриборов := TADOQuery.Create(nil);
  СписокЗаголовки := TADOQuery.Create(nil);
  ЕдиницыСправ := TADOQuery.Create(nil);
  СписокСтроки := TADOQuery.Create(nil);
  Приборы := TADOQuery.Create(nil);
  dtbTypeMeters := TZQuery.Create(nil);
  dtbListHeaders := TZQuery.Create(nil);
  dtbParamUnits := TZQuery.Create(nil);
  dtbListPatams := TZQuery.Create(nil);
  dtbMeters := TZQuery.Create(nil);
  try
     //Connection
     ТипыПриборов.Connection := UDM.ADOConnection;
     СписокЗаголовки.Connection := UDM.ADOConnection;
     ЕдиницыСправ.Connection := UDM.ADOConnection;
     СписокСтроки.Connection := UDM.ADOConnection;
     Приборы.Connection := UDM.ADOConnection;
     dtbTypeMeters.Connection := UDM.MySQLConnection;
     dtbListHeaders.Connection := UDM.MySQLConnection;
     dtbParamUnits.Connection := UDM.MySQLConnection;
     dtbListPatams.Connection := UDM.MySQLConnection;
     dtbMeters.Connection := UDM.MySQLConnection;
     //sql
     ТипыПриборов.SQL.Text := 'SELECT * FROM ТипыПриборов';
     СписокЗаголовки.SQL.Text := 'SELECT * FROM СписокЗаголовки';
     ЕдиницыСправ.SQL.Text := 'SELECT * FROM ЕдиницыСправ';
     СписокСтроки.SQL.Text := 'SELECT * FROM СписокСтроки';
     Приборы.SQL.Text := 'SELECT * FROM Приборы';
     dtbTypeMeters.SQL.Text :=
        'SELECT * FROM typesmeters WHERE typemeter_id = :typemeter_id';
     dtbListHeaders.SQL.Text :=
        'SELECT * FROM groupsparams WHERE groupparams_id = :groupparams_id';
     dtbParamUnits.SQL.Text :=
        'SELECT * FROM unitsparams WHERE unitparam_id = :unitparam_id';
     dtbListPatams.SQL.Text :=
        'SELECT * FROM params WHERE param_id = :param_id';
     dtbMeters.SQL.Text :=
        'SELECT * FROM meters WHERE meter_id = :meter_id';
     FTablesSynchronization := TFTablesSynchronization.Create(nil);
     if not FTablesSynchronization.Execute then Exit;
     //Open
     ТипыПриборов.Open;
     СписокЗаголовки.Open;
     ЕдиницыСправ.Open;
     СписокСтроки.Open;
     Приборы.Open;
     N := ТипыПриборов.RecordCount + СписокЗаголовки.RecordCount + ЕдиницыСправ.RecordCount +
          СписокСтроки.RecordCount + Приборы.RecordCount;
     FProgress.SetMinMaxProgress(0, N);
     FProgress.Show;
     FProgress.UpdateProgressInfo('ТипыПриборов');
     try
       if FTablesSynchronization.bOnTypeMeters then
       while not ТипыПриборов.Eof do
       begin
          dtbTypeMeters.ParamByName('typemeter_id').AsInteger :=
              ТипыПриборов.FieldByName('КодТипаПрибора').AsInteger;
          dtbTypeMeters.Open;
          if dtbTypeMeters.IsEmpty then
             dtbTypeMeters.Insert
          else
             if FTablesSynchronization.bOnUpdate then dtbTypeMeters.Edit;
          if (dtbTypeMeters.State = dsInsert) or FTablesSynchronization.bOnUpdate then
          begin
            dtbTypeMeters.FieldByName('typemeter_id').AsInteger :=
              ТипыПриборов.FieldByName('КодТипаПрибора').AsInteger;
            dtbTypeMeters.FieldByName('name').AsString :=
              ТипыПриборов.FieldByName('НаимТипаПрибора').AsString;
            dtbTypeMeters.Post;
          end;
          dtbTypeMeters.Close;
          ТипыПриборов.Next;
          FProgress.Progress := FProgress.Progress + 1;
          Application.ProcessMessages;
       end;
       FProgress.UpdateProgressInfo('СписокЗаголовки');
       if FTablesSynchronization.bOnHeaderList then
       while not СписокЗаголовки.Eof do
       begin
          dtbListHeaders.ParamByName('groupparams_id').AsInteger :=
            СписокЗаголовки.FieldByName('КодСписка').AsInteger;
          dtbListHeaders.Open;
          if dtbListHeaders.IsEmpty then
             dtbListHeaders.Insert
          else
             if FTablesSynchronization.bOnUpdate then dtbListHeaders.Edit;
          if (dtbListHeaders.State = dsInsert) or FTablesSynchronization.bOnUpdate then
          begin
            dtbListHeaders.FieldByName('groupparams_id').AsInteger :=
              СписокЗаголовки.FieldByName('КодСписка').AsInteger;
            dtbListHeaders.FieldByName('name').AsString :=
              СписокЗаголовки.FieldByName('ИмяСписка').AsString;
            dtbListHeaders.FieldByName('user_id').AsInteger := 1;
            dtbListHeaders.FieldByName('typemeter_id').AsInteger :=
              СписокЗаголовки.FieldByName('КодТипаПрибора').AsInteger;
            dtbListHeaders.Post;
          end;
          dtbListHeaders.Close;
          СписокЗаголовки.Next;
          FProgress.Progress := FProgress.Progress + 1;
          Application.ProcessMessages;
       end;
       FProgress.UpdateProgressInfo('ЕдиницыСправ');
       if FTablesSynchronization.bOnUnitHandBook then
       while not ЕдиницыСправ.Eof do
       begin
          dtbParamUnits.ParamByName('unitparam_id').AsInteger :=
            ЕдиницыСправ.FieldByName('КодЕдиниц').AsInteger;
          dtbParamUnits.Open;
          if dtbParamUnits.IsEmpty then
             dtbParamUnits.Insert
          else
             if FTablesSynchronization.bOnUpdate then dtbParamUnits.Edit;
          if (dtbParamUnits.State = dsInsert) or FTablesSynchronization.bOnUpdate then
          begin
            dtbParamUnits.FieldByName('unitparam_id').AsInteger :=
              ЕдиницыСправ.FieldByName('КодЕдиниц').AsInteger;
            dtbParamUnits.FieldByName('unitSN').AsString :=
              ЕдиницыСправ.FieldByName('ИмяЕдиницСИ').AsString;
            dtbParamUnits.FieldByName('unitPR').AsString :=
              ЕдиницыСправ.FieldByName('ИмяЕдиницПР').AsString;
            dtbParamUnits.Post;
          end;
          dtbParamUnits.Close;
          ЕдиницыСправ.Next;
          FProgress.Progress := FProgress.Progress + 1;
          Application.ProcessMessages;
       end;
       FProgress.UpdateProgressInfo('СписокСтроки');
       if FTablesSynchronization.bOnListOfString then
       while not СписокСтроки.Eof do
       begin
          dtbListPatams.ParamByName('param_id').AsInteger :=
            СписокСтроки.FieldByName('КодСтрокиСписка').AsInteger;
          dtbListPatams.Open;
          if dtbListPatams.IsEmpty then
             dtbListPatams.Insert
          else
             if FTablesSynchronization.bOnUpdate then dtbListPatams.Edit;
          if (dtbListPatams.State = dsInsert) or FTablesSynchronization.bOnUpdate then
          begin
            dtbListPatams.FieldByName('param_id').AsInteger :=
              СписокСтроки.FieldByName('КодСтрокиСписка').AsInteger;
            dtbListPatams.FieldByName('spparam').AsInteger :=
              СписокСтроки.FieldByName('НомерПараметра').AsInteger;
            dtbListPatams.FieldByName('description').AsString :=
              СписокСтроки.FieldByName('ИмяПараметра').AsString;
            dtbListPatams.FieldByName('canal').AsInteger :=
              СписокСтроки.FieldByName('НомерКанала').AsInteger;
            dtbListPatams.FieldByName('unitparam_id').AsInteger :=
              СписокСтроки.FieldByName('КодЕдиниц').AsInteger;
            dtbListPatams.FieldByName('groupparams_id').AsInteger :=
              СписокСтроки.FieldByName('КодСписка').AsInteger;
            dtbListPatams.Post;
          end;
          dtbListPatams.Close;
          СписокСтроки.Next;
          FProgress.Progress := FProgress.Progress + 1;
          Application.ProcessMessages;
       end;
       FProgress.UpdateProgressInfo('Приборы');
       if FTablesSynchronization.bOnMeters then
       while not Приборы.Eof do
       begin
          dtbMeters.ParamByName('meter_id').AsInteger :=
            Приборы.FieldByName('КодПрибора').AsInteger;
          dtbMeters.Open;
          if dtbMeters.RecordCount > 1 then
             raise EMain.Create('Найдено совпадение в номерах счетчиков. ' +
                  'Исправьте ошибку и попробуйте снова.' + #10#13 +
                  'Категорически запрещается запускать архив, до исправления.');
          if dtbMeters.IsEmpty then
             dtbMeters.Insert
          else
             if FTablesSynchronization.bOnUpdate then dtbMeters.Edit;
          if (dtbMeters.State = dsInsert) or FTablesSynchronization.bOnUpdate then
          begin
            dtbMeters.FieldByName('meter_id').AsInteger :=
              Приборы.FieldByName('КодПрибора').AsInteger;
            dtbMeters.FieldByName('device').AsInteger :=
              Приборы.FieldByName('ФизическийАдрес').AsInteger;
            dtbMeters.FieldByName('description').AsString :=
              Приборы.FieldByName('ПримечаниеПрибора').AsString;
            dtbMeters.FieldByName('name').AsString :=
              Приборы.FieldByName('НазваниеПрибора').AsString;
            dtbMeters.FieldByName('user_id').AsInteger := 1;
            dtbMeters.FieldByName('typemeter_id').AsString :=
              Приборы.FieldByName('КодТипаПрибора').AsString;
            dtbMeters.FieldByName('enabled').AsInteger := 0;
            dtbMeters.FieldByName('codegroup').AsInteger :=
              Приборы.FieldByName('КодГруппы').AsInteger;
            dtbMeters.Post;
          end;
          dtbMeters.Close;
          Приборы.Next;
          FProgress.Progress := FProgress.Progress + 1;
          Application.ProcessMessages;
       end;
       if UDBData.InTransaction then
         UDBData.ComitTransaction;
     except
       if UDBData.InTransaction then
         UDBData.RollBackTransaction;
     end;
     //Close
     ТипыПриборов.Close;
     СписокЗаголовки.Close;
     ЕдиницыСправ.Close;
     СписокСтроки.Close;
     Приборы.Close;     
//     FProgress.UpdateProgressInfo('Завершение');
     FProgress.Hide;
  finally
     WriteToLog('DO SYNCHRONIZATION');
     //Free
     FProgress.Free;
     FTablesSynchronization.Free;
     ТипыПриборов.Free;
     СписокЗаголовки.Free;
     ЕдиницыСправ.Free;
     СписокСтроки.Free;
     Приборы.Free;
     dtbTypeMeters.Free;
     dtbListHeaders.Free;
     dtbParamUnits.Free;
     dtbListPatams.Free;
     dtbMeters.Free;
  end;
  MessageBeep(MB_ICONWARNING);
  ShowMessage('Синхронизация окончена. Необходимо перезапустить программу.');
  Close;
end;

procedure TFMain.ActionSynchronizationUpdate(Sender: TObject);
begin
  ActionSynchronization.Enabled := not FLockProgram;
end;

function TFMain.BaseSizeIsOK: Boolean;
begin
  Result := UDBData.GetVariantVal('SELECT COUNT(*) count FROM anlarchive WHERE date < NOW() - INTERVAL 3 MONTH', [], 'count') = 0;
end;

function TFMain.MeterRequestIndexOf(const AMeterId : LongWord) : Integer;
var i : Integer;
    MeterRequest : TMeterRequest;
    MeterData : TDevice;
begin
  Result := -1;
  i := FListMeterRequest.Count - 1;
  while i >= 0 do
  begin
    MeterRequest := FListMeterRequest[i] as TMeterRequest;
    MeterData := MeterRequest.MeterData;
    if MeterData.Id = AMeterId then
    begin
      Result := i;
      Break;
    end;
    Dec(i);
  end;
end;

procedure TFMain.N3Click(Sender: TObject);
begin
  TFAbout.ShowFormAbout('ArchiveDataHeat');
end;

constructor THreadInquiry.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  FreeOnTerminate := False;
  FTopicName := 'G' + FIniConfig.GetIniStr(SETTING_KEY, DDE_QUERY_TOPIC_VAL, EmptyStr);
  Priority := TThreadPriority(FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_PRIORITY_VAL, Integer(tpNormal)));
  FEvent := CreateEvent(nil, True, False, nil);
end;

destructor THreadInquiry.Destroy;
begin
  FIniConfig.Free;
  ResetEvent(FEvent);
  CloseHandle(FEvent);
  inherited Destroy;
end;

procedure THreadInquiry.Execute;
var
  dxTreeListNode : TdxTreeListNode;
  MeterData : TDevice;
  ARequest, AResponse : TDesParams;
  IsHour, IsDay, IsMonth, IsYear, archiveWasReaded : Boolean;
  i, k, Index, aInterval, tryN : Integer;
  Sec, Frequency, Start, Stop, StopTimer, TimeSpended, TimeWent : TLargeInteger;
  MeterRequest : TMeterRequest;
  FSPData : TSPData;
  qStr : string;

  procedure CalcArhiveDateTimeFlags(const ServerDateTime : TDateTime; 
    out bY, bM, bD, bH : Boolean);
  var AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond : Word;
  begin
    DecodeDateTime(UDBData.GetServerDateTime,
      AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
    bH := (AMinute >= 5) and (AMinute <= 15);
    bD := (AHour = 0) and IsHour;
    bM := (ADay = 1) and IsDay;
    bY := (AMonth = 1) and IsMonth;
  end;

begin
  Frequency := 0;
  Start := 0;
  Stop := 0;
  Index := 0;
  archiveWasReaded := False;
  if not SPServerIsRunning then
    if not StartSPServer then
       raise EMain.Create('Не удалось запустить СП-Сервер');
  FSPData := TSPData.Create(FTopicName);
  try
    if not QueryPerformanceFrequency(Frequency) then
       raise EMain.Create('E - QueryPerformanceFrequency does not support');
    QueryPerformanceCounter(Start);
    CalcArhiveDateTimeFlags(UDBData.GetServerDateTime, IsYear, IsMonth, IsDay, IsHour);
    while (Index < FMain.FListMeters.Count) and
          (WaitForSingleObject(FEvent, 0) <> WAIT_OBJECT_0) and not Terminated do
    try
      dxTreeListNode := TdxTreeListNode(FMain.FListMeters[Index]);
      MeterData := dxTreeListNode.Data;
      if MeterData.Enabled then
      begin
        k := FMain.MeterRequestIndexOf(MeterData.Id);
        if k = -1 then
        begin
          MeterRequest := TMeterRequest.Create;
          MeterRequest.MeterData := MeterData;
          FMain.FListMeterRequest.Add(MeterRequest);
        end else
          MeterRequest := FMain.FListMeterRequest[k] as TMeterRequest;
        if Length(MeterRequest.Request) = 0 then
        try
          MeterRequest.Request := UDBData.GetParamsQuery(MeterData.Id);
        except
           on E : Exception do
              raise EMain.Create(
                'E: GetParamsFromParamsQueries() ' + E.Message
              );
        end;
        if not SPServerIsRunning then
          if not StartSPServer then
             raise EMain.Create('Не удалось запустить СП-Сервер')
          else
           FSPData.ReConnectDde;

        //Читаю аналоговые показания с приборов*********************************
        try
          AResponse := FSPData.GetParams(MeterData.Id, MeterRequest.Request);
        except
          on E : Exception do
             raise EMain.Create('E: GetParams() ' + E.Message);
        end;

        //Записываю полученную информацию в базу данных*************************
        if Length(AResponse) > 0 then
        begin
          //Для аналоговых показаний********************************************
          try
            UDBData.WriteMomentAnalogValue(AResponse);
          except
            on E : Exception do
              raise EMain.Create('E: WriteMomentAnalogValue() ' + E.Message);
          end;
          //Для архивных показаний**********************************************
          try
            UDBData.WriteMomentValueToArchive(AResponse);
          except
            on E : Exception do
               raise EMain.Create('E: WriteMomentValueToArchive() ' + E.Message);
          end;
          //Для аварийных показаний*********************************************
          try
            UDBData.AddAlertToArchive(AResponse);
          except
            on E : Exception do
               raise EMain.Create('E: AddAlertToArchive() ' + E.Message);
          end;
        end;

        //АРХИВ-АРХИВ-АРХИВ-АРХИВ-АРХИВ
         
        if (IsHour or IsDay or IsMonth or IsYear) and (not archiveWasReaded) then
        begin
          try
            ARequest :=  UDBData.GetArrayParamsQuery(MeterData.Id);
          except
            on E : Exception do
               raise EMain.Create('E: GetArray() ' + E.Message);
          end;
          tryN := FIniConfig.GetIniInt(SETTING_KEY, DDE_RELIABILITY_OF_READING_VAL, 0);
          for i := 0 to Length(ARequest) - 1 do
          begin
            //Если СП-Сервере не запущен, запускаю******************************
            if not SPServerIsRunning then
              if not StartSPServer then
                 raise EMain.Create('Не удалось запустить СП-Сервер')
              else
                 FSPData.ReConnectDde;

            // **************** ЧТЕНИЕ ЧАСОВЫХ ЗНАЧЕНИЙ ****************

            if IsHour and (ARequest[i].code = ARRAY_HOUR) then
            begin
              try
                //R(60, 13371, 28051300, 28051300, 2010, 2010)
                aResponse :=  FSPData.GetArray(
                    MeterData.Id, aRequest[i],
                    FormatDateTime('ddmmhh00, ddmmhh00, yyyy, yyyy', UDBData.GetServerDateTime),
                    tryN
                );
              except
                 on E : Exception do
                    raise EMain.Create(
                      'E: GetArray() ARRAY_HOUR ' + E.Message
                    );
              end;
              if Length(AResponse) > 0 then
              try  
                if HourOf(UDBData.GetServerDateTime) = 0 then  //новые сутки
                   UDBData.WriteHourValueToArchive(
                      AResponse[0].id, AResponse[0].Value,
                      IncDay(UDBData.GetServerDateTime, -1)
                   )
                else
                   UDBData.WriteHourValueToArchive(
                      AResponse[0].id, AResponse[0].Value,
                      UDBData.GetServerDateTime
                   );
              except
                 on E : Exception do
                    raise EMain.Create(
                      'E: WriteHour() ARRAY_HOUR ' + E.Message
                    );
              end;
            end;

            // **************** ЧТЕНИЕ СУТОЧНЫХ ЗНАЧЕНИЙ ****************

            if IsDay and (ARequest[i].code = ARRAY_DAY) then
            begin                
                qStr := FormatDateTime('ddmm0000, ddmm0000, yyyy, yyyy', IncDay(UDBData.GetServerDateTime, -1));
              try
                //R(60, 13372, 06070000, 06070000)
                AResponse :=  FSPData.GetArray(MeterData.Id, ARequest[i], qStr, tryN);
              except
                on E : Exception do
                   raise EMain.Create('E: GetArray() ARRAY_DAY ' + E.Message);
              end;
              if Length(AResponse) > 0 then
              try
                UDBData.WriteDayValueToArchive(AResponse[0].id, AResponse[0].Value, IncDay(UDBData.GetServerDateTime, -1));
              except
                on E : Exception do
                   raise EMain.Create(
                     'E: WriteDayArchiveValue() ARRAY_DAY ' + E.Message
                   );
              end;
              //сообщение об очистке базы данных от архива аналоговых показаний
              FMain.LabelCleanDB.Visible := not FMain.BaseSizeIsOK;
            end;

            // **************** ЧТЕНИЕ МЕСЯЧНЫХ ЗНАЧЕНИЙ ****************
            
            if IsMonth and (ARequest[i].code = ARRAY_MONTH) then
            begin
              try                              
                //R(60, 13315, 01060000, 01060000, 2010, 2010)
                AResponse := FSPData.GetArray(MeterData.Id, ARequest[i],
                    FormatDateTime('01mm0000, 01mm0000, yyyy, yyyy', IncMonth(UDBData.GetServerDateTime, -1)), tryN);
              except
                on E : Exception do
                   raise EMain.Create('E: GetArray() ARRAY_MONTH ' + E.Message);
              end;
              if Length(AResponse) > 0 then
              try
                 UDBData.WriteMonthValueToArchive(
                    AResponse[0].id, AResponse[0].Value,
                    IncMonth(UDBData.GetServerDateTime, -1)
                 );
              except
                 on E : Exception do
                    raise EMain.Create(
                      'E: WriteMonthArchiveValue() ARRAY_MONTH ' + E.Message
                    );
              end;
            end;
          end;
        end;
        if UDBData.InTransaction then UDBData.ComitTransaction;
      end;
      Inc(Index);
      if Index = FMain.FListMeters.Count then
      begin
        Index := 0;
        if not QueryPerformanceCounter(Stop) then
          raise EHreadInquiry.Create('Ошибка вызова QueryPerformanceCounter' + IntToStr(GetLastError));
        TimeSpended := Round(1000 * (Stop - Start) / Frequency);
        Sec := TimeSpended div 1000;
        FMain.LabelLastTQ.Caption := FormatDateTime('hh:mm:ss', UDBData.GetServerDateTime);
        FMain.LabelLastLQ.Caption := Format('%d мкс (%d сек)', [TimeSpended, Sec]);
        if Boolean(FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_NOT_USE_INTERVAL_VAL, 0)) then
          aInterval := 0
        else
          aInterval := FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_INTERVAL_VAL, 0);
        if (aInterval - TimeSpended) > 0 then
          WaitForSingleObject(FEvent, aInterval - TimeSpended);
        QueryPerformanceCounter(Start);
        archiveWasReaded := IsHour or IsDay or IsMonth or IsYear; //архивы прочитались
        CalcArhiveDateTimeFlags(UDBData.GetServerDateTime, IsYear, IsMonth, IsDay, IsHour);
      end;
    except
      on E : Exception do WriteToLog(E.Message); // <<< --- ОШИБКИ В ЛОГ ФАЙЛ
    end;
  finally
    FSPData.Free;
  end;
end;

end.
