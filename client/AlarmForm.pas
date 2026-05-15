{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit AlarmForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, frxpngimage, HelpPic, SountUtils, dm_general,
  MdExtCtrls, SPTForm;

type
  TAlertForm = class(TSPTForm)
    AlertImage: TImage;
    HelpPic1: THelpPic;
    AlertList: TMemo;
    MdPlayer: TMdPlayer;
    MdBitBtn1: TMdBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MdBitBtn1Click(Sender: TObject);
  private
    FIniConfig: TIniConfig;
    function GetAlertText: string;
    procedure SetAlertText(const Value: string);
    procedure PlayAlert(const Play: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    destructor Destroy; override;
    property AlertText: string read GetAlertText write SetAlertText;
    procedure ClearAlertText;
    constructor Create(AOwner: TComponent); override;
  end;

var
  FAlertForm: TAlertForm;

implementation

uses globalmethods, globalvars;

{$R *.dfm}

{ TAlarmForm }

procedure TAlertForm.ClearAlertText;
begin
  AlertList.Lines.Clear;
end;

constructor TAlertForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FormStyle := fsStayOnTop;
  Position := poScreenCenter;
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  AlertList.Lines.Clear;
  MdPlayer.FileName := 'Alert.wav';
end;

procedure TAlertForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
end;

destructor TAlertForm.Destroy;
begin
  FIniConfig.Free;
  inherited Destroy;
end;

procedure TAlertForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Boolean(FIniConfig.GetIniInt(SETTING_KEY, PLAY_ALERT_VAL, 0)) then PlayAlert(False);
end;

procedure TAlertForm.FormShow(Sender: TObject);
var Info: FLASHWINFO;
begin
  if Boolean(FIniConfig.GetIniInt(SETTING_KEY, PLAY_ALERT_VAL, 0)) then PlayAlert(True);
  //Создаю эффект моргающего окна***********************************************
  FillChar(Info, SizeOf(Info), 0);
  Info.cbSize := SizeOf(FLASHWINFO);
  Info.hwnd := Handle;
  Info.dwTimeout := 500; //Частота мерцания*************************************
  Info.dwFlags := FLASHW_ALL or FLASHW_TIMER;
  FlashWindowEx(Info);
end;

function TAlertForm.GetAlertText: string;
begin
  Result := AlertList.Lines.Text;
end;

procedure TAlertForm.MdBitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TAlertForm.SetAlertText(const Value: string);
begin
  AlertList.Lines.Text := Value;
end;

procedure TAlertForm.PlayAlert(const Play: Boolean);
begin
  if Play then
  begin
    if Boolean(FIniConfig.GetIniInt(SETTING_KEY, PLAY_ALERT_VAL, 0)) then MdPlayer.Play;
  end else
    MdPlayer.Stop;
end;

end.
