 {*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit CreateReportTreeElement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, globalvars, HelpPic,
  MdExtCtrls, SPTForm;

type
  TReportTreeElement = (rtaNone, rtaGroup, rtaDay, rtaMonth, rtaYear, rtaSimple);

  TCreateReportTreeElement = class(TSPTForm)
    GroupBox2: TGroupBox;
    EditElementName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MemoElementDescroption: TMemo;
    GroupBox1: TGroupBox;
    RBGroup: TRadioButton;
    RBDay: TRadioButton;
    RBMonth: TRadioButton;
    RBYear: TRadioButton;
    RBSimple: TRadioButton;
    HelpPic1: THelpPic;
    BtnOK: TMdBitBtn;
    BtnCancel: TMdBitBtn;
  private
    function GetChoosenElement: TReportTreeElement;
    function GetElementName: string;
    function GetElementDescription: string;
  public
    property ElementName : string read GetElementName;
    property ElementDescription : string read GetElementDescription;
    property ChoosenElement : TReportTreeElement read GetChoosenElement;
    function Execute : Boolean;
    constructor Create(AOwner : TComponent); reintroduce;
  end;

var
  FCreateReportTreeElement: TCreateReportTreeElement;

implementation

{$R *.dfm}

constructor TCreateReportTreeElement.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

function TCreateReportTreeElement.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TCreateReportTreeElement.GetElementDescription: string;
begin
  Result := MemoElementDescroption.Lines.Text;
end;

function TCreateReportTreeElement.GetElementName: string;
begin
  Result := EditElementName.Text;
end;

function TCreateReportTreeElement.GetChoosenElement: TReportTreeElement;
begin
  Result := rtaNone;
  if RBGroup.Checked then Result := rtaGroup
  else
  if RBDay.Checked then Result := rtaDay
  else
  if RBMonth.Checked then Result := rtaMonth
  else
  if RBYear.Checked then Result := rtaYear
  else
  if RBSimple.Checked then Result := rtaSimple;
end;

end.
