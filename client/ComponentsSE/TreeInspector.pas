unit TreeInspector;

interface

{$IFNDEF VER80}                { DELPHI 1.0     }
 {$IFNDEF VER90}               { DELPHI 2.0     }
  {$IFNDEF VER93}              { C++Builder 1.0 }
   {$IFNDEF VER100}            { DELPHI 3.0     }
    {$IFNDEF VER110}           { C++Builder 3.0 }
     {$IFNDEF VER120}          { DELPHI 4.0 }
      {$IFNDEF VER125}         { C++Builder 4.0 }
       {$DEFINE DELPHI5_UP}
       {$IFNDEF VER130}        { DELPHI/C++Builder 5.0 }
        {$DEFINE DELPHI6_UP}
       {$ENDIF}
      {$ENDIF}
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

uses
  Windows, Classes, Controls, ComCtrls, CommCtrl, StdCtrls, Messages, Graphics,
  SysUtils, Forms, Mask;

const
  WM_FORCEFOCUS = WM_USER + 1234;

type
  TCustomTreeInspector = class;

  TGridEditStyle = (geSimple, geEllipsis, gePickList, geDataList, geUserDefine);

{ TGridListBox }

  {
    Выпадающий список строки редактирования.
  }

  TInplaceListBox = class(TCustomListBox)
  private
    FInspector: TCustomTreeInspector;
    FSearchText: String;
    FSearchTime: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Inspector: TCustomTreeInspector read FInspector;
  end;

  { The inplace editor is not intended to be used outside the grid }
  TInplaceEdit = class(TCustomMaskEdit)
  private
    FInspector: TCustomTreeInspector;
    FClickTime: Longint;
    FEditStyle: TGridEditStyle;
    FWantReturns: Boolean;
    FWordWrap: Boolean;
    FDropDownCount: Integer;
    FDropListVisible: Boolean;
    FPickList: TInplaceListBox;
    FActiveList: TWinControl;
    FButtonWidth: Integer;
    FButtonTracking: Boolean;
    FButtonPressed: Boolean;
    FDefocusing: Boolean;
    FAlignment: TAlignment;
    function GetButtonRect: TRect;
    function GetLineCount: Integer;
    function GetVisible: Boolean;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetAlignment(Value: TAlignment);
    procedure SetButtonWidth(Value: Integer);
    procedure SetDropListVisible(Value: Boolean);
    procedure SetEditStyle(Value: TGridEditStyle);
    procedure SetWordWrap(Value: Boolean);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaste(var Message); message WM_PASTE;
    procedure WMCut(var Message); message WM_CUT;
    procedure WMClear(var Message); message WM_CLEAR;
    procedure WMUndo(var Message); message WM_UNDO;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMContextMenu(var Message: TMessage); message WM_CONTEXTMENU;
    procedure WMForceFocus(var Message: TMessage); message WM_FORCEFOCUS;
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DblClick; override;
// TODO: {$IFDEF EX_D4_UP}
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
// {$ENDIF}
    function EditCanModify: Boolean; override;
    function GetDropList: TWinControl; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PaintButton(DC: HDC); virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure StartButtonTracking(X, Y: Integer);
    procedure StepButtonTracking(X, Y: Integer);
    procedure StopButtonTracking;
    procedure UpdateBounds(ScrollCaret: Boolean); virtual;
    procedure UpdateColors; virtual;
    procedure UpdateContents; virtual;
    procedure UpdateList; virtual;
    procedure UpdateListBounds; virtual;
    procedure UpdateListItems; virtual;
    procedure UpdateListValue(Accept: Boolean); virtual;
    procedure UpdateStyle; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure Deselect;
    procedure DropDown;
    procedure Invalidate; override;
    procedure Hide;
    procedure Press;
    procedure SelectNext;
    procedure SetFocus; override;
    procedure Show;
    property ActiveList: TWinControl read FActiveList write FActiveList;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ButtonRect: TRect read GetButtonRect;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth;
    property Color;
    property DropDownCount: Integer read FDropDownCount write FDropDownCount;
    property DropListVisible: Boolean read FDropListVisible write SetDropListVisible;
    property EditStyle: TGridEditStyle read FEditStyle write SetEditStyle;
    property Font;
    property Inspector: TCustomTreeInspector read FInspector;
    property LineCount: Integer read GetLineCount;
    property MaxLength;
    property PickList: TInplaceListBox read FPickList;
    property Visible: Boolean read GetVisible;
    property WantReturns: Boolean read FWantReturns write FWantReturns;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
  end;

  TTreeGetSetEditTextEvent = procedure(Sender: TObject; Node: TTreeNode;
    ALabel: boolean; var Text: string) of object;

  TCustomTreeInspector = class(TCustomTreeView)
  private
    FLabelsColWidth: integer;
    FLabelsLeftIndent: Integer;
    FInplaceEdit: TInplaceEdit;
    FDefaultEditMenu: Boolean;
    FTextRightIndent: Integer;
    FHitTest: TPoint;
    FAllowLabelEdit: boolean;
    FOnSetEditText: TTreeGetSetEditTextEvent;
    FOnGetEditText: TTreeGetSetEditTextEvent;
    {$IFNDEF DELPHI6_UP}
    FCanvasChanged: boolean;
    FOurFont: Integer;
    FStockFont: Integer;
    procedure CanvasChanged(Sender: TObject);
    {$ENDIF}
    function GetNodeFromItem(const Item: TTVItem): TTreeNode;
    procedure SetTextRightIndent(const Value: Integer);
    function AcquireFocus: Boolean;
    procedure UpdateFocus;
    procedure UpdateEditText;
    function IsActiveControl: Boolean;
    function GetPropertyCount: integer;
    procedure SetPropertyCount(Value: integer);
    procedure SetEditNode(const Value: TTreeNode);
    procedure SetAllowLabelEdit(const Value: boolean);
    procedure SetEditing(const Value: Boolean);
    procedure SetEditingLabel(const Value: Boolean);
    procedure SetLabelsColWidth(Value: integer);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure TWMEnsureVisible(var Message: TMessage); message TVM_ENSUREVISIBLE;
  protected
    FConstructed: Boolean;
    FDelimBmp: TBitmap;
    FEditing: Boolean; // TODO: ?
    FEditingLabel: Boolean;
    FEditNode: TTreeNode;
    FColResizing: boolean;
    procedure CreateHandle; override;
    function CanEditModify(Node: TTreeNode; ALabel: boolean): Boolean; virtual;
    function CanEditAcceptKey(Node: TTreeNode; Key: Char;
      ALabel: boolean): Boolean; virtual;
    function GetEditAlignment(Node: TTreeNode;
      ALabel: boolean): TAlignment; virtual;
    function GetEditStyle(Node: TTreeNode;
      ALabel: boolean): TGridEditStyle; virtual;
    function GetEditMask(Node: TTreeNode; ALabel: boolean): string; virtual;
    function GetEditText(Node: TTreeNode; ALabel: boolean): string; virtual;
    function GetEditLimit: Integer; virtual;
    function GetEditRect(Node: TTreeNode; ALabel: boolean): TRect; virtual;
    function GetEditReadOnly(Node: TTreeNode;
      ALabel: boolean): boolean; virtual;
    function GetCellTextIndent(Node: TTreeNode;
      ALabel: boolean): TPoint; virtual;
    procedure GetEditList(Node: TTreeNode; Items: TStrings); virtual;
    procedure SetEditText(Node: TTreeNode; ALabel: boolean;
      var Value: string); virtual;
    procedure EditCloseUp(Node: TTreeNode; ItemIndex: Integer;
      var Accept: Boolean); virtual;
    procedure EditButtonPress(Node: TTreeNode); virtual;
    procedure EditChange(Node: TTreeNode); virtual;
    {$IFDEF DELPHI6_UP}
    function IsCustomDrawn(Target: TCustomDrawTarget;
      Stage: TCustomDrawStage): Boolean; override;
    {$ENDIF}
    procedure DrawInspectorItem(Node: TTreeNode; State: TCustomDrawState);
    function CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage
      {$IFDEF DELPHI5_UP}; var PaintImages: Boolean {$ENDIF}): Boolean; override;
    procedure AdjustDelimBmp(Force: boolean = false);
    function ColResizeAllowed(X, Y: Integer): Boolean;
    procedure Resize; override; // TODO: {$IFDEF EX_D4_UP} override; {$ELSE} dynamic; {$ENDIF}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
// TODO: {$IFDEF EX_D4_UP}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
// TODO: {$ENDIF}
    procedure StartColResize(X, Y: Integer);
    procedure StepColResize(X, Y: Integer);
    procedure StopColResize(Abort: Boolean);
    property DefaultEditMenu: Boolean read FDefaultEditMenu
       write FDefaultEditMenu default False;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ApplyEdit; virtual;
    procedure CancelEdit; virtual;
    procedure UpdateEdit(Force: Boolean = False); virtual;
    procedure UpdateEditContents(SaveText: Boolean); virtual;
    procedure InvalidateValues;
    property  PropertyCount: integer read GetPropertyCount
      write SetPropertyCount;
    property  LabelsColWidth: integer read FLabelsColWidth
      write SetLabelsColWidth;
    property  TextRightIndent: Integer read FTextRightIndent
      write SetTextRightIndent default 6;
    property  InplaceEdit: TInplaceEdit read FInplaceEdit;
    property  EditNode: TTreeNode read FEditNode write SetEditNode;
    property  Editing: Boolean read FEditing write SetEditing;
    property  EditingLabel: Boolean read FEditingLabel write SetEditingLabel;
    property  AllowLabelEdit: boolean read FAllowLabelEdit
      write SetAllowLabelEdit default False;
    property  OnGetEditText: TTreeGetSetEditTextEvent read FOnGetEditText
      write FOnGetEditText;
    property  OnSetEditText: TTreeGetSetEditTextEvent read FOnSetEditText
      write FOnSetEditText;
  end;

  TTreeInspector = class(TCustomTreeInspector)
  published
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color default clBtnFace;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    // property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    {$IFDEF DELPHI6_UP}
    property MultiSelect;
    property MultiSelectStyle;
    {$ENDIF}
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    // property ReadOnly;
    property RightClickSelect;
    // property RowSelect;
    // property ShowButtons;
    property ShowHint;
    // property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Visible;
    {$IFDEF DELPHI6_UP}
    property OnAddition;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnContextPopup;
    property OnCreateNodeClass;
    {$ENDIF}
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;

    property OnGetEditText;
    property OnSetEditText;

    { Items must be published after OnGetImageIndex and OnGetSelectedIndex }
    property Items;
  end;

implementation

// TInplaceListBox ///////////////////////////////////////////////////////////////

constructor TInplaceListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentShowHint := False;
  ShowHint := False;
end;

procedure TInplaceListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TInplaceListBox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;

procedure TInplaceListBox.Keypress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27:
      { сбрасываем текст поиска }
      FSearchText := '';
    #32..#255:
      { инициируем поиск }
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTime > 2000 then FSearchText := '';
        FSearchTime := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SELECTSTRING, WORD(-1), Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TInplaceListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Inspector <> nil) and (Inspector.InplaceEdit <> nil) then
    Inspector.InplaceEdit.CloseUp(
      (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height) );
end;

// TCustomGridEdit ////////////////////////////////////////////////////////////

constructor TInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { внутренние переменные }
  FEditStyle := geSimple;
  FDropDownCount := 8;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  { параметры внешнего вида }
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  ParentShowHint := False;
  ShowHint := False;
  ParentColor := False;
end;

function TInplaceEdit.GetButtonRect: TRect;
begin
  Result := Rect(Width - FButtonWidth, 0, Width, Height);
end;

function TInplaceEdit.GetLineCount: Integer;
var
  P: PChar;
begin
  // Result := ExtStrUtils.GetLineCount(Text);
  Result := 0;
  { ищем перенос строки }
  P := Pointer(Text);
  while P^ <> #0 do
  begin
    while not (P^ in [#0, #10, #13]) do Inc(P);
    { была строка }
    Inc(Result);
    { учитываем символы переноса }
    if P^ = #13 then Inc(P);
    if P^ = #10 then Inc(P);
  end;
end;

function TInplaceEdit.GetVisible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (FActiveList <> nil) then CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TInplaceEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TInplaceEdit.SetButtonWidth(Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    Repaint;
  end;
end;

procedure TInplaceEdit.SetDropListVisible(Value: Boolean);
begin
  if Value then DropDown else CloseUp(False);
end;

procedure TInplaceEdit.SetEditStyle(Value: TGridEditStyle);
begin
  if FEditStyle <> Value then
  begin
    FEditStyle := Value;
    Repaint;
  end;
end;

procedure TInplaceEdit.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

procedure TInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  { символы, переход по нажатию TAB }
  with Message do
  begin
    Result := Result or DLGC_WANTARROWS or DLGC_WANTCHARS;
    // if (Inspector <> nil) and (gkTabs in Inspector.CursorKeys) then Result := Result or DLGC_WANTTAB;
  end;
end;

procedure TInplaceEdit.WMCancelMode(var Message: TMessage);
begin
  StopButtonTracking;
  inherited;
end;

procedure TInplaceEdit.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CloseUp(False);
end;

procedure TInplaceEdit.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Invalidate;
end;

procedure TInplaceEdit.WMPaint(var Message: TWMPaint);
begin                            
  PaintHandler(Message);
end;

procedure TInplaceEdit.WMLButtonDown(var Message: TWMLButtonDown);
begin
  SendCancelMode(Self);
  with Message do
    { чтобы выделение текста не гасло при нажатии на кнопку, обрабатываем
      нажатие сами }
    if (EditStyle <> geSimple) and PtInrect(ButtonRect, Point(XPos, YPos)) then
    begin
      if csCaptureMouse in ControlStyle then MouseCapture := True;
      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
    end
    else
    begin
      CloseUp(False);
      inherited;
    end;
end;

procedure TInplaceEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  P: TPoint;
begin
  with Message do
  begin
    P := Point(XPos, YPos);
    if (FEditStyle <> geSimple) and PtInRect(GetButtonRect, P) then Exit;
  end;
  inherited;
end;

procedure TInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  { не попала ли мышка на кнопку }
  if (FEditStyle <> geSimple) and PtInRect(GetButtonRect, ScreenToClient(P)) then
  begin
    Windows.SetCursor(LoadCursor(0, IDC_ARROW));
    Exit;
  end;
  { обработка по умолчанию }
  inherited;
end;

procedure TInplaceEdit.WMPaste(var Message);
begin
  if EditCanModify then inherited;
end;

procedure TInplaceEdit.WMCut(var Message);
begin
  if EditCanModify then inherited;
end;

procedure TInplaceEdit.WMClear(var Message);
begin
  if EditCanModify then inherited;
end;

procedure TInplaceEdit.WMUndo(var Message);
begin
  {if (Inspector = nil) or Inspector.EditCanUndo(Inspector.EditCell) then }inherited;
end;

procedure TInplaceEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) then CloseUp(False);
end;

procedure TInplaceEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TInplaceEdit.CMShowingChanged(var Message: TMessage);
begin
  { игнорируем изменение видимости через изменение свойства Visible }
end;

procedure TInplaceEdit.WMContextMenu(var Message: TMessage);
begin
  { если свойство DefaultPopupMenu таблицы установлено в True, то по правой
    кнопке надо показать стандартное popup меню строки ввода, а не Popup
    меню таблицы }
  if (Inspector <> nil) and Inspector.DefaultEditMenu and Assigned(Inspector.PopupMenu) then
    with Message do
      Result := CallWindowProc(DefWndProc, Handle, Msg, WParam, LParam)
  else
    inherited;
end;

procedure TInplaceEdit.WMForceFocus(var Message: TMessage);
begin
  Windows.SetFocus(Handle);
end;

procedure TInplaceEdit.Change;
begin
  if Inspector <> nil then Inspector.EditChange(Inspector.EditNode);
end;

procedure TInplaceEdit.CreateParams(var Params: TCreateParams);
const
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
  Aligns: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and (not WordWraps[FWordWrap]) or ES_MULTILINE or
      Aligns[FAlignment];
end;

procedure TInplaceEdit.DblClick;
begin
  { событие таблицы }
  if Inspector <> nil then Inspector.DblClick;
  { двойной щелчок - эмуляция нажатия на кнопку }
  case EditStyle of
    geEllipsis: Press;
    gePickList, geDataList: if not FDropListVisible then SelectNext;
  end;
end;

// TODO: {$IFDEF EX_D4_UP}

function TInplaceEdit.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := (Inspector <> nil) and Inspector.DoMouseWheel(Shift, WheelDelta, MousePos);
end;

// {$ENDIF}

function TInplaceEdit.EditCanModify: Boolean;
begin
  Result := (Inspector <> nil) and
    Inspector.CanEditModify(Inspector.EditNode, Inspector.EditingLabel);
end;

function TInplaceEdit.GetDropList: TWinControl;
begin
  if FPickList = nil then
  begin
    FPickList := TInplaceListBox.Create(Self);
    FPickList.IntegralHeight := True;
    FPickList.FInspector := Inspector;
  end;
  Result := FPickList;
end;

procedure TInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  var
    Node, NewNode: TTreeNode;
  begin
    if Inspector <> nil then begin
      Node := Inspector.EditNode;
      if Assigned(Node) then
        case Key of
          VK_UP:
            begin
              NewNode := Node.GetPrevVisible;
              if Assigned(NewNode) then Inspector.EditNode := NewNode;
            end;
          VK_DOWN:
            begin
              NewNode := Node.GetNextVisible;
              if Assigned(NewNode) then Inspector.EditNode := NewNode;
            end;
        end;
      Inspector.KeyDown(Key, Shift);
      Key := 0;
    end;
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
    if Inspector <> nil then
    begin
      GridKeyDown := Inspector.OnKeyDown;
      if Assigned(GridKeyDown) then GridKeyDown(Inspector, Key, Shift);
    end;
  end;

begin
  { обрабатываем нажатие }
  case Key of
    VK_UP,
    VK_DOWN:
      { перемещение фокуса }
      if (Shift = [ssCtrl]) or ((Shift = []) and (not (WantReturns or WordWrap))) then SendToParent;
    VK_PRIOR,
    VK_NEXT:
      { перемещение фокуса }
      if Shift = [ssCtrl] then SendToParent;
    VK_ESCAPE:
      { отмена }
      SendToParent;
    VK_DELETE:
      { удаление }
      if not EditCanModify then SendToParent;
    VK_INSERT:
      { вставка }
      if (not EditCanModify) or (Shift = []) then SendToParent;
(*
    VK_LEFT,
    VK_RIGHT,
    VK_HOME,
    VK_END:
      { перемещение фокуса при нажатом Ctrl }
      if Shift = [ssCtrl] then SendToParent;
*)
    VK_TAB:
      { табуляция }
      if not (ssAlt in Shift) then SendToParent;
  end;
  { кнопка не обработана - событие }
  if Key <> 0 then
  begin
    ParentEvent;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TInplaceEdit.KeyPress(var Key: Char);
begin
  if Inspector <> nil then
  begin
    { отсылаем клавишу таблице }
    Inspector.KeyPress(Key);
    { проверяем доступность символа }
    if (Key in [#32..#255]) and
        not Inspector.CanEditAcceptKey(
              Inspector.EditNode, Key, Inspector.EditingLabel) then
    begin
      Key := #0;
      MessageBeep(0);
    end;
    { разбираем символ }
    case Key of
      #9, #27:
        { TAB, ESC убираем }
        Key := #0;
      ^H, ^V, ^X, #32..#255:
        { BACKSPACE, обычные символы убираем, если нельзя редактировать }
        if not EditCanModify then Key := #0;
      #13:
        begin
          // Устанавливаем строку
          Inspector.Editing := False;
          SelectAll;
          Key := #0;
        end;
    end;
  end;
  { обработан ли символ }
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Inspector <> nil then Inspector.KeyUp(Key, Shift);
end;

procedure TInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { проверяем нажатие на кнопку }
  if (Button = mbLeft) and (EditStyle <> geSimple) and PtInrect(ButtonRect, Point(X, Y)) then
  begin
    { видим ли список }
    if FDropListVisible then
      { закрываем его }
      CloseUp(False)
    else
    begin
      { начинаем нажатие на кнопку и, если нужно, открываем список }
      StartButtonTracking(X, Y);
      if EditStyle <> geEllipsis then DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  M: TSmallPoint;
begin
  if FButtonTracking then
  begin
    { нажатие на кнопку }
    StepButtonTracking(X, Y);
    { для открытого списка }
    if FDropListVisible then
    begin
      { получаем точку на списке }
      P := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      { если попали на список }
      if PtInRect(FActiveList.ClientRect, P) then
      begin
        { прекращаем нажатие на кнопку }
        StopButtonTracking;
        { эмулируем нажатие на список }
        M := PointToSmallPoint(P);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(M));
        Exit;
      end;
    end;
  end;
  { обработка по умолчанию }
  inherited MouseMove(Shift, X, Y);
end;

procedure TInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: Boolean;
begin
  P := FButtonPressed;
  { завершаем нажатие }
  StopButtonTracking;
  { нажатие на кнопку }
  if (Button = mbLeft) and (EditStyle = geEllipsis) and P then Press;
  { обработка по умолчанию }
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TInplaceEdit.PaintButton(DC: HDC);
var
  R: TRect;
  Flags, DX: Integer;
begin
  { рисуем кнопку }
  if EditStyle <> geSimple then
  begin
    { получаем прямоугольник кнопки }
    R := GetButtonRect;
    { рисуем кнопку }
    case EditStyle of
      geEllipsis:
        { кнопка с многоточием }
        // PaintBtnEllipsis(DC, R, FButtonPressed);
        begin
          Flags := 0;
          if FButtonPressed then Flags := BF_FLAT;
          DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
          Flags := (R.Right - R.Left) div 2 - 1 + Ord(FButtonPressed);
          PatBlt(DC, R.Left + Flags, R.Top + Flags -1, 2, 2, BLACKNESS);
          PatBlt(DC, R.Left + Flags - 3, R.Top + Flags -1, 2, 2, BLACKNESS);
          PatBlt(DC, R.Left + Flags + 3, R.Top + Flags -1, 2, 2, BLACKNESS);
        end;
      gePickList, geDataList:
        { кнопка списка }
        begin
          // PaintBtnComboBox2(DC, R, FButtonPressed);
          Flags := 0;
          if FButtonPressed then Flags := DFCS_FLAT;
          DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
          Flags := (R.Right - R.Left) div 2 - 1 + Ord(FButtonPressed);
          DX := (R.Right - R.Left) mod 2 - 1;
          PatBlt(DC, R.Left + Flags - 2 + DX, R.Top + Flags - 1 -1, 7, 1, BLACKNESS);
          PatBlt(DC, R.Left + Flags - 1 + DX, R.Top + Flags + 0 -1, 5, 1, BLACKNESS);
          PatBlt(DC, R.Left + Flags - 0 + DX, R.Top + Flags + 1 -1, 3, 1, BLACKNESS);
          PatBlt(DC, R.Left + Flags + 1 + DX, R.Top + Flags + 2 -1, 1, 1, BLACKNESS);
        end;
    end;
  end;
end;

procedure TInplaceEdit.PaintWindow(DC: HDC);
var
  R: TRect;
begin
  { рисуем кнопку }
  PaintButton(DC);
  { убираем прямоугольник кнопки из области отрисовки }
  if (EditStyle <> geSimple) then 
  begin
    R := GetButtonRect;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  { отрисовка по умолчанию }
  inherited PaintWindow(DC);
end;

procedure TInplaceEdit.StartButtonTracking(X, Y: Integer);
begin
  MouseCapture := True;
  FButtonTracking := True;
  StepButtonTracking(X, Y);
end;

procedure TInplaceEdit.StepButtonTracking(X, Y: Integer);
var
  R: TRect;
  P: Boolean;
begin
  R := GetButtonRect;
  P := PtInRect(R, Point(X, Y));
  if FButtonPressed <> P then
  begin
    FButtonPressed := P;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TInplaceEdit.StopButtonTracking;
begin
  if FButtonTracking then
  begin
    StepButtonTracking(-1, -1);
    FButtonTracking := False;
    MouseCapture := False;
  end;
end;

type
  THackWinControl = class(TWinControl);

procedure TInplaceEdit.UpdateBounds(ScrollCaret: Boolean);
const
  Flags = SWP_SHOWWINDOW or SWP_NOREDRAW;
var
  R, F: TRect;
  L, T, W, H: Integer;
  TI: TPoint;
begin
  if Inspector <> nil then
  begin
    { определяем прямоугольник ячейки строки ввоа }
    R := Inspector.GetEditRect(Inspector.EditNode, Inspector.EditingLabel);
    { запоминаем прямоугольник }
    F := R;
    { подправляем строку в соотвествии с фиксированными
    with Inspector.GetFixedRect do
    begin
      if R.Left < Right then R.Left := Right;
      if R.Right < Right then R.Right := Right;
    end;
    { подправляем строку в соотвествии с заголовком
    with Inspector.GetHeaderRect do
    begin
      if R.Top < Bottom then R.Top := Bottom;
      if R.Bottom < Bottom then R.Bottom := Bottom;
    end; }
    { устанавливаем положение }
    W := R.Right - R.Left;
    H := R.Bottom - R.Top;
    SetWindowPos(Handle, HWND_TOP, R.Left, R.Top, W, H, Flags);
    { вычисляем новые границы такста }
    L := F.Left - R.Left;
    T := F.Top - R.Top;
    W := F.Right - F.Left;
    H := F.Bottom - F.Top;
    { смещение текста }
    TI := Inspector.GetCellTextIndent(Inspector.EditNode, Inspector.EditingLabel);
    { учитываем кнопку }
    if EditStyle <> geSimple then
      Dec(W, ButtonWidth + 1)
    else
      Dec(W, Inspector.TextRightIndent);
    { устанавливаем границы текста }
    R := Bounds(L + TI.X, T + TI.Y, W - TI.X + Ord(Alignment = taRightJustify), H);
    dec(R.Right, 2);
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
    { курсор в конец строки }
    if ScrollCaret then SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  end
end;

procedure TInplaceEdit.UpdateColors;
var
  Canvas: TCanvas;
begin
  if Inspector <> nil then
  begin
    Canvas := TCanvas.Create;
    try
      { получаем цвета ячейки }
      // TODO: ?? Inspector.GetCellColors(Inspector.EditCell, Canvas);
      { запоминаем их }
      Color := Canvas.Brush.Color;
      Font := Canvas.Font;
    finally
      Canvas.Free;
    end;
  end;
end;

procedure TInplaceEdit.UpdateContents;
begin
  if Inspector = nil then Exit;
  { обновляем параметры строки }
  with Inspector do
    if Assigned(EditNode) then begin
      // Self.MaxLength := Columns[EditCell.Col].MaxLength;
      Self.ReadOnly :=
        GetEditReadOnly(EditNode, EditingLabel) or (Self.MaxLength = -1);
      Self.WantReturns := False;
      Self.WordWrap := False;
      Self.Alignment := GetEditAlignment(EditNode, EditingLabel);
      Self.EditMask := GetEditMask(EditNode, EditingLabel);
      Self.Text := GetEditText(EditNode, EditingLabel);
    end else begin
      Self.ReadOnly := True;
      Self.Text := '';
    end;
end;

procedure TInplaceEdit.UpdateList;
begin
  if FActiveList <> nil then
  begin
    FActiveList.Visible := False;
    FActiveList.Parent := Self;
    THackWinControl(FActiveList).OnMouseUp := ListMouseUp;
    THackWinControl(FActiveList).Font := Font;
  end;
end;

procedure TInplaceEdit.UpdateListBounds;
var
  I, X, W: Integer;
  R: TRect;
begin
  { а есть ли таблица }
  if (Inspector = nil) or (FActiveList = nil) then Exit;
  { для стандартного списка определяем ширину и высоту по строкам }
  if FActiveList is TInplaceListBox then
    with TInplaceListBox(FActiveList) do
    begin
      Canvas.Font := Font;
      if Items.Count > 0 then
      begin
        W := 0;
        for I := 0 to Items.Count - 1 do
        begin
          X := Canvas.TextWidth(Items[I]);
          if W < X then W := X;
        end;
        ClientWidth := W + 6;
      end
      else
        ClientWidth := 100;
      { определяем высоту }
      if (FDropDownCount < 1) or (Items.Count = 0) then
        ClientHeight := ItemHeight
      else if Items.Count < FDropDownCount then
        ClientHeight := Items.Count * ItemHeight
      else
        ClientHeight := FDropDownCount * ItemHeight;
    end;
  { подправлям размеры списка в зависимости от размеров колонки и его
    положение на экране }
  with FActiveList do
  begin
    { подправляем по ширине колонки }
    // R := Inspector.EditNode.DisplayRect(False); // TODO: Inspector.GetCellRect(Inspector.EditCell);
    R := Inspector.GetEditRect(Inspector.EditNode, Inspector.EditingLabel);
    // Width := MaxIntValue([Width, R.Right - R.Left]);
    if Width < R.Right - R.Left then Width := R.Right - R.Left;
    { положение }
    Left := Self.ClientOrigin.X + Self.Width - Width;
    Top := Self.ClientOrigin.Y + Self.Height;
    if Top + Height > Screen.Height then Top := Self.ClientOrigin.Y - Height;
    { подправляем в соотвествием с пожеланием пользователя }
    R := BoundsRect;
    // TODO: ?? Inspector.GetEditListBounds(Inspector.EditCell, R);
    BoundsRect := R;
  end;
end;

procedure TInplaceEdit.UpdateListItems;
begin
  if (Inspector = nil) or (FActiveList = nil) or (not (FActiveList is TInplaceListBox)) then Exit;
  { обновляем выпадающий список }
  with TInplaceListBox(FActiveList) do
  begin
    { очищаем старый список, заполняем новый }
    Items.Clear;
    Inspector.GetEditList(Inspector.EditNode, Items);
    { устанавливаем выделенную позицию }
    SendMessage(Handle, LB_SELECTSTRING, WORD(-1), Longint(PChar(Self.Text)));
  end;
end;

procedure TInplaceEdit.UpdateListValue(Accept: Boolean);
var
  I: Integer;
begin
  if (FActiveList <> nil) and (FActiveList is TInplaceListBox) then
  begin
    I := TInplaceListBox(FActiveList).ItemIndex;
    { событие }
    if (Inspector <> nil) then Inspector.EditCloseUp(Inspector.EditNode, I, Accept);
    { устанавливаем значение }
    if Accept and (I <> -1) then
    begin
      Text := TInplaceListBox(FActiveList).Items[I];
      SendMessage(Handle, EM_SETSEL, 0, -1);
    end;
  end;
end;

procedure TInplaceEdit.UpdateStyle;
var
  Style: TGridEditStyle;
begin
  { получаем стиль строки }
  Style := geSimple;
  if (Inspector <> nil) and Assigned(Inspector.EditNode) then
    Style := Inspector.GetEditStyle(Inspector.EditNode, Inspector.EditingLabel);
  { устанавливаем }
  EditStyle := Style;
end;

{
  Delete the requested message from the queue, but throw back
  any WM_QUIT msgs that PeekMessage may also return.
}
procedure KillMessage(Wnd: HWND; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, PM_REMOVE) and (M.Message = WM_QUIT) then PostQuitMessage(M.wParam);
end;

procedure TInplaceEdit.WndProc(var Message: TMessage);

  procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
  begin
    case Key of
      VK_UP, VK_DOWN:
        { открытие или закрытие }
        if ssAlt in Shift then
        begin
          if FDropListVisible then CloseUp(True) else DropDown;
          Key := 0;
        end;
      VK_RETURN, VK_ESCAPE:
        { закрытие списка }
        if (not (ssAlt in Shift)) and FDropListVisible then
        begin
          KillMessage(Handle, WM_CHAR);
          CloseUp(Key = VK_RETURN);
          Key := 0;
        end;
    end;
  end;

  procedure DoButtonKeys(var Key: Word; Shift: TShiftState);
  begin
    if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    begin
      KillMessage(Handle, WM_CHAR);
      Key := 0;
      { эмуляция нажатия на кнопку }
      case EditStyle of
        geEllipsis: Press;
        gePickList, geDataList: if not FDropListVisible then SelectNext;
      end;
    end;
  end;

begin
  case Message.Msg of
    WM_KEYDOWN,
    WM_SYSKEYDOWN,
    WM_CHAR:
        with TWMKey(Message) do
        begin
          { открытие списка }
          if EditStyle in [gePickList, geDataList] then
          begin
            DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
            { передаем оставшееся событие списку }
            if (CharCode <> 0) and FDropListVisible then
            begin
              with TMessage(Message) do SendMessage(FActiveList.Handle, Msg, WParam, LParam);
              Exit;
            end;
          end;
          { эмуляция нажатия на кнопку }
          if not WantReturns then
          begin
            DoButtonKeys(CharCode, KeyDataToShiftState(KeyData));
            if CharCode = 0 then Exit;
          end;
        end;
    WM_SETFOCUS:
      begin
        if (GetParentForm(Self) = nil) or
            GetParentForm(Self).SetFocusedControl(Inspector) then
          Dispatch(Message);
        Exit;
      end;
    WM_LBUTTONDOWN:
      { двойное нажатие мышки }
      with TWMLButtonDown(Message) do
      begin
        { на нажатие на кнопку не реагируем }
        if (EditStyle = geSimple) or (not PtInrect(ButtonRect, Point(XPos, YPos))) then
          { смотрим время повторного щелчка }
          if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
            { меняем сообщение на двойной щелчок }
            Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TInplaceEdit.CloseUp(Accept: Boolean);
const
  Flags = SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW;
begin
  if FDropListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    { скрываем список }
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, Flags);
    FDropListVisible := False;
    Invalidate;
    { устанавливаем выбранное значение }
    UpdateListValue(Accept);
  end;
end;

procedure TInplaceEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

procedure TInplaceEdit.DropDown;
const
  Flags = SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW;
begin
  if (not FDropListVisible) and (Inspector <> nil) and (EditStyle in [gePickList, geDataList]) then
  begin
    { получаем выпадающий список }
    FActiveList := GetDropList;
    if FActiveList <> nil then
    begin
      { заполяем список, устанавливаем размеры }
      UpdateList;
      UpdateListItems;
      UpdateListBounds;
      { показываем список }
      SetWindowPos(FActiveList.Handle, HWND_TOP, FActiveList.Left, FActiveList.Top, 0, 0, Flags);
      FDropListVisible := True;
      Invalidate;
      { устанавливаем на него фокус }
      Windows.SetFocus(Handle);
    end;
  end;
end;

procedure TInplaceEdit.Invalidate;
var
  Cur: TRect;
begin
  { проверяем таблицу }
  if Inspector = nil then
  begin
    inherited Invalidate;
    Exit;
  end;
  { перерисовываемся }
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  { обновляем прямоугольник таблицы }
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Inspector.Handle, Cur, 2);
  ValidateRect(Inspector.Handle, @Cur);
  InvalidateRect(Inspector.Handle, @Cur, False);
end;

procedure TInplaceEdit.Hide;
const
  Flags = SWP_HIDEWINDOW or SWP_NOZORDER or SWP_NOREDRAW;
begin
  if (Inspector <> nil) and HandleAllocated and Visible then
  begin
    { сбрасываем флаг редактирования }
    Inspector.FEditing := False;
    { скрываем строку ввода }
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, Flags);
    { удаляем фокус }
    if Focused then
    begin
      FDefocusing := True;
      try
        Windows.SetFocus(Inspector.Handle);
      finally
        FDefocusing := False;
      end;
    end;
  end;
end;

procedure TInplaceEdit.Press;
begin
  if Inspector <> nil then Inspector.EditButtonPress(Inspector.EditNode);
end;

procedure TInplaceEdit.SelectNext;
var
  OldText, NewText: string;
begin
  if Inspector <> nil then
  begin
    OldText := Text;
    NewText := OldText;
    { вызываем метод таблицы }
    // TODO: ?? Inspector.EditSelectNext(Inspector.EditCell, NewText);
    { устанавливаем новое значение }
    if NewText <> OldText then
    begin
      Text := NewText;
      SendMessage(Handle, EM_SETSEL, 0, -1);
    end;
  end;
end;

procedure TInplaceEdit.SetFocus;
begin
  if IsWindowVisible(Handle) then Windows.SetFocus(Handle);
end;

procedure TInplaceEdit.Show;
var
  ScrollCaret: Boolean;
begin
  if Inspector <> nil then
  begin
    ScrollCaret := not Inspector.FEditing;
    { поднимаем флаг редактирования }
    Inspector.FEditing := True;
    // TODO: ?? Inspector.FCellSelected := True;
    { подправляем цвета (следует делать до установки границ, так как
      они выставляются в зависимости от размера шрифта) }
    UpdateColors;
    { получаем размеры }
    UpdateBounds(ScrollCaret);
    { устанавливаем фокус }
    // {if Inspector.Focused then }Windows.SetFocus(Handle);
    PostMessage(Handle, WM_FORCEFOCUS, 0, 0);
  end;
end;

// TCustomTreeInspector ///////////////////////////////////////////////////////

constructor TCustomTreeInspector.Create(AOwner: TComponent);
begin
  inherited;
  FLabelsColWidth := 100;
  FLabelsLeftIndent := 4;
  FInplaceEdit := TInplaceEdit.Create(Self);
  FInplaceEdit.Parent := Self;
  FInplaceEdit.FInspector := Self;

  ShowLines := False;
  ShowButtons := False;
  RowSelect := True;
  ReadOnly := True;
  HideSelection := False;
  Color := clBtnFace;

  FConstructed := True;
end;

function TCustomTreeInspector.GetNodeFromItem(const Item: TTVItem): TTreeNode;
begin
  Result := nil;
  if Items <> nil then
    with Item do
      if (state and TVIF_PARAM) <> 0 then
        Result := Pointer(lParam)
      else
        Result := Items.GetNode(hItem);
end;

procedure TCustomTreeInspector.TWMEnsureVisible(var Message: TMessage);
begin
  inherited;
  UpdateEdit(False);
end;

{$IFNDEF DELPHI6_UP}
procedure TCustomTreeInspector.CanvasChanged(Sender: TObject);
begin
  FCanvasChanged := True;
end;
{$ENDIF}

procedure TCustomTreeInspector.CNNotify(var Message: TWMNotify);
var
  NewEditingLabel: boolean;
  Node: TTreeNode;
  TreeItem: HTreeItem;
  R: TRect;
{$IFNDEF DELPHI6_UP}
  DefaultDraw: Boolean;
  TmpItem: TTVItem;
  LogFont: TLogFont;
  {$IFDEF DELPHI5_UP}
  PaintImages: Boolean;
  {$ENDIF}
{$ENDIF}
begin
  NewEditingLabel := AllowLabelEdit and (FHitTest.X < FLabelsColWidth);
  with Message do
    case NMHdr^.code of
      NM_CLICK:
        if Windows.GetCursor <> Screen.Cursors[crHSplit] then begin
          if AllowLabelEdit and (NewEditingLabel <> FEditingLabel) then begin
            { проверяем смену узла }
            Node := GetNodeAt(FHitTest.X, FHitTest.Y);
            { обновляем ячейку только в том случае, если узел не поменялся.
              Иначе должен отработать TVN_SELCHANGED }
            if Node = Selected then begin
              { при изменении положения курсора гасим подсказку }
              Application.CancelHint;
              { если идет редактирование - проверяем текст }
              Editing := False;
              { меняем ячейку }
              FEditingLabel := NewEditingLabel;
              UpdateEdit(True);
            end;
          end;
        end else
          Result := 1;
      TVN_DELETEITEM:
        begin
          Node := GetNodeFromItem(PNMTreeView(NMHdr).itemOld);
          if Node = FEditNode then begin
            FEditNode := Nil;
            FInplaceEdit.Hide;
          end;
        end;
      TVN_SELCHANGINGA, TVN_SELCHANGINGW:
        if FInplaceEdit.FDefocusing then
          Result := 1;
      TVN_SELCHANGEDA, TVN_SELCHANGEDW:
        with PNMTreeView(NMHdr)^ do begin
          TreeItem := TreeView_GetPrevVisible(Handle, itemOld.hItem);
          if integer(TreeItem) <> 0 then begin
            TreeView_GetItemRect(Handle, TreeItem, R, False);
            InvalidateRect(Handle, @R, True);
          end;
          TreeItem := TreeView_GetPrevVisible(Handle, itemNew.hItem);
          if integer(TreeItem) <> 0 then begin
            TreeView_GetItemRect(Handle, TreeItem, R, False);
            InvalidateRect(Handle, @R, True);
          end;
          { при изменении положения курсора гасим подсказку }
          Application.CancelHint;
          { если идет редактирование - проверяем текст }
          Editing := False;
          { меняем ячейку }
          if action = TVC_BYMOUSE then
            FEditingLabel := NewEditingLabel;
          UpdateEdit;
          if Assigned(FEditNode) then
            FEditNode.MakeVisible;
        end;
      {$IFNDEF DELPHI6_UP}
      NM_CUSTOMDRAW:
        if Assigned(Canvas) then begin
          with PNMCustomDraw(NMHdr)^ do begin
            Canvas.Lock;
            try
              Result := CDRF_DODEFAULT;
              if (dwDrawStage and CDDS_ITEM) = 0 then
              begin
                R := ClientRect;
                case dwDrawStage of
                  CDDS_PREPAINT:
                  begin
                    if IsCustomDrawn(dtControl, cdPrePaint) then
                    begin
                      try
                        Canvas.Handle := hdc;
                        Canvas.Font := Font;
                        Canvas.Brush := Brush;
                        DefaultDraw := CustomDraw(R, cdPrePaint);
                      finally
                        Canvas.Handle := 0;
                      end;
                      if not DefaultDraw then
                      begin
                        Result := CDRF_SKIPDEFAULT;
                        Exit;
                      end;
                    end;
                    // if IsCustomDrawn(dtItem, cdPrePaint) or IsCustomDrawn(dtItem, cdPreErase) then
                      Result := Result or CDRF_NOTIFYITEMDRAW;
                    if IsCustomDrawn(dtItem, cdPostPaint) then
                      Result := Result or CDRF_NOTIFYPOSTPAINT;
                    if IsCustomDrawn(dtItem, cdPostErase) then
                      Result := Result or CDRF_NOTIFYPOSTERASE;
                  end;
                  CDDS_POSTPAINT:
                    if IsCustomDrawn(dtControl, cdPostPaint) then
                      CustomDraw(R, cdPostPaint);
                  CDDS_PREERASE:
                    if IsCustomDrawn(dtControl, cdPreErase) then
                      CustomDraw(R, cdPreErase);
                  CDDS_POSTERASE:
                    if IsCustomDrawn(dtControl, cdPostErase) then
                      CustomDraw(R, cdPostErase);
                end;
              end else
              begin
                FillChar(TmpItem, SizeOf(TmpItem), 0);
                TmpItem.hItem := HTREEITEM(dwItemSpec);
                Node := GetNodeFromItem(TmpItem);
                if Node = nil then Exit;
                case dwDrawStage of
                  CDDS_ITEMPREPAINT:
                    begin
                      // release the font we may have loaned during item drawing.
                      if (dwDrawStage and CDDS_ITEMPOSTPAINT <> 0) and
                         (FOurFont <> 0) and (FStockFont <> 0) then
                      begin
                        SelectObject(hdc, FStockFont);
                        DeleteObject(FOurFont);
                        FOurFont := 0;
                        FStockFont := 0;
                      end;
                      try
                        Canvas.Handle := hdc;
                        Canvas.Font := Font;
                        Canvas.Brush := Brush;
                        // Unlike the list view, the tree view doesn't override the text
                        //  foreground and background colors of selected items.
                        if uItemState and CDIS_SELECTED <> 0 then
                        begin
                          Canvas.Font.Color := clHighlightText;
                          Canvas.Brush.Color := clHighlight;
                        end;
                        Canvas.Font.OnChange := CanvasChanged;
                        Canvas.Brush.OnChange := CanvasChanged;
                        FCanvasChanged := False;
                        DefaultDraw := CustomDrawItem(Node,
                          TCustomDrawState(Word(uItemState)), cdPrePaint
                          {$IFDEF DELPHI5_UP}, PaintImages {$ENDIF}
                        );
                        {$IFDEF DELPHI5_UP}
                        if not PaintImages then
                          Result := Result or TVCDRF_NOIMAGES;
                        {$ENDIF}
                        if not DefaultDraw then
                          Result := Result or CDRF_SKIPDEFAULT
                        else if FCanvasChanged then
                        begin
                          FCanvasChanged := False;
                          Canvas.Font.OnChange := nil;
                          Canvas.Brush.OnChange := nil;
                          with PNMTVCustomDraw(NMHdr)^ do
                          begin
                            clrText := ColorToRGB(Canvas.Font.Color);
                            clrTextBk := ColorToRGB(Canvas.Brush.Color);
                            if GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont) <> 0 then
                            begin
                              Canvas.Handle := 0;  // disconnect from hdc
                              // don't delete the stock font
                              FOurFont := CreateFontIndirect(LogFont);
                              FStockFont := SelectObject(hdc, FOurFont);
                              Result := Result or CDRF_NEWFONT;
                            end;
                          end;
                        end;
                        if IsCustomDrawn(dtItem, cdPostPaint) then
                          Result := Result or CDRF_NOTIFYPOSTPAINT;
                      finally
                        Canvas.Handle := 0;
                      end;
                    end;
                  CDDS_ITEMPOSTPAINT:
                      if IsCustomDrawn(dtItem, cdPostPaint) then
                        CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPostPaint
                          {$IFDEF DELPHI5_UP}, PaintImages {$ENDIF} );
                  CDDS_ITEMPREERASE:
                      if IsCustomDrawn(dtItem, cdPreErase) then
                        CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPreErase
                          {$IFDEF DELPHI5_UP}, PaintImages {$ENDIF} );
                  CDDS_ITEMPOSTERASE:
                      if IsCustomDrawn(dtItem, cdPostErase) then
                        CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPostErase
                          {$IFDEF DELPHI5_UP}, PaintImages {$ENDIF} );
                end;
              end;
            finally
              Canvas.Unlock;
            end;
          end;
          Exit;
        end;
        {$ENDIF}
    end;
  inherited;
end;

procedure TCustomTreeInspector.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  FHitTest := ScreenToClient(SmallPointToPoint(Message.Pos));
end;

procedure TCustomTreeInspector.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message, FHitTest do
    if not (csDesigning in ComponentState) and (GetKeyState(VK_LBUTTON) >= 0) and
       (HitTest = HTCLIENT) and ColResizeAllowed(X, Y) then begin
      Windows.SetCursor(Screen.Cursors[crHSplit]);
      Exit;
    end;
  inherited;
end;

procedure TCustomTreeInspector.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomTreeInspector.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  UpdateEdit(True);
end;

{$IFDEF DELPHI6_UP}
function TCustomTreeInspector.IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
begin
  { Tree view doesn't support erase notifications }
  if Stage = cdPrePaint then
  begin
    if Target = dtItem then
      Result := True
    else
    if Target = dtControl then
      Result := Assigned(OnCustomDraw) or Assigned(OnAdvancedCustomDraw) or
        Assigned(OnCustomDrawItem) or Assigned(OnAdvancedCustomDrawItem)  
    else
      Result := False;
  end
  else
  begin
    if Target = dtItem then
      Result := Assigned(OnAdvancedCustomDrawItem)
    else
    if Target = dtControl then
      Result := Assigned(OnAdvancedCustomDraw) or Assigned(OnAdvancedCustomDrawItem)
    else
      Result := False;
  end;
end;
{$ENDIF}

function TCustomTreeInspector.CustomDrawItem(Node: TTreeNode;
  State: TCustomDrawState; Stage: TCustomDrawStage
  {$IFDEF DELPHI5_UP}; var PaintImages: Boolean {$ENDIF}): Boolean;
begin
  Result :=
    inherited CustomDrawItem(Node, State, Stage
      {$IFDEF DELPHI5_UP}, PaintImages {$ENDIF});
  if not Result then exit;
  if Stage = cdPrePaint then begin
    DrawInspectorItem(Node, State);
    Result := False;
  end;
end;

procedure TCustomTreeInspector.DrawInspectorItem(Node: TTreeNode;
  State: TCustomDrawState);
var
  R, RText: TRect; // RR,
  DC: HDC;
  ClipRgn: HRgn;
  ClipReset: boolean;
  IsNextVisible: boolean;
  IsSelected: boolean;
  s: string;

  procedure DrawSelRect;
  begin
    dec(R.Left, 2);
    inc(R.Right, 2);
    dec(R.Top, 2);
    DrawEdge(DC, R, EDGE_SUNKEN, BF_RECT);
    inc(R.Left, 2);
    inc(R.Top, 2);
    dec(R.Right, 2);
  end;

  procedure InstallClipRgn(const R: TRect);
  begin
    ClipRgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
    ClipReset := GetClipRgn(DC, ClipRgn) = 0;
    if ClipReset then
      SelectClipRgn(DC, ClipRgn)
    else
      IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;

  procedure RemoveClipRgn;
  begin
    if ClipReset then
      SelectClipRgn(DC, 0)
    else begin
      SelectClipRgn(DC, ClipRgn);
      DeleteObject(ClipRgn);
    end;
  end;

  procedure PaintDelim;
  begin
    // Paint delimiter
    with Canvas do begin
      Pen.Color := clBtnShadow;
      MoveTo(R.Left + FLabelsColWidth, R.Top);
      LineTo(R.Left + FLabelsColWidth, R.Bottom);
      Pen.Color := clBtnHighlight;
      MoveTo(R.Left + FLabelsColWidth + 1, R.Top);
      LineTo(R.Left + FLabelsColWidth + 1, R.Bottom);
    end;
  end;

begin
  IsNextVisible := Node.GetNextVisible = EditNode;
  IsSelected := cdsSelected in State; // Node = EditNode;
  R := Node.DisplayRect(False);
  with Canvas do begin
    Brush.Color := Self.Color;
//    RR := R;
//    if cdsSelected in State then RR.Right := RR.Left + FLabelsColWidth;
   // FillRect(RR);
    // Paint selection
    if IsSelected or IsNextVisible then begin
      PaintDelim;
      Brush.Style := bsClear;
      DC := Handle;
      InstallClipRgn(R);
      if IsNextVisible then begin
        Pen.Color := cl3DDkShadow;
        MoveTo(R.Left, R.Bottom-2); LineTo(R.Right, R.Bottom-2);
        Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Bottom-1); LineTo(R.Right, R.Bottom-1);
      end else begin
        Pen.Color := cl3DLight;
        MoveTo(R.Left, R.Bottom-2); LineTo(R.Right, R.Bottom-2);
        Pen.Color := clBtnHighlight;
        MoveTo(R.Left, R.Bottom-1); LineTo(R.Right, R.Bottom-1);
      end;
      RemoveClipRgn;
    end else begin
      AdjustDelimBmp;
      Draw(0, R.Bottom-1, FDelimBmp);
      PaintDelim;
    end;
    RText := Node.DisplayRect(True);
    inc(RText.Top);
    inc(RText.Bottom);
    DC := Handle;
    // Paint label
    if not IsSelected or not FEditingLabel then begin
      if not ShowButtons then inc(RText.Left, FLabelsLeftIndent);
      RText.Right := R.Left + FLabelsColWidth - 2;
      SetTextColor(DC, ColorToRGB(Self.Font.Color));
      s := GetEditText(Node, True);
      DrawText(DC, PChar(s), Length(s), RText, DT_SINGLELINE or DT_END_ELLIPSIS);
    end;
    // Paint value
    if not IsSelected or FEditingLabel then begin
      RText.Left := FLabelsColWidth + 4;
      RText.Right := R.Right;
      SetTextColor(DC, ColorToRGB(Self.Font.Color));
      s := GetEditText(Node, False);
      DrawText(DC, PChar(s), Length(s), RText, DT_SINGLELINE or DT_END_ELLIPSIS);
    end;
  end;
end;

procedure TCustomTreeInspector.AdjustDelimBmp(Force: boolean = false);
var
  StartPos: integer;
  R: TRect;
begin
  if not Force and Assigned(FDelimBmp) and (FDelimBmp.Width >= ClientWidth) then
    Exit;
  if not Assigned(FDelimBmp) then begin
    FDelimBmp := TBitmap.Create;
    FDelimBmp.Height := 1;
  end;
  StartPos := 0;
  if FDelimBmp.Width < ClientWidth then begin
    if not Force then StartPos := FDelimBmp.Width;
    FDelimBmp.Width := ClientWidth;
    FDelimBmp.Canvas.Brush.Color := Self.Color;
    FDelimBmp.Canvas.FillRect(Rect(StartPos, 0, FDelimBmp.Width, 1));
  end;
  if StartPos = FDelimBmp.Width then
    Exit;
  // Dots filling
  FDelimBmp.Canvas.Brush.Color := clBtnShadow;
  inc(StartPos, StartPos and 1);
  R := Rect(StartPos, 0, StartPos + 1, 1);
  while R.Left <= FDelimBmp.Width do begin
    FDelimBmp.Canvas.FillRect(R);
    inc(R.Left, 2);
    inc(R.Right, 2);
  end;
end;

function TCustomTreeInspector.CanEditModify(Node: TTreeNode;
  ALabel: boolean): Boolean;
begin
  Result := True; // TODO: FCanEditModify;
end;

function TCustomTreeInspector.CanEditAcceptKey(Node: TTreeNode; Key: Char;
  ALabel: boolean): Boolean;
begin
  Result := True; // TODO:
end;

function TCustomTreeInspector.GetEditAlignment(Node: TTreeNode;
  ALabel: boolean): TAlignment;
begin
  Result := taLeftJustify; // TODO:
end;

function TCustomTreeInspector.GetEditStyle(Node: TTreeNode;
  ALabel: boolean): TGridEditStyle;
begin
  Result := geSimple; // TODO:
end;

function TCustomTreeInspector.GetEditMask(Node: TTreeNode;
  ALabel: boolean): string;
begin
  Result := ''; // TODO:
end;

function TCustomTreeInspector.GetEditText(Node: TTreeNode;
  ALabel: boolean): string; 
begin
  Result := '';
  if Assigned(FOnGetEditText) then FOnGetEditText(Self, Node, ALabel, Result);
end;

function TCustomTreeInspector.GetEditLimit: Integer;
begin
  Result := 0;
end;

procedure TCustomTreeInspector.GetEditList(Node: TTreeNode; Items: TStrings);
begin
  Items.Clear; // TODO:
end;

procedure TCustomTreeInspector.EditChange(Node: TTreeNode);
begin
  // TODO:
end;

function TCustomTreeInspector.GetEditRect(Node: TTreeNode;
  ALabel: boolean): TRect;
begin
  // TODO: ??
  if Assigned(Node) then begin
    Result := Node.DisplayRect(False);
    if ALabel then
      Result.Right := FLabelsColWidth
    else
      inc(Result.Left, FLabelsColWidth + 2);
    dec(Result.Bottom, 2);
  end else
    SetRectEmpty(Result);
end;

function TCustomTreeInspector.GetCellTextIndent(Node: TTreeNode;
  ALabel: boolean): TPoint;
begin
  // TODO:
  if ALabel then
    Result.X := 4
  else
    Result.X := 2;
  Result.Y := 1;
(*
  { значение по умолчанию }
  Result.X := TextLeftIndent;
  Result.Y := TextTopIndent;
  { учитываем картинки и 3D эффект }
  if IsCellHasCheck(Cell) or IsCellHasImage(Cell) then
  begin
    Result.X := 2;
    if (Fixed.Count > 0) and (not Fixed.Flat) then Inc(Result.Y, 1);
  end;
  { событие пользователя }
  if Assigned(FOnGetCellTextIndent) then FOnGetCellTextIndent(Self, Cell, Result);
*)
end;

procedure TCustomTreeInspector.SetTextRightIndent(const Value: Integer);
begin
  if FTextRightIndent = Value then Exit;
  FTextRightIndent := Value;
  UpdateEdit;
  Invalidate;
end;

function TCustomTreeInspector.GetEditReadOnly(Node: TTreeNode;
  ALabel: boolean): boolean;
begin
  Result := False; // TODO:
end;

procedure TCustomTreeInspector.EditCloseUp(Node: TTreeNode; ItemIndex: Integer;
  var Accept: Boolean);
begin
  // TODO:
end;

procedure TCustomTreeInspector.EditButtonPress(Node: TTreeNode);
begin
  // TODO:
end;

procedure TCustomTreeInspector.UpdateEdit(Force: Boolean = False);
var NewNode: Boolean;
begin
  NewNode := FEditNode <> Selected;
  { если положение изменилось - гасим и обновляем строку }
  if Force or NewNode then
  begin
    FInplaceEdit.Hide;
    FEditNode := Selected;
    FInplaceEdit.Updating;
    FInplaceEdit.UpdateContents;
    FInplaceEdit.UpdateStyle;
    FInplaceEdit.Updated;
    FInplaceEdit.SelectAll;
  end;
  { показываем строку }
  if Assigned(FEditNode) then
    FInplaceEdit.Show
  else
    FInplaceEdit.Hide;
end;

procedure TCustomTreeInspector.UpdateEditContents(SaveText: Boolean);
var
  EditText: string;
begin
  EditText := InplaceEdit.Text;
  { чтобы строка обновилась полностью, ее необходимо погасить }
  FInplaceEdit.Hide;
  { обновляем и вновь показываем строку }
  UpdateEdit;
  { восстанавливаем текст }
  if SaveText then InplaceEdit.Text := EditText;
end;

function TCustomTreeInspector.ColResizeAllowed(X, Y: Integer): Boolean;
begin
  Result :=
    (Items.Count > 0) and
    (X >= FLabelsColWidth - 3) and (X <= FLabelsColWidth + 3);
end;

function TCustomTreeInspector.IsActiveControl: Boolean;
var
  H: HWND;
begin
  { определяем активность по форме }
  if (GetParentForm(Self) <> nil) and (GetParentForm(Self).ActiveControl = Self) then
  begin
    Result := True;
    Exit;
  end;
  { определяем по описателю }
  H := GetFocus;
  while IsWindow(H) do
  begin
    if H = WindowHandle then
    begin
      Result := True;
      Exit;
    end;
    H := GetParent(H);
  end;
  { ничего не нашли }
  Result := False;
end;

procedure TCustomTreeInspector.UpdateFocus;
begin
  if csDesigning in ComponentState then Exit;
  { если таблица уже активна, то ставим фокус на нее еще раз насильно,
    т.к. в противном случае могут быть глюки с MDI формами }
  if IsActiveControl then
  begin
    Windows.SetFocus(Handle);
    if GetFocus = Handle then Perform(CM_UIACTIVATE, 0, 0);
  end
  else
    { а можно ли устанавливать фокус }
    if IsWindowVisible(Handle) and TabStop and (CanFocus or (GetParentForm(Self) = nil)) then
    begin
      SetFocus;
      {if AlwaysEdit and (Edit <> nil) then }UpdateEdit;
    end;
end;

function TCustomTreeInspector.AcquireFocus: Boolean;
begin
  Result := True;
  { можно ли устанавливать фокус }
  if not (csDesigning in ComponentState) and CanFocus then
  begin
    UpdateFocus;
    Result := IsActiveControl;
  end;
end;

procedure TCustomTreeInspector.StartColResize(X, Y: Integer);
begin
  { вычисляем граничный прямоугольник для изменения размера }
  FColResizing := True;
  { захватываем мышку }
  MouseCapture := True;
end;

procedure TCustomTreeInspector.StepColResize(X, Y: Integer);
var
  R: TRect;
  W: integer;
begin
  R := ClientRect;
  W := R.Right - R.Left;
  if X < 30 then X := 30 else
  if X > W - 30 then X := W - 30;
  FLabelsColWidth := X;

  InvalidateRect(Handle, @R, False);
  UpdateEdit;
end;

procedure TCustomTreeInspector.StopColResize(Abort: Boolean);
begin
  if FColResizing then
  try
    { освобождаем мышку }
    MouseCapture := False;
  finally
    FColResizing := False;
  end;
end;

procedure TCustomTreeInspector.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { устанавливаем фокус на себя }
  if not AcquireFocus then
  begin
    MouseCapture := False;
    Exit;
  end;
  { левая клавиша }
  if Button = mbLeft then
  begin
    { попытка начать изменения размера колонки }
    if ColResizeAllowed(X, Y) then
    begin
      { начинаем изменение размера }
      StartColResize(X, Y);
      { не пускаем дальше }
      Exit;
    end;
  end;
  { обработчик по умолчанию }
  inherited;
end;

procedure TCustomTreeInspector.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { идет ли изменение размера колонки }
  if FColResizing then
  begin
    { заканчиваем изменение }
    StopColResize(False);
    { не пускаем дальше }
    Exit;
  end;
  { обработчик по умолчанию }
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomTreeInspector.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
  R: TRect;
begin
  { идет ли изменение размера колонки  }
  if FColResizing then
  begin
    { продолжаем изменение }
    StepColResize(X, Y);
    { не пускаем дальше }
    Exit;
  end else
  if ssLeft in Shift then begin
    // Переход на узел под мышкой
    Node := GetNodeAt(X, Y);
    if Assigned(Node) then begin
      R := Node.DisplayRect(False);
      with ClientRect do
        // Только если узел виден целиком (иначе будет рекурсивная прокрутка)
        if (R.Left >= Left) and (R.Right <= Right) and
           (R.Top >= Top) and (R.Bottom <= Bottom) then
          Selected := Node;
    end;
  end;
  { обработчик по умолчанию }
  inherited;
end;

function TCustomTreeInspector.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  NextNode: TTreeNode;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then begin
    if Assigned(Selected) then
      NextNode := Selected.GetNext
    else
      NextNode := Items.GetFirstNode;
    if Assigned(NextNode) then
      Selected := NextNode;
    Result := True;
  end;
end;

function TCustomTreeInspector.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
var
  PrevNode: TTreeNode;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then begin
    if Assigned(Selected) then
      PrevNode := Selected.GetPrev
    else
      PrevNode := Items.GetFirstNode;
    if Assigned(PrevNode) then
      Selected := PrevNode;
    Result := True;
  end;
end;

procedure TCustomTreeInspector.Resize;
var
  ValuesColWidth: integer;
begin
  inherited;
  ValuesColWidth := ClientWidth - LabelsColWidth;
  if ValuesColWidth < 30 then begin
    LabelsColWidth := LabelsColWidth - (30 - ValuesColWidth); 
  end;
  UpdateEdit;
// {$IFDEF EX_D4_UP}
  inherited Resize;
// {$ELSE}
  if Assigned(OnResize) then OnResize(Self);
// {$ENDIF}
end;

procedure TCustomTreeInspector.SetEditNode(const Value: TTreeNode);
begin
  Selected := Value;
end;

procedure TCustomTreeInspector.SetEditingLabel(const Value: Boolean);
begin
  if (Value = FEditingLabel) or (Value and not AllowLabelEdit) then exit;
  FEditingLabel := Value;
  UpdateEdit(True);
end;

procedure TCustomTreeInspector.SetAllowLabelEdit(const Value: boolean);
begin
  if Value = FAllowLabelEdit then exit;
  if not Value and FEditingLabel then begin
    FEditingLabel := False;
    UpdateEdit;
  end;
  FAllowLabelEdit := Value;
end;

procedure TCustomTreeInspector.ApplyEdit;
begin
  Editing := False;
end;

procedure TCustomTreeInspector.CancelEdit;
begin
  if Editing then
  begin
    { восстанавливаем значение }
    UpdateEditContents(False);
    { ввод текста отменен }
    // TODO:
    // EditCanceled(EditCell);
    // if Assigned(FOnEditCanceled) then FOnEditCanceled(Self, Cell);
  end;
end;

procedure TCustomTreeInspector.SetEditText(Node: TTreeNode; ALabel: boolean;
  var Value: string);
begin
  if Assigned(FOnSetEditText) then FOnSetEditText(Self, Node, ALabel, Value);
end;

procedure TCustomTreeInspector.UpdateEditText;
var
  EditFocused: Boolean;
  EditText: string;
begin
  if csDestroying in ComponentState then
    Exit;
  if Assigned(FEditNode) and Assigned(InplaceEdit) and InplaceEdit.Visible then
  begin
    EditFocused := Editing;
    { проверяем текст строки ввода }
    try
      EditText := InplaceEdit.Text;
      try
        SetEditText(FEditNode, FEditingLabel, EditText);
      finally
        InplaceEdit.Text := EditText;
      end;
    except
      on E: Exception do
      begin
        { не даем сдвигаться движку скроллера }
        // MakeCellVisible(CellFocused, False);
        { если строка видна - фокус на нее, иначе она погасится после
          открытия окна с сообщением об ошибке }
        if EditFocused then InplaceEdit.SetFocus;
        { ошибка }
        raise;
      end;
    end;
  end;
end;

procedure TCustomTreeInspector.SetEditing(const Value: Boolean);
var
  AllowEdit: Boolean;
begin
  AllowEdit := Items.Count > 0;
  // FEditing := Value;
  { проверяем начало редактирования }
  if Value and AllowEdit then begin
    { фокус на таблицу, показываем строку ввода }
    if AcquireFocus then UpdateEdit(True); // ShowEdit;
  end else
  { смотрим завершение ввода }
  if (not Value) and FEditing then begin
    { проверяем текст, гасим строку }
    UpdateEditText;
    // if not AlwaysEdit then HideEdit;
  end;
  // TODO: { событие }
  // ChangeEditing;
end;

procedure TCustomTreeInspector.SetLabelsColWidth(Value: integer);
begin
  if Value < 30 then Value := 30;
  if Value = FLabelsColWidth then exit;
  FLabelsColWidth := Value;
  UpdateEdit(True);
  Invalidate;
end;

procedure TCustomTreeInspector.CreateHandle;
begin
  if FConstructed then
    inherited;
end;

procedure TCustomTreeInspector.InvalidateValues;
var R: TRect;
begin
  if Items.Count = 0 then exit;
  R := ClientRect;
  R.Left := FLabelsColWidth + 2;
  InvalidateRect(Handle, @R, False);
end;

function TCustomTreeInspector.GetPropertyCount: integer;
begin
  Result := Items.Count;
end;

procedure TCustomTreeInspector.SetPropertyCount(Value: integer);
begin
  if Value < 0 then Value := 0;
  Items.BeginUpdate;
  try
    while Items.Count > Value do Items.Delete(Items.GetFirstNode);
    while Items.Count < Value do Items.Add(Nil, '');
  finally
    Items.EndUpdate;
  end;
end;

end.
