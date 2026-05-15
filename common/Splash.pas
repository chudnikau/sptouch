{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  ComCtrls, NGJPEG, SPTForm;

type
  TSplashForm = class(TSPTForm)
    Image: TImage;
    InfoLabel: TLabel;
    ProductVersion: TLabel;
    cxProgress: TcxProgressBar;
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure ShowSplash(const Info: string; const UseTick: Boolean = True);
procedure UpdateSplash(const Position: Word; const Info: string = '');
procedure CloseSplashForm;

implementation

uses globalmethods;

{$R *.dfm}

var
  SplashForm: TSplashForm;
  Tick: Cardinal;
  VUseTick: Boolean;

procedure ShowSplash(const Info: string; const UseTick: Boolean);
begin
  if not Assigned(SplashForm) then
    SplashForm := TSplashForm.Create(nil);
  SplashForm.InfoLabel.Caption := Info;
  SplashForm.Show;
  Tick := GetTickCount;
  VUseTick := UseTick;
end;

procedure UpdateSplash(const Position: Word; const Info: string);
begin
  if Assigned(SplashForm) then
  begin
    if Info <> EmptyStr then
      SplashForm.InfoLabel.Caption := Info;
    SplashForm.cxProgress.Visible := Position > 0;
    SplashForm.cxProgress.Position := Position;
  end;  
end;

procedure CloseSplashForm;
begin
  if Assigned(SplashForm) then
  begin
    while ((GetTickCount - Tick) < 5000) and VUseTick do
      Application.ProcessMessages;
    SplashForm.Free;
  end;
end;

constructor TSplashForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ProductVersion.Caption := GetVerInfo(Application.ExeName, 'ProductVersion');
  Image.AutoSize := True;
  Width := Image.Width;
  Height := Image.Height;
  Position := poScreenCenter;
  cxProgress.Visible := False;
  cxProgress.Position := 0;
end;

end.
