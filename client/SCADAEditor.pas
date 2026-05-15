unit SCADAEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Menus, ImgList, ActnList, ExtCtrls, StdActns, Buttons,
  ClipBrd, Printers, Jpeg, fOptions, Grids,
  ToolWin, ToolMngr, 
  {$IFDEF USE_FLEXPLUS} FlexPlus, {$ENDIF}
  FlexBase, FlexProps, FlexUtils, FlexControls, FlexPath, MdExtCtrls;

{.DEFINE DEBUG_HISTORY}

{.DEFINE DEBUG_POINTS}

type
  TSCADAEditor = class(TFrame)
    sbrMain: TStatusBar;
    imgToolIcons: TImageList;
    imgStdIcons: TImageList;
    pmControl: TPopupMenu;
    miAddToLibrary: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Clone1: TMenuItem;
    BackOne3: TMenuItem;
    ForwardOne2: TMenuItem;
    Toback1: TMenuItem;
    Tofront1: TMenuItem;
    Group1: TMenuItem;
    Ungroup1: TMenuItem;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Delete2: TMenuItem;
    Duplicate2: TMenuItem;

    alMain: TActionList;
    acFileExit: TAction;
    acFileOpen: TAction;
    acFileSave: TAction;
    acFileSaveAs: TAction;
    acEditCut: TAction;
    acEditCopy: TAction;
    acEditPaste: TAction;
    acEditClone: TAction;
    acEditUndo: TAction;
    acEditRedo: TAction;
    acFilePrint: TAction;
    acFileExport: TAction;
    acArrangeForwardOne: TAction;
    acArrangeBackOne: TAction;
    acArrangeToFront: TAction;
    acArrangeToBack: TAction;
    acArrangeGroup: TAction;
    acArrangeUngroup: TAction;
    acLayerNew: TAction;
    acLayerDelete: TAction;
    acEditDelete: TAction;
    acSchemeNew: TAction;
    acSchemeDelete: TAction;
    acWindowArrange: TWindowArrange;
    acWindowCascade: TWindowCascade;
    acWindowClose: TWindowClose;
    acWindowMinimizeAll: TWindowMinimizeAll;
    acWindowTileHorizontal: TWindowTileHorizontal;
    acWindowTileVertical: TWindowTileVertical;
    acFileProperties: TAction;
    acDockerInspector: TAction;
    acDockerLibrary: TAction;
    acDockerLayers: TAction;
    acDockerPalette: TAction;
    acAlignLeft: TAction;
    acAlignHCenter: TAction;
    acAlignRight: TAction;
    acAlignTop: TAction;
    acAlignVCenter: TAction;
    acAlignBottom: TAction;
    acAlignCenter: TAction;
    acLibItemAdd: TAction;
    acViewOptions: TAction;
    acFilePreview: TAction;
    acZoomIn: TAction;
    acZoomOut: TAction;
    acZoomActual: TAction;
    acEditDuplicate: TAction;
    acTranslateRotateCW: TAction;
    acTranslateRotateCCW: TAction;
    acTranslateFlipHorz: TAction;
    acTranslateFlipVertical: TAction;
    acDockerUserData: TAction;
    acHelpAbout: TAction;
    acGridShow: TAction;
    acGridPixelShow: TAction;
    acGridSnap: TAction;
    acGridOptions: TAction;
    acLayerToBack: TAction;
    acLayerToFront: TAction;
    acDebugPoints: TAction;
    acCurveJoin: TAction;
    acCurveBreak: TAction;
    acCurveClose: TAction;
    acCurveToLine: TAction;
    acCurveToCurve: TAction;
    acCurveBreakApart: TAction;
    acCurveCombine: TAction;
    acCurveFlatten: TAction;
    acCurveConvertToCurve: TAction;
    acDebugHistory: TAction;

    pd_Main: TPrintDialog;
    od_Main: TOpenDialog;
    sd_Main: TSaveDialog;
    cd_Palette: TColorDialog;
    sd_Export: TSaveDialog;

    panColors: TPanel;
    dgColors: TDrawGrid;

    cbZoom: TComboBox;
    cbActiveLayer: TComboBox;
    cbActiveScheme: TComboBox;

    tbrTools: TToolBar;
    tbrStdTools: TToolBar;
    tbrZoomTools: TToolBar;
    tbrGridTools: TToolBar;
    tbrLayoutTools: TToolBar;
    tbrTranslateTools: TToolBar;
    tbrAlignTools: TToolBar;
    tbrCurveEditTools: TToolBar;

    tbtArrowTool: TToolButton;
    tbtShapeTool: TToolButton;
    tbtZoomTool: TToolButton;
    tbtPanTool: TToolButton;
    tbtPolylineTool: TToolButton;
    tbtConnectorTool: TToolButton;
    tbtRectTool: TToolButton;
    tbtEllipseTool: TToolButton;
    tbtTextTool: TToolButton;
    tbtPictureTool: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    ToolButton44: TToolButton;
    ToolButton45: TToolButton;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    ToolButton48: TToolButton;
    ToolButton49: TToolButton;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    ToolButton54: TToolButton;
    ToolButton55: TToolButton;
    ToolButton56: TToolButton;
    ToolButton57: TToolButton;
    ToolButton58: TToolButton;

    cbrMain: TCoolBar;
    ToolButton1: TToolButton;
    FlexArea: TFlexPanel;
    sptColors: TMdSplitter;
    procedure tbtToolClick(Sender: TObject);
    procedure tbtStdToolsClose(Sender: TObject);
    procedure cbActiveLayerChange(Sender: TObject);
    procedure cbActiveSchemeChange(Sender: TObject);
    procedure cbZoomExit(Sender: TObject);
    procedure cbZoomClick(Sender: TObject);
    procedure cbZoomKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acLayerNewExecute(Sender: TObject);
    procedure acLayerDeleteExecute(Sender: TObject);
    procedure acFileExitExecute(Sender: TObject);
    procedure acFileOpenExecute(Sender: TObject);
    procedure acSchemeDeleteExecute(Sender: TObject);
    procedure acSchemeNewExecute(Sender: TObject);
    procedure acFilePropertiesExecute(Sender: TObject);
    procedure acArrangeForwardOneExecute(Sender: TObject);
    procedure acArrangeBackOneExecute(Sender: TObject);
    procedure acArrangeToFrontExecute(Sender: TObject);
    procedure acArrangeToBackExecute(Sender: TObject);
    procedure acArrangeGroupExecute(Sender: TObject);
    procedure acArrangeUngroupExecute(Sender: TObject);
    procedure acEditDeleteExecute(Sender: TObject);
    procedure acDockerExecute(Sender: TObject);
    procedure acEditCopyExecute(Sender: TObject);
    procedure acEditPasteExecute(Sender: TObject);
    procedure acEditCutExecute(Sender: TObject);
    procedure acEditPasteUpdate(Sender: TObject);
    procedure acAlignExecute(Sender: TObject);
    procedure acFilePreviewExecute(Sender: TObject);
    procedure acLibItemAddExecute(Sender: TObject);
    procedure acViewOptionsExecute(Sender: TObject);
    procedure acFilePrintExecute(Sender: TObject);
    procedure acZoomInExecute(Sender: TObject);
    procedure acZoomOutExecute(Sender: TObject);
    procedure acEditDuplicateExecute(Sender: TObject);
    procedure acZoomActualExecute(Sender: TObject);
    procedure acHelpAboutExecute(Sender: TObject);
    procedure acFileSaveExecute(Sender: TObject);
    procedure acTranslateRotateCWExecute(Sender: TObject);
    procedure acTranslateRotateCCWExecute(Sender: TObject);
    procedure acTranslateFlipHorzExecute(Sender: TObject);
    procedure acTranslateFlipVerticalExecute(Sender: TObject);
    procedure acFileExportExecute(Sender: TObject);
    procedure acGridShowExecute(Sender: TObject);
    procedure acGridPixelShowExecute(Sender: TObject);
    procedure acGridSnapExecute(Sender: TObject);
    procedure acLayerToFrontExecute(Sender: TObject);
    procedure acLayerToBackExecute(Sender: TObject);
    procedure acDebugPointsExecute(Sender: TObject);
    procedure acCurveJoinExecute(Sender: TObject);
    procedure acCurveBreakExecute(Sender: TObject);
    procedure acCurveCloseExecute(Sender: TObject);
    procedure acCurveToLineExecute(Sender: TObject);
    procedure acCurveToCurveExecute(Sender: TObject);
    procedure acCurveBreakApartExecute(Sender: TObject);
    procedure acCurveCombineExecute(Sender: TObject);
    procedure acCurveFlattenExecute(Sender: TObject);
    procedure acCurveConvertToCurveExecute(Sender: TObject);
    procedure acGridOptionsExecute(Sender: TObject);
    procedure acDockerPaletteExecute(Sender: TObject);
    procedure acEditCloneExecute(Sender: TObject);
    procedure acEditUndoExecute(Sender: TObject);
    procedure acEditRedoExecute(Sender: TObject);
    procedure acDebugHistoryExecute(Sender: TObject);
    procedure acFileSaveAsExecute(Sender: TObject);
    procedure panColorsResize(Sender: TObject);
    procedure sptColorsMoved(Sender: TObject);
    procedure dgColorsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dgColorsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbrMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FlexAreaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlexAreaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FlexAreaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FActiveFlex: TFlexPanel;
    FActiveFlexModified: boolean;
    FIniting: boolean;
    FIsFileLoading: boolean;
    FInspDataNeedUpdate: boolean;
    FInspPropsNeedUpdate: boolean;
    FFilerProgress: integer;
    FToolbarItems: TList;
    FColors: TList;
    FDockSites: TFormDockSites;
    procedure RegisterExternalControls;
    function  GetToolScale: integer;
    procedure SetCurrentOptions(Flex: TFlexPanel;
      const Edited: TOptionEditPages = AllOptions);
    function  CreateToolWindow(ToolForm: TCustomForm; DockTo: TWinControl;
      DockAlign: TAlign = alNone): TToolContainer;
    procedure ToolbarItemClick(Sender: TObject);
    procedure ToolWinNeedClose(Sender: TObject);
    procedure ToolWinPopupChange(Sender: TObject);
    procedure ControlPropChanged(Sender: TObject; Prop: TCustomProp);
    procedure CheckTools;
    procedure CheckToolbars;
    procedure CheckToolButtons(Sender: TObject);
    procedure CheckUpdates(Flex: TFlexPanel);
    procedure ChildChange(Sender: TObject);
    procedure HistoryChange(Sender: TObject);
    procedure CustomColorsChange(Sender: TObject);
    procedure ActiveLibChange(Sender: TObject);
//    function  CreateDocument(const DocName: string): TFlexPanel;
    //function  GetActiveFlex: TFlexPanel;
    procedure FlexEndSelUpdate(Sender: TObject);
    procedure UpdateToolWins(Flex: TFlexPanel);
    procedure UpdateLayers(Flex: TFlexPanel);
    procedure UpdateSchemes(Flex: TFlexPanel);
    procedure UpdateAllOptions(const Edited: TOptionEditPages = AllOptions);
    procedure FlexProgress(Sender: TObject; Progress: integer;
      Process: TFlexFilerProcess);
    function  GetInFilerProcess: boolean;
    procedure BeginFilerProcess;
    procedure EndFilerProcess;
    procedure ViewOptionsExecute(Page: TOptionEditPage = opDocument);
    procedure RefreshColors;
    procedure FormDockDrop(Sender: TObject);
  public
    { Public declarations }
    procedure ControlNotify(Sender: TObject; Control: TFlexControl;
      Notify: TFlexNotify);
//    function  SaveChanges(ChildForm: TFlexChildForm;
//      AskName: boolean = true): boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property  ActiveFlex: TFlexPanel read FActiveFlex; //GetActiveFlex;
    property  InFilerProcess: boolean read GetInFilerProcess;
    property  DockSites: TFormDockSites read FDockSites;
  end;

implementation

uses
  Consts, ColorBoxSE,  
  fInspector, fLibrary, fPreview, fDocProps, fUserData, fAboutPrg, fLayers,
  {$IFDEF DEBUG_HISTORY} fHistoryDbg, {$ENDIF}
  {$IFDEF DEBUG_POINTS} fPointsDbg, {$ENDIF}
  FlexHistory, FlexActions, SVGExport;

{$R *.DFM}

const
  SDeleteLayer  = 'Do you really want to delete layer %s?';
  SDeleteScheme = 'Do you really want to delete scheme %s?';

  DefaultPalette: array[0..52] of TColor = (
   TColor($000000),
   TColor($191919),
   TColor($333333),
   TColor($4C4C4C),
   TColor($666666),
   TColor($808080),
   TColor($999999),
   TColor($B2B2B2),
   TColor($E5E5E5),
   TColor($FFFFFF),
   TColor($000080),
   TColor($008000),
   TColor($008080),
   TColor($800000),
   TColor($800080),
   TColor($808000),
   TColor($808080),
   TColor($C0C0C0),
   TColor($0000FF),
   TColor($00FF00),
   TColor($00FFFF),
   TColor($FF0000),
   TColor($FF00FF),
   TColor($FFFF00),
   TColor($400000),
   TColor($A00000),
   TColor($004000),
   TColor($404000),
   TColor($804000),
   TColor($408000),
   TColor($C08000),
   TColor($FF8000),
   TColor($40FF00),
   TColor($80FF00),
   TColor($000040),
   TColor($400040),
   TColor($800040),
   TColor($400080),
   TColor($FF0080),
   TColor($004080),
   TColor($404080),
   TColor($C08080),
   TColor($FF8080),
   TColor($00FF80),
   TColor($80FF80),
   TColor($FFFF80),
   TColor($8000FF),
   TColor($0080FF),
   TColor($4080FF),
   TColor($8080FF),
   TColor($C080FF),
   TColor($FF80FF),
   TColor($80FFFF)
  );

procedure TSCADAEditor.RegisterExternalControls;
var i: integer;
    B: TBitmap;
    TBItem: TToolButton;
    Hint: string;
begin
  if Length(RegisteredFlexControls) = 0 then exit;
  B := TBitmap.Create;
  try
   B.Width := imgToolIcons.Width;
   B.Height := imgToolIcons.Height;
   for i:=0 to High(RegisteredFlexControls) do begin
    FillRect(B.Canvas.Handle, Rect(0, 0, B.Width, B.Height),
      GetStockObject(WHITE_BRUSH) );
    Hint := '';
    if not RegisteredFlexControls[i].GetToolInfo(B, Hint) then continue;
    tbrTools.Images.AddMasked(B, B.TransparentColor);
    TBItem := TToolButton.Create(Self);
    TBItem.AllowAllUp := True;
    TBItem.ImageIndex := tbrTools.Images.Count-1;
    TBItem.Grouped := True;
    TBItem.Style := tbsCheck;
    TBItem.Hint := Hint;
    TBItem.Tag := integer(RegisteredFlexControls[i]);
    TBItem.OnClick := tbtToolClick;
    TBItem.Left := Width;
    TBItem.Top := Height;
    TBItem.Parent := tbrTools;
   end;
  finally
   B.Free;
  end;
end;

procedure TSCADAEditor.tbtToolClick(Sender: TObject);
var i: integer;
begin
  if Sender is TToolButton then with TToolButton(Sender) do
  begin
    if not Down then begin
     // Cannot "up" same button
     Down := True;
     Exit;
    end;
    // "Up" all other buttons if exist
    for i:=0 to tbrTools.ButtonCount-1 do
     if Sender <> tbrTools.Buttons[i] then tbrTools.Buttons[i].Down := False;
  end;

// for i:=0 to MDIChildCount-1 do
//  with (MDIChildren[i] as TFlexChildForm).Flex do
  with FlexArea do
  begin
    if Sender = tbtZoomTool then
    begin
      EditPointControl := Nil;
      CreatingControlClass := Nil;
      ToolMode := ftmZoom;
    end else
    if Sender = tbtPanTool then
    begin
      //EditPointControl := Nil;
      CreatingControlClass := Nil;
      ToolMode := ftmPan;
    end else
    if Sender = tbtShapeTool then
    begin
      CreatingControlClass := Nil;
      //if SelectedCount = 1 then EditPointControl := Selected[0];
      ToolMode := ftmPointEdit;
    end else
    begin
      if Sender = tbtArrowTool then
      begin
        CreatingControlClass := Nil;
        //EditPointControl := Nil;
      end else
      if Sender = tbtPolyLineTool then
        CreatingControlClass := TFlexCurve
      else
      if Sender = tbtConnectorTool then
        CreatingControlClass := TFlexConnector
      else
      if Sender = tbtRectTool then
        CreatingControlClass := TFlexBox
      else
      if Sender = tbtEllipseTool then
        CreatingControlClass := TFlexEllipse
      else
      if Sender = tbtTextTool then
        CreatingControlClass := TFlexText
      else
      if Sender = tbtPictureTool then
        CreatingControlClass := TFlexPicture
      else
      if TToolButton(Sender).Tag <> 0 then
        CreatingControlClass := TFlexControlClass(TToolButton(Sender).Tag);
       //if ToolMode in [ftmZoom, ftmZooming, ftmPan, ftmPanning] then
      ToolMode := ftmSelect;
    end;
  end;
  CheckTools;
end;

procedure TSCADAEditor.ToolbarItemClick(Sender: TObject);
var i: integer;
    Item: TMenuItem;
    ToolBar: TToolbar;
begin
 for i:=0 to FToolbarItems.Count-1 do begin
  Item := TMenuItem(FToolbarItems[i]);
  if Item <> Sender then continue;
  ToolBar := TToolbar(Item.Tag);
  ToolBar.Visible := not ToolBar.Visible;
  break;
 end; 
 CheckToolbars;
end;

procedure TSCADAEditor.CheckToolbars;
var i: integer;
    Item: TMenuItem;
    ToolBar: TToolbar;
begin
 for i:=0 to FToolbarItems.Count-1 do begin
  Item := TMenuItem(FToolbarItems[i]);
  ToolBar := TToolbar(Item.Tag);
  Item.Checked := ToolBar.Visible;
 end; 
end;

procedure TSCADAEditor.tbtStdToolsClose(Sender: TObject);
begin
 CheckToolbars;
end;

procedure TSCADAEditor.CheckToolButtons(Sender: TObject);
begin
 if Sender <> ActiveFlex then exit;
 with TFlexPanel(Sender) do
 case ToolMode of
  ftmSelect:
    if not Assigned(CreatingControlClass) then tbtArrowTool.Click;
  ftmPan:
    tbtPanTool.Click;
 end;
end;

procedure TSCADAEditor.CheckTools;
var Flex: TFlexPanel;
    IsDoc, IsSel, IsSelMany, IsModified: boolean;
    IsSelGroup, IsSelCurve, IsLib, IsChecked: boolean;
    IsSelAllCurves: boolean;
    IsLastLayer, IsFirstLayer: boolean;
    SelCount, i, FigCount: integer;
    CurveCaps: TPathEditFuncs;

 function GetHistoryCaption(const Ident: string; Index: integer): string;
 var Action: THistoryAction;
 begin
  if Assigned(Flex) and
     (Index >= 0) and (Index < Flex.History.ActionCount) then begin
   Action := Flex.History[Index];
   while (Action is THistoryGroup) and
     (THistoryGroup(Action).ActionCount = 1) do
    Action := THistoryGroup(Action).Actions[0];
   Result := Ident + ' "' + Action.Caption + '"';
  end else
   Result := Ident;
 end;

begin
// Flex := ActiveFlex;
// // Flags
// if Assigned(Flex) then with Flex do begin
//  IsDoc := True;
//  SelCount := SelectedCount;
//  IsSel := SelCount > 0;
//  IsSelMany := SelCount > 1;
//  //IsSelGroup := (SelCount = 1) and (Selected[0] is TFlexGroup);
//  IsSelGroup := false;
//  for i:=0 to SelCount-1 do begin
//   IsSelGroup := Selected[i].IsUngroupable;
//   if IsSelGroup then break;
//  end;
//  IsSelCurve := (SelCount = 1) and (Selected[0].PointCount > 0);
//  if IsSelCurve {and Flex.IsEditPointsVisible} then begin
//   if Flex.IsEditPointsVisible
//    then CurveCaps := Flex.EditPointsCaps
//    else CurveCaps := [];
//   FigCount := Length(Selected[0].PointsInfo.Figures);
//  end else begin
//   CurveCaps := [];
//   FigCount := 0;
//  end;
//  IsSelAllCurves := true;
//  for i:=0 to SelCount-1 do
//   if Selected[i].PointCount = 0 then begin
//    IsSelAllCurves := false;
//    break;
//   end;
//  IsModified := Flex.Modified;
//  FActiveFlexModified := Flex.Modified;
//  IsLastLayer := Layers.IndexOf(ActiveLayer) = Layers.Count-1;
//  IsFirstLayer := Layers.IndexOf(ActiveLayer) = 0;
//  acLayerDelete.Enabled := cbActiveLayer.Items.Count > 1;
//  acSchemeDelete.Enabled := cbActiveScheme.Items.Count > 1;
// end else begin
//  IsDoc := False;
//  IsSel := False;
//  IsSelMany := False;
//  IsSelGroup := False;
//  IsSelAllCurves := False;
//  IsSelCurve := False;
//  CurveCaps := [];
//  FigCount := 0;
//  IsModified := False;
//  IsLastLayer := False;
//  IsFirstLayer := False;
//  cbActiveLayer.Clear;
//  cbActiveScheme.Clear;
//  acLayerDelete.Enabled := False;
//  acSchemeDelete.Enabled := False;
//  FActiveFlexModified := false;
// end;
// IsLib := Assigned(fmLibrary) and Assigned(fmLibrary.ActiveLibrary);
// IsChecked := false;
// // Draw tools
// for i:=0 to tbrTools.ButtonCount-1 do with tbrTools.Buttons[i] do begin
//  Enabled := IsDoc;
//  if not IsDoc then
//   Down := False
//  else
//  if Down then
//   IsChecked := true;
// end;
// if IsDoc and not IsChecked then tbtArrowTool.Down := true;
// // Grid
// acGridShow.Checked := EditOptions.ShowGrid;
// acGridPixelShow.Checked := EditOptions.ShowPixGrid;
// acGridSnap.Checked := EditOptions.SnapToGrid;
// // Dockers
// acDockerInspector.Checked := Assigned(FindToolParentContainer(fmInspector));
// acDockerLibrary.Checked := Assigned(FindToolParentContainer(fmLibrary));
// acDockerUserData.Checked := Assigned(FindToolParentContainer(fmUserData));
// acDockerLayers.Checked := Assigned(FindToolParentContainer(fmLayers));
// acDockerPalette.Checked := panColors.Visible; 
// // Edit
// acEditDelete.Enabled := IsSel;
// acEditCut.Enabled := IsSel;
// acEditCopy.Enabled := IsSel;
// acEditDuplicate.Enabled := IsSel;
// acEditClone.Enabled := IsSel {and
//   (IsSelMany or not (Flex.Selected[0] is TFlexClone))};
// acEditUndo.Enabled := IsDoc and (Flex.History.ActionIndex >= 0);
// acEditRedo.Enabled := IsDoc and (Flex.History.ActionCount > 0) and
//   (Flex.History.ActionIndex < Flex.History.ActionCount - 1);
// if IsDoc then begin
//  acEditUndo.Hint := GetHistoryCaption('Undo', Flex.History.ActionIndex);
//  acEditRedo.Hint := GetHistoryCaption('Redo', Flex.History.ActionIndex +1);
// end else begin
//  acEditUndo.Hint := 'Undo';
//  acEditRedo.Hint := 'Redo';
// end;
// acLibItemAdd.Enabled := IsSel and IsLib;
// // Layout
// cbActiveLayer.Enabled := IsDoc;
// cbActiveScheme.Enabled := IsDoc;
// acLayerNew.Enabled := IsDoc;
// acSchemeNew.Enabled := IsDoc;
// acLayerToFront.Enabled := IsDoc and not IsLastLayer;
// acLayerToBack.Enabled := IsDoc and not IsFirstLayer;
// // File
// acFileProperties.Enabled := IsDoc;
// acFilePreview.Enabled := IsDoc and not Assigned(fmPreview);
// acFileSave.Enabled := IsDoc and IsModified;
// acFileSaveAs.Enabled := IsDoc;
// acFilePrint.Enabled := IsDoc;
// acFileExport.Enabled := IsDoc;
// // Arrange
// acArrangeForwardOne.Enabled := IsSel;
// acArrangeBackOne.Enabled := IsSel;
// acArrangeToFront.Enabled := IsSel;
// acArrangeToBack.Enabled := IsSel;
// acArrangeGroup.Enabled := IsSelMany;
// acArrangeUngroup.Enabled := IsSelGroup;
// // Translate
// acTranslateRotateCW.Enabled := IsSel;
// acTranslateRotateCCW.Enabled := IsSel;
// acTranslateFlipHorz.Enabled := IsSel;
// acTranslateFlipVertical.Enabled := IsSel;
// // Curve edit
// acCurveJoin.Enabled := pfJoin in CurveCaps;
// acCurveBreak.Enabled := pfBreak in CurveCaps;
// acCurveClose.Enabled := pfClose in CurveCaps;
// acCurveToLine.Enabled := pfToLine in CurveCaps;
// acCurveToCurve.Enabled := pfToCurve in CurveCaps;
// acCurveFlatten.Enabled := IsSelCurve and
//   Flex.Selected[0].PointsInfo.IsCurve;
// acCurveBreakApart.Enabled := FigCount > 1;
// acCurveCombine.Enabled := IsSelMany and IsSelAllCurves;
// acCurveConvertToCurve.Enabled := IsSel;
// // Align
// acAlignLeft.Enabled := IsSelMany;
// acAlignHCenter.Enabled := IsSelMany;
// acAlignRight.Enabled := IsSelMany;
// acAlignTop.Enabled := IsSelMany;
// acAlignVCenter.Enabled := IsSelMany;
// acAlignBottom.Enabled := IsSelMany;
// acAlignCenter.Enabled := IsSelMany;
// // Zoom
// cbZoom.Enabled := IsDoc;
// if cbZoom.Enabled
//  then cbZoom.Text := IntToStr(Flex.Scale)+'%'
//  else cbZoom.Text := '';
// acZoomIn.Enabled := IsDoc and (Flex.Scale < MaxScale);
// acZoomOut.Enabled := IsDoc and (Flex.Scale > MinScale);
// acZoomActual.Enabled := IsDoc and (Flex.Scale <> 100);
end;

procedure TSCADAEditor.FormDockDrop(Sender: TObject);
begin
  DisableAlign;
  try
    sbrMain.Top := Height;
    sptColors.Left := Width;
    panColors.Left := Width;
  finally
    EnableAlign;
  end;
end;

function TSCADAEditor.CreateToolWindow(ToolForm: TCustomForm;
  DockTo: TWinControl; DockAlign: TAlign = alNone): TToolContainer;
begin
 if (DockAlign = alClient) and (DockTo is TPanel) and
    (DockTo.ControlCount > 0) and (DockTo.Controls[0] is TToolContainer) then
   DockTo := TToolContainer(DockTo.Controls[0]);
 if Assigned(DockTo) and (DockTo is TToolContainer) then begin
  // Dock to existen tool container
  Result := TToolContainer(DockTo);
  Result.InsertTool(ToolForm);
  Result.ActivePageForm := ToolForm;
  exit;
 end;
 Result := TToolContainer.Create(Application);
 with Result do begin
  InitDockSites(FDockSites);
  OnNeedClose := ToolWinNeedClose;
  OnPopupChange := ToolWinPopupChange;
  InsertTool(ToolForm);
  Show;
 end;
// if Assigned(DockTo) and (DockTo is TPanel) then
//   Result.ManualDock(DockTo, Nil, DockAlign);
end;

procedure TSCADAEditor.ToolWinNeedClose(Sender: TObject);
begin
 if Sender is TToolContainer then TToolContainer(Sender).Close;
end;

procedure TSCADAEditor.ToolWinPopupChange(Sender: TObject);
begin
 if not (csDestroying in ComponentState) then CheckTools;
end;

procedure TSCADAEditor.acDockerExecute(Sender: TObject);
var ToolForm: TCustomForm;
    Container: TToolContainer;
begin
 if Sender = acDockerInspector then ToolForm := fmInspector else
 if Sender = acDockerLibrary   then ToolForm := fmLibrary else
 if Sender = acDockerUserData  then ToolForm := fmUserData else
 if Sender = acDockerLayers    then ToolForm := fmLayers else exit;
 Container := FindToolParentContainer(ToolForm);
 if not Assigned(Container) then
  CreateToolWindow(ToolForm, DockSites.RightDockPanel, alClient)
 else
  Container.RemoveTool(ToolForm);
 CheckTools;
end;

procedure TSCADAEditor.acDockerPaletteExecute(Sender: TObject);
var Enabled: boolean;
begin
 Enabled := not acDockerPalette.Checked; // invert
 if panColors.Visible = Enabled then exit;
 if Enabled then begin
  // Show palette
  panColors.Visible := true;
  panColors.Left := Self.ClientWidth;
  sptColors.Visible := true;
  sptColors.Left := panColors.Left;
 end else begin
  // Hide palette
  panColors.Visible := false;
  sptColors.Visible := false;
 end;
 CheckTools;
end;

procedure TSCADAEditor.acLayerNewExecute(Sender: TObject);
var
  Layer: TFlexLayer;
begin
  Layer := FlexArea.Layers.New;
  FlexArea.ActiveLayer := Layer;
  fmInspector.Control := Layer;
end;

procedure TSCADAEditor.acLayerDeleteExecute(Sender: TObject);
begin
  if MessageDlg(Format(SDeleteLayer, [FlexArea.ActiveLayer.Name]),
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  FlexArea.Layers.Remove(FlexArea.ActiveLayer);
end;

procedure TSCADAEditor.acSchemeNewExecute(Sender: TObject);
var
  Scheme: TFlexScheme;
begin
  Scheme := TFlexScheme.Create(FlexArea.Schemes.Owner, FlexArea.Schemes, Nil); //Schemes.New;
  FlexArea.ActiveScheme := Scheme;
  fmInspector.Control := Scheme;
end;

procedure TSCADAEditor.acSchemeDeleteExecute(Sender: TObject);
begin
  if MessageDlg(Format(SDeleteScheme, [FlexArea.ActiveScheme.Name]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  FlexArea.Schemes.Remove(FlexArea.ActiveScheme);
end;

{
function TEditMainForm.GetActiveFlex: TFlexPanel;
var Child: TCustomForm;
begin
 Child := ActiveMDIChild;
 if Assigned(Child) and (Child is TFlexChildForm)
  then Result := TFlexChildForm(Child).Flex
  else Result := Nil;
end;
}
procedure TSCADAEditor.ChildChange(Sender: TObject);
var Flex: TFlexPanel;
begin
// if Assigned(ActiveMDIChild)
//  then Flex := TFlexChildForm(ActiveMDIChild).Flex
//  else Flex := Nil;
 if Assigned(Flex) and (csDestroying in Flex.ComponentState) then Flex := Nil;
 if Flex <> FActiveFlex then begin
  FActiveFlex := Flex;
  UpdateToolWins(Flex);
  UpdateLayers(Flex);
  UpdateSchemes(Flex);
  //SetCurrentOptions(Flex);
  CheckTools;
  {$IFDEF DEBUG_HISTORY}
  if Assigned(fmHistoryDebug) then fmHistoryDebug.Flex := Flex;
  {$ENDIF}
 end;
end;

procedure TSCADAEditor.HistoryChange(Sender: TObject);
begin
 if Assigned(FActiveFlex) and (Sender = FActiveFlex.History) then begin
  CheckTools;
  {$IFDEF DEBUG_HISTORY}
  if Assigned(fmHistoryDebug) then fmHistoryDebug.HistoryChange(Sender);
  {$ENDIF}
 end;
end;

procedure TSCADAEditor.UpdateToolWins(Flex: TFlexPanel);
begin
 if Assigned(fmInspector) then fmInspector.ActiveFlex := Flex;
 if Assigned(fmLibrary) then fmLibrary.ActiveFlex := Flex;
 if Assigned(fmUserData) then fmUserData.ActiveFlex := Flex;
 if Assigned(fmLayers) then fmLayers.ActiveFlex := Flex;
end;

procedure TSCADAEditor.ControlPropChanged(Sender: TObject; Prop: TCustomProp);
var Panel: TFlexPanel;
begin
 if FIsFileLoading then exit;
 if Sender = fmInspector.Control then fmInspector.UpdateProps(Prop);
 if (Sender = fmUserData.SelControl) and Assigned(Prop) and
    (Prop = TFlexControl(Sender).UserData) then fmUserData.UpdateData;
 if Assigned(Sender) and (Sender is TFlexLayer) then begin
  if Assigned(fmLayers) then fmLayers.UpdateData(TFlexLayer(Sender));
  if Assigned(fmInspector) and Assigned(fmInspector.Control) then
   fmInspector.UpdateProps(fmInspector.Control.LayerProp);
 end;
 Panel := TFlexControl(Sender).Owner;
 if not (Panel.ToolMode in
   [ ftmResizing, ftmMoving, ftmSelecting, ftmZoom, ftmZooming,
     ftmMove, ftmMoving, ftmResize, ftmResizing, ftmCreating,
     ftmPointSelecting, ftmCurveMoving, ftmPan, ftmPanning ]) or
   ((Panel = ActiveFlex) and (Panel.Modified <> FActiveFlexModified)) then
  CheckTools;
end;

procedure TSCADAEditor.ActiveLibChange(Sender: TObject);
begin
 CheckTools;
end;

constructor TSCADAEditor.Create(AOwner: TComponent);
var List: TStringList;
    i, Index: integer;
    Item: TMenuItem;
begin
  inherited;
  FIniting := true;

  with FlexArea do
  begin
    InDesign := True;
    //History.Active := true;
    History.DisableRecording;
    try
//      OnNotify := ControlNotify;
//      OnPropChanged := ControlPropChanged;
//      OnEndSelectionUpdate := FlexEndSelUpdate;
//      OnProgress := FlexProgress;
//      OnToolMode := CheckToolButtons;
//      History.OnChange := HistoryChange;
      PopupMenu := pmControl;
      //OnActiveChange := ChildChange;
//       if DocName = '' then
//       begin
//         Filename := 'Document' + IntToStr(Self.MDIChildCount+1);
//      DocWidth := EditOptions.DocWidth;
//      DocHeight := EditOptions.DocHeight;
      Modified := False;
      SetCurrentOptions(FlexArea);
//      FormStyle := fsMDIChild;
//    end else begin
//       Caption := DocName;
//     end;
//      ChildChange(FlexArea);
    finally
      History.EnableRecording;
    end;
  end; 

  LoadFlexCursors;
  RegisterExternalControls;
  // Insert all toolbars to main menu
  FDockSites := TFormDockSites.Create(nil);
  FDockSites.OnDockDrop := FormDockDrop;
  FToolbarItems := TList.Create;
  List := TStringList.Create;
  try
   // Collect all toolbars
   for i:=0 to ComponentCount-1 do
    if Components[i] is TToolbar then
     List.AddObject(TToolbar(Components[i]).Caption, Components[i]);
   if List.Count > 0 then begin
    // Sort by captions
    List.Sort;
    // Place to main menu
//    Index := miView.IndexOf(miToolBarsDelimiter);
//    if Index < 0 then Index := 0;
//    for i:=List.Count-1 downto 0 do begin
//     Item := TMenuItem.Create(miView);
//     Item.OnClick := ToolbarItemClick;
//     Item.Caption := List[i];
//     Item.Tag := integer(List.Objects[i]);
//     miView.Insert(Index, Item);
//     FToolbarItems.Add(Item);
//    end;
   end else
    // No toolbars: Hide delimiter in main menu
//    miToolBarsDelimiter.Visible := false;
  finally
   List.Free;
  end;

//  if FIniting then
//  begin
//    // Show Inspector
//    CreateToolWindow(fmInspector, DockSites.RightDockPanel);
//    // Show layer manager
//    CreateToolWindow(fmLayers, DockSites.RightDockPanel, alBottom);
//    // Init
////    fmLibrary.OnLibChange := ActiveLibChange;
//    FIniting := False;
//    CheckTools;
//  end;

  {$IFDEF DEBUG_HISTORY}
  fmHistoryDebug := TfmHistoryDebug.Create(Self);
  fmHistoryDebug.BorderStyle := bsSizeToolWin;
  fmHistoryDebug.Align := alBottom;
  fmHistoryDebug.Parent := Self;
  fmHistoryDebug.Height := 200;
  fmHistoryDebug.sbrMain.Visible := false;
  fmHistoryDebug.Visible := true;
  {$ENDIF}
  // Setup custom color change event
  FColors := TList.Create;
  CustomColors.OnChange := CustomColorsChange;
  RefreshColors;
  CheckToolbars;
end;

//function TSCADAEditor.CreateDocument(const DocName: string): TFlexPanel;
//begin
//  Result := TFlexPanel.Create(nil);
//  Result.Align := alClient;
//  Result.Parent := Self;
//end;

procedure TSCADAEditor.SetCurrentOptions(Flex: TFlexPanel;
  const Edited: TOptionEditPages);
begin
 if not Assigned(Flex) then exit;
 with EditOptions do begin
  if opDocument in Edited then begin
   //Flex.DocWidth := DocWidth;
   //Flex.DocHeight := DocHeight;
   Flex.AutoNameNumbs := DocAutoNameNumbs;
  end;
  if opGrid in Edited then begin
   Flex.ShowGrid := ShowGrid;
   Flex.SnapToGrid := SnapToGrid;
   Flex.SnapStyle := SnapStyle;
   Flex.ShowPixGrid := ShowPixGrid;
   Flex.GridStyle := GridStyle;
   Flex.GridColor := GridColor;
   Flex.GridPixColor := GridPixColor;
   Flex.GridHorizSize := GridHSize;
   Flex.GridVertSize := GridVSize;
   Flex.GridControl.HOffset := GridHOffset;
   Flex.GridControl.VOffset := GridVOffset;
   Flex.Refresh;
  end;
  if opConnectors in Edited then begin
   // Flex.ConnectorsMinGap := ConnectorsMinGap;
  end;
 end;
end;

procedure TSCADAEditor.cbActiveLayerChange(Sender: TObject);
begin
 if Assigned(ActiveFlex) then with ActiveFlex do begin
  ActiveLayer :=
    TFlexLayer(cbActiveLayer.Items.Objects[cbActiveLayer.ItemIndex]);
  UnselectAll;
  fmInspector.Control := ActiveLayer;
 end;
end;

procedure TSCADAEditor.cbActiveSchemeChange(Sender: TObject);
begin
 if Assigned(ActiveFlex) then begin
  ActiveFlex.ActiveScheme :=
   TFlexScheme(cbActiveScheme.Items.Objects[cbActiveScheme.ItemIndex]);
  fmInspector.Control := ActiveFlex.ActiveScheme;
 end;
end;

//function TSCADAEditor.SaveChanges(ChildForm: TFlexChildForm;
//  AskName: boolean = true): boolean;
//var SaveName: string;
//begin
// SaveName := ChildForm.Filename;
// if AskName or ChildForm.NewDocument then begin
//  sd_Main.FileName := SaveName;
//  Result := sd_Main.Execute;
//  if not Result then exit;
//  SaveName := sd_Main.FileName;
// end;
// BeginFilerProcess;
// try
//  Result := ChildForm.Flex.SaveToFile(SaveName);
//  ChildForm.Filename := SaveName;
// finally
//  EndFilerProcess;
// end;
// CheckTools;
//end;

procedure TSCADAEditor.acFileSaveExecute(Sender: TObject);
begin
//  SaveChanges(TFlexChildForm(ActiveMDIChild), false);
end;

procedure TSCADAEditor.acFileSaveAsExecute(Sender: TObject);
begin
// SaveChanges(TFlexChildForm(ActiveMDIChild));
end;

procedure TSCADAEditor.acFileExportExecute(Sender: TObject);
var
  Flex: TFlexPanel;
  Ext: string;
  Graphic: TGraphic;
  MC: TMetafileCanvas;
  Bmp: TBitmap;
begin
 Flex := ActiveFlex;
 if not Assigned(Flex) then exit;
 if not sd_Export.Execute then exit;
 Ext := ExtractFileExt(sd_Export.FileName);
 if Ext = '' then Ext := '.bmp'; // Default extenstion
 if pos(UpperCase('*'+Ext), UpperCase(sd_Export.Filter)) = 0 then
  Ext := '.bmp';
  //raise EInvalidGraphic.CreateFmt(SUnknownExtension, [Ext]);
 Delete(Ext, 1, 1);
 Ext := LowerCase(Ext);
 // Define graphic class
 if pos('svg', Ext) = 1 then begin
  ExportFxdToSVG(Flex, sd_Export.FileName);
 end else begin
  if (pos('jpg', Ext) = 1) or (pos('jpeg', Ext) = 1) then
   Graphic := TJpegImage.Create
  else
  if (pos('wmf', Ext) = 1) or (pos('emf', Ext) = 1) then
   Graphic := TMetafile.Create
  else
   Graphic := TBitmap.Create;
  try
   if Graphic.ClassType = TJpegImage then begin
    // Create bitmap for jpeg output
    Bmp := TBitmap.Create;
    try
     Bmp.Width := ScaleValue(Flex.DocWidth, 100);
     Bmp.Height := ScaleValue(Flex.DocHeight, 100);
     Flex.PaintTo(Bmp.Canvas, Rect(0, 0, Bmp.Width, Bmp.Height),
      Point(0, 0), 100, Flex.ActiveScheme, False, False, False, True);
     // Assign to jpeg
     Graphic.Assign(Bmp);
    finally
     Bmp.Free;
    end;
   end else begin
    Graphic.Width := ScaleValue(Flex.DocWidth, 100);
    Graphic.Height := ScaleValue(Flex.DocHeight, 100);
    if Graphic.ClassType = TBitmap then
     // Paint to bitmap canvas
     Flex.PaintTo(TBitmap(Graphic).Canvas, Rect(0, 0, Width, Height),
       Point(0, 0), 100, Flex.ActiveScheme, False, False, False, True)
    else begin
     // Paint to metafile canvas
     MC := TMetafileCanvas.Create(TMetafile(Graphic), 0);
     try
      Flex.PaintTo(MC,
        Rect(0, 0, ScaleValue(Flex.DocWidth, 100), ScaleValue(Flex.DocHeight, 100)),
        Point(0, 0), 100, Flex.ActiveScheme, False, False, False, True, True);
     finally
      MC.Free;
     end;
    end;
   end;
   Graphic.SaveToFile(sd_Export.FileName);
  finally
   Graphic.Free;
  end;
 end;
end;

procedure TSCADAEditor.acFileOpenExecute(Sender: TObject);
//var Child: TFlexChildForm;
//    i: integer;
begin
 if not od_Main.Execute then Exit;
 FlexArea.LoadFromFile(od_Main.FileName);
 // Search in already opened documents
// for i:=0 to MDIChildCount-1 do with TFlexChildForm(MDIChildren[i]) do
//  if FileName = od_Main.Filename then begin
//   Show;
//   exit;
//  end;
 // Create form for document
// Child := CreateDocument(ExtractFilename(od_Main.Filename));
// try
//  if not Assigned(Child) then exit;
//  BeginFilerProcess;
//  try
//   FIsFileLoading := true;
//   Child.Flex.LoadFromFile(od_Main.Filename);
//   Child.Filename := od_Main.Filename;
//   Child.FormStyle := fsMDIChild;
//   // Update tools
//   SetCurrentOptions(Child.Flex, AllOptions);
//   fmUserData.UpdateData;
//   UpdateLayers(Child.Flex);
//   UpdateSchemes(Child.Flex);
//   fmLibrary.FlexSelectionChange;
//   fmInspector.UpdateData;
//   fmInspector.UpdateProps(Nil);
//  finally
//   FIsFileLoading := false;
//   EndFilerProcess;
//  end;
//  sd_Main.FileName := od_Main.Filename;
// except
//  Child.Free;
//  raise;
// end;
// CheckTools;
end;

procedure TSCADAEditor.acFilePrintExecute(Sender: TObject);
begin
 if not Assigned(ActiveFlex) or not pd_Main.Execute then exit;
 ActiveFlex.Print(Printer, True, pd_Main.PrintRange = prSelection);
end;

procedure TSCADAEditor.ViewOptionsExecute(Page: TOptionEditPage = opDocument);
var fmOptions: TfmOptions;
begin
 fmOptions := TfmOptions.Create(Application);
 try
  fmOptions.EditOptions := EditOptions;
  fmOptions.Page := Page;
  if fmOptions.ShowModal = mrOk then begin
   Move(fmOptions.EditOptions, EditOptions, SizeOf(EditOptions));
   UpdateAllOptions(fmOptions.Edited);
  end;
 finally
  fmOptions.Free;
 end;
end;

procedure TSCADAEditor.acViewOptionsExecute(Sender: TObject);
begin
 ViewOptionsExecute;
end;

procedure TSCADAEditor.acFilePropertiesExecute(Sender: TObject);
var Flex: TFlexPanel;
begin
 Flex := ActiveFlex;
 if not Assigned(Flex) then exit;
 fmDocProps := TfmDocProps.Create(Application);
 with fmDocProps do
 try
  Tag := integer(Flex);
  if ShowModal = mrOk then Flex.Refresh;
 finally
  fmDocProps.Free;
 end;
end;

procedure TSCADAEditor.UpdateLayers(Flex: TFlexPanel);
var StrList: TStringList;
    i: integer;
begin
 if not Assigned(Flex) then exit;
 StrList := Nil;
 cbActiveLayer.Items.BeginUpdate;
 try
  StrList := TStringList.Create;
  for i:=0 to Flex.Layers.Count-1 do
   StrList.AddObject(Flex.Layers[i].Name, Flex.Layers[i]);
  StrList.Sort;
  cbActiveLayer.ItemIndex := -1;
  cbActiveLayer.Items.Assign(StrList);
  cbActiveLayer.ItemIndex := StrList.IndexOfObject(Flex.ActiveLayer);
  cbActiveLayer.Refresh;
 finally
  cbActiveLayer.Items.EndUpdate;
  StrList.Free;
 end;
 fmLayers.UpdateData;
end;

procedure TSCADAEditor.UpdateSchemes(Flex: TFlexPanel);
var StrList: TStringList;
    i: integer;
begin
 if not Assigned(Flex) then exit;
 StrList := Nil;
 cbActiveScheme.Items.BeginUpdate;
 try
  StrList := TStringList.Create;
  for i:=0 to Flex.Schemes.Count-1 do
   StrList.AddObject(Flex.Schemes[i].Name, Flex.Schemes[i]);
  StrList.Sort;
  cbActiveScheme.Items.Assign(StrList);
  cbActiveScheme.ItemIndex := StrList.IndexOfObject(Flex.ActiveScheme);
 finally
  cbActiveScheme.Items.EndUpdate;
  StrList.Free;
 end;
end;

procedure TSCADAEditor.UpdateAllOptions(const Edited: TOptionEditPages);
var i: integer;
begin
// for i:=0 to MDIChildCount-1 do with TFlexChildForm(MDIChildren[i]) do
//  SetCurrentOptions(Flex, Edited);
end;

procedure TSCADAEditor.CheckUpdates(Flex: TFlexPanel);
begin
 if Flex.SelectionUpdateCounter = 0 then begin
  if FInspDataNeedUpdate then begin
   fmInspector.UpdateData;
   FInspDataNeedUpdate := False;
  end;
  if FInspPropsNeedUpdate then begin
   fmInspector.UpdateProps(Nil);
   FInspDataNeedUpdate := False;
  end;
 end;
end;

procedure TSCADAEditor.FlexAreaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_MENU) and (FlexArea.ToolMode = ftmSelect) and
    not Assigned(FlexArea.CreatingControlClass) then
  FlexArea.ToolMode := ftmPan;
end;

procedure TSCADAEditor.FlexAreaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_MENU) and
   ((FlexArea.ToolMode = ftmPan) or (FlexArea.ToolMode = ftmPanning)) then
  FlexArea.ToolMode := ftmSelect;
end;

procedure TSCADAEditor.FlexAreaMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender = FlexArea then
  begin
    FlexArea.SetFocus;
    if not FlexArea.Focused then Windows.SetFocus(FlexArea.Handle);
  end;
end;

procedure TSCADAEditor.FlexEndSelUpdate(Sender: TObject);
begin
 if Sender = ActiveFlex then CheckUpdates(TFlexPanel(Sender));
end;

procedure TSCADAEditor.ControlNotify(Sender: TObject;
  Control: TFlexControl; Notify: TFlexNotify);
var Flex: TFlexPanel;
    NeedUpdate: boolean;
begin
 if FIsFileLoading or (csDestroying in ComponentState) or
    not Assigned(Sender) or not (Sender is TFlexPanel) then exit;
 Flex := TFlexPanel(Sender);
 if Flex <> ActiveFlex then exit;
 if Notify in [ fnName, fnCreated, fnDestroyed, fnOrder ] then begin
  {if Flex.SelectionUpdateCounter = 0 then fmInspector.UpdateData; }
  FInspDataNeedUpdate := True;
 end;
 NeedUpdate := false;
 case Notify of
  fnDestroyed:
    begin
     if Control = fmInspector.Control then fmInspector.Control := Nil;
     fmUserData.UpdateData;
    end;
  fnName:
    if Assigned(Control) then
     if Control is TFlexLayer then UpdateLayers(Flex) else
     if Control is TFlexScheme then UpdateSchemes(Flex);
  fnSelect:
    begin
     if Flex.SelectedCount = 1
      then fmInspector.Control := Flex.Selected[0]
      else fmInspector.Control := Nil;
     fmLibrary.FlexSelectionChange;
     fmUserData.UpdateData;
     if Flex.HandleAllocated then Windows.SetFocus(Flex.Handle);
     sbrMain.SimpleText := 'Selected: '+IntToStr(Flex.SelectedCount);
     NeedUpdate := true;
    end;
  fnLayers:
    UpdateLayers(Flex);
  fnSchemes:
    begin
     UpdateSchemes(Flex);
     FInspDataNeedUpdate := True;
     FInspPropsNeedUpdate := True;
   {  fmInspector.UpdateData;
     fmInspector.UpdateProps(Nil); }
    end;
  fnRect:
    exit;
  fnScale:
    begin
     CheckTools;
     exit;
    end;
 end;
 if NeedUpdate or not (Flex.ToolMode in
   [ ftmResizing, ftmMoving, ftmSelecting, ftmZoom, ftmZooming,
     ftmMove, ftmMoving, ftmResize, ftmResizing, ftmCreating,
     {ftmPointSelecting, }ftmCurveMoving, ftmPan, ftmPanning ]) then begin
  CheckUpdates(Flex);
  CheckTools;
 end;
end;

procedure TSCADAEditor.BeginFilerProcess;
begin
 Screen.Cursor := crHourGlass;
 sbrMain.SimplePanel := False;
end;

procedure TSCADAEditor.EndFilerProcess;
begin
 Screen.Cursor := crDefault;
 sbrMain.SimplePanel := True;
end;

function TSCADAEditor.GetInFilerProcess: boolean;
begin
 Result := not sbrMain.SimplePanel;
end;

procedure TSCADAEditor.FlexProgress(Sender: TObject; Progress: integer;
  Process: TFlexFilerProcess);
begin
 if not InFilerProcess then exit;
 FFilerProgress := Progress;
 sbrMain.Refresh;
end;

procedure TSCADAEditor.sbrMainDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var R: TRect;
begin
 if Panel <> sbrMain.Panels[0] then exit;
 R := Rect;
 InflateRect(R, -1, -1);
 R.Right := R.Left + Round(FFilerProgress / 100 * (R.Right - R.Left)); 
 with sbrMain.Canvas do begin
  Brush.Style := bsSolid;
  Brush.Color := clNavy;
  FillRect(R);
 end;
end;

procedure TSCADAEditor.acArrangeForwardOneExecute(Sender: TObject);
begin
  FlexArea.ForwardOne;
end;

procedure TSCADAEditor.acArrangeBackOneExecute(Sender: TObject);
begin
  FlexArea.BackOne;
end;

procedure TSCADAEditor.acArrangeToFrontExecute(Sender: TObject);
begin
  FlexArea.ToFront;
end;

procedure TSCADAEditor.acArrangeToBackExecute(Sender: TObject);
begin
  FlexArea.ToBack;
end;

procedure TSCADAEditor.acArrangeGroupExecute(Sender: TObject);
begin
  FlexArea.Group;
end;

procedure TSCADAEditor.acArrangeUngroupExecute(Sender: TObject);
begin
  FlexArea.Ungroup;
end;

procedure TSCADAEditor.acEditDeleteExecute(Sender: TObject);
var Flex: TFlexPanel;
begin
 Flex := ActiveFlex;
 if not Assigned(Flex) or not Flex.Focused then exit;
 if (Flex.ToolMode = ftmPointEdit) and (Flex.EditPointSelectedTotal > 0) then begin
  if Flex.EditPointControl.PointCount - Flex.EditPointSelectedTotal > 2 then
   Flex.DeleteSelectedPoints;
 end else
  Flex.DeleteSelected;
end;

procedure TSCADAEditor.acEditCopyExecute(Sender: TObject);
begin
 if Assigned(ActiveFlex) then ActiveFlex.CopyToClipboard;
end;

procedure TSCADAEditor.acEditCutExecute(Sender: TObject);
begin
 if Assigned(ActiveFlex) then ActiveFlex.CutToClipboard;
end;

procedure TSCADAEditor.acEditPasteExecute(Sender: TObject);
begin
 if Assigned(ActiveFlex) then ActiveFlex.PasteFromClipboard;
end;

procedure TSCADAEditor.acEditPasteUpdate(Sender: TObject);
begin
 acEditPaste.Enabled :=
   Assigned(ActiveFlex) and ActiveFlex.PasteAvailable; //Clipboard.HasFormat(CF_FLEXDOC);
end;

procedure TSCADAEditor.acAlignExecute(Sender: TObject);
var Align: TFlexAlign;
begin
 if Sender = acAlignLeft     then Align := faLeft else
 if Sender = acAlignHCenter  then Align := faHCenter else
 if Sender = acAlignRight    then Align := faRight else
 if Sender = acAlignTop      then Align := faTop else
 if Sender = acAlignVCenter  then Align := faVCenter else
 if Sender = acAlignBottom   then Align := faBottom else
 if Sender = acAlignCenter   then Align := faCenter
                             else Align := faLeft;
 FlexArea.AlignSelected(Align);
end;

procedure TSCADAEditor.acFilePreviewExecute(Sender: TObject);
var WasModified: boolean;
begin
 fmPreview := TfmPreview.Create(Nil);
 try
  BeginFilerProcess;
  try
   WasModified := ActiveFlex.Modified;
   fmPreview.Flex.OnProgress := FlexProgress;
   fmPreview.Flex.Assign(ActiveFlex);
   fmPreview.Flex.OnProgress := Nil;
   ActiveFlex.Modified := WasModified;
  finally
   EndFilerProcess;
  end;
  CheckTools;
//  fmPreview.Caption := fmPreview.Caption + ' ['+ActiveMDIChild.Caption+']';
  fmPreview.ShowModal;
 finally
  fmPreview.Free;
  fmPreview := Nil;
  CheckTools;
 end;
end;

procedure TSCADAEditor.acLibItemAddExecute(Sender: TObject);
begin
 if Assigned(fmLibrary) then fmLibrary.acLibAddItem.Execute;
end;

procedure TSCADAEditor.acZoomInExecute(Sender: TObject);
begin
 FlexArea.Zoom(FlexArea.Scale * 2, Nil);
end;

procedure TSCADAEditor.acZoomOutExecute(Sender: TObject);
begin
 FlexArea.Zoom(FlexArea.Scale div 2, Nil);
end;

procedure TSCADAEditor.acZoomActualExecute(Sender: TObject);
begin
 FlexArea.Zoom(100, Nil);
end;

function TSCADAEditor.GetToolScale: integer;
var i, Len: integer;
    s: string;
begin
 Result := 100;
 if not Assigned(ActiveFlex) then exit;
 s := cbZoom.Text;
 Len := Length(s);
 for i:=1 to Len+1 do
  if (i > Len) or not (s[i] in ['0'..'9']) then begin
   Result := StrToIntDef(copy(s, 1, i-1), -1);
   if Result < 0 then Result := ActiveFlex.Scale;
   break;
  end;
end;

procedure TSCADAEditor.cbZoomExit(Sender: TObject);
var NewScale: integer;
begin
 NewScale := GetToolScale;
 if Assigned(ActiveFlex) then with ActiveFlex do
  if NewScale <> Scale then Zoom(NewScale, Nil);
end;

procedure TSCADAEditor.cbZoomClick(Sender: TObject);
var NewScale: integer;
begin
 NewScale := GetToolScale;
 if Assigned(ActiveFlex) then with ActiveFlex do
  if NewScale <> Scale then Zoom(NewScale, Nil);
end;

procedure TSCADAEditor.cbZoomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then
  cbZoomClick(cbZoom)
 else
 if Key = VK_ESCAPE then
  CheckTools;
end;

procedure TSCADAEditor.acEditCloneExecute(Sender: TObject);
var Shift: TPoint;
    SelList: TList;
    i: integer;
begin
 if not Assigned(ActiveFlex) then exit;
 SelList := Nil;
 with ActiveFlex do
 try
  Shift := Point(EditOptions.ShiftX, EditOptions.ShiftY);
  if EditOptions.DupRandom then begin
   Randomize;
   Shift.X := Round(Random * 2*Shift.X) - Shift.X;
   Shift.Y := Round(Random * 2*Shift.Y) - Shift.Y;
   SelList := TList.Create;
   for i:=0 to SelectedCount-1 do SelList.Add(Selected[i]);
  end;
  CloneSelected(Shift.X, Shift.Y);
  if Assigned(SelList) then begin
   BeginSelectionUpdate;
   try
    UnselectAll;
    for i:=0 to SelList.Count-1 do Select(TFlexControl(SelList[i]));
   finally
    EndSelectionUpdate;
   end;
  end;
 finally
  SelList.Free;
 end;
end;

procedure TSCADAEditor.acEditDuplicateExecute(Sender: TObject);
var Shift: TPoint;
    SelList: TList;
    i: integer;
begin
 if not Assigned(ActiveFlex) then exit;
 SelList := Nil;
 with ActiveFlex do
 try
  Shift := Point(EditOptions.ShiftX, EditOptions.ShiftY);
  if EditOptions.DupRandom then begin
   Randomize;
   Shift.X := Round(Random * 2*Shift.X) - Shift.X;
   Shift.Y := Round(Random * 2*Shift.Y) - Shift.Y;
   SelList := TList.Create;
   for i:=0 to SelectedCount-1 do SelList.Add(Selected[i]);
  end;
  Duplicate(Shift.X, Shift.Y);
  if Assigned(SelList) then begin
   BeginSelectionUpdate;
   try
    UnselectAll;
    for i:=0 to SelList.Count-1 do Select(TFlexControl(SelList[i]));
   finally
    EndSelectionUpdate;
   end;
  end;
 finally
  SelList.Free;
 end;
end;

procedure TSCADAEditor.acHelpAboutExecute(Sender: TObject);
begin
 ShowAbout;
end;

procedure TSCADAEditor.acTranslateRotateCWExecute(Sender: TObject);
begin
  FlexArea.Rotate(-90, False);
end;

procedure TSCADAEditor.acTranslateRotateCCWExecute(Sender: TObject);
begin
  FlexArea.Rotate(90, False);
end;

procedure TSCADAEditor.acTranslateFlipHorzExecute(Sender: TObject);
begin
  FlexArea.Rotate(0, True);
end;

procedure TSCADAEditor.acTranslateFlipVerticalExecute(Sender: TObject);
begin
  FlexArea.Rotate(180, True);
end;

procedure TSCADAEditor.acGridShowExecute(Sender: TObject);
begin
 EditOptions.ShowGrid := not EditOptions.ShowGrid;
 UpdateAllOptions;
 CheckTools;
end;

procedure TSCADAEditor.acGridPixelShowExecute(Sender: TObject);
begin
 EditOptions.ShowPixGrid := not EditOptions.ShowPixGrid;
 UpdateAllOptions;
 CheckTools;
end;

procedure TSCADAEditor.acGridSnapExecute(Sender: TObject);
begin
  EditOptions.SnapToGrid := not EditOptions.SnapToGrid;
  UpdateAllOptions;
  CheckTools;
end;

procedure TSCADAEditor.acLayerToFrontExecute(Sender: TObject);
var Index: integer;
begin
  if Assigned(ActiveFlex) then with ActiveFlex do
  begin
    Index := Layers.IndexOf(ActiveLayer);
    if Index < Layers.Count-1 then Layers.ChangeOrder(Index, Index+1);
  end;
end;

procedure TSCADAEditor.acLayerToBackExecute(Sender: TObject);
var Index: integer;
begin
 if Assigned(ActiveFlex) then with ActiveFlex do begin
  Index := Layers.IndexOf(ActiveLayer);
  if Index > 0 then Layers.ChangeOrder(Index, Index-1);
 end;
end;

procedure TSCADAEditor.acFileExitExecute(Sender: TObject);
begin
// Close;
end;

procedure TSCADAEditor.acDebugPointsExecute(Sender: TObject);
begin
 {$IFDEF DEBUG_POINTS}
 ShowPointsDebug;
 {$ENDIF}
end;

procedure TSCADAEditor.acCurveJoinExecute(Sender: TObject);
begin
  FlexArea.EditPoints(pfJoin);
  CheckTools;
end;

procedure TSCADAEditor.acCurveBreakExecute(Sender: TObject);
begin
  FlexArea.EditPoints(pfBreak);
  CheckTools;
end;

procedure TSCADAEditor.acCurveCloseExecute(Sender: TObject);
begin
  FlexArea.EditPoints(pfClose);
  CheckTools;
end;

procedure TSCADAEditor.acCurveToLineExecute(Sender: TObject);
begin
  FlexArea.EditPoints(pfToLine);
  CheckTools;
end;

procedure TSCADAEditor.acCurveToCurveExecute(Sender: TObject);
begin
  FlexArea.EditPoints(pfToCurve);
  CheckTools;
end;

procedure TSCADAEditor.acCurveFlattenExecute(Sender: TObject);
begin
  FlexArea.FlattenSelected((FlexArea.Scale/100) * (1/PixelScaleFactor));
  CheckTools;
end;

procedure TSCADAEditor.acCurveBreakApartExecute(Sender: TObject);
begin
  FlexArea.BreakApartSelected;
  CheckTools;
end;

procedure TSCADAEditor.acCurveCombineExecute(Sender: TObject);
begin
  FlexArea.CombineSelected;
  CheckTools;
end;

procedure TSCADAEditor.acCurveConvertToCurveExecute(Sender: TObject);
begin
  FlexArea.ConvertSelectedToCurves;
end;

procedure TSCADAEditor.acGridOptionsExecute(Sender: TObject);
begin
  ViewOptionsExecute(opGrid);
end;

procedure TSCADAEditor.RefreshColors;
var i, j, Color: integer;
    s: string;
    ARows, ACols: integer;
begin
 FColors.Clear;
 // Add transparent color
 FColors.Add(pointer(clNone));
 // Add default colors
 for i:=Low(DefaultPalette) to High(DefaultPalette) do
  FColors.Add(pointer(ColorToRGB(DefaultPalette[i])));
 // Add custom colors
 for i:=0 to CustomColors.Count-1 do begin
  s := CustomColors[i];
  j := Pos('=', s);
  if j = 0 then continue;
  Color := StrToIntDef('$' + copy(s, j+1, Length(s)-j), -1);
  if Color = -1 then continue;
  FColors.Add(pointer(ColorToRGB(Color)));
 end;
 // Add default (color edit) color
 FColors.Add(pointer(clDefault));
 // Rebuild color grid
 with dgColors do begin
  RowCount := FColors.Count;
  i := (DefaultRowHeight + GridLineWidth);
  if i > 0
   then ARows := Height div i
   else ARows := 0;
  if ARows > 0
   then ACols := FColors.Count div ARows + byte(FColors.Count mod ARows <> 0)
   else ACols := 0;
  RowCount := ARows;
  ColCount := ACols;
  Invalidate;
 end;
end;

procedure TSCADAEditor.CustomColorsChange(Sender: TObject);
begin
 RefreshColors;
end;

destructor TSCADAEditor.Destroy;
begin
  if Assigned(CustomColors) then CustomColors.OnChange := Nil;
  FColors.Free;
  FToolbarItems.Free;
  FDockSites.Free;
  inherited;
end;

procedure TSCADAEditor.dgColorsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var Index: integer;
    Color: TColor;
begin
 Index := ACol * dgColors.RowCount + ARow;
 with dgColors.Canvas do begin
  if Index < FColors.Count then begin
   Pen.Color := clBlack;
   Pen.Style := psSolid;
   Brush.Style := bsClear;
   {$IFDEF VER120} // {FG_D4}
   Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
   {$ELSE}
   Rectangle(Rect);
   {$ENDIF}
   InflateRect(Rect, -1, -1);
   Color := TColor(FColors[Index]);
   case Color of
    clNone:
      with Rect do begin
       Brush.Color := clWhite;
       Brush.Style := bsSolid;
       FillRect(Rect);
       MoveTo(Left, Top);
       LineTo(Right, Bottom);
       MoveTo(Right, Top-1);
       LineTo(Left-1, Bottom);
      end;
    clDefault:
      begin
       Brush.Color := clWhite;
       Brush.Style := bsSolid;
       FillRect(Rect);
       InflateRect(Rect, -4, 0);
       dec(Rect.Bottom, 2);
       Rect.Top := Rect.Bottom - 2;
       Brush.Color := clBlack;
       FillRect(Rect);
      end;
    else
      begin
       Brush.Color := ColorToRGB(Color);
       Brush.Style := bsSolid;
       FillRect(Rect);
      end;
   end;
  end;
 end;
end;

procedure TSCADAEditor.panColorsResize(Sender: TObject);
begin
 RefreshColors;
end;

procedure TSCADAEditor.sptColorsMoved(Sender: TObject);
begin
 RefreshColors;
end;

procedure TSCADAEditor.dgColorsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Flex: TFlexPanel;
    Index, i: integer;
    ACol, ARow: integer;
    Color: TColor;
    Control: TFlexControl;
    Brush: TBrushProp;
    Pen: TPenProp;
    {$IFDEF USE_FLEXPLUS}
    BrushPlus: TBrushPlusProp;
    PenPlus: TPenPlusProp;
    {$ENDIF}
    PassRec: TPassControlRec;
begin
 dgColors.MouseToCell(X, Y, ACol, ARow);
 Index := ACol * dgColors.RowCount + ARow;
 if (Index >= 0) and (Index < FColors.Count)
  then Color := TColor(FColors[Index])
  else exit;
 Flex := ActiveFlex;
 if not Assigned(Flex) or (Flex.SelectedCount = 0) then exit;
 if Color = clDefault then begin
  // Define initial color
  Color := clBlack;
  for i:=0 to Flex.SelectedCount-1 do begin
   Control := Flex.Selected[i];
   FirstControl(Control, PassRec);
   while Assigned(Control) do begin
    Brush := Control.Props['Brush'] as TBrushProp;
    Pen := Control.Props['Pen'] as TPenProp;
    if (Button = mbLeft) and Assigned(Brush) and
      (Brush.Method = bmHatch) then begin
     // Get color
     Color := Brush.Color;
     if Brush.Style <> bsClear then break;
    end else
    if (Button = mbRight) and Assigned(Pen) then begin
     Color := Pen.Color;
     if Pen.Style <> psClear then break;
    end;
    {$IFDEF USE_FLEXPLUS}
    if not Assigned(Brush) then begin
     BrushPlus := Control.Props['BrushPlus'] as TBrushPlusProp;
     if (Button = mbLeft) and Assigned(BrushPlus) and
        (BrushPlus.Method in [bpmClear, bpmSolid, bpmHatch]) then begin
      // Get color
      Color := BrushPlus.Color;
      if (Color <> clNone) and (BrushPlus.Method <> bpmClear) then break;
     end;
    end;
    if not Assigned(Pen) then begin
     PenPlus := Control.Props['PenPlus'] as TPenPlusProp;
     if (Button = mbRight) and Assigned(PenPlus) then begin
      // Get color
      Color := PenPlus.Color;
      if (Color <> clNone) and (PenPlus.Method <> ppmClear) then break;
     end;
    end;
    {$ENDIF}
    // Next sub-control
    Control := NextControl(PassRec);
   end;
   ClosePassRec(PassRec);
  end;
  cd_Palette.Color := Color;
  // Update custom colors
  cd_Palette.CustomColors.Assign(CustomColors);
  if cd_Palette.Execute then begin
   CustomColors.Assign(cd_Palette.CustomColors);
   Color := cd_Palette.Color;
  end else
   exit;
 end;
 Flex.History.BeginPanelGroup(TPanelColorHistoryGroup);
 try
  for i:=0 to Flex.SelectedCount-1 do begin
   Control := Flex.Selected[i];
   FirstControl(Control, PassRec);
   while Assigned(Control) do begin
    Brush := Control.Props['Brush'] as TBrushProp;
    Pen := Control.Props['Pen'] as TPenProp;
    if (Button = mbLeft) and Assigned(Brush) then begin
     // Fill
     Brush.Method := bmHatch;
     if Color = clNone then
      Brush.Style := bsClear
     else begin
      Brush.Style := bsSolid;
      Brush.Color := ColorToRGB(Color);
     end;
    end else
    if (Button = mbRight) and Assigned(Pen) then begin
     // Outline
     if Color = clNone then
      Pen.Style := psClear
     else begin
      Pen.Style := psSolid;
      Pen.Color := ColorToRGB(Color);
     end;
    end;
    {$IFDEF USE_FLEXPLUS}
    if not Assigned(Brush) then begin
     BrushPlus := Control.Props['BrushPlus'] as TBrushPlusProp;
     if (Button = mbLeft) and Assigned(BrushPlus) then begin
      // Fill
      if Color = clNone then
       BrushPlus.Method := bpmClear
      else begin
       BrushPlus.Method := bpmSolid;
       BrushPlus.Color := Color;
      end;
     end;
    end;
    if not Assigned(Pen) then begin
     PenPlus := Control.Props['PenPlus'] as TPenPlusProp;
     if (Button = mbRight) and Assigned(PenPlus) then begin
      // Outline
      if Color = clNone then
       PenPlus.Method := ppmClear
      else begin
       PenPlus.Method := ppmDash;
       PenPlus.Color := Color;
      end;
     end;
    end;
    {$ENDIF}
    // Next sub-control
    Control := NextControl(PassRec);
   end;
   ClosePassRec(PassRec);
  end;
 finally
  Flex.History.EndPanelGroup(TPanelColorHistoryGroup);
 end;
end;

procedure TSCADAEditor.acEditUndoExecute(Sender: TObject);
begin
 if not Assigned(ActiveFlex) then exit;
 ActiveFlex.History.Undo;
 CheckTools;
 {$IFDEF DEBUG_HISTORY}
 if Assigned(fmHistoryDebug) then
   fmHistoryDebug.HistoryChange(ActiveFlex.History);
 {$ENDIF} 
end;

procedure TSCADAEditor.acEditRedoExecute(Sender: TObject);
begin
 if not Assigned(ActiveFlex) then exit;
 ActiveFlex.History.Redo;
 CheckTools;
 {$IFDEF DEBUG_HISTORY}
 if Assigned(fmHistoryDebug) then
   fmHistoryDebug.HistoryChange(ActiveFlex.History);
 {$ENDIF}
end;

procedure TSCADAEditor.acDebugHistoryExecute(Sender: TObject);
begin
 {$IFDEF DEBUG_HISTORY}
 if not Assigned(fmHistoryDebug) then
  fmHistoryDebug := TfmHistoryDebug.Create(Application);
 fmHistoryDebug.Flex := ActiveFlex;
 fmHistoryDebug.Show;
 {$ENDIF}
end;

end.

