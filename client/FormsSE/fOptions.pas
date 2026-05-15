unit fOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, SpinSE, ColorBoxSE,
  FlexBase, FlexUtils;

type
  TOptionEditPage = ( opDocument, opGrid, opDuplicates, opConnectors );
  TOptionEditPages = set of TOptionEditPage;

const
  AllOptions = [opDocument, opGrid];

type
  PEditOptions = ^TEditOptions;
  TEditOptions = record
   // Document props
   DocWidth: integer;
   DocHeight: integer;
   DocAutoNameNumbs: boolean;
   // Grid props
   ShowGrid: boolean;
   SnapToGrid: boolean;
   SnapStyle: TFlexSnaps;
   ShowPixGrid: boolean;
   GridStyle: TFlexGridStyle;
   GridColor: TColor;
   GridPixColor: TColor;
   GridHSize: integer;
   GridVSize: integer;
   GridHOffset: integer;
   GridVOffset: integer;
   // Duplicates
   ShiftX: integer;
   ShiftY: integer;
   DupRandom: boolean;
  end;

  TfmOptions = class(TForm)
    bbOk: TBitBtn;
    bbClose: TBitBtn;
    pgOptions: TPageControl;
    tsDocProps: TTabSheet;
    gbDocSize: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    chAutoNameNumbs: TCheckBox;
    tsGridProps: TTabSheet;
    gbGridSize: TGroupBox;
    chShowGrid: TCheckBox;
    chSnapToGrid: TCheckBox;
    chShowPixGrid: TCheckBox;
    panGridStyle: TPanel;
    rbGridAsLines: TRadioButton;
    rbGridAsDots: TRadioButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    gbGridOffset: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    gbSnapStyle: TGroupBox;
    chSnapLeft: TCheckBox;
    chSnapCenter: TCheckBox;
    chSnapTop: TCheckBox;
    chSnapBottom: TCheckBox;
    chSnapRight: TCheckBox;
    tsDupProps: TTabSheet;
    gbDupShift: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    chDupRandom: TCheckBox;
    panWidth: TPanel;
    panHeight: TPanel;
    panGridHSize: TPanel;
    panGridVSize: TPanel;
    panGridHOffset: TPanel;
    panGridVOffset: TPanel;
    panGridColor: TPanel;
    panDupShiftX: TPanel;
    panDupShiftY: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ctrlDocChange(Sender: TObject);
    procedure ctrlGridClick(Sender: TObject);
    procedure ctrlGridChange(Sender: TObject);
    procedure ctrlDupChange(Sender: TObject);
    procedure ctrlDupClick(Sender: TObject);
    procedure ctrlConnectorsChange(Sender: TObject);
  private
    { Private declarations }
    FOptions: TEditOptions;
    FEdited: TOptionEditPages;
    procedure ReadFromOptions;
    procedure WriteToOptions;
    procedure SetOptions(const Value: TEditOptions);
    function GetPage: TOptionEditPage;
    procedure SetPage(const Value: TOptionEditPage);
  public
    { Replaced controls }
    sedWidth: TSpinEditSE;
    sedHeight: TSpinEditSE;
    sedGridHSize: TSpinEditSE;
    sedGridVSize: TSpinEditSE;
    sedGridHOffset: TSpinEditSE;
    sedGridVOffset: TSpinEditSE;
    sedDupShiftX: TSpinEditSE;
    sedDupShiftY: TSpinEditSE;
    cceGridColor: TColorBoxSE;
    { Public declarations }
    property  Edited: TOptionEditPages read FEdited;
    property  EditOptions: TEditOptions read FOptions write SetOptions;
    property  Page: TOptionEditPage read GetPage write SetPage;
  end;

var
  fmOptions: TfmOptions;
  EditOptions: TEditOptions;

implementation

{$R *.DFM}

uses
  FlexControls, UtilsSE;

procedure InitDefaultOptions;
begin
 with EditOptions do begin
  // Document props
  DocWidth := 640 * PixelScaleFactor;
  DocHeight := 480 * PixelScaleFactor;
  DocAutoNameNumbs := False;
  // Grid props
  ShowGrid := False;
  SnapToGrid := False;
  SnapStyle := [snLeft, snTop];
  ShowPixGrid := False;
  GridStyle := gsDots;
  GridColor := clGray;
  GridPixColor := clSilver;
  GridHSize := 10 * PixelScaleFactor;
  GridVSize := 10 * PixelScaleFactor;
  GridHOffset := 0;
  GridVOffset := 0;
  // Duplicates
  ShiftX := 10 * PixelScaleFactor;
  ShiftY := 10 * PixelScaleFactor;
  DupRandom := False;
 end;
end;

// TfmOptions /////////////////////////////////////////////////////////////////

procedure TfmOptions.FormCreate(Sender: TObject);
begin
 sedWidth := CreateSpinEdit('sedWidth', panWidth, 0, 99999);
 sedWidth.OnChange := ctrlDocChange;
 sedHeight := CreateSpinEdit('sedHeight', panHeight, 0, 99999);
 sedHeight.OnChange := ctrlDocChange;
 sedGridHSize := CreateSpinEdit('sedGridHSize', panGridHSize, 0.001, 99999);
 sedGridHSize.OnChange := ctrlGridChange;
 sedGridVSize := CreateSpinEdit('sedGridVSize', panGridVSize, 0.001, 99999);
 sedGridVSize.OnChange := ctrlGridChange;
 sedGridHOffset := CreateSpinEdit('sedGridHOffset', panGridHOffset, -99999, 99999);
 sedGridHOffset.OnChange := ctrlGridChange;
 sedGridVOffset := CreateSpinEdit('sedGridVOffset', panGridVOffset, -99999, 99999);
 sedGridVOffset.OnChange := ctrlGridChange;
 cceGridColor := CreateColorBox('cceGridColor', panGridColor, True);
 cceGridColor.OnChange := ctrlGridChange;
 sedDupShiftX := CreateSpinEdit('sedDupShiftX', panDupShiftX, -99999, 99999);
 sedDupShiftX.OnChange := ctrlDupChange;
 sedDupShiftY := CreateSpinEdit('sedDupShiftY', panDupShiftY, -99999, 99999);
 sedDupShiftY.OnChange := ctrlDupChange;

 pgOptions.ActivePage := tsDocProps;
end;

procedure TfmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteToOptions;
 Action := caHide;
end;

function TfmOptions.GetPage: TOptionEditPage;
begin
 if pgOptions.ActivePage = tsDocProps then Result := opDocument else
 if pgOptions.ActivePage = tsGridProps then Result := opGrid else
 if pgOptions.ActivePage = tsDupProps then Result := opDuplicates else
 //if pgOptions.ActivePage = tsConnectors then Result := opConnectors else
  Result := opDocument;
end;

procedure TfmOptions.SetPage(const Value: TOptionEditPage);
begin
 case Value of
  opDocument   : pgOptions.ActivePage := tsDocProps;
  opGrid       : pgOptions.ActivePage := tsGridProps;
  opDuplicates : pgOptions.ActivePage := tsDupProps;
  //opConnectors : pgOptions.ActivePage := tsConnectors;
 end;
end;

procedure TfmOptions.SetOptions(const Value: TEditOptions);
begin
 FOptions := Value;
 ReadFromOptions;
end;

procedure TfmOptions.ReadFromOptions;
var SnapAll: boolean;
begin
 with FOptions do begin
  sedWidth.Value := DocWidth / PixelScaleFactor;
  sedHeight.Value := DocHeight / PixelScaleFactor;
  chAutoNameNumbs.Checked := DocAutoNameNumbs;
  chShowGrid.Checked := ShowGrid;
  chSnapToGrid.Checked := SnapToGrid;
  SnapAll := snAll in SnapStyle;
  chSnapLeft.Checked := SnapAll or (snLeft in SnapStyle);
  chSnapRight.Checked := SnapAll or (snRight in SnapStyle);
  chSnapTop.Checked := SnapAll or (snTop in SnapStyle);
  chSnapBottom.Checked := SnapAll or (snBottom in SnapStyle);
  chSnapCenter.Checked := SnapAll or (snCenter in SnapStyle);
  chShowPixGrid.Checked := ShowPixGrid;
  case GridStyle of
   gsLines : rbGridAsLines.Checked := true;
   gsDots  : rbGridAsDots.Checked := true;
  end;
  sedGridHSize.Value := GridHSize / PixelScaleFactor;
  sedGridVSize.Value := GridVSize / PixelScaleFactor;
  sedGridHOffset.Value := GridHOffset / PixelScaleFactor;
  sedGridVOffset.Value := GridVOffset / PixelScaleFactor;
  cceGridColor.ColorValue := GridColor;
  sedDupShiftX.Value := ShiftX / PixelScaleFactor;
  sedDupShiftY.Value := ShiftY / PixelScaleFactor;
  chDupRandom.Checked := DupRandom;
  // sedConnectorsMinGap.Value := ConnectorsMinGap / PixelScaleFactor;
 end;
 FEdited := [];
end;

procedure TfmOptions.WriteToOptions;
begin
 // Documents
 FOptions.DocWidth := Round(sedWidth.Value * PixelScaleFactor);
 FOptions.DocHeight := Round(sedHeight.Value * PixelScaleFactor);
 FOptions.DocAutoNameNumbs := chAutoNameNumbs.Checked;
 // Grid
 FOptions.ShowGrid := chShowGrid.Checked;
 FOptions.SnapToGrid := chSnapToGrid.Checked;
 FOptions.SnapStyle := [];
 if chSnapLeft.Checked then Include(FOptions.SnapStyle, snLeft);
 if chSnapRight.Checked then Include(FOptions.SnapStyle, snRight);
 if chSnapTop.Checked then Include(FOptions.SnapStyle, snTop);
 if chSnapBottom.Checked then Include(FOptions.SnapStyle, snBottom);
 if chSnapCenter.Checked then Include(FOptions.SnapStyle, snCenter);
 FOptions.ShowPixGrid := chShowPixGrid.Checked;
 if rbGridAsLines.Checked then
  FOptions.GridStyle := gsLines
 else
 if rbGridAsDots.Checked then
  FOptions.GridStyle := gsDots;
 FOptions.GridHSize := Round(sedGridHSize.Value * PixelScaleFactor);
 FOptions.GridVSize := Round(sedGridVSize.Value * PixelScaleFactor);
 FOptions.GridHOffset := Round(sedGridHOffset.Value * PixelScaleFactor);
 FOptions.GridVOffset := Round(sedGridVOffset.Value * PixelScaleFactor);
 FOptions.GridColor := cceGridColor.ColorValue;
 // Duplicates
 FOptions.ShiftX := Round(sedDupShiftX.Value * PixelScaleFactor);
 FOptions.ShiftY := Round(sedDupShiftY.Value * PixelScaleFactor);
 FOptions.DupRandom := chDupRandom.Checked;
 // Connectors
 // FOptions.ConnectorsMinGap := Round(sedConnectorsMinGap.Value * PixelScaleFactor);
end;

procedure TfmOptions.ctrlDocChange(Sender: TObject);
begin
 Include(FEdited, opDocument);
end;

procedure TfmOptions.ctrlGridClick(Sender: TObject);
begin
 Include(FEdited, opGrid);
end;

procedure TfmOptions.ctrlGridChange(Sender: TObject);
begin
 Include(FEdited, opGrid);
end;

procedure TfmOptions.ctrlDupChange(Sender: TObject);
begin
 Include(FEdited, opDuplicates);
end;

procedure TfmOptions.ctrlDupClick(Sender: TObject);
begin
 Include(FEdited, opDuplicates);
end;

procedure TfmOptions.ctrlConnectorsChange(Sender: TObject);
begin
 Include(FEdited, opConnectors);
end;

initialization
  InitDefaultOptions;

end.
