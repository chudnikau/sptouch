unit SpinSE;

// Set this define if you use ThemeManager library
// in Delphi/C++Builder lower 7.0 
{.DEFINE XPTHEMES}

{$IFNDEF VER80}                { DELPHI 1.0     }
 {$IFNDEF VER90}               { DELPHI 2.0     }
  {$IFNDEF VER93}              { C++Builder 1.0 }
   {$IFNDEF VER100}            { DELPHI 3.0     }
    {$IFNDEF VER110}           { C++Builder 3.0 }
     {$IFNDEF VER120}          { DELPHI 4.0 }
      {$IFNDEF VER125}         { C++Builder 4.0 }
       {$IFNDEF VER130}        { DELPHI/C++Builder 5.0 }
        {$IFNDEF VER140}       { DELPHI/C++Builder 6.0 }
         {$DEFINE DELPHI7_UP}  { DELPHI/C++Builder higher 6.0 }
         {$DEFINE XPTHEMES}
        {$ENDIF}
       {$ENDIF}
      {$ENDIF}
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

interface

uses
  Windows, Classes, StdCtrls, ExtCtrls, Controls, Messages, SysUtils,
  {$IFDEF XPTHEMES}
    {$IFDEF DELPHI7_UP} Themes, {$ELSE} ThemeSrv, {$ENDIF}
  {$ENDIF}
  Forms, Graphics, Menus, Buttons;

const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 70;  { pause before hint window displays (ms)}

type
  TUpDownBtnSE = ( udbNone, udbUp, udbDown );

  TCustomUpDownSE = class(TCustomControl)
  private
   FRepeatTimer: TTimer;
   FFocusControl: TWinControl;
   FOnUpClick: TNotifyEvent;
   FOnDownClick: TNotifyEvent;
   FHighlighted: TUpDownBtnSE;
   FPressed: TUpDownBtnSE;
   procedure TimerExpired(Sender: TObject);
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
   procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
   procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
   procedure Paint; override;
   procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
   procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
     X, Y: Integer); override;
   procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
     override;
   procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   procedure DoUpClick; virtual;
   procedure DoDownClick; virtual;
   property  FocusControl: TWinControl read FFocusControl write FFocusControl;
   property  OnDownClick: TNotifyEvent read FOnDownClick write FOnDownClick;
   property  OnUpClick: TNotifyEvent read FOnUpClick write FOnUpClick;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   property   Pressed: TUpDownBtnSE read FPressed;
  end;

  TUpDownSE = class(TCustomUpDownSE)
  published
    property Align;
    property Anchors;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDownClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
    property OnUpClick;
  end;

  TFlexSpinValueType = (
    fvtInteger,
    fvtFloat
  );

  TFlexSpinUpDownEvent = procedure(Sender: TObject;
    var NewValue: extended) of object;

  TFlexSpinValidChar = procedure(Sender: TObject; AChar: char;
    var IsValid: boolean) of object;

  TCustomSpinEditSE = class(TCustomEdit)
  private
   FMinValue: extended;
   FMaxValue: extended;
   FIncrement: extended;
   FButton: TUpDownSE;
   FEditorEnabled: Boolean;
   FDigitsOnly: boolean;
   FDecimal: integer;
   FOnUpClick: TFlexSpinUpDownEvent;
   FOnDownClick: TFlexSpinUpDownEvent;
   FOnIsCharValid: TFlexSpinValidChar;
   function  GetMinHeight: Integer;
   function  GetValue: extended;
   function  CheckValue(NewValue: extended): extended;
   procedure SetValue(NewValue: extended);
   procedure SetEditRect;
   procedure SetDigitsOnly(const Value: boolean);
   function  GetIntValue: integer;
   procedure SetIntValue(const Value: integer);
   procedure SetDecimal(const Value: integer);
   procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
   procedure CMExit(var Message: TCMExit); message CM_EXIT;
   procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
   procedure WMSize(var Message: TWMSize); message WM_SIZE;
   procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
   procedure WMCut(var Message: TWMCut); message WM_CUT;
  protected
   procedure DoUpClick(var NewValue: extended); virtual;
   procedure DoDownClick(var NewValue: extended); virtual;
   procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
   function  IsValidChar(Key: Char): Boolean; virtual;
   procedure UpClick(Sender: TObject); virtual;
   procedure DownClick(Sender: TObject); virtual;
   procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   procedure KeyPress(var Key: Char); override;
   procedure CreateParams(var Params: TCreateParams); override;
   procedure CreateWnd; override;
   property  EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
   property  Increment: extended read FIncrement write FIncrement;
   property  MaxValue: extended read FMaxValue write FMaxValue;
   property  MinValue: extended read FMinValue write FMinValue;
   property  Value: extended read GetValue write SetValue;
   property  IntValue: integer read GetIntValue write SetIntValue;
   property  Decimal: integer read FDecimal write SetDecimal default 0;
   property  DigitsOnly: boolean read FDigitsOnly write SetDigitsOnly
     default false;
   property  OnDownClick: TFlexSpinUpDownEvent read FOnDownClick
     write FOnDownClick;
   property  OnUpClick: TFlexSpinUpDownEvent read FOnUpClick write FOnUpClick;
   property  OnIsCharValid: TFlexSpinValidChar read FOnIsCharValid
     write FOnIsCharValid;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   property  Button: TUpDownSE read FButton;
  end;


  TSpinEditSE = class(TCustomSpinEditSE)
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Color;
    property Constraints;
    property Ctl3D;
    property Decimal;
    property DigitsOnly;
    property DragCursor;
    property DragMode;
    property EditorEnabled;
    property Enabled;
    property Font;
    property Increment;
    property MaxLength;
    property MaxValue;
    property MinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnIsCharValid; 
    property OnDownClick;
    property OnUpClick;
  end;

implementation

// TCustomFlexUpDown ///////////////////////////////////////////////////////////

constructor TCustomUpDownSE.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] +
   [csOpaque];
 Width := 20;
 Height := 25;
end;

destructor TCustomUpDownSE.Destroy;
begin
 FRepeatTimer.Free;
 FRepeatTimer := Nil;
 inherited;
end;

procedure TCustomUpDownSE.CMMouseLeave(var Message: TMessage);
begin
 FHighlighted := udbNone;
 Invalidate;
end;

procedure TCustomUpDownSE.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
 Message.Result := DLGC_WANTARROWS;
end;

procedure TCustomUpDownSE.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
 Message.Result := 1;
end;

procedure TCustomUpDownSE.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 if (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height) then begin
  if Y <= Height div 2
   then FHighlighted := udbUp
   else FHighlighted := udbDown;
  if FPressed = udbNone then Invalidate;
 end;
 inherited;
end;

procedure TCustomUpDownSE.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
 if (FHighlighted <> udbNone) and (Button = mbLeft) then begin
  FPressed := FHighlighted;
  Invalidate;
  case FPressed of
   udbUp   : DoUpClick;
   udbDown : DoDownClick;
  end;
  if FRepeatTimer = nil then begin
   FRepeatTimer := TTimer.Create(Self);
   FRepeatTimer.OnTimer := TimerExpired;
  end else
   FRepeatTimer.Enabled := false;
  FRepeatTimer.Interval := InitRepeatPause;
  FRepeatTimer.Enabled  := true;
 end;
 inherited;
end;

procedure TCustomUpDownSE.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
 inherited;
 FRepeatTimer.Free;
 FRepeatTimer := Nil;
 if FPressed <> udbNone then begin
  FPressed := udbNone;
  Invalidate;
 end;
end;

procedure TCustomUpDownSE.TimerExpired(Sender: TObject);
begin
 FRepeatTimer.Interval := RepeatPause;
 if (FPressed = udbNone) or not MouseCapture then begin
  FRepeatTimer.Enabled := false;
  exit;
 end;
 try
  case FPressed of
   udbUp   : DoUpClick;
   udbDown : DoDownClick;
  end;
 except
  FRepeatTimer.Enabled := False;
  raise;
 end;
end;

procedure TCustomUpDownSE.KeyDown(var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_UP   : DoUpClick;
  VK_DOWN : DoDownClick;
 end;
 inherited;
end;

procedure TCustomUpDownSE.Paint;
var DC: HDC;
    UpSize, DownPos: integer;
    {$IFDEF XPTHEMES}
    Details: TThemedElementDetails;
    {$ENDIF}
    FillBrush: HBrush;
    State: cardinal;
    Range: TRect;
    IsEnabled: boolean;
begin
 DC := Canvas.Handle;
 UpSize := Height div 2;
 DownPos := UpSize;
 if Height and 1 <> 0 then begin
  FillBrush := CreateSolidBrush(ColorToRGB(clBtnFace));
  FillRect(DC, Rect(0, UpSize, Width, UpSize+1), FillBrush);
  DeleteObject(FillBrush);
  inc(DownPos);
 end;
 if Assigned(FFocusControl) and (FFocusControl is TCustomSpinEditSE)
   {$IFDEF XPTHEMES}
   and ThemeServices.ThemesEnabled
   {$ENDIF}
  then Range := Rect(0, -1, Width + 1, Height + 1)
  else Range := Rect(0, 0, Width, Height);
 IsEnabled := Enabled and
   (not Assigned(FFocusControl) or FFocusControl.Enabled);
 {$IFDEF XPTHEMES}
 if ThemeServices.ThemesEnabled then with ThemeServices do begin
  if not IsEnabled then
   Details := GetElementDetails(tsUpDisabled)
  else
  if FPressed = udbUp then
   Details := GetElementDetails(tsUpPressed)
  else
  if (FHighlighted = udbUp) and (FPressed = udbNone) then
   Details := GetElementDetails(tsUpHot)
  else
   Details := GetElementDetails(tsUpNormal);
  DrawElement(DC, Details, Rect(Range.Left, Range.Top, Range.Right, UpSize));
  if not IsEnabled then
   Details := GetElementDetails(tsDownDisabled)
  else
  if FPressed = udbDown then
   Details := GetElementDetails(tsDownPressed)
  else
  if (FHighlighted = udbDown) and (FPressed = udbNone) then
   Details := GetElementDetails(tsDownHot)
  else
   Details := GetElementDetails(tsDownNormal);
  DrawElement(DC, Details, Rect(Range.Left, DownPos, Range.Right, Range.Bottom));
 end else
 {$ENDIF}
 begin
  if FPressed = udbUp
   then State := DFCS_SCROLLUP or DFCS_PUSHED
   else State := DFCS_SCROLLUP;
  if Assigned(FFocusControl) and not FFocusControl.Enabled then
   State := State or DFCS_INACTIVE;
  DrawFrameControl(DC, Rect(Range.Left, Range.Top, Range.Right, UpSize),
    DFC_SCROLL, State);
  if FPressed = udbDown
   then State := DFCS_SCROLLDOWN or DFCS_PUSHED
   else State := DFCS_SCROLLDOWN;
  if not IsEnabled then State := State or DFCS_INACTIVE;
  DrawFrameControl(DC, Rect(Range.Left, DownPos, Range.Right, Range.Bottom),
    DFC_SCROLL, State);
 end;
end;

procedure TCustomUpDownSE.DoDownClick;
begin
 if Assigned(FOnDownClick) then FOnDownClick(Self);
end;

procedure TCustomUpDownSE.DoUpClick;
begin
 if Assigned(FOnUpClick) then FOnUpClick(Self);
end;

// TCustomSpinEditSE /////////////////////////////////////////////////////////

constructor TCustomSpinEditSE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TUpDownSE.Create(Self);
  {$IFDEF XPTHEMES}
  if ThemeServices.ThemesEnabled then FButton.Width := 16 else
  {$ENDIF}
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  //Text := '0';
  SetValue(0.0);
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1;
  FEditorEnabled := True;
  {$IFDEF DELPHI7_UP}
  ParentBackground := False;
  {$ENDIF}
end;

destructor TCustomSpinEditSE.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TCustomSpinEditSE.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TCustomSpinEditSE.SetDigitsOnly(const Value: boolean);
var i: integer;
    s: string;
begin
 if Value = FDigitsOnly then exit;
 FDigitsOnly := Value;
 if FDigitsOnly then begin
  // Remove all non-digits chars from text
  s := Text;
  for i:=Length(s) downto 1 do
   if not (s[i] in ['0'..'9']) then Delete(s, i, 1);
 end;
end;

procedure TCustomSpinEditSE.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_UP then UpClick (Self)
  else if Key = VK_DOWN then DownClick (Self);
  inherited KeyDown(Key, Shift);
end;

procedure TCustomSpinEditSE.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

function TCustomSpinEditSE.IsValidChar(Key: Char): Boolean;
var Valid: set of char;
begin
 if FDigitsOnly
  then Valid := ['0'..'9']
  else Valid := [DecimalSeparator, '+', '-', '0'..'9'];
 Result := (Key in Valid) or ((Key < #32) and (Key <> Chr(VK_RETURN)));
 if not FEditorEnabled and Result and ((Key >= #32) or
   (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then Result := False;
 if Assigned(FOnIsCharValid) then FOnIsCharValid(Self, Key, Result);
end;

procedure TCustomSpinEditSE.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
{  Params.Style := Params.Style and not WS_BORDER;  }
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TCustomSpinEditSE.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TCustomSpinEditSE.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 2;
  Loc.Top := 0;  
  Loc.Left := 0;  
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));  {debug}
end;

procedure TCustomSpinEditSE.WMSize(var Message: TWMSize);
var MinHeight: Integer;
begin
 inherited;
 MinHeight := GetMinHeight;
 { text edit bug: if size to less than minheight, then edit ctrl does
   not display the text }
 if Height < MinHeight then
   Height := MinHeight
 else
 if FButton <> nil then begin
  if NewStyleControls and Ctl3D then begin
   {if ThemeServices.ThemesEnabled then
    FButton.SetBounds(Width - FButton.Width - 3, -1, FButton.Width, Height - 2)
   else }
    FButton.SetBounds(Width - FButton.Width - 4, 0, FButton.Width, Height - 4);
  end else
   FButton.SetBounds (Width - FButton.Width, 1, FButton.Width, Height - 3);
  SetEditRect;
 end;
end;

function TCustomSpinEditSE.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 1;//2;
end;

procedure TCustomSpinEditSE.UpClick(Sender: TObject);
var NewValue: extended;
begin
 if ReadOnly then
  MessageBeep(0)
 else begin
  NewValue := Value + FIncrement;
  DoUpClick(NewValue);
  Value := NewValue;
 end;
end;

procedure TCustomSpinEditSE.DownClick (Sender: TObject);
var NewValue: extended;
begin
 if ReadOnly then
  MessageBeep(0)
 else begin
  NewValue := Value - FIncrement;
  DoDownClick(NewValue);
  Value := NewValue;
 end;
end;

procedure TCustomSpinEditSE.DoDownClick(var NewValue: extended);
begin
 if Assigned(FOnUpClick) then FOnUpClick(Self, NewValue);
end;

procedure TCustomSpinEditSE.DoUpClick(var NewValue: extended);
begin
 if Assigned(FOnDownClick) then FOnDownClick(Self, NewValue);
end;

procedure TCustomSpinEditSE.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TCustomSpinEditSE.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TCustomSpinEditSE.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;

procedure TCustomSpinEditSE.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue (Value) <> Value then
    SetValue (Value);
end;

procedure TCustomSpinEditSE.CMEnabledChanged(var Message: TMessage);
begin
 inherited;
 FButton.Invalidate;
end;

function TCustomSpinEditSE.GetValue: extended;
var s: string;
begin
 // Result := StrToFloatDef(Text, FMinValue);
 s := Text;
 if not TextToFloat(PChar(s), Result, fvExtended) then
  Result := FMinValue;
end;

procedure TCustomSpinEditSE.SetValue(NewValue: extended);
begin
 Text := FloatToStrF(CheckValue(NewValue), ffFixed, 15, FDecimal);
end;

function TCustomSpinEditSE.CheckValue(NewValue: extended): extended;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) then
  begin
    if NewValue < FMinValue then
      Result := FMinValue
    else if NewValue > FMaxValue then
      Result := FMaxValue;
  end;
end;

function TCustomSpinEditSE.GetIntValue: integer;
begin
 Result := Trunc(Value);
end;

procedure TCustomSpinEditSE.SetIntValue(const Value: integer);
begin
 Self.Value := Value;
end;

procedure TCustomSpinEditSE.SetDecimal(const Value: integer);
begin
 if Value = FDecimal then exit;
 FDecimal := Value;
 Self.Value := Self.Value;
end;

end.
