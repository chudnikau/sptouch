 {*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Settings;

interface

{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, bsSkinBoxCtrls, ExtCtrls, dxCntner,
  dxExEdtr, dxEdLib, FileCtrl, bsSkinCtrls, ActnList, dm_general, HelpPic, Edits,
  MdExtCtrls, SPTForm;

type
  ESettings = class(Exception);

  TSettings = class(TSPTForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    ActionList: TActionList;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    IncludeParamq: TSpeedButton;
    DeclareParamq: TSpeedButton;
    Del: TAction;
    LC: TLabel;
    HelpPic1: THelpPic;
    EditDBPort: TMdIntEdit;
    EditTimeUpdateData: TMdIntEdit;
    EditDBLogin: TEdit;
    EditDBName: TEdit;
    Hosts: TListBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EditPassword: TEdit;
    MdBitBtn1: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    CheckW_AlertForm: TMdCheckBox;
    CheckE_AlertForm: TMdCheckBox;
    CheckAlert: TMdCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure DelUpdate(Sender: TObject);
    procedure DelExecute(Sender: TObject);
    procedure IncludeParamqClick(Sender: TObject);
    procedure MdBitBtn1Click(Sender: TObject);
  private
    FIniConfig : TIniConfig;
  public
    function Execute: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses globalmethods, globalvars, DialogsEx;

{$R *.dfm}

constructor TSettings.Create(AOwner: TComponent);
begin
  inherited;
  if not DirectoryExists(GetCurrentUserPath + SPTOUCH_STR) then
    ForceDirectories(GetCurrentUserPath + SPTOUCH_STR);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
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

function TSettings.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

procedure TSettings.FormCreate(Sender: TObject);
var
  slHosts: TStringList;
  i: Integer;
begin
  EditDBName.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_NAME_VAL, 'dbda');
  EditDBPort.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_PORT_VAL, '3306');
  EditDBLogin.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_LOGIN_VAL, EmptyStr);
  EditPassword.Text := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_PASSWORD_VAL, EmptyStr);

  //загружаю хосты
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

  LC.Caption := IntToStr(Hosts.Items.Count);
  EditTimeUpdateData.Text := FIniConfig.GetIniStr(SETTING_KEY, UPDATE_INTERVAL_VAL, '10000');
  CheckW_AlertForm.Checked := Boolean(FIniConfig.GetIniInt(SETTING_KEY, INI_APP_W_ALERT_FORM, 0));
  CheckE_AlertForm.Checked := Boolean(FIniConfig.GetIniInt(SETTING_KEY, INI_APP_E_ALERT_FORM, 0));
  CheckAlert.Checked := Boolean(FIniConfig.GetIniInt(SETTING_KEY, PLAY_ALERT_VAL, 0));

  if EditTimeUpdateData.Text = EmptyStr then
    EditTimeUpdateData.Text := '0';
end;

procedure TSettings.IncludeParamqClick(Sender: TObject);
var s : string;
begin
  s := _InputBox('¬вод хоста', '’ост#ќписание', EmptyStr);
  if s <> EmptyStr then
  begin
    Hosts.Items.Add(s);
    Hosts.ItemIndex := Hosts.Items.Count - 1;
    //кол хостов
    LC.Caption := IntToStr(Hosts.Items.Count);
  end;
end;

procedure TSettings.MdBitBtn1Click(Sender: TObject);
begin
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_NAME_VAL, EditDBName.Text);
  FIniConfig.WriteIniHosts(Hosts.Items);
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_PORT_VAL, EditDBPort.Text);
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_LOGIN_VAL, EditDBLogin.Text);
  FIniConfig.SetIniStr(DB_UNIT_KEY, DB_PASSWORD_VAL, EditPassword.Text);

  FIniConfig.SetIniStr(SETTING_KEY, UPDATE_INTERVAL_VAL, EditTimeUpdateData.Text);
  FIniConfig.SetIniInt(SETTING_KEY, INI_APP_W_ALERT_FORM, Integer(CheckW_AlertForm.Checked));
  FIniConfig.SetIniInt(SETTING_KEY, INI_APP_E_ALERT_FORM, Integer(CheckE_AlertForm.Checked));
  FIniConfig.SetIniInt(SETTING_KEY, PLAY_ALERT_VAL, Integer(CheckAlert.Checked));
  ModalResult := mrOk;
end;

end.
