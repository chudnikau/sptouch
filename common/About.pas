{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ShellApi, jpeg, DB,
  RxMemDS, MdExtCtrls, NGJPEG, SPTForm;

type

  EAbout = class(Exception);

  TFAbout = class(TSPTForm)
    MdBitBtn1: TMdBitBtn;
    Image1: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    TextInfoLabel: TLabel;
    LabelChudnikau: TLabel;
    procedure LabelChudnikauClick(Sender: TObject);
    procedure MdBitBtn1Click(Sender: TObject);
  public
    class procedure ShowFormAbout(const AppName : string);
  end;

var
  FAbout: TFAbout;

implementation

uses globalmethods;

{$R *.DFM}

procedure TFAbout.MdBitBtn1Click(Sender: TObject);
begin
  Close;
end;

class procedure TFAbout.ShowFormAbout(const AppName : string);
begin
  if FAbout = nil then
  begin
    FAbout := TFAbout.Create(Application);
    with FAbout do
    begin
      TextInfoLabel.Caption := Format(
        'Copyright (c) 2008-2010 by chudnikau'#13#10#13#10 +
        'Email'#13#10#13#10 +
        'Part of chudnikau. Republic of Belarus'#13#10#13#10 +
        'Product name %s'#13#10#13#10 +
        'Product version %s'#13#10#13#10 +
        'File version %s',
        [GetVerInfo(Application.ExeName, 'ProductName'),
         GetVerInfo(Application.ExeName, 'ProductVersion'),
         GetVerInfo(Application.ExeName, 'FileVersion')]);
      Show;
    end;
  end else
    FAbout.Show;
end;

procedure TFAbout.LabelChudnikauClick(Sender: TObject);
begin
  if Shellexecute(Handle, 'open', 'mailto:chudnikau@gmail.com', nil, nil, SW_RESTORE) <= 32 then
    raise EAbout.Create('Не найден почтовый клиент. Отправьте письмо вручную.');
end;

end.
