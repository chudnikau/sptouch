{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit SpDesignPanel;

interface

uses
  SysUtils, ExtCtrls, Windows, Messages, Controls, Classes, Graphics, Dialogs,
  Contnrs, Forms;

const
  CN_INFORMPARENT = CN_BASE + 1;

type
  TDWin = class;

  TControlClick = procedure (Sender: TObject; Control: TControl) of object;

  TSpDesignPanel = class(TPanel)
  private
    FDrawing: Boolean;
    FPicture: TPicture;
    FDesignView: Boolean;
    FDxGrid: Word;
    FDWinList: TObjectList;
    FOnControlClick: TControlClick;
    FUseStep: Boolean;
    FDesigned: Boolean;
    FOnSave: TNotifyEvent;
    FOnCancel: TNotifyEvent;
    FStretch: Boolean;
    FTransparent: Boolean;
    FProportional: Boolean;
    FCenter: Boolean;
    procedure SetDesignView(const Value: Boolean);
    procedure SetDxGrid(const Value: Word);
    function GetActiveControl: TControl;
    procedure SetUseStep(const Value: Boolean);
    procedure SetPicture(const Value: TPicture);
    procedure SetStretch(const Value: Boolean);
    procedure PictureChanged(Sender: TObject);
    procedure SetTransparent(const Value: Boolean);
    procedure SetProportional(const Value: Boolean);
    procedure SetCenter(const Value: Boolean);
  protected
    function DestRect: TRect;
    procedure Paint; override;
    function DoPaletteChange: Boolean;
    //Уведомляет неактивное окно, что в нем был сделан щелчок мышью
    procedure CMMouseActivate(var Message: TCMMouseActivate); message CM_MOUSEACTIVATE;
    procedure CNInformParent(var Message: TMessage); message CN_INFORMPARENT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save; virtual;
    procedure Cancel; virtual;
    property Designed: Boolean read FDesigned;
    property ActiveControl: TControl read GetActiveControl;
  published
    property DesignView: Boolean read FDesignView write SetDesignView default False;
    property DxGrid: Word read FDxGrid write SetDxGrid default 8;
    property UseStep: Boolean read FUseStep write SetUseStep default True;
    property OnControlClick: TControlClick read FOnControlClick write FOnControlClick;
    property OnSave: TNotifyEvent read FOnSave write FOnSave;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
    property Picture: TPicture read FPicture write SetPicture;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property Proportional: Boolean read FProportional write SetProportional default false;
    property Center: Boolean read FCenter write SetCenter default False;
  end;

  TDWin = class(TCustomControl)
  private
    FDControl: TControl;
    FX0, FY0, FWidth, FHeight: Integer;
    FCursor: Integer;
    FStep: Integer;
    FOldWndProc: TWndMethod;
    FActive: Boolean;
    FUseStep: Boolean;
    procedure SetControl(const Value: TControl);
    procedure RebuildRegion;
    procedure Visible(const Value: Boolean);
    procedure SetActive(const Value: Boolean);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Paint; override;
    procedure DControlWndProc(var Message: TMessage);
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DControl: TControl read FDControl write SetControl;
    property Active: Boolean read FActive write SetActive;
  published
    property Step: Integer read FStep write FStep default 8;
    property UseStep: Boolean read FUseStep write FUseStep default True;
  end;

implementation

uses Types;

type
  TGradientDirection = (gdHorizontal, gdVertical);

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
const
  cGradientDirections: array[TGradientDirection] of Cardinal =
    (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  StartColor, EndColor: Cardinal;
  Vertexes: array[0..1] of TTriVertex;
  GradientRect: TGradientRect;
begin
  StartColor := ColorToRGB(AStartColor);
  EndColor := ColorToRGB(AEndColor);
  Vertexes[0].x := ARect.Left;
  Vertexes[0].y := ARect.Top;
  Vertexes[0].Red := GetRValue(StartColor) shl 8;
  Vertexes[0].Blue := GetBValue(StartColor) shl 8;
  Vertexes[0].Green := GetGValue(StartColor) shl 8;
  Vertexes[0].Alpha := 0;
  Vertexes[1].x := ARect.Right;
  Vertexes[1].y := ARect.Bottom;
  Vertexes[1].Red := GetRValue(EndColor) shl 8;
  Vertexes[1].Blue := GetBValue(EndColor) shl 8;
  Vertexes[1].Green := GetGValue(EndColor) shl 8;
  Vertexes[1].Alpha := 0;
  GradientRect.UpperLeft := 0;
  GradientRect.LowerRight := 1;
  GradientFill(ACanvas.Handle, @Vertexes[0], 2, @GradientRect, 1, cGradientDirections[Direction]);
end;

procedure TSpDesignPanel.CNInformParent(var Message: TMessage);
begin
  FDesigned := True;
end;

constructor TSpDesignPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
  FDesigned := False;
  BevelOuter := bvNone;
  FDxGrid := 8;
  FDWinList := TObjectList.Create;
  FUseStep := True;
end;

destructor TSpDesignPanel.Destroy;
begin
  FPicture.Free;
  FDWinList.Free;
  inherited Destroy;
end;

function TSpDesignPanel.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and
    (Tmp.PaletteModified) then
  begin
    if (Tmp.Palette = 0) then
      Tmp.PaletteModified := False
    else
    begin
      ParentForm := GetParentForm(Self);
      if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
      begin
        if FDrawing then
          ParentForm.Perform(wm_QueryNewPalette, 0, 0)
        else
          PostMessage(ParentForm.Handle, wm_QueryNewPalette, 0, 0);
        Result := True;
        Tmp.PaletteModified := False;
      end;
    end;
  end;
end;

function TSpDesignPanel.GetActiveControl: TControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FDWinList.Count - 1 do
  begin
    if TDWin(FDWinList[i]).Active then
    begin
      Result := TDWin(FDWinList[i]).DControl;
      Break;
    end;
  end;
end;

procedure TSpDesignPanel.Paint;
var
  Hdx, Hdy: Integer;
  Save: Boolean;
begin
  Save := FDrawing;
  FDrawing := True;
  try
    with inherited Canvas do
    begin
      StretchDraw(DestRect, Picture.Graphic);
      if FDesignView then
      begin
        Hdy := 0;
        while Hdy <= Height do begin
          Hdx := 0;
          while Hdx <= Width do begin
            Canvas.Pixels[Hdx, Hdy] := clBlack;
            Inc(Hdx, FDxGrid);
          end;
          Inc(Hdy, FDxGrid);
        end;
      end;
    end;
  finally
    FDrawing := Save;
  end;
end;

function TSpDesignPanel.DestRect: TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
begin
  w := Picture.Width;
  h := Picture.Height;
  cw := ClientWidth;
  ch := ClientHeight;
  if Stretch or (Proportional and ((w > cw) or (h > ch))) then
  begin
    if Proportional and (w > 0) and (h > 0) then
    begin
      xyaspect := w / h;
      if w > h then
      begin
        w := cw;
        h := Trunc(cw / xyaspect);
        if h > ch then  // woops, too big
        begin
          h := ch;
          w := Trunc(ch * xyaspect);
        end;
      end
      else
      begin
        h := ch;
        w := Trunc(ch * xyaspect);
        if w > cw then  // woops, too big
        begin
          w := cw;
          h := Trunc(cw / xyaspect);
        end;
      end;
    end
    else
    begin
      w := cw;
      h := ch;
    end;
  end;

  with Result do
  begin
    Left := 0;
    Top := 0;
    Right := w;
    Bottom := h;
  end;

  if Center then
    OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
end;

procedure TSpDesignPanel.PictureChanged(Sender: TObject);
var
  G: TGraphic;
  D : TRect;
begin
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
	SetBounds(Left, Top, Picture.Width, Picture.Height);
  G := Picture.Graphic;
  if G <> nil then
  begin
    if not ((G is TMetaFile) or (G is TIcon)) then
      G.Transparent := FTransparent;
    D := DestRect;
    if (not G.Transparent) and (D.Left <= 0) and (D.Top <= 0) and
       (D.Right >= Width) and (D.Bottom >= Height) then
      ControlStyle := ControlStyle + [csOpaque]
    else  // picture might not cover entire clientrect
      ControlStyle := ControlStyle - [csOpaque];
    if DoPaletteChange and FDrawing then Update;
  end
  else ControlStyle := ControlStyle - [csOpaque];
  if not FDrawing then Invalidate;
end;

procedure TSpDesignPanel.Save;
begin
  if Assigned(FOnSave) then FOnSave(Self);
  FDesigned := False;  
end;

procedure TSpDesignPanel.SetCenter(const Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure TSpDesignPanel.SetDesignView(const Value: Boolean);
var
  i, j, k: Integer;
  Flag: Boolean;
  DWin: TDWin;
  CaptureControl: TControl;
begin
  FDesignView := Value;
  if FDesignView and not (csDesigning in ComponentState) then
  begin
    i := 0;
    k := ControlCount - 1;
    while i < k do
    begin
      if not (Controls[i] is TDWin) then
      begin
        Flag := False;
        for j := 0 to FDWinList.Count - 1 do
        if TDWin(FDWinList[j]).FDControl = Controls[i] then
        begin
          Flag := True;
          Break;
        end;
        if not Flag then
        begin        
          CaptureControl := Controls[i];
          DWin := TDWin.Create(Self);
          DWin.Parent := Self;
          DWin.DControl := CaptureControl;
          DWin.Step := DxGrid;
          FDWinList.Add(DWin);
        end;
      end;
      Inc(i);
      k := ControlCount;
    end;
  end else FDWinList.Clear;
  Invalidate;
end;

procedure TSpDesignPanel.SetDxGrid(const Value: Word);
begin
  if Value = 0 then
    FDxGrid := 1
  else
    FDxGrid := Value;
  Invalidate;
end;

procedure TSpDesignPanel.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
  Repaint;
  FDesigned := True;
end;

procedure TSpDesignPanel.SetProportional(const Value: Boolean);
begin
  if FProportional <> Value then
  begin
    FProportional := Value;
    PictureChanged(Self);
  end;
end;

procedure TSpDesignPanel.SetStretch(const Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    PictureChanged(Self);
  end;
end;

procedure TSpDesignPanel.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    PictureChanged(Self);
  end;
end;

procedure TSpDesignPanel.SetUseStep(const Value: Boolean);
var
  i: Integer;
begin
  FUseStep := Value;
  for i := 0 to FDWinList.Count - 1 do
      TDWin(FDWinList[i]).UseStep := FUseStep;
end;

procedure TSpDesignPanel.Cancel;
begin
  if Assigned(FOnCancel) then FOnCancel(Self);
  FDesigned := False;  
end;

procedure TSpDesignPanel.CMMouseActivate(var Message: TCMMouseActivate);
var
  C: TControl;
  i: Integer;
begin
  inherited;
  if FDesignView and not (csDesigning in ComponentState) then
  begin
    for i := 0 to FDWinList.Count - 1 do
      if TObject(FDWinList[i]) is TDWin then TDWin(FDWinList[i]).Active := False;
    C := ControlAtPos(Message.MouseActivateRec.MousePos, True, True);
    if C is TDWin then
    begin
      if Assigned(FOnControlClick) then FOnControlClick(Self, TDWin(C).FDControl);
      TDWin(C).Active := True;
    end;
  end;
end;

{ =========================== TDWin =========================== }

procedure TDWin.Visible(const Value: Boolean);
begin
  if Value then
  begin
    RebuildRegion;
    Show;
    BringToFront;
  end else begin
    Hide;
    if Assigned(FDControl) then
      FDControl.BringToFront;
  end;
end;

procedure TDWin.CMMouseleave(var Message: TMessage);
begin
  inherited;
  FCursor := HTNOWHERE;
  Cursor := crArrow;
end;

constructor TDWin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStep := 8;
  FUseStep := True;
end;

procedure TDWin.DControlWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN: Perform(WM_LBUTTONDOWN, Message.WParam, Message.LParam);
//    WM_SETCURSOR: ; //перекрываю курсоры прикрепленного компоненты
    WM_MOUSEMOVE: begin
                    TWMMouse(Message).XPos := TWMMouse(Message).XPos + 5;
                    TWMMouse(Message).YPos := TWMMouse(Message).YPos + 5;
                    Perform(WM_MOUSEMOVE, Message.WParam, Message.LParam);
                  end;
    else
      FDControl.Dispatch(Message);
  end;
end;

destructor TDWin.Destroy;
begin
  if Assigned(FOldWndProc) and Assigned(FDControl) then
    FDControl.WindowProc := FOldWndProc;
  inherited Destroy;
end;

procedure TDWin.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then
  begin
    FX0 := X;
    FY0 := Y;
    FWidth := Width;
    FHeight := Height;
    Visible(False);
  end;
end;

procedure TDWin.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  DMIN = 20;
var
  S, OLD1, OLD2: Integer;

  procedure DoLeft;
  begin
    if FUseStep then
      S := X div FStep * FStep
    else
      S := X;  
    if Width - S > DMIN then
    begin
      //проверю можно ли контролу менять размеры, пози и позицию
      OLD1 := FDControl.Left;
      OLD2 := FDControl.Width;
      FDControl.Left := Left + S + 5;
      FDControl.Width := Width - S - 10;
      if OLD1 <> FDControl.Left then Left := Left + S;
      if OLD2 <> FDControl.Width then Width := Width - S;
    end;
  end;

  procedure DoTop;
  begin
    if FUseStep then
      S := Y div FStep * FStep
    else
      S := Y;
    if Height - S > DMIN then
    begin
      //проверю можно ли контролу менять размеры, пози и позицию
      OLD1 := FDControl.Top;
      OLD2 := FDControl.Height;
      FDControl.Top := Top + S + 5;
      FDControl.Height := Height - S - 10;
      if OLD1 <> FDControl.Top then Top := Top + S;
      if OLD2 <> FDControl.Height then Height := Height - S;
    end;  
  end;

  procedure DoRight;
  begin
    if FUseStep then
      S := (X - FX0) div FStep * FStep
    else
      S := X - FX0;
    if FWidth + S > DMIN then
    begin
      //проверю можно ли контролу менять размеры, пози и позицию
      OLD1 := FDControl.Width;
      FDControl.Width := FWidth + S - 10;
      if OLD1 <> FDControl.Width then Width := FWidth + S;
    end;  
  end;

  procedure DoBottom;
  begin
    if FUseStep then
      S := (Y - FY0) div FStep * FStep
    else
      S := Y - FY0;
    if FHeight + S > DMIN then
    begin      
      //проверю можно ли контролу менять размеры, пози и позицию
      OLD1 := FDControl.Height;
      FDControl.Height := FHeight + S - 10;
      if OLD1 <> FDControl.Height then Height := FHeight + S;      
    end;  
  end;

  procedure DoMove;
  begin
    if FUseStep then
    begin
      Left := Left + (X - FX0) div FStep * FStep;
      Top := Top + (Y - FY0) div FStep * FStep;
    end else begin
      Left := Left + (X - FX0);
      Top := Top + (Y - FY0);
    end;
    FDControl.Left := Left + 5;
    FDControl.Top := Top + 5;
  end;

begin
  if Assigned(FDControl) and FActive then
  begin
    if ssLeft in Shift then
    begin
      case FCursor of
        HTLEFT        : DoLeft;
        HTTOP         : DoTop;
        HTRIGHT       : DoRight;
        HTBOTTOM      : DoBottom;
        HTTOPLEFT     : begin
                          DoTop;
                          DoLeft;
                        end;
        HTTOPRIGHT    : begin
                          DoTop;
                          DoRight;
                        end;
        HTBOTTOMLEFT  : begin
                          DoBottom;
                          DoLeft;
                        end;
        HTBOTTOMRIGHT : begin
                          DoBottom;
                          DoRight;
                        end;
        else DoMove;
      end;
      Parent.Perform(CN_INFORMPARENT, 0, 0);
    end else begin
      FCursor := HTNOWHERE;
      Cursor := crArrow;
      if PtInRect(Rect(0, 0, 10, 10), Point(X, Y)) then
      begin
        Cursor := crSizeNWSE;
        FCursor := HTTOPLEFT;
      end else
      if PtInRect(Rect((Width - 10) div 2, 0, (Width + 10) div 2, 10), Point(X, Y)) then
      begin
        Cursor := crSizeNS;
        FCursor := HTTOP;
      end else
      if PtInRect(Rect(Width - 10, 0, Width, 10), Point(X, Y)) then
      begin
        Cursor := crSizeNESW;
        FCursor := HTTOPRIGHT;
      end else
      if PtInRect(Rect(Width - 10, (Height - 10) div 2, Width, (Height + 10) div 2), Point(X, Y)) then
      begin
        Cursor := crSizeWE;
        FCursor := HTRIGHT;
      end else
      if PtInRect(Rect(Width - 10, Height - 10, Width, Height), Point(X, Y)) then
      begin
        Cursor := crSizeNWSE;
        FCursor := HTBOTTOMRIGHT;
      end else
      if PtInRect(Rect((Width - 10) div 2, Height - 10, (Width + 10) div 2, Height), Point(X, Y)) then
      begin
        Cursor := crSizeNS;
        FCursor := HTBOTTOM;
      end else
      if PtInRect(Rect(0, Height - 10, 10, Height), Point(X, Y)) then
      begin
        Cursor := crSizeNESW;
        FCursor := HTBOTTOMLEFT;
      end else
      if PtInRect(Rect(0, (Height - 10) div 2, 10, (Height + 10) div 2), Point(X, Y)) then
      begin
        Cursor := crSizeWE;
        FCursor := HTLEFT;
      end;
    end;
  end else Windows.SetCursor(Screen.Cursors[Cursor]);
end;

procedure TDWin.RebuildRegion;
var
  Region, Region2: HRGN;
begin
  Region := CreateRectRgn(0, 0, Width, Height);
  CombineRgn(Region, Region, Region, RGN_DIFF);
  if FActive then
  begin
    Region2 := CreateRectRgn(Width - 5, 0, Width, Height);
    CombineRgn(Region, Region, Region2, RGN_DIFF);
    Region2 := CreateRectRgn(0, Height - 5, Width, Height);
    CombineRgn(Region, Region, Region2, RGN_DIFF);
    Region2 := CreateRectRgn(0, 0, 5, Height);
    CombineRgn(Region, Region, Region2, RGN_DIFF);
    Region2 := CreateEllipticRgn(0, 0, 10, 10);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn((Width - 10) div 2, 0, (Width + 10) div 2, 10);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn(Width - 10, 0, Width, 10);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn(Width - 10, (Height - 10) div 2, Width, (Height + 10) div 2);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn(Width - 10, Height - 10, Width, Height);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn((Width - 10) div 2, Height - 10, (Width + 10) div 2, Height);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn(0, Height - 10, 10, Height);
    CombineRgn(Region, Region, Region2, RGN_OR);
    Region2 := CreateEllipticRgn(0, (Height - 10) div 2, 10, (Height + 10) div 2);
    CombineRgn(Region, Region, Region2, RGN_OR);
  end;
  SetWindowRgn(Handle, Region, True);
end;

procedure TDWin.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Visible(True);
  FCursor := HTNOWHERE;
  Cursor := crArrow;
end;

procedure TDWin.SetActive(const Value: Boolean);
begin
  FActive := Value;
  RebuildRegion;
end;

procedure TDWin.SetControl(const Value: TControl);
begin
  if Assigned(FOldWndProc) and Assigned(FDControl) then
  begin
    FDControl.WindowProc := FOldWndProc;
    Visible(False);
  end;
  FDControl := Value;
  FActive := False;
  if Assigned(FDControl) then
  begin
    Left := FDControl.Left - 5;
    Top := FDControl.Top - 5;
    Width := FDControl.Width + 5 + 5;
    Height := FDControl.Height + 5 + 5;
    FOldWndProc := FDControl.WindowProc;
    FDControl.WindowProc := DControlWndProc;
    Visible(True);
  end;
end;

procedure TDWin.Paint;
begin
  GradientFillCanvas(Canvas, $00FF1717, $00FF8000, ClientRect, gdVertical);
end;

end.
