{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ModAnalogTreeElement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, globalvars, ExtCtrls, HelpPic, MdExtCtrls;

type
  TModPlanTreeElement = class(TForm)
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    ProductName: TEdit;
    MemoProductDescription: TMemo;
    HelpPic1: THelpPic;
    BtnOK: TMdBitBtn;
    BtnCancel: TMdBitBtn;
  private
    function GetElementName: string;
    function GetElementDescription: string;
    procedure SetElementDescription(const Value: string);
    procedure SetElementName(const Value: string);
  public
    property ElementName : string read GetElementName write SetElementName;
    property ElementDescription : string read GetElementDescription write SetElementDescription;
    function Execute : Boolean;
  end;

implementation

{$R *.dfm}

function TModPlanTreeElement.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TModPlanTreeElement.GetElementDescription: string;
begin
  Result := MemoProductDescription.Lines.Text;
end;

function TModPlanTreeElement.GetElementName: string;
begin
  Result := ProductName.Text;
end;

procedure TModPlanTreeElement.SetElementDescription(const Value: string);
begin
  MemoProductDescription.Lines.Text := Value;
end;

procedure TModPlanTreeElement.SetElementName(const Value: string);
begin
  ProductName.Text := Value;
end;

end.
