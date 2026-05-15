{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Settings;

interface

//{$WARN UNIT_PLATFORM OFF}
//{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, bsSkinBoxCtrls, ExtCtrls, dxCntner,
  dxExEdtr, dxEdLib, FileCtrl, bsSkinCtrls, ActnList, ShellApi, GIFImage, dm_general,
  Edits, HelpPic;

type
  TSettings = class(TForm)
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PriorityCombo: TbsSkinComboBox;
    CheckBoxNotUseInterval: TCheckBox;
    ComboGroupList: TbsSkinComboBox;
    Label1: TLabel;
    EditReliabilityRead: TbsSkinComboBox;
    IncludeParamq: TSpeedButton;
    DeclareParamq: TSpeedButton;
    ActionList: TActionList;
    Del: TAction;
    LC: TLabel;
    GroupBox3: TGroupBox;
    BtnResetLockPswd: TBitBtn;
    DBPort: TMdNumEdit;
    EditInterval: TMdIntEdit;
    DBName: TEdit;
    Label3: TLabel;
    DBLogin: TEdit;
    DBPassword: TEdit;
    HelpPic1: THelpPic;
    Hosts: TListBox;
    procedure CheckBoxNotUseIntervalClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure DelUpdate(Sender: TObject);
    procedure IncludeParamqClick(Sender: TObject);
    procedure DelExecute(Sender: TObject);
    procedure BtnResetLockPswdClick(Sender: TObject);
  private
    FIniConfig: TIniConfig;
    function WasMaintenanceInstall : Boolean;
  public
    function Execute : Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FSettings: TSettings;

implementation

uses Registry, globalvars, globalmethods, DBdata, DialogsEx;

{$R *.dfm}

function TSettings.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TSettings.BtnOKClick(Sender: TObject);
begin
  //database
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_NAME_VAL, DBName.Text);
  FIniConfig.WriteIniHosts(Hosts.Items);
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_PORT_VAL, DBPort.Text);
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_LOGIN_VAL, DBLogin.Text);
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_PASSWORD_VAL, DBPassword.Text);
  //quiry
  if Trim(EditInterval.Text) = EmptyStr then
    EditInterval.Text := '0';
  FIniConfig.SetIniStr(SETTING_KEY, DDE_QUERY_INTERVAL_VAL, Trim(EditInterval.Text));
  FIniConfig.SetIniInt(SETTING_KEY, DDE_QUERY_NOT_USE_INTERVAL_VAL, Integer(CheckBoxNotUseInterval.Checked));
  if ComboGroupList.ItemIndex <> -1 then
    FIniConfig.SetIniInt(SETTING_KEY, DDE_QUERY_TOPIC_VAL,
      Integer(ComboGroupList.Items.Objects[ComboGroupList.ItemIndex])
    );
  FIniConfig.SetIniInt(SETTING_KEY, DDE_QUERY_PRIORITY_VAL, PriorityCombo.ItemIndex);
  FIniConfig.SetIniInt(SETTING_KEY, DDE_RELIABILITY_OF_READING_VAL, EditReliabilityRead.ItemIndex);
  ModalResult := mrOk;
end;

procedure TSettings.BtnResetLockPswdClick(Sender: TObject);
begin
  FIniConfig.SetIniStr(SETTING_KEY, DDE_RELIABILITY_OF_READING_VAL, EmptyStr);
  MessageBeep(MB_ICONWARNING);
  ShowMessage('Пароль сброшен!!!');
end;

procedure TSettings.CheckBoxNotUseIntervalClick(Sender: TObject);
begin
  EditInterval.Enabled := not CheckBoxNotUseInterval.Checked;
  if EditInterval.Text = EmptyStr then EditInterval.Text := '0';
end;

constructor TSettings.Create(AOwner: TComponent);
var
  aSL : TStringList;
  aTopic : Integer;
  k, i : Integer;
  slHosts : TStringList;
begin
  inherited Create(AOwner);
  if not DirectoryExists(GetCurrentUserPath + SPTOUCH_STR) then
    ForceDirectories(GetCurrentUserPath + SPTOUCH_STR);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  //database
  DBName.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_NAME_VAL, 'dbda');
  Hosts.Items.Clear;
  slHosts := TStringList.Create;
  try
    FIniConfig.ReadIniHosts(slHosts);
    for i := 0 to slHosts.Count - 1 do
      Hosts.Items.Add(slHosts.ValueFromIndex[i]);
    Hosts.ItemIndex := 0;
  finally
    slHosts.Free;
  end;
  DBPort.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_PORT_VAL, '3306');
  DBLogin.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_LOGIN_VAL, EmptyStr);
  DBPassword.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_PASSWORD_VAL, EmptyStr);
  //quiry
  EditInterval.Text := FIniConfig.GetIniStr(SETTING_KEY, DDE_QUERY_INTERVAL_VAL, '30000');
  if Trim(EditInterval.Text) = EmptyStr then
    EditInterval.Text := '0';
  CheckBoxNotUseInterval.Checked := Boolean(FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_NOT_USE_INTERVAL_VAL, 0));
  PriorityCombo.ItemIndex := FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_PRIORITY_VAL, 0);
  //Top группы СП-Сети
  aSL := UDBData.GetListGroups;
  if Assigned(aSL) then
  try
    ComboGroupList.Items.Assign(aSL);
    ComboGroupList.Items.Insert(0, EmptyStr);
  finally
    aSL.Free;
  end;
  aTopic := FIniConfig.GetIniInt(SETTING_KEY, DDE_QUERY_TOPIC_VAL, 0);
  k := ComboGroupList.Items.IndexOfObject(TObject(aTopic));
  if k <> -1 then
    ComboGroupList.ItemIndex := k;
  EditReliabilityRead.ItemIndex := FIniConfig.GetIniInt(SETTING_KEY, DDE_RELIABILITY_OF_READING_VAL, 0);
  //кол хостов
  LC.Caption := IntToStr(Hosts.Items.Count);
end;

procedure TSettings.DelExecute(Sender: TObject);
begin
  if Hosts.ItemIndex <> -1 then
  begin
    Hosts.Items.Delete(Hosts.ItemIndex);
    //кол хостов
    LC.Caption := IntToStr(Hosts.Items.Count);    
  end;
end;

procedure TSettings.DelUpdate(Sender: TObject);
begin
  Del.Enabled := Hosts.Items.Count > 1;
end;

destructor TSettings.Destroy;
begin
  FIniConfig.Free;
  inherited Destroy;
end;

procedure TSettings.IncludeParamqClick(Sender: TObject);
var s : string;
begin
  s := DialogsEx._InputBox('Ввод хоста', 'Хост#Имя', EmptyStr);
  if s <> EmptyStr then
  begin
    Hosts.Items.Add(s);
    Hosts.ItemIndex := Hosts.Items.Count - 1;
    //кол хостов
    LC.Caption := IntToStr(Hosts.Items.Count);
  end;
end;

function TSettings.WasMaintenanceInstall: Boolean;
var Reg : TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.KeyExists('SOFTWARE\Microsoft\Windows\CurrentVersion\Run') then
    begin
      Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', False);
      Result := Reg.ValueExists(MAINTENANCE_NAME);
    end;
  finally
    Reg.Free;
  end;
end;

end.
