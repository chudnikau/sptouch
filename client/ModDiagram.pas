{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ModDiagram;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ColorGrd, ExtCtrls, TeeProcs,
  TeEngine, Chart, Series, HelpPic, Edits, MdExtCtrls, SPTForm;

type
  TFModDiagram = class(TSPTForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    EditDiagramName: TEdit;
    Label5: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    EditDimensionName: TComboBox;
    ChartPreview: TChart;
    Series1: TBarSeries;
    LabelRangeError: TLabel;
    HelpPic1: THelpPic;
    EditHighValue: TMdNumEdit;
    EditLowValue: TMdNumEdit;
    EditAngleLable: TMdIntEdit;
    MdBitBtn1: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    CheckBoxUpperCaseName: TMdCheckBox;
    procedure EditDimensionNameKeyPress(Sender: TObject; var Key: Char);
    procedure EditDimensionNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDimensionNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MdBitBtn1Click(Sender: TObject);
    procedure MdCheckBox1Click(Sender: TObject);
  private
    procedure SetDiagramName(const Value: string);
    function GetDiagramName: string;
    function GetLowValue: Double;
    procedure SetLowValue(const Value: Double);
    function GetHighValue: Double;
    procedure SetHighValue(const Value: Double);
    function GetAngleLable: Integer;
    procedure SetAngleLable(const Value: Integer);
    function GetDimensionName: string;
    procedure SetDimensionName(const Value: string);
    procedure PropertyChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property LowValue : Double read GetLowValue write SetLowValue;
    property HighValue : Double read GetHighValue write SetHighValue;
    property DiagramName : string read GetDiagramName write SetDiagramName;
    property AngleLable : Integer read GetAngleLable write SetAngleLable;
    property DimensionName : string read GetDimensionName write SetDimensionName;
    function Execute : Boolean;
  end;

var
  FModDiagram: TFModDiagram;

implementation

uses ZDataSet, DBdata, dm_general;

{$R *.dfm}

constructor TFModDiagram.Create(AOwner: TComponent);
var sql : string;
    AZQuery : TZQuery;
begin
  inherited Create(AOwner);
  //параметры по умолчанию
  EditDiagramName.CharCase := ecUpperCase;
  EditDiagramName.Text := '<Имя на диаграмме>';
  EditHighValue.Text := '0';
  EditLowValue.Text := '0';
  EditAngleLable.Text := '90';
  //ед. измерения
  EditDimensionName.Items.Clear;
  sql := 'select unitSN from unitsparams';
  AZQuery := UDM.CreateDataSet(sql) as TZQuery;
  try
    AZQuery.Open;
    while not AZQuery.Eof do
    begin
      EditDimensionName.Items.Add(AZQuery.FieldByName('unitSN').AsString);
      AZQuery.Next;
    end;
    AZQuery.Close;
  finally
    AZQuery.Free;
  end;
  if EditDimensionName.Items.Count > 0 then
    EditDimensionName.ItemIndex := 0
  else
    EditDimensionName.Text := EmptyStr;
  //обновлять при редактировании 
  EditDiagramName.OnChange := PropertyChange;
  EditHighValue.OnChange := PropertyChange;
  EditLowValue.OnChange := PropertyChange;
  EditAngleLable.OnChange := PropertyChange;
  EditDimensionName.OnChange := PropertyChange;
  EditDimensionName.OnChange := PropertyChange;
end;

procedure TFModDiagram.PropertyChange(Sender: TObject);
var aMaxVChart, aMinVChart : Double;
    aBarSeries : TBarSeries;
begin
  aMaxVChart := StrToFloatDef(EditHighValue.Text, 0);
  aMinVChart := StrToFloatDef(EditLowValue.Text, 0);
  LabelRangeError.Visible := aMinVChart > aMaxVChart;
  ChartPreview.Title.Text.Text := Format('%s (%s)', [EditDiagramName.Text, EditDimensionName.Text]);
  ChartPreview.LeftAxis.SetMinMax(aMaxVChart, aMinVChart);
  ChartPreview.BottomAxis.LabelsAngle := StrToIntDef(EditAngleLable.Text, 0);
  ChartPreview.LeftAxis.Increment := ChartPreview.LeftAxis.Maximum / 4;
  aBarSeries := TBarSeries(ChartPreview.Series[0]);
  aBarSeries.Clear;
  aBarSeries.AddBar(aMinVChart+(aMaxVChart-aMinVChart)/2, 'ИМЯ', clBlue);
end;

procedure TFModDiagram.EditDimensionNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TFModDiagram.EditDimensionNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key := #0;
end;

procedure TFModDiagram.EditDimensionNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

function TFModDiagram.Execute: Boolean;
begin
  PropertyChange(nil); //обновляю preview
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TFModDiagram.GetAngleLable: Integer;
begin
  Result := StrToInt(EditAngleLable.Text);
end;

function TFModDiagram.GetDiagramName: string;
begin
  Result := EditDiagramName.Text;
end;

function TFModDiagram.GetDimensionName: string;
begin
  Result := EditDimensionName.Text;
end;

function TFModDiagram.GetHighValue: Double;
begin
  Result := StrToFloat(EditHighValue.Text);
end;

function TFModDiagram.GetLowValue: Double;
begin
  Result := StrToFloat(EditLowValue.Text);
end;

procedure TFModDiagram.MdBitBtn1Click(Sender: TObject);
begin
  if (Trim(EditDiagramName.Text) <> EmptyStr) and (Trim(EditHighValue.Text) <> EmptyStr) and (Trim(EditLowValue.Text) <> EmptyStr)
    and (Trim(EditAngleLable.Text) <> EmptyStr) and (Trim(EditDimensionName.Text) <> EmptyStr) then
  begin
    ModalResult := mrOk;
  end else begin
    MessageBeep(MB_ICONWARNING);
    ShowMessage('Не все поля заполнены !!!');
    ModalResult := mrNone;
  end;
end;

procedure TFModDiagram.MdCheckBox1Click(Sender: TObject);
begin
  if CheckBoxUpperCaseName.Checked then
     EditDiagramName.CharCase := ecUpperCase
  else
     EditDiagramName.CharCase := ecNormal;
  PropertyChange(Sender);
end;

procedure TFModDiagram.SetAngleLable(const Value: Integer);
begin
  EditAngleLable.Text := FloatToStr(Value);
end;

procedure TFModDiagram.SetDiagramName(const Value: string);
begin
  EditDiagramName.Text := Value;
end;

procedure TFModDiagram.SetDimensionName(const Value: string);
begin
  EditDimensionName.Text := Value;
end;

procedure TFModDiagram.SetHighValue(const Value: Double);
begin
  EditHighValue.Text := FloatToStr(Value);
end;

procedure TFModDiagram.SetLowValue(const Value: Double);
begin
  EditLowValue.Text := FloatToStr(Value);
end;

end.
