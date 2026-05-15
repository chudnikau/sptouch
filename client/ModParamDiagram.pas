{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ModParamDiagram;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ColorGrd, ExtCtrls, Buttons, bsSkinCtrls, bsColorCtrls,
  HelpPic, Edits, MdExtCtrls, SPTForm;

type
  TFParamDiagram = class(TSPTForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditParamName: TEdit;
    ColorParamDiagram: TbsSkinColorGrid;
    PanelColor: TPanel;
    bsSkinColorDialog: TColorDialog;
    BtnOtherColor: TSpeedButton;
    HelpPic1: THelpPic;
    EditWarningValue: TMdNumEdit;
    EditAccidentValue: TMdNumEdit;
    EditOrder: TMdIntEdit;
    MdBitBtn1: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    procedure ColorParamDiagramChange(Sender: TObject);
    procedure BtnOtherColorClick(Sender: TObject);
  private
    function GetParamDiagramAccidentValue: Double;
    function GetParamDiagramColor: Integer;
    function GetParamDiagramCaption: string;
    function GetParamDiagramWarningValue: Double;
    procedure SetParamDiagramAccidentValue(const Value: Double);
    procedure SetParamDiagramColor(const Value: Integer);
    procedure SetParamDiagramCaption(const Value: string);
    procedure SetParamDiagramWarningValue(const Value: Double);
    function GetParamDiagramOrder: Integer;
    procedure SetParamDiagramOrder(const Value: Integer);
  private
    FParamColor : TColor;
  public
    property ParamDiagramCaption : string read GetParamDiagramCaption write SetParamDiagramCaption;
    property ParamDiagramWarningValue : Double read GetParamDiagramWarningValue write SetParamDiagramWarningValue;
    property ParamDiagramAccidentValue : Double read GetParamDiagramAccidentValue write SetParamDiagramAccidentValue;
    property ParamDiagramOrder : Integer read GetParamDiagramOrder write SetParamDiagramOrder; 
    property ParamDiagramColor : Integer read GetParamDiagramColor write SetParamDiagramColor;
    function Execute : Boolean;
  end;

var
  FParamDiagram: TFParamDiagram;

implementation

{$R *.dfm}

procedure TFParamDiagram.ColorParamDiagramChange(Sender: TObject);
begin
  FParamColor := ColorParamDiagram.ColorValue;
end;

function TFParamDiagram.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TFParamDiagram.GetParamDiagramAccidentValue: Double;
begin
  Result := StrToFloatDef(EditAccidentValue.Text, 0);
end;

function TFParamDiagram.GetParamDiagramColor: Integer;
begin
  Result := FParamColor;
end;

function TFParamDiagram.GetParamDiagramOrder: Integer;
begin
  Result := StrToIntDef(EditOrder.Text, 0);
end;

function TFParamDiagram.GetParamDiagramCaption: string;
begin
  Result := EditParamName.Text;
end;

function TFParamDiagram.GetParamDiagramWarningValue: Double;
begin
  Result := StrToFloatDef(EditWarningValue.Text, 0);
end;

procedure TFParamDiagram.SetParamDiagramAccidentValue(const Value: Double);
begin
  EditAccidentValue.Text := FloatToStr(Value);
end;

procedure TFParamDiagram.SetParamDiagramColor(const Value: Integer);
begin
  ColorParamDiagram.ColorValue := Value;
  FParamColor := Value;
  PanelColor.Color := FParamColor;
end;

procedure TFParamDiagram.SetParamDiagramOrder(const Value: Integer);
begin
  EditOrder.Text := IntToStr(Value);
end;

procedure TFParamDiagram.SetParamDiagramCaption(const Value: string);
begin
  EditParamName.Text := Value;
end;

procedure TFParamDiagram.SetParamDiagramWarningValue(const Value: Double);
begin
  EditWarningValue.Text := FloatToStr(Value);
end;

procedure TFParamDiagram.BtnOtherColorClick(Sender: TObject);
begin
  bsSkinColorDialog.Color := FParamColor;
  if bsSkinColorDialog.Execute then
  begin
    FParamColor := bsSkinColorDialog.Color;
    PanelColor.Color := FParamColor;
    ColorParamDiagram.ColorValue := FParamColor;
  end;
end;

end.
