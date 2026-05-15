{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PasswordDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  TFPasswordDialog = class(TForm)
    LoginEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PasswordEdit: TEdit;
    BitBtn1: TBitBtn;
    Image1: TImage;
    BtnCancel: TBitBtn;
  private
    function GetLoginEdit: string;
    function GetPasswordEdit: string;
  public
    function Execute : Boolean;
    property Login : string read GetLoginEdit;
    property Password : string read GetPasswordEdit;
  end;

var
  FPasswordDialog: TFPasswordDialog;

implementation

{$R *.dfm}

{ TFPasswordDialog }

function TFPasswordDialog.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TFPasswordDialog.GetLoginEdit: string;
begin
  Result := LoginEdit.Text;
end;

function TFPasswordDialog.GetPasswordEdit: string;
begin
  Result := PasswordEdit.Text;
end;

end.
