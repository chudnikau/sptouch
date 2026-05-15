{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit DBdata;

interface

uses DB, SysUtils, Classes, ZConnection, dm_general, Dialogs, ZDataset,
     ZAbstractDataset, SPData, ADODB;

type
  TDevice = class
    Id : LongWord;                       //real id of meter
    Enabled : Boolean;                   //enabled/disable meter for inquery
    Name : string[120];
    Description : string[120];           //description of meter
    TypeDeviceId : Integer;               //type of meter
    Device : Integer;
  end;

  //Потребитель
  TCustomer = record
    Id: LongWord;                       //real id product
    Name: string;                       //name of product
    ConsId: LongWord;                   //implements product to consumer
    ReportId: LongWord;
    MonthCount, DayCount: Word;
    Description: string[120];           //description of product
    SubId: LongWord;
  end;

  TArrayCons = array of TCustomer;

  EDBData = class(Exception);

  TDBData = class
  private
    FDM: TDM;
    procedure WriteArchiveValue(const aProcName : string; const aParamQueryId : LongWord; const aValue : Single; const aDateTime : TDateTime); overload;
    procedure WriteArchiveValue(const aProcName: string; const aParamQueryId: LongWord; const aValue: Single); overload;
  public
    constructor Create(const aDM: TDM);
    function AddConsumerism(const aName, aDescription : string; const aReportId, aSubId : LongWord; const aType, aTree : Word) : LongWord;

    function GetArrayParamsQuery(const DeviceID : LongWord) : TDesParams;
    function GetDayViewReportCount: Integer;
    function GetDevice(const DeviceID : LongWord): TDataSet;
    function GetDevices(const aEnabled : Boolean; const aGroupCode : Integer) : TDataSet;
    function GetListGroups : TStringList;
    function GetMonthViewReportCount: Integer;
    function GetParamQueryArchive(const aParamQueryId : LongWord; const aDateTimeStart, aDateTimeEnd : TDateTime) : TDataSet;
    function GetParamsQuery(const DeviceID : LongWord) : TDesParams;
    function GetParamsQueryOfArchiveGroup(const aGroupId : Integer) : TDataSet;
    function GetServerDateTime : TDateTime;
    function GetVariantVal(const aSql: string; const aValue: array of Variant; const aReturnField: string): Variant;
    function GetYearViewReportCount: Integer;

    procedure AddAlertToArchive(const aDesParams : TDesParams);
    procedure AddArchiveGroup(const aGroupName, aUserName : string);
    procedure AddDiagram(const aLowValue, aHightValue : Double; const aConsumerismId : LongWord; const aDiagramsName, aDimantionsName : string; aTablesAngle : Word);
    procedure AddParamQuery(const aMeterId, aParamId : LongWord; const AEnabled : Byte);
    procedure AddParamQueryToArchiveGroup(const aGroupId, aParamQueryId : LongWord);
    procedure AddParamQueryToDiagram(const aDiagramId, aParamQueryId : LongWord); overload;
    procedure AddParamQueryToDiagram(const aDiagramId, aParamQueryId : LongWord; const aOrder, aColor : Integer; const aCaption : string; aWValue, aAValue : Double); overload;
    procedure AddParamQueryToReport(const aParamQueryId, aReportId : LongWord; const aSQLParam : string);

    procedure DeleteArchiveGroup(const aArchiveGroupId : Longword);
    procedure DeleteCons(const aConsId : LongWord);
    procedure DeleteDiagram(const aDiagramId : LongWord);
    procedure DeleteNotRelatedReports;
    procedure DeleteParamQuery(const aParamQueryId : LongWord);
    procedure DeleteParamQueryFromArchiveGroup(const aGroupId, aParamQueryId : LongWord);
    procedure DeleteParamQueryFromDiagram(const aDiagramId, aParamQueryId : LongWord);
    procedure DeleteParamQueryFromReport(const aParamQueryId, aReportId : LongWord);

    procedure UpdateArrayIdOfParamQuery(const aParamQueryId, aMeterId: LongWord; const aArrayId: LongWord);
    procedure UpdateConsDescription(const aConsId : Longword; const aDescription : string);
    procedure UpdateConsName(const aConsId : Longword; const aName : string);
    procedure UpdateConsReportId(const aConsId, aReportId : Longword);
    procedure UpdateConsSubId(const aConsId, aSubId: Longword);
    procedure UpdateConsType(const aConsId : Longword; const aType : Word);
    procedure UpdateCreateUserNameOfReport(const aReportId: LongWord; const aCreateUserName: string);
    procedure UpdateDiagram(const aDiagramId, aConsId : LongWord; const aLowValue, aHightValue : Double; const aDiagramsName, aDimantionsName : string; aAngleLable : Smallint);
    procedure UpdateModUserNameOfReport(const aReportId: LongWord; const aModUserName: string);
    procedure UpdateNameOfParamQuery(const aParamQueryId, aMeterId: LongWord; const aName: string);
    procedure UpdateParamQueryOfArchiveGroup(const aGroupId, aParamQueryId: LongWord; const aLValue, aSValue, aHValue: Double; const aColor: Integer);
    procedure UpdateParamQueryOfDiagram(const aDiagramId, aParamQueryId : LongWord; const aOrder, aColor : Integer; const aCaption : string; aWValue, aValue : Double);
    procedure UpdateSQLOfReport(const aReportId: LongWord; const Value: string);
    procedure UpdateUnitIdOfParamQuery(const aParamQueryId, aMeterId : LongWord; const aUnitId: LongWord);
    
    procedure WriteDayValueToArchive(const aParamQueryId : LongWord; const aValue : Single; const aDateTime : TDateTime);
    procedure WriteHourValueToArchive(const aParamQueryId : LongWord; const aValue : Single; const aDateTime : TDateTime);   overload;
    procedure WriteMomentAnalogValue(const aDesParams : TDesParams);
    procedure WriteMomentValueToArchive(const aDesParams : TDesParams);
    procedure WriteMonthValueToArchive(const aParamQueryId : LongWord; const aValue : Single; const aDateTime : TDateTime);  overload;

    function IfThen(const aValue: Boolean; const aTrue, aFalse: Variant): Variant;
    function InTransaction: Boolean;
    function MySQLPingServer: Boolean;
    function UserIsAdmin(const aUserName: string) : Boolean;
    procedure ComitTransaction;
    procedure ExecSQL(const aSql: string; const aValue: array of Variant);
    procedure FillMetData(aDataSet: TZQuery; aMetData: TDevice);
    procedure RollBackTransaction;
    procedure StartTransaction;
  end;

var
  UDBData: TDBData;

implementation

uses Variants, DateUtils, ZAbstractRODataset;

constructor TDBData.Create(const aDM : TDM);
begin
  inherited Create;
  FDM := aDM;
end;

function TDBData.GetListGroups: TStringList;
var
  dbGroup: TADOQuery;
begin
  Result := nil;
  if not Assigned(FDM) then Exit;
  if not FDM.ADOConnection.Connected then Exit;
  dbGroup := TADOQuery.Create(nil);
  try
     dbGroup.Connection := FDM.ADOConnection;
     dbGroup.SQL.Text := 'SELECT НаименованиеГруппы, КодГруппы FROM Группы';
     try
       dbGroup.Open;
       Result := TStringList.Create;
       while not dbGroup.Eof do
       begin
         Result.AddObject(dbGroup.FieldByName('НаименованиеГруппы').AsString,
            TObject(dbGroup.FieldByName('КодГруппы').AsInteger));
         dbGroup.Next;
       end;
     except
     end;
  finally
     dbGroup.Free;
  end;
end;

procedure TDBData.WriteMomentAnalogValue(const aDesParams: TDesParams);
var
  aSQL: string;
  i: Integer;
begin
  aSQL := 'UPDATE paramsqueries SET ' +
            'value = :value, ' +
            'lastvalueupdate = NOW() ' +
          'WHERE paramquery_id = :id';
  for i := 0 to Length(aDesParams) - 1 do
    ExecSQL(aSQL, [aDesParams[i].Value, aDesParams[i].Id]);
end;

procedure TDBData.WriteMomentValueToArchive(const aDesParams: TDesParams);
var
  aSQL: string;
  i: Integer;
begin
  aSQL := 'INSERT INTO anlarchive ' +
          ' (paramquery_id, date, value) ' +
          'VALUES ' +
          ' (:paramquery_id, NOW(), :value)';
  for i := 0 to Length(aDesParams) - 1 do
    ExecSQL(aSQL, [aDesParams[i].Id, aDesParams[i].Value]);
end;

procedure TDBData.ComitTransaction;
begin
  FDM.MySQLConnection.Commit;
end;

procedure TDBData.FillMetData(aDataSet: TZQuery; aMetData: TDevice);
begin
  with aMetData, aDataSet do
  begin
    Id := FieldByName('meter_id').AsInteger;
    Device := FieldByName('device').AsInteger;
    TypeDeviceId := FieldByName('typemeter_id').AsInteger;
    Enabled := Boolean(FieldByName('enabled').AsInteger);
    Name := FieldByName('name').AsString;
    Description := FieldByName('description').AsString;
  end;
end;

function TDBData.GetDayViewReportCount: Integer;
begin
  Result := UDBData.GetVariantVal('SELECT daycount FROM reportdatecount LIMIT 1', [], 'daycount');
end;

function TDBData.GetMonthViewReportCount: Integer;
begin
  Result := UDBData.GetVariantVal('SELECT monthcount FROM reportdatecount LIMIT 1', [], 'monthcount');
end;

function TDBData.UserIsAdmin(const aUserName: string): Boolean;
var
  aSQL: string;
  aZQuery: TZQuery;
  i: Integer;
  B: Boolean;
begin
  aSQL :=
  'SELECT Select_priv, Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv,                ' +
  '       Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv, References_priv,          ' +
  '       Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, Lock_tables_priv, ' +
  '       Execute_priv, Repl_slave_priv, Repl_client_priv, Create_view_priv, Show_view_priv,         ' +
  '       Create_routine_priv, Alter_routine_priv, Create_user_priv                                  ' +
  'FROM mysql.user WHERE user = :user';
  aZQuery := FDM.CreateDataSet(aSQL) as TZQuery;
  with aZQuery do
  try
    ParamByName('user').AsString := aUserName;
    Open;
    B := True;
    for i := 0 to Fields.Count - 1 do
    begin
      B := B and (Fields[i].AsString = 'True');
      if not B then Break;
    end;
    Result := B;
  finally
    aZQuery.Free;
  end;
end;

function TDBData.GetYearViewReportCount: Integer;
begin
  Result := UDBData.GetVariantVal('SELECT yearcount FROM reportdatecount LIMIT 1', [], 'yearcount');
end;

function TDBData.GetDevices(const aEnabled : Boolean; const aGroupCode : Integer): TDataSet;
var
  aSQL: string;
begin
  if AEnabled then
     aSQL := Format('SELECT * FROM meters WHERE enabled = 1 AND codegroup = %d ORDER BY meter_id', [aGroupCode])
  else
     aSQL := Format('SELECT * FROM meters WHERE codegroup = %d ORDER BY meter_id', [aGroupCode]);
  Result := FDM.CreateDataSet(aSQL);
end;

procedure TDBData.AddParamQuery(const aMeterId, aParamId: LongWord;
  const AEnabled : Byte);
var
  aSQL : string;
begin
  aSQL := 'CALL procAddParamQuery(:meter_id, :param_id, :enabled)';
  ExecSQL(aSQL, [aMeterId, aParamId, aEnabled]);
end;

procedure TDBData.WriteArchiveValue(const aProcName : string;
  const aParamQueryId : LongWord; const aValue : Single);
var
  aSQL : string;
begin
  aSQL := Format('CALL %s(:paramquery_id, :value)', [aProcName]);
  ExecSQL(aSQL, [aParamQueryId, AValue]);
end;

procedure TDBData.WriteArchiveValue(const aProcName : string;
  const aParamQueryId : LongWord; const aValue : Single; const aDateTime : TDateTime);
var
  aSQL : string;
begin
  aSQL := Format('CALL %s(:paramquery_id, :value, :datetime)', [aProcName]);
  ExecSQL(aSQL, [aParamQueryId, AValue, aDateTime]);
end;

procedure TDBData.WriteHourValueToArchive(const aParamQueryId : LongWord; const aValue : Single;
  const aDateTime : TDateTime);
begin
  WriteArchiveValue('procAddArchiveHoursE', aParamQueryId, aValue, aDateTime);
end;

procedure TDBData.WriteDayValueToArchive(const aParamQueryId : LongWord; const aValue : Single;
  const aDateTime : TDateTime);
begin
  WriteArchiveValue('procAddArchiveDaysE', aParamQueryId, aValue, aDateTime);
end;

procedure TDBData.WriteMonthValueToArchive(const aParamQueryId : LongWord; const aValue : Single;
  const aDateTime : TDateTime);
begin
  WriteArchiveValue('procAddArchiveMonthesE', aParamQueryId, aValue, aDateTime);
end;

procedure TDBData.DeleteParamQuery(const aParamQueryId: LongWord);
var
  aSQL : string;
begin
  aSQL := 'CALL procDeleteParamQuery(:paramquery_id)';
  ExecSQL(aSQL, [aParamQueryId]);
end;

function TDBData.GetParamsQuery(const DeviceID: LongWord): TDesParams;
var
  aSQL: string;
  aZQuery: TZQuery;
begin
  SetLength(Result, 0);
  aSQL :=
  'SELECT paramsqueries.paramquery_id, ' +
  '       paramsqueries.param_id,      ' +
  '       unitsparams.unitSN           ' +
  'FROM paramsqueries           ' +
  'INNER JOIN params ON params.param_id = paramsqueries.param_id AND        ' +
  'paramsqueries.array_id IS NULL                                           ' +
  'LEFT JOIN unitsparams ON unitsparams.unitparam_id = params.unitparam_id  ' +
  'WHERE paramsqueries.meter_id = :meter_id AND paramsqueries.enabled > 0   ' +
  'ORDER BY params.spparam';
  aZQuery := TZQuery(FDM.CreateDataSet(aSQL));
  try
    aZQuery.ParamByName('meter_id').AsInteger := DeviceID;
    aZQuery.Open;
    while not aZQuery.Eof do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)].Id := aZQuery.FieldByName('paramquery_id').AsInteger;
      Result[High(Result)].ParamID := aZQuery.FieldByName('param_id').AsInteger;
      aZQuery.Next;
    end;
  finally
    aZQuery.Close;
    aZQuery.Free;
  end;
end;

function TDBData.GetArrayParamsQuery(const DeviceID: LongWord): TDesParams;
var
  aSQL: string;
  aZQuery: TZQuery;
begin
  SetLength(Result, 0);
  aSQL :=
  'SELECT paramsqueries.paramquery_id,   ' +
  '       paramsqueries.param_id,        ' +
  '       arraies.code                   ' +
  'FROM paramsqueries             ' +
  'INNER JOIN params ON params.param_id = paramsqueries.param_id AND      ' +
  'paramsqueries.array_id IS NOT NULL                                     ' +
  'LEFT JOIN arraies ON arraies.array_id = paramsqueries.array_id         ' +
  'WHERE paramsqueries.meter_id = :meter_id AND paramsqueries.enabled > 0 ' +
  'ORDER BY params.spparam';
  aZQuery := TZQuery(FDM.CreateDataSet(aSQL));
  try
    aZQuery.ParamByName('meter_id').AsInteger := DeviceID;
    aZQuery.Open;
    while not aZQuery.Eof do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)].Id := aZQuery.FieldByName('paramquery_id').AsInteger;
      Result[High(Result)].ParamID := aZQuery.FieldByName('param_id').AsInteger;
      Result[High(Result)].Code := aZQuery.FieldByName('code').AsString;
      aZQuery.Next;
    end;
  finally
    aZQuery.Close;
    aZQuery.Free;
  end;
end;

function TDBData.GetDevice(const DeviceID: LongWord): TDataSet;
var
  aSQL: string;
begin
  aSQL := Format('SELECT * FROM meters WHERE meter_id = %d', [DeviceID]);
  Result := FDM.CreateDataSet(aSQL);
end;

procedure TDBData.StartTransaction;
begin
  if not FDM.MySQLConnection.InTransaction then
    FDM.MySQLConnection.StartTransaction;
end;

procedure TDBData.RollBackTransaction;
begin
  FDM.MySQLConnection.Rollback;
end;

function TDBData.InTransaction : Boolean;
begin
  Result := FDM.MySQLConnection.InTransaction;
end;

function TDBData.MySQLPingServer : Boolean;
begin
  Result := FDM.MySQLConnection.PingServer;
end;

procedure TDBData.AddParamQueryToArchiveGroup(const aGroupId, aParamQueryId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'INSERT INTO paramsanaloggroup (analoggroup_id, paramquery_id) ' +
         'VALUES ' +
         '(:analoggroup_id, :paramquery_id)';
  ExecSQL(aSQL, [aGroupId, aParamQueryId]);
end;

procedure TDBData.AddArchiveGroup(const aGroupName, aUserName: string);
var
  aSQL: string;
begin
  aSQL := 'INSERT INTO analoggroups (name, username) ' +
          'VALUES ' +
          '(:name, :username)';
  ExecSQL(aSQL, [aGroupName, IfThen(aUserName = EmptyStr, Null, aUserName)])
end;

procedure TDBData.DeleteParamQueryFromArchiveGroup(const aGroupId, aParamQueryId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM paramsanaloggroup ' +
          'WHERE analoggroup_id = :analoggroup_id AND paramquery_id = :paramquery_id';
  ExecSQL(aSQL, [aGroupId, aParamQueryId]);
end;

procedure TDBData.UpdateParamQueryOfArchiveGroup(const aGroupId, aParamQueryId: LongWord;
  const aLValue, aSValue, aHValue: Double; const aColor: Integer);
var
  aSQL: string;
begin
  aSQL := 'UPDATE paramsanaloggroup SET ' +
          'lvalue = :lvalue, ' +
          'svalue = :svalue, ' +
          'hvalue = :hvalue, ' +
          'color = :color ' +
         'WHERE analoggroup_id = :analoggroup_id AND paramquery_id = :paramquery_id';
  ExecSQL(aSQL, [aLValue, aSValue, aHValue, aColor, aGroupId, aParamQueryId]);
end;

function TDBData.GetParamsQueryOfArchiveGroup(const AGroupId: Integer): TDataSet;
var
  aSQL: string;
  aZQuery: TZQuery;
begin
  aSQL :=
  'SELECT paramsqueries.paramquery_id,         ' +
  '       paramsanaloggroup.color,             ' +
  '       paramsqueries.name paramquery_name,  ' +
  '       meters.name,                         ' +
  '       params.spparam,                      ' +
  '       params.canal,                        ' +
  '       params.description,                  ' +
  '       unitsparams.unitSN,                  ' +
  '       paramsanaloggroup.lvalue,            ' +
  '       paramsanaloggroup.hvalue FROM params ' +
  'INNER JOIN paramsqueries ON paramsqueries.param_id = params.param_id                           ' +
  'INNER JOIN paramsanaloggroup ON paramsanaloggroup.paramquery_id = paramsqueries.paramquery_id  ' +
  'INNER JOIN meters ON meters.meter_id = paramsqueries.meter_id                                  ' +
  'LEFT JOIN unitsparams ON unitsparams.unitparam_id = paramsqueries.unitparam_id                 ' +
  'WHERE paramsanaloggroup.analoggroup_id = :analoggroup_id ORDER BY paramsqueries.paramquery_id';

   aZQuery := FDM.CreateDataSet(aSQL) as TZQuery;
   aZQuery.ParamByName('analoggroup_id').AsInteger := AGroupId;
   Result := aZQuery;
end;

function TDBData.AddConsumerism(const aName, aDescription: string;
  const aReportId, aSubId: LongWord; const aType, aTree: Word): LongWord;
var
  aSQL: string;
begin
  aSQL := 'INSERT INTO consumerism (name, report_id, user_id, description, subconsumerism_id, type, tree) ' +
          'VALUES (:name, NULLIF(:report_id, 0), :user_id, :description, NULLIF(:subconsumerism_id, 0), :type, :tree)';
  ExecSQL(aSQL, [aName, aReportId, 1, aDescription, aSubId, aType, aTree]);
  Result := GetVariantVal('SELECT LAST_INSERT_ID() LAST_INSERT_ID', [], 'LAST_INSERT_ID');
end;

procedure TDBData.DeleteCons(const aConsId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM consumerism WHERE consumerism_id = :consumerism_id';
  ExecSQL(aSQL, [aConsId]);
end;

procedure TDBData.DeleteArchiveGroup(const aArchiveGroupId: Longword);
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM analoggroups ' +
          'WHERE analoggroup_id = :id';
  ExecSQL(aSQL, [aArchiveGroupId]);
end;

procedure TDBData.DeleteNotRelatedReports;
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM reports ' +
          'WHERE reports.report_id NOT IN ' +
            '(SELECT report_id FROM consumerism WHERE report_id IS NOT NULL)';
  ExecSQL(aSQL, []);
end;

procedure TDBData.UpdateConsReportId(const aConsId, aReportId: Longword);
var
  aSQL: string;
begin
  aSQL := 'UPDATE consumerism SET ' +
            'report_id = :report_id ' +
          'WHERE consumerism_id = :consumerism_id';
  ExecSQL(aSQL, [aReportId, aConsId]);
end;

procedure TDBData.UpdateConsName(const aConsId: Longword; const aName: string);
var
  aSQL: string;
begin
  aSQL := 'UPDATE consumerism SET ' +
            'name = :name ' +
          'WHERE consumerism_id = :id';
  ExecSQL(aSQL, [aName, aConsId]);
end;

procedure TDBData.UpdateConsDescription(const aConsId: Longword; const aDescription: string);
var
  aSQL: string;
begin
  aSQL := 'UPDATE consumerism SET ' +
             'description = :description ' +
          'WHERE consumerism_id = :consumerism_id';
  ExecSQL(aSQL, [aDescription, aConsId]);
end;

procedure TDBData.UpdateConsType(const aConsId: Longword; const aType: Word);
var
  aSQL: string;
begin
  aSQL := 'UPDATE consumerism SET ' +
             'type = :type ' +
          'WHERE consumerism_id = :consumerism_id';
  ExecSQL(aSQL, [aType, aConsId]);
end;

procedure TDBData.AddDiagram(const aLowValue, aHightValue: Double;
  const aConsumerismId: LongWord; const aDiagramsName, aDimantionsName: string;
   ATablesAngle: Word);
var
  aSQL: string;
begin
  aSQL := 'INSERT INTO diagrams (lvalue, hvalue, name, consumerism_id, anglelable, dimensionname) ' +
          'VALUES ' +
          '(:lvalue, :hvalue, :name, :consumerism_id, :anglelable, :dimensionname)';
  ExecSQL(aSQL, [aLowValue, aHightValue, aDiagramsName, aConsumerismId, aTablesAngle, aDimantionsName]);
end;

procedure TDBData.UpdateDiagram(const aDiagramId, aConsId: LongWord;
  const aLowValue, AHightValue: Double; const aDiagramsName, aDimantionsName: string;
   aAngleLable: Smallint);
var
  aSQL: string;
begin
  aSQL := 'UPDATE diagrams SET ' +
              'lvalue=:lvalue, ' +
              'hvalue=:hvalue, ' +
              'name=:name, ' +
              'consumerism_id=:consumerism_id, ' +
              'anglelable = :anglelable, ' +
              'dimensionname = :dimensionname ' +
          'WHERE diagram_id = :diagram_id';
  ExecSQL(aSQL, [aLowValue, aHightValue, aDiagramsName, aConsId, aAngleLable, aDimantionsName, aDiagramId]);
end;

procedure TDBData.DeleteDiagram(const aDiagramId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM diagrams WHERE diagram_id = :id';
  ExecSQL(aSQL, [aDiagramId]);
end;

procedure TDBData.AddParamQueryToDiagram(const aDiagramId, aParamQueryId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'INSERT paramsdiagrams (diagram_id, paramquery_id) VALUES (:diagram_id, :paramquery_id)';
  ExecSQL(aSQL, [aDiagramId, aParamQueryId]);
end;

procedure TDBData.AddAlertToArchive(const aDesParams: TDesParams);
var
  aSQL: string;
  i: Integer;
begin
  aSQL := 'INSERT INTO alertarchive (paramquery_id, value, wvalue, avalue, date) ' +
          'SELECT paramquery_id, value, wvalue, avalue, NOW() AS date FROM analog_alert ' +
          'WHERE paramquery_id = :paramquery_id AND alert_type > 1';
  for i := 0 to Length(aDesParams) - 1 do
    ExecSQL(aSQL, [aDesParams[i].Id]);
end;

procedure TDBData.AddParamQueryToDiagram(const aDiagramId, aParamQueryId: LongWord;
    const aOrder, aColor: Integer; const aCaption: string; aWValue, aAValue: Double);
var
  aSQL: string;
begin
  aSQL := 'INSERT paramsdiagrams (diagram_id, paramquery_id, color, caption, avalue, wvalue, paramsdiagrams.order) ' +
          'VALUES (:diagram_id, :paramquery_id, :color, :caption, :avalue, :wvalue, :order)';
  ExecSQL(aSQL, [aDiagramId, aParamQueryId, aColor, aCaption, aAValue, aWValue, aOrder]);
end;

procedure TDBData.UpdateParamQueryOfDiagram(const aDiagramId, aParamQueryId: LongWord;
  const aOrder, aColor: Integer; const aCaption: string; aWValue, aValue: Double);
var
  aSQL: string;
begin
  aSQL := 'UPDATE paramsdiagrams SET ' +
          '  color=:color,       ' +
          '  caption=:caption,   ' +
          '  avalue=:avalue,     ' +
          '  wvalue=:wvalue,     ' +
          '  paramsdiagrams.order=:order ' +
          'WHERE diagram_id = :diagram_id AND paramquery_id = :paramquery_id';
  ExecSQL(aSQL, [aColor, aCaption, aValue, aWValue, aOrder, aDiagramId, aParamQueryId]);
end;

procedure TDBData.DeleteParamQueryFromDiagram(const aDiagramId, aParamQueryId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM paramsdiagrams ' +
          'WHERE diagram_id = :diagram_id AND paramquery_id = :paramquery_id';
  ExecSQL(aSQL, [aDiagramId, aParamQueryId]);
end;

function TDBData.GetVariantVal(const aSql: string; const aValue: array of Variant;
  const aReturnField: string): Variant;
var
  aZQuery: TZQuery;
  i: Integer;
begin
  aZQuery := FDM.CreateDataSet(ASql) as TZQuery;
  try
    for i := Low(aValue) to High(aValue) do
      aZQuery.Params[i].Value := aValue[i];
    aZQuery.Open;
    Result := aZQuery.FieldByName(aReturnField).Value;
    aZQuery.Close;
  finally
    aZQuery.Free;
  end;
end;

procedure TDBData.AddParamQueryToReport(const aParamQueryId, aReportId: LongWord;
  const aSQLParam : string);
var
  aSQL: string;
begin
  aSQL := 'INSERT paramsreports (paramquery_id, report_id, sql_param, sql_param_number) ' +
          'VALUES ' +
          '(:paramquery_id, :report_id, :sql_param, CAST(SUBSTRING(:sql_param FROM 3) AS UNSIGNED INTEGER))';
  ExecSQL(aSQL, [aParamQueryId, aReportId, aSQLParam, aSQLParam]);
end;

procedure TDBData.DeleteParamQueryFromReport(const AParamQueryId, AReportId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'DELETE FROM paramsreports ' +
          'WHERE paramquery_id = :paramquery_id AND report_id = :report_id';
  ExecSQL(aSQL, [AParamQueryId, AReportId]);
end;

function TDBData.GetServerDateTime: TDateTime;
var
  aSQL: string;
  aZQuery: TZQuery;
begin
  aSQL := 'SELECT NOW() AS now';
  aZQuery := FDM.CreateDataSet(aSQL) as TZQuery;
  try
    aZQuery.Open;
    Result := aZQuery.FieldByName('now').AsDateTime;
    aZQuery.Close;
  finally
    aZQuery.Free;
  end;
end;

function TDBData.GetParamQueryArchive(const aParamQueryId: LongWord;
  const aDateTimeStart, aDateTimeEnd: TDateTime): TDataSet;
var
  aSQL: string;
  aZQuery: TZQuery;
begin
  Result := nil;
  aSQL := 'SELECT date, value ' +
         'FROM anlarchive ' +
         'WHERE paramquery_id = :paramquery_id AND date BETWEEN :start AND :end';
  aZQuery := FDM.CreateDataSet(aSQL) as TZQuery;
  with aZQuery do
  try
    ParamByName('paramquery_id').AsInteger := aParamQueryId;
    ParamByName('start').AsDateTime := aDateTimeStart;
    ParamByName('end').AsDateTime := aDateTimeEnd;
  except
    aZQuery.Free;
  end;
  Result := aZQuery;
end;

procedure TDBData.UpdateArrayIdOfParamQuery(const aParamQueryId, aMeterId: LongWord;
  const aArrayId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'UPDATE paramsqueries SET ' +
            'array_id = :array_id ' +
          'WHERE paramquery_id = :paramquery_id AND meter_id = :meter_id';
  ExecSQL(aSQL, [IfThen(aArrayId = 0, Null, aArrayId)]);
end;

procedure TDBData.UpdateUnitIdOfParamQuery(const aParamQueryId, aMeterId: LongWord;
  const aUnitId: LongWord);
var
  aSQL: string;
begin
  aSQL := 'UPDATE paramsqueries SET ' +
           'unitparam_id = :unitparam_id ' +
         'WHERE paramquery_id = :paramquery_id AND meter_id = :meter_id';
  ExecSQL(aSQL, [IfThen(aUnitId = 0, Null, aUnitId)]);
end;

procedure TDBData.UpdateNameOfParamQuery(const aParamQueryId, aMeterId: LongWord;
  const aName: string);
var
  aSQL: string;
begin
  aSQL := 'UPDATE paramsqueries SET ' +
           'name = :name ' +
          'WHERE paramquery_id = :paramquery_id AND meter_id = :meter_id';
  ExecSQL(aSQL, [IfThen(aName = EmptyStr, Null, aName), aParamQueryId, aMeterId]);
end;

procedure TDBData.UpdateSQLOfReport(const aReportId: LongWord; const Value: string);
var
  aSQL: string;
begin
  aSQL := 'UPDATE reports SET ' +
           'sql = :sql ' +
         'WHERE report_id = :report_id';
  ExecSQL(aSQL, [aSql, aReportId]);
end;

procedure TDBData.UpdateCreateUserNameOfReport(const aReportId: LongWord; const aCreateUserName: string);
var
  aSQL: string;
begin
  aSQL := 'UPDATE reports SET ' +
           'createusername = :createusername ' +
         'WHERE report_id = :id';
  ExecSQL(aSQL, [aCreateUserName, aReportId]);
end;

procedure TDBData.UpdateModUserNameOfReport(const aReportId: LongWord; const aModUserName: string);
var
  aSQL: string;
begin
  aSQL := 'UPDATE reports SET ' +
           'modusername = :modusername, ' +
           'moddatetime = NOW() ' +
         'WHERE report_id = :id';
  ExecSQL(aSQL, [aModUserName, aReportId]);
end;

procedure TDBData.UpdateConsSubId(const aConsId, aSubId: Longword);
var
  aSQL: string;
begin
  aSQL := 'UPDATE consumerism SET      ' +
            'subconsumerism_id = :sub_id ' +
          'WHERE consumerism_id = :id AND subconsumerism_id IS NOT NULL';
  ExecSQL(aSQL, [aSubId, aConsId]);
end;

procedure TDBData.ExecSQL(const aSql: string; const aValue: array of Variant);
var
  aZQuery: TZQuery;
  i: Integer;
begin
  aZQuery := FDM.CreateDataSet(ASql) as TZQuery;
  try
    for i := Low(aValue) to High(aValue) do
      aZQuery.Params[i].Value := aValue[i];
    aZQuery.ExecSQL;
  finally
    aZQuery.Free;
  end;
end;

function TDBData.IfThen(const aValue: Boolean; const aTrue, aFalse: Variant): Variant;
begin
  if aValue then
    Result := aTrue
  else
    Result := False;
end;

end.
