{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit CreateAnalogTreeElement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, HelpPic, MdExtCtrls, SPTForm;

type
  TPlanTreeElement = (ataNone, ataGroup, ataElement);

  TPlanTreeElementForm = class(TSPTForm)
    GroupBox1: TGroupBox;
    RBGroup: TRadioButton;
    RBElement: TRadioButton;
    HelpPic1: THelpPic;
    BtnOK: TMdBitBtn;
    BtnCancel: TMdBitBtn;
  private
    function GetChoosenElement: TPlanTreeElement;
  published
  public
    property ChoosenElement : TPlanTreeElement read GetChoosenElement;
    function Execute : Boolean;
  end;

implementation

{$R *.dfm}

function TPlanTreeElementForm.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TPlanTreeElementForm.GetChoosenElement: TPlanTreeElement;
begin
  Result := ataNone;
  if RBGroup.Checked then Result := ataGroup
  else
  if RBElement.Checked then Result := ataElement;
end;

end.
