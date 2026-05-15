{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ChooseAnl;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, dm_general, 
  ActnList, Dialogs, Tabs, Mask, FileCtrl, dxEditor,
  dxEdLib, bsSkinBoxCtrls, bsSkinCtrls, DateUtils, dxDBTLCl, dxGrClms, pdbGrid,
  HelpPic, MdExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, SPTForm;

type

  TDateInterval = (diHour, diDay, diTwoDay, diThreeDay);

  EChooseAnl = class(Exception);

  TChooseArchiveForm = class(TSPTForm)
    dtsdtbanaloggroups: TDataSource;
    dtsparamsanaloggroups: TDataSource;
    dtbparamsanaloggroup: TZQuery;
    dtbanaloggroups: TZQuery;
    ActionList: TActionList;
    ActionDelGroup: TAction;
    ActionDelParam: TAction;
    dtbanaloggroupsanaloggroup_id: TLargeintField;
    dtbanaloggroupsname: TStringField;
    tdbAllParams: TZReadOnlyQuery;
    ActionModGroup: TAction;
    ActionAddParam: TAction;
    ActionAddGroup: TAction;
    Panel2: TPanel;
    PanelDetailGroups: TPanel;
    ActionModParam: TAction;
    dtbparamsanaloggroupname: TStringField;
    dtbparamsanaloggroupparamquery_id: TLargeintField;
    tdbAllParamsparamquery_id: TLargeintField;
    tdbAllParamsparamsqueries_name: TStringField;
    tdbAllParamsDeviceName: TStringField;
    tdbAllParamsspparam: TLargeintField;
    tdbAllParamscanal: TLargeintField;
    tdbAllParamsdescription: TStringField;
    dtbanaloggroupsusername: TStringField;
    dtbparamsanaloggroupcolor: TLargeintField;
    tdbAllParamsparamQueryState: TStringField;
    GroupBox2: TGroupBox;
    EditSearch: TEdit;
    ActionGroupToFirst: TAction;
    ActionGroupToLast: TAction;
    ActionParamToFirst: TAction;
    ActionParamToLast: TAction;
    BtnClearSearch: TSpeedButton;
    ActionCancelSearch: TAction;
    PanelControlBtns: TPanel;
    PanelChooseInterval: TPanel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    ChoosedDateTime: TDateTimePicker;
    EditDateTimeStart: TDateTimePicker;
    EditDateTimeEnd: TDateTimePicker;
    Label2: TLabel;
    HelpPic2: THelpPic;
    BitOK: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    BtnShowDetailParams: TMdBitBtn;
    Panel1: TPanel;
    LabelGroupsCount: TLabel;
    Panel3: TPanel;
    PanelGroupEdit: TPanel;
    AddGroup: TSpeedButton;
    DelGroup: TSpeedButton;
    SBModifyGroup: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    PanelDetailParams: TPanel;
    LabelParamsCount: TLabel;
    Panel5: TPanel;
    PanelParamsEdit: TPanel;
    IncludeParamq: TSpeedButton;
    DeclareParamq: TSpeedButton;
    SBModifyParam: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridDBTableViewanaloggroup_id: TcxGridDBColumn;
    cxGridDBTableViewname: TcxGridDBColumn;
    cxGridDBTableViewusername: TcxGridDBColumn;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1paramquery_id: TcxGridDBColumn;
    cxGrid1DBTableView1name: TcxGridDBColumn;
    cxGrid1DBTableView1color: TcxGridDBColumn;
    procedure ActionDelGroupExecute(Sender: TObject);
    procedure ActionDelGroupUpdate(Sender: TObject);
    procedure ActionDelParamExecute(Sender: TObject);
    procedure ActionDelParamUpdate(Sender: TObject);
    procedure dtbanaloggroupsAfterOpen(DataSet: TDataSet);
    procedure dtbanaloggroupsAfterRefresh(DataSet: TDataSet);
    procedure dtbparamsanaloggroupAfterOpen(DataSet: TDataSet);
    procedure dtbparamsanaloggroupAfterRefresh(DataSet: TDataSet);
    procedure ActionModGroupExecute(Sender: TObject);
    procedure ActionModGroupUpdate(Sender: TObject);
    procedure ActionAddParamExecute(Sender: TObject);
    procedure ActionAddGroupExecute(Sender: TObject);
    procedure ActionAddParamUpdate(Sender: TObject);
    procedure ActionModParamExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionModParamUpdate(Sender: TObject);
    procedure DBGridParamscolorCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dtbanaloggroupsFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ActionGroupToFirstExecute(Sender: TObject);
    procedure ActionGroupToLastExecute(Sender: TObject);
    procedure ActionGroupToFirstUpdate(Sender: TObject);
    procedure ActionGroupToLastUpdate(Sender: TObject);
    procedure ActionParamToFirstExecute(Sender: TObject);
    procedure ActionParamToFirstUpdate(Sender: TObject);
    procedure ActionParamToLastExecute(Sender: TObject);
    procedure ActionParamToLastUpdate(Sender: TObject);
    procedure EditSearchChange(Sender: TObject);
    procedure ActionCancelSearchExecute(Sender: TObject);
    procedure DBGridParamsDblClick(Sender: TObject);
    procedure BitOKClick(Sender: TObject);
    procedure BtnShowDetailParamsClick(Sender: TObject);
    procedure cxGrid1DBTableView1colorCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    FIniConfig: TIniConfig;
    function GetParamGroupId: Integer;
    function GetDateTimeEnd: TDateTiME;
    function GetDateTimeStart: TDateTime;
    function GetGroupName: string;
  public
    function Execute : Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ParamGroupId : Integer read GetParamGroupId;
    property DateTimeStart : TDateTime read GetDateTimeStart;
    property DateTimeEnd : TDateTiME read GetDateTimeEnd;
    property GroupName : string read GetGroupName; 
  end;

implementation

{$R *.dfm}

uses QuerySearchList, DBdata, CommCtrl, ModifyParamOfAnlGroup, globalvars,
  DialogsEx, globalmethods;

procedure TChooseArchiveForm.ActionAddGroupExecute(Sender: TObject);
var groupName : string;
begin
  if _InputQuery('Новая группа', 'Название группы', groupName) then
    if Trim(groupName) <> EmptyStr then
    begin
      if not UDBData.InTransaction then
        UDBData.StartTransaction;
      try
        UDBData.AddArchiveGroup(Trim(groupName),
          {$IFDEF USE_ADMIN}
          EmptyStr
          {$ELSE}
          UDM.User
          {$ENDIF});
        if UDBData.InTransaction then
          UDBData.ComitTransaction;
      except
        if UDBData.InTransaction then
          UDBData.RollBackTransaction;
      end;
      dtbanaloggroups.Refresh;
      dtbanaloggroups.Last;
    end else
      raise EChooseAnl.Create('Имя группы не может быть пустым. Группа не создана.');
end;

procedure TChooseArchiveForm.ActionAddParamExecute(Sender: TObject);
begin
  FQuerySearchList := TFQuerySearchList.Create(Self, tdbAllParams, 'paramquery_id');
  FQuerySearchList.Caption := 'Новый параметр группы';
  try
    tdbAllParams.Close;
    tdbAllParams.ParamByName('analoggroup_id').AsInteger := dtbanaloggroups.FieldByName('analoggroup_id').AsInteger;
    tdbAllParams.Open;
    if FQuerySearchList.Execute then
    begin
      if tdbAllParams.FieldByName('paramquery_id').IsNull then Exit;
      if not UDBData.InTransaction then
        UDBData.StartTransaction;
      try
        UDBData.AddParamQueryToArchiveGroup(dtbanaloggroups.FieldByName('analoggroup_id').AsInteger,
           tdbAllParams.FieldByName('paramquery_id').AsInteger);
        if UDBData.InTransaction then
          UDBData.ComitTransaction;
      except
        if UDBData.InTransaction then
          UDBData.RollBackTransaction;
      end;
      dtbparamsanaloggroup.Refresh;
      dtbparamsanaloggroup.Last;
    end;
  finally
    tdbAllParams.Close;
    FQuerySearchList.Free;
  end;
end;

procedure TChooseArchiveForm.ActionAddParamUpdate(Sender: TObject);
begin
  ActionAddParam.Enabled := not dtbanaloggroups.IsEmpty
  {$IFNDEF USE_ADMIN}
  and (not dtbanaloggroups.FieldByName('username').IsNull);
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TChooseArchiveForm.ActionDelParamUpdate(Sender: TObject);
begin
  ActionDelParam.Enabled := not dtbanaloggroups.IsEmpty
  {$IFNDEF USE_ADMIN}
  and (not dtbanaloggroups.FieldByName('username').IsNull);
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TChooseArchiveForm.ActionGroupToFirstExecute(Sender: TObject);
begin
  dtbanaloggroups.First;
end;

procedure TChooseArchiveForm.ActionGroupToFirstUpdate(Sender: TObject);
begin
  ActionGroupToFirst.Enabled := not dtbanaloggroups.IsEmpty;
end;

procedure TChooseArchiveForm.ActionGroupToLastExecute(Sender: TObject);
begin
  dtbanaloggroups.Last;
end;

procedure TChooseArchiveForm.ActionGroupToLastUpdate(Sender: TObject);
begin
  ActionGroupToLast.Enabled := not dtbanaloggroups.IsEmpty;
end;

procedure TChooseArchiveForm.ActionDelGroupExecute(Sender: TObject);
begin
  if _MessageBox(Handle, PChar('Вы уверены что хотите удалить?'),
        'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    if not UDBData.InTransaction then
      UDBData.StartTransaction;
    try
      UDBData.DeleteArchiveGroup(dtbanaloggroups.FieldByName('analoggroup_id').AsInteger);
      if UDBData.InTransaction then
        UDBData.ComitTransaction;
    except
      if UDBData.InTransaction then
        UDBData.RollBackTransaction;
    end;
    dtbanaloggroups.Refresh;
    dtbanaloggroups.First;
  end;
end;

procedure TChooseArchiveForm.ActionDelGroupUpdate(Sender: TObject);
begin
  ActionDelGroup.Enabled := not dtbanaloggroups.IsEmpty 
  {$IFNDEF USE_ADMIN}
  and (not dtbanaloggroups.FieldByName('username').IsNull);
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TChooseArchiveForm.ActionModGroupExecute(Sender: TObject);
var groupName : string;
    OldRecNo : LongInt;
begin
  groupName := Trim(_InputBox('Редактирование имени группы', 'Новое имя группы',
    dtbanaloggroups.FieldByName('name').AsString));
  if groupName <> dtbanaloggroups.FieldByName('name').AsString then
    if groupName <> EmptyStr then
    begin
      if not UDBData.InTransaction then
        UDBData.StartTransaction;
      dtbanaloggroups.Edit;
      dtbanaloggroups.FieldByName('name').AsString := groupName;
      dtbanaloggroups.Post;
      if UDBData.InTransaction then
        UDBData.ComitTransaction;
      OldRecNo := dtbanaloggroups.RecNo;
      dtbanaloggroups.Refresh;
      dtbanaloggroups.RecNo := OldRecNo;
    end else
      raise EChooseAnl.Create('Имя группы не может быть пустым. Имя группы не изменено.');
end;

procedure TChooseArchiveForm.ActionModGroupUpdate(Sender: TObject);
begin
  ActionModGroup.Enabled := not dtbanaloggroups.IsEmpty
  {$IFNDEF USE_ADMIN}
  and (not dtbanaloggroups.FieldByName('username').IsNull);
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TChooseArchiveForm.ActionModParamExecute(Sender: TObject);
var
  OldRecNo : LongInt;
begin
  FModifyParamOfAnlGroup := TFModifyParamOfAnlGroup.Create(Application,
    dtbanaloggroups.FieldByName('analoggroup_id').AsInteger,
    dtbparamsanaloggroup.FieldByName('paramquery_id').AsInteger);
  FModifyParamOfAnlGroup.Caption := 'Редактирование свойст параметра группы';  
  try
    if FModifyParamOfAnlGroup.Execute then
    begin
      if not UDBData.InTransaction then
        UDBData.StartTransaction;
      UDBData.UpdateParamQueryOfArchiveGroup(dtbanaloggroups.FieldByName('analoggroup_id').AsInteger,
         dtbparamsanaloggroup.FieldByName('paramquery_id').AsInteger,
         FModifyParamOfAnlGroup.MinScaleValue,
         FModifyParamOfAnlGroup.SignalScaleValue,
         FModifyParamOfAnlGroup.MaxScaleValue,
         FModifyParamOfAnlGroup.ParamColor);
      OldRecNo := dtbparamsanaloggroup.RecNo;
      dtbparamsanaloggroup.Refresh;
      dtbparamsanaloggroup.RecNo := OldRecNo;
    end;
  finally
    FModifyParamOfAnlGroup.Free;
  end;
end;

procedure TChooseArchiveForm.ActionModParamUpdate(Sender: TObject);
begin
  ActionModParam.Enabled := not dtbanaloggroups.IsEmpty
  {$IFNDEF USE_ADMIN}
  and (not dtbanaloggroups.FieldByName('username').IsNull);
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TChooseArchiveForm.ActionParamToFirstExecute(Sender: TObject);
begin
  dtbparamsanaloggroup.First;
end;

procedure TChooseArchiveForm.ActionParamToFirstUpdate(Sender: TObject);
begin
  ActionParamToFirst.Enabled := not dtbparamsanaloggroup.IsEmpty;
end;

procedure TChooseArchiveForm.ActionParamToLastExecute(Sender: TObject);
begin
  dtbparamsanaloggroup.Last;
end;

procedure TChooseArchiveForm.ActionParamToLastUpdate(Sender: TObject);
begin
  ActionParamToLast.Enabled := not dtbparamsanaloggroup.IsEmpty;
end;

procedure TChooseArchiveForm.ActionCancelSearchExecute(Sender: TObject);
begin
  EditSearch.Text := EmptyStr;
end;

constructor TChooseArchiveForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  PanelDetailParams.Visible := False;
  dtbanaloggroups.Filtered := True;
  dtbanaloggroups.Connection := UDM.MySQLConnection;
  dtbparamsanaloggroup.Connection := UDM.MySQLConnection;
  tdbAllParams.Connection := UDM.MySQLConnection;
  {$IFNDEF USE_ADMIN}
  //неадминистратор видит все группы админов + свои
  DBGridGroupsusername.Visible := False;
  dtbanaloggroups.SQL.Text :=
     'SELECT * FROM analoggroups ' +
     'WHERE username IS NULL OR username = :username ' +
     'ORDER BY analoggroup_id';
  dtbanaloggroups.ParamByName('username').AsString := UDM.User;
  dtbanaloggroups.Open;
  {$ELSE}
  //администратор видит все группы, всех пользователей
  cxGridDBTableViewusername.Visible := True;
  dtbanaloggroups.SQL.Text :=
     'SELECT * FROM analoggroups ' +
     'ORDER BY analoggroup_id';
  dtbanaloggroups.Open;
  {$ENDIF}
  dtbparamsanaloggroup.Open;
  ChoosedDateTime.DateTime := UDBData.GetServerDateTime;
  BitOK.ModalResult := mrNone;

  ChoosedDateTime.DateTime := FIniConfig.GetIniFloat(SETTING_KEY, ARCHIVE_FILTER_DATE_VAL, DateOf(Now));
end;

procedure TChooseArchiveForm.cxGrid1DBTableView1colorCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.FillRect(AViewInfo.Bounds, TColor(AViewInfo.Value));
  ADone := True;
end;

procedure TChooseArchiveForm.DBGridParamscolorCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  AColor := StrToIntDef(ANode.Strings[2], clWhite);
  AText := EmptyStr;
end;

procedure TChooseArchiveForm.DBGridParamsDblClick(Sender: TObject);
begin
  ActionModParam.Execute;
end;

destructor TChooseArchiveForm.Destroy;
begin
  FIniConfig.Free;
  dtbanaloggroups.Close;
  dtbparamsanaloggroup.Close;
  inherited Destroy;
end;

procedure TChooseArchiveForm.dtbanaloggroupsAfterOpen(DataSet: TDataSet);
begin
  LabelGroupsCount.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TChooseArchiveForm.dtbanaloggroupsAfterRefresh(DataSet: TDataSet);
begin
  LabelGroupsCount.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TChooseArchiveForm.dtbanaloggroupsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  aSearchStr : string;
begin
  aSearchStr := Trim(EditSearch.Text);
  Accept := (Pos(AnsiUpperCase(aSearchStr), AnsiUpperCase(DataSet.FieldByName('name').AsString)) > 0) or (aSearchStr = EmptyStr);
end;

procedure TChooseArchiveForm.dtbparamsanaloggroupAfterOpen(DataSet: TDataSet);
begin
  LabelParamsCount.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TChooseArchiveForm.dtbparamsanaloggroupAfterRefresh(DataSet: TDataSet);
begin
  LabelParamsCount.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TChooseArchiveForm.EditSearchChange(Sender: TObject);
begin
  dtbanaloggroups.Filtered := False;
  dtbanaloggroups.Filtered := True;
  LabelGroupsCount.Caption := IntToStr(dtbanaloggroups.RecordCount);
end;

function TChooseArchiveForm.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
  if UDBData.InTransaction then
    if Result then
      UDBData.ComitTransaction
    else
      UDBData.RollBackTransaction;
end;

procedure TChooseArchiveForm.FormShow(Sender: TObject);
begin
  EditDateTimeStart.Time := StartOfTheDay(UDBData.GetServerDateTime);
  EditDateTimeEnd.Time := EndOfTheDay(UDBData.GetServerDateTime);
end;

function TChooseArchiveForm.GetDateTimeStart: TDateTime;
var aTime : TDateTime;
begin
  aTime := EncodeTime(HourOf(EditDateTimeStart.Time), MinuteOf(EditDateTimeStart.Time), 0, 0);
  Result := DateOf(ChoosedDateTime.DateTime) + aTime;
end;

function TChooseArchiveForm.GetGroupName: string;
begin
  Result := Trim(dtbanaloggroups.FieldByName('name').AsString);
end;

function TChooseArchiveForm.GetDateTimeEnd: TDateTime;
var aTime : TDateTime;
begin
  aTime := EncodeTime(HourOf(EditDateTimeEnd.Time), MinuteOf(EditDateTimeEnd.Time), 0, 0);
  Result := DateOf(ChoosedDateTime.DateTime) + aTime;
end;

function TChooseArchiveForm.GetParamGroupId: Integer;
begin
  Result := dtbanaloggroups.FieldByName('analoggroup_id').AsInteger;
end;

procedure TChooseArchiveForm.BtnShowDetailParamsClick(Sender: TObject);
begin
  PanelDetailParams.Visible := not PanelDetailParams.Visible;
end;

procedure TChooseArchiveForm.BitOKClick(Sender: TObject);
var
  aTimeStart, aTimeEnd: TTime;
begin
  aTimeStart := EncodeTime(HourOf(EditDateTimeStart.Time), MinuteOf(EditDateTimeStart.Time), 0, 0);
  aTimeEnd := EncodeTime(HourOf(EditDateTimeEnd.Time), MinuteOf(EditDateTimeEnd.Time), 0, 0);
  if aTimeStart >= aTimeEnd then
    raise EChooseAnl.Create('Дата начала должна быть меньше даты окончания.');
  FIniConfig.SetIniFloat(SETTING_KEY, ARCHIVE_FILTER_DATE_VAL, DateOf(ChoosedDateTime.DateTime));
  ModalResult := mrOk;
end;

procedure TChooseArchiveForm.ActionDelParamExecute(Sender: TObject);
begin
  if not UDBData.InTransaction then
    UDBData.StartTransaction;
  try
    UDBData.DeleteParamQueryFromArchiveGroup(dtbanaloggroups.FieldByName('analoggroup_id').AsInteger,
      dtbparamsanaloggroup.FieldByName('paramquery_id').AsInteger);
    if UDBData.InTransaction then
      UDBData.ComitTransaction;
  except
    if UDBData.InTransaction then
      UDBData.RollBackTransaction;
  end;
  dtbparamsanaloggroup.Refresh;
  dtbparamsanaloggroup.First;
end;

end.

