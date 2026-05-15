{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit dm_general;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ZConnection, DB, ZDataset, dbtables, IniFiles, ADODB, bsDialogs, ExtDlgs,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient;

type
  EDM = class(Exception);

  TIniConfig = class;
  
  //класс отвечает за подключение к базе данных
  TDM = class(TDataModule)
    ADOConnection: TADOConnection;
    MySQLConnection: TZConnection;
  private
    FConnected: Boolean;
    FHost, FHostDes, FDBName, FUser, FPassword: string;
    FIniConfig: TIniConfig;
    FPort: Integer;
    FUserId: Longword;
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    destructor Destroy; override;
    function Connect: Boolean;
    function CreateDataSet(const ASQL: string): TDataSet;
    property Connected: Boolean read FConnected;
    property DBName: string read FDBName;
    property Host: string read FHost;
    property HostDes: string read FHostDes;
    property Port: Integer read FPort;
    property User: string read FUser;
    property UserId: Longword read FUserId;
  end;

  //Класс читает/записывает информацию INI файл*********************************
  TIniConfig = class
  private
    FFilePath : string;
  public
    constructor Create(const FilePath: string);
    //Читает все хосты
    procedure ReadIniHosts(Hosts: TStrings);
    //Записывает указанные хосты
    function GetIniFloat(const Section, Ident: string; const Default: Double): Double;
    function GetIniInt(const Section, Ident: string; const Default: Integer): Integer;
    function GetIniStr(const Section, Ident, Default: string): string;
    procedure SetIniFloat(const Section, Ident: string; const Value: Double);
    procedure SetIniInt(const Section, Ident : string; const Value: Integer);
    procedure SetIniStr(const Section, Ident, Value: string);
    procedure WriteIniHosts(Hosts: TStrings);
  end;

var
  UDM: TDM = nil;

implementation

uses
  ZDbcIntfs, globalmethods, Settings, globalvars, Wcrypt2, Login,
  DialogsEx, NetPC, SPServer, Log;

{$R *.DFM}

function TDM.Connect: Boolean;
type
  THost = record
    HostName, Description : string;
  end;

var
  aAgreementFlag, inputedSN: Boolean;
  aPathINI, aSettingsObject: TSettings;
  fLogin: TLogin;
  fSettings: TSettings;
  hash: HCRYPTHASH;
  hashData, hProv: HCRYPTPROV;
  hSKey: HCRYPTKEY;
  IdIcmpClient: TIdIcmpClient;
  LicFilePath: string;
  ListHosts: TStringList;
  localPathIniFile,
  p: PByte;
  pswd_hash_db, slLic: TStringList;
  sz: dword;
  ZQuery: TZQuery;

  //Разделяет описание хоста на описание и имя
  function GetHost(const aStr : string): THost;
  var k : Integer;
  begin
    k := Pos('#', aStr);
    if k > 0 then
    begin
      Result.Description := Copy(aStr, k + 1, Length(aStr) - k);
      Result.HostName := Copy(aStr, 1, k - 1);
    end else begin
      Result.Description := aStr;
      Result.HostName := aStr;
    end;
  end;

begin
  try
    FConnected := False;
    
    ASSERT(FileExists('libmysql51.dll'), 'Не удалось обнаружить файл libmysql51.dll');
    ASSERT(FileExists('user32.dll'), 'Не удалось обнаружить файл user32.dll');

    if not FileExists(GetConfigIniFile) then
    begin
      fSettings := TSettings.Create(Self); 
      try
        if (_MessageBox(0, PChar('Файл конфигурации не обнаружен на компьютере. Сейчас будет произведена его настройка'),
          'Предупреждение', MB_YESNO + MB_ICONQUESTION) <> IDYES) or not fSettings.Execute then
            raise EDM.Create('Не удалось открыть программу из-за отказа создания конфигурационного файла');
      finally
        fSettings.Free;
      end;
    end;
     
    //свойста подключения
    FDBName := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_NAME_VAL, EmptyStr);
    FUser := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_LOGIN_VAL, EmptyStr);
    FPassword := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_PASSWORD_VAL, EmptyStr);
    FPort := FIniConfig.GetIniInt(DB_UNIT_KEY, DB_PORT_VAL, 3306);

    MySQLConnection.Database := FDBName;
    MySQLConnection.User := FUser;
    MySQLConnection.Password := FPassword;
    MySQLConnection.Port := FPort;

    //выбираю хост
    ListHosts := TStringList.Create;
    try
      FIniConfig.ReadIniHosts(ListHosts);
      if ListHosts.Count = 1 then
      begin
        //если хост один
        FHost := GetHost(ListHosts.ValueFromIndex[0]).HostName;
        FHostDes := GetHost(ListHosts.ValueFromIndex[0]).Description;
      end else
        if ListHosts.Count > 0 then
        begin
          //хостов несколько
          fLogin := TLogin.Create(nil, ListHosts);
          with fLogin do
          try
            if Execute then
            begin
              FHostDes := GetHost(ListHosts.ValueFromIndex[FLogin.HostIndex]).Description;
              FHost := GetHost(ListHosts.ValueFromIndex[FLogin.HostIndex]).HostName;
            end else
              raise EDM.Create('Запуск приложения был прерван');
          finally
            fLogin.Free;
          end;
        end else
          raise EDM.Create('Не задан хост. Приложение будет закрыто');
    finally
      ListHosts.Free;
    end;

    MySQLConnection.HostName := FHost;

    //с выбором хоста определились, иду дальше
    MySQLConnection.AutoCommit := False;
    MySQLConnection.TransactIsolationLevel := ZDbcIntfs.tiReadCommitted;

    try
      MySQLConnection.Connect;
      //соединение прошло успешно, получу id пользователя
      with TZQuery.Create(nil) do
      try
        Connection := MySQLConnection;
        SQL.BeginUpdate;
        SQL.Clear;
        SQL.Add('SELECT user_id FROM users WHERE name = :user');
        SQL.EndUpdate;
        ParamByName('user').AsString := FUser;
        Open;
        FUserId := FieldByName('user_id').AsInteger;
        Close;
      finally
        Free;
      end;
    except
      on E: Exception do raise EDM.Create('Ошибка подключения к MySQL');
    end;

    {$IFDEF USE_MDSERVER}
    //подключаюсь к базе данных сп сети
    if SPServer.SPServerInstall then
    begin
      ADOConnection.ConnectionString := Format('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s\Spdef.mdb;' +
        'Mode=Read;Persist Security Info=False', [GetSPServerPath]);
      try
        ADOConnection.Open;
      except
        on E: Exception do raise EDM.Create('Ошибка подключения к MS Access');
      end;
    end;
    {$ENDIF}
    
    //подключение прошло успешно
    FConnected := True;
  finally
    Result := FConnected;
  end;
end;

constructor TDM.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  if MySQLConnection.Connected then MySQLConnection.Disconnect;
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
end;

destructor TDM.Destroy;
begin
  if MySQLConnection.Connected then MySQLConnection.Disconnect;
  {$IFDEF USE_MDSERVER}
  if ADOConnection.Connected then ADOConnection.Close;
  {$ENDIF}
  FIniConfig.Free;
  inherited Destroy;
end;

function TDM.CreateDataSet(const ASQL: string): TDataSet;
begin
  ASSERT(FConnected, 'Не вызван метод Connect');
  try
    if not MySQLConnection.Ping then MySQLConnection.Reconnect;
  except
    on E: Exception do raise EDM.Create('Ошибка переподключения к MySQL');
  end;
  Result := TZQuery.Create(Self);
  with Result as TZQuery do
  try
    Connection := MySQLConnection;
    SQL.BeginUpdate;
    SQL.Clear;
    SQL.Add(ASql);
    SQL.EndUpdate;
  except
    on E: Exception do WriteToLog('E: CreateDataSet' + E.Message);
  end;
 end;

{TIniConfig}

function TIniConfig.GetIniStr(const Section, Ident, Default: string): string;
begin
  with TIniFile.Create(FFilePath) do
  try
    Result := ReadString(Section, Ident, Default);
  finally
    Free;
  end;
end;

constructor TIniConfig.Create(const FilePath : string);
begin
  FFilePath := FilePath;
end;

function TIniConfig.GetIniFloat(const Section, Ident: string;
  const Default: Double): Double;
begin
  with TIniFile.Create(FFilePath) do
  try
    Result := ReadFloat(Section, Ident, Default);
  finally
    Free;
  end;
end;

function TIniConfig.GetIniInt(const Section, Ident : string;
  const Default: Integer) : Integer;
begin
  with TIniFile.Create(FFilePath) do
  try
    Result := ReadInteger(Section, Ident, Default);
  finally
    Free;
  end;
end;

procedure TIniConfig.SetIniFloat(const Section, Ident: string;
  const Value: Double);
begin
  with TIniFile.Create(FFilePath) do
  try
    WriteFloat(Section, Ident, Value);
  finally
    Free;
  end;
end;

procedure TIniConfig.SetIniInt(const Section, Ident : string;
  const Value: Integer);
begin
  with TIniFile.Create(FFilePath) do
  try
    WriteInteger(Section, Ident, Value);
  finally
    Free;
  end;
end;

procedure TIniConfig.SetIniStr(const Section, Ident, Value : string);
begin
  with TIniFile.Create(FFilePath) do
  try
    WriteString(Section, Ident, Value);
  finally
    Free;
  end;
end;

procedure TIniConfig.WriteIniHosts(Hosts: TStrings);
var sl : TStringList;
    i, k : Integer;
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(FFilePath);
    i := 0;
    k := -1;
    //упдаляю все хосты
    while i < sl.Count do
    begin
      if AnsiUpperCase(sl[i]) = '[' + AnsiUpperCase(DB_UNIT_KEY) + ']' then
        k := i;
      if Pos(AnsiUpperCase(DB_HOST_VAL), AnsiUpperCase(sl[i])) = 1 then
        sl.Delete(i)
      else
        Inc(i);
    end;
    if k <> -1 then
    //добавляю хосты
    for i := Hosts.Count - 1 downto 0 do
       sl.Insert(k + 1, DB_HOST_VAL + '=' + Hosts[i]);
    sl.SaveToFile(FFilePath);
  finally
    sl.Free;
  end;
end;

procedure TIniConfig.ReadIniHosts(Hosts : TStrings);
var sl : TStringList;
    i : Integer;
begin
  //читаю хосты
  if not FileExists(FFilePath) then Exit;  
  sl := TStringList.Create;
  try
    sl.LoadFromFile(FFilePath);
    for i := 0 to sl.Count - 1 do
      if Pos(AnsiUpperCase(DB_HOST_VAL), AnsiUpperCase(sl[i])) = 1 then
       Hosts.Add(sl[i]);
  finally
    sl.Free;
  end;
end;

end.
