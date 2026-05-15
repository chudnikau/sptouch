unit ModReportTreeElement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, HelpPic, CreateReportTreeElement;

type
  TModReportTreeElement = class(TCreateReportTreeElement)
  private
    function GetElementDescription: string;
    function GetElementName: string;
    procedure SetElementDescription(const Value: string);
    procedure SetElementName(const Value: string);
    function GetChoosenElement: TReportTreeElement;
    procedure SetChoosenElement(const Value: TReportTreeElement);
  public
    procedure EnableChecks(const aGroup, aDay, aMonth, aYear, aSimple : Boolean);
    property ElementName : string read GetElementName write SetElementName;
    property ElementDescription : string read GetElementDescription write SetElementDescription;
    property ChoosenElement : TReportTreeElement read GetChoosenElement write SetChoosenElement;
  end;

var
  FModReportTreeElement: TModReportTreeElement;

implementation

{$R *.dfm}

{ TModReportTreeElement }

procedure TModReportTreeElement.EnableChecks(const aGroup, aDay, aMonth, aYear,
  aSimple: Boolean);
begin
  RBGroup.Enabled := aGroup;
  RBDay.Enabled := aDay;
  RBMonth.Enabled := aMonth;
  RBYear.Enabled := aYear;
  RBSimple.Enabled := aSimple;
end;

function TModReportTreeElement.GetElementDescription: string;
begin
  Result := inherited ElementDescription;
end;

function TModReportTreeElement.GetElementName: string;
begin
  Result := inherited ElementName;
end;

function TModReportTreeElement.GetChoosenElement: TReportTreeElement;
begin
  Result := inherited ChoosenElement;
end;

procedure TModReportTreeElement.SetElementDescription(const Value: string);
begin
  MemoElementDescroption.Lines.Text := Value;
end;

procedure TModReportTreeElement.SetElementName(const Value: string);
begin
  EditElementName.Text := Value;
end;

procedure TModReportTreeElement.SetChoosenElement(
  const Value: TReportTreeElement);
begin
  case Value of
    rtaGroup : RBGroup.Checked := True;
    rtaDay : RBDay.Checked := True;
    rtaMonth : RBMonth.Checked := True;
    rtaYear : RBYear.Checked := True;
    rtaSimple : RBSimple.Checked := True;
  end;
end;

end.
