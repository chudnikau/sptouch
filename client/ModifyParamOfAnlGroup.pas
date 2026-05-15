{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ModifyParamOfAnlGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ColorGrd, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, DBCtrls, bsSkinCtrls, bsColorCtrls, ExtCtrls,
  HelpPic, MdExtCtrls, SPTForm;

type
  TFModifyParamOfAnlGroup = class(TSPTForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dtsParamsAnalogGroup: TDataSource;
    EditMaxVal: TDBEdit;
    EditSignalVal: TDBEdit;
    EditMinVal: TDBEdit;
    dtbParamsAnalogGroup: TZQuery;
    dtbParamsAnalogGroupanaloggroup_id: TLargeintField;
    dtbParamsAnalogGroupparamquery_id: TLargeintField;
    dtbParamsAnalogGrouplvalue: TFloatField;
    dtbParamsAnalogGroupsvalue: TFloatField;
    dtbParamsAnalogGrouphvalue: TFloatField;
    dtbParamsAnalogGroupcolor: TLargeintField;
    ChooseParamColor: TbsSkinColorGrid;
    PanelColor: TPanel;
    bsSkinColorDialog: TColorDialog;
    Label4: TLabel;
    BtnOtherColor: TSpeedButton;
    HelpPic1: THelpPic;
    MdBitBtn1: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    procedure ChooseParamColorChange(Sender: TObject);
    procedure BtnOtherColorClick(Sender: TObject);
  private
    FParamColor : TColor;
    function GetMaxScaleValue: Double;
    function GetMinScaleValue: Double;
    function GetSignalScaleValue: Double;
    function GetParamColor: Integer;
  public
    constructor Create(AOwner: TComponent; const aGroupId, aParamId : LongWord); 
    destructor Destroy; override;
    property MaxScaleValue : Double read GetMaxScaleValue;
    property MinScaleValue : Double read GetMinScaleValue;
    property SignalScaleValue : Double read GetSignalScaleValue;
    property ParamColor : Integer read GetParamColor;
    function Execute : Boolean;
  end;

var
  FModifyParamOfAnlGroup: TFModifyParamOfAnlGroup;

implementation

uses dm_general;

{$R *.dfm}

procedure TFModifyParamOfAnlGroup.BtnOtherColorClick(Sender: TObject);
begin
  bsSkinColorDialog.Color := FParamColor;
  if bsSkinColorDialog.Execute then
  begin
    FParamColor := bsSkinColorDialog.Color;
    PanelColor.Color := FParamColor;
    ChooseParamColor.ColorValue := FParamColor;
  end;
end;

procedure TFModifyParamOfAnlGroup.ChooseParamColorChange(Sender: TObject);
begin
  FParamColor := ChooseParamColor.ColorValue;
end;

constructor TFModifyParamOfAnlGroup.Create(AOwner: TComponent; const aGroupId,
  aParamId: LongWord);
begin
  inherited Create(AOwner);
  dtbParamsAnalogGroup.Connection := UDM.MySQLConnection;
  dtbParamsAnalogGroup.ParamByName('analoggroup_id').AsInteger := aGroupId;
  dtbParamsAnalogGroup.ParamByName('paramquery_id').AsInteger := aParamId;
  dtbParamsAnalogGroup.Open;
  FParamColor := dtbParamsAnalogGroup.FieldByName('color').AsInteger;
  ChooseParamColor.ColorValue := FParamColor;
  PanelColor.Color := FParamColor;
end;

destructor TFModifyParamOfAnlGroup.Destroy;
begin
  dtbParamsAnalogGroup.Close;
  inherited;
end;

function TFModifyParamOfAnlGroup.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TFModifyParamOfAnlGroup.GetMaxScaleValue: Double;
begin
  Result := StrToFloatDef(Trim(EditMaxVal.Text), 0);
end;

function TFModifyParamOfAnlGroup.GetMinScaleValue: Double;
begin
  Result := StrToFloatDef(Trim(EditMinVal.Text), 0);
end;

function TFModifyParamOfAnlGroup.GetParamColor: Integer;
begin
  Result := FParamColor;
end;

function TFModifyParamOfAnlGroup.GetSignalScaleValue: Double;
begin
  Result := StrToFloatDef(Trim(EditSignalVal.Text), 0);
end;

end.
