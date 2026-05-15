unit ColorBoxSE;

interface

{$IFNDEF VER80}                { DELPHI 1.0     }
 {$IFNDEF VER90}               { DELPHI 2.0     }
  {$IFNDEF VER93}              { C++Builder 1.0 }
   {$IFNDEF VER100}            { DELPHI 3.0     }
    {$IFNDEF VER110}           { C++Builder 3.0 }
     {$IFNDEF VER120}          { DELPHI 4.0 }
      {$IFNDEF VER125}         { C++Builder 4.0 }
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
  Windows, Classes, Controls, StdCtrls, Graphics, Dialogs, SysUtils, Messages;

const
  NoColorSelected = TColor($FF000000);

  {$IFNDEF DELPHI6_UP}
  StandardColorsCount = 16;

  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
  clMedGray = TColor($A4A0A0);
  ExtendedColorsCount = 4;
  {$ENDIF}

type
  TFlexColorBoxStyles = (
    fcbStandardColors, // first sixteen RGBI colors
    fcbExtendedColors, // four additional reserved colors
    fcbSystemColors,   // system managed/defined colors
    fcbNoneColor,      // include clNone color, must be used with cbSystemColors
    fcbDefaultColor,   // include clDefault color, must be used with cbSystemColors
    fcbCustomColor,    // last color is customizable
    fcbPrettyNames     // instead of 'clColorNames' you get 'Color Names'
  );

  TFlexColorBoxStyle = set of TFlexColorBoxStyles;

const
  DefaultFlexColorBoxStyle = [
    fcbStandardColors, fcbExtendedColors, fcbNoneColor, fcbCustomColor,
    fcbPrettyNames ];

type
  TCustomColorBoxSE = class(TCustomComboBox)
  private
    FStyle: TFlexColorBoxStyle;
    FNeedToPopulate: Boolean;
    FListSelected: Boolean;
    FDefaultColor: TColor;
    FSelectedColor: TColor;
    FColorNames: array[TFlexColorBoxStyles] of string;
    function GetColor(Index: Integer): TColor;
    function GetColorName(Index: Integer): string;
    function GetColorValue: TColor;
    procedure SetColorValue(const AColor: TColor);
    procedure ColorCallBack(const AName: string);
    function ColorToName(const AColor: TColor): string;
    procedure SetDefaultColor(const Value: TColor);
    function GetColorType(Index: Integer): TFlexColorBoxStyles;
    function GetCustomColor: TColor;
    procedure SetCustomColor(const Value: TColor);
    procedure SetUserColorName(const Index: TFlexColorBoxStyles;
      const Value: string);
    function StoredUserColorName(const Index: TFlexColorBoxStyles): Boolean;
    function GetUserColorName(const Index: TFlexColorBoxStyles): string;
    {$IFNDEF DELPHI6_UP}
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    {$ENDIF}
  protected
    procedure CreateWnd; override;
    procedure CloseUp; {$IFDEF DELPHI6_UP} override; {$ELSE} virtual; {$ENDIF}
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    function PickCustomColor: Boolean; virtual;
    procedure PopulateList;
    procedure Select; {$IFDEF DELPHI6_UP} override; {$ELSE} virtual; {$ENDIF}
    procedure SetStyle(AStyle: TFlexColorBoxStyle); reintroduce;
  public
    constructor Create(AOwner: TComponent); override;
    property ColorType[Index: Integer]: TFlexColorBoxStyles read GetColorType;
    property Style: TFlexColorBoxStyle read FStyle write SetStyle
      default DefaultFlexColorBoxStyle;
    property Colors[Index: Integer]: TColor read GetColor;
    property ColorNames[Index: Integer]: string read GetColorName;
    property ColorValue: TColor read GetColorValue write SetColorValue default clBlack;
    property DefaultColor: TColor read FDefaultColor
      write SetDefaultColor default clBlack;
    property CustomColor: TColor read GetCustomColor write SetCustomColor;
    property CustomColorName: string index fcbCustomColor read GetUserColorName
      write SetUserColorName stored StoredUserColorName;
    property NoneColorName: string index fcbNoneColor read GetUserColorName
      write SetUserColorName stored StoredUserColorName;
    property DefaultColorName: string index fcbDefaultColor read GetUserColorName
      write SetUserColorName stored StoredUserColorName;
  end;

  TColorBoxSE = class(TCustomColorBoxSE)
  published
    {$IFDEF DELPHI6_UP}
    property AutoComplete;
    property AutoDropDown;
    {$ENDIF}
    property ColorValue;
    property DefaultColor;
    property CustomColor;
    property CustomColorName;
    property NoneColorName;
    property DefaultColorName;
    property Style;

    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
    {$IFDEF DELPHI6_UP}
    property OnCloseUp;
    property OnContextPopup;
    property OnSelect;
    {$ENDIF}
  end;

var
  CustomColors: TStringList;

implementation

resourcestring
  SFlexColorBoxCustomCaption = 'Other...';

  clNameBlack = 'Black';
  clNameMaroon = 'Maroon';
  clNameGreen = 'Green';
  clNameOlive = 'Olive';
  clNameNavy = 'Navy';
  clNamePurple = 'Purple';
  clNameTeal = 'Teal';
  clNameGray = 'Gray';
  clNameSilver = 'Silver';
  clNameRed = 'Red';
  clNameLime = 'Lime';
  clNameYellow = 'Yellow';
  clNameBlue = 'Blue';
  clNameFuchsia = 'Fuchsia';
  clNameAqua = 'Aqua';
  clNameWhite = 'White';
  clNameMoneyGreen = 'Money Green';
  clNameSkyBlue = 'Sky Blue';
  clNameCream = 'Cream';
  clNameMedGray = 'Medium Gray';
  clNameActiveBorder = 'Active Border';
  clNameActiveCaption = 'Active Caption';
  clNameAppWorkSpace = 'Application Workspace';
  clNameBackground = 'Background';
  clNameBtnFace = 'Button Face';
  clNameBtnHighlight = 'Button Highlight';
  clNameBtnShadow = 'Button Shadow';
  clNameBtnText = 'Button Text';
  clNameCaptionText = 'Caption Text';
  clNameDefault = 'Default';
  clNameGradientActiveCaption = 'Gradient Active Caption';
  clNameGradientInactiveCaption = 'Gradient Inactive Caption';
  clNameGrayText = 'Gray Text';
  clNameHighlight = 'Highlight Background';
  clNameHighlightText = 'Highlight Text';
  clNameInactiveBorder = 'Inactive Border';
  clNameInactiveCaption = 'Inactive Caption';
  clNameInactiveCaptionText = 'Inactive Caption Text';
  clNameInfoBk = 'Info Background';
  clNameInfoText = 'Info Text';
  clNameMenu = 'Menu Background';
  clNameMenuText = 'Menu Text';
  clNameNone = 'None';
  clNameScrollBar = 'Scroll Bar';
  clName3DDkShadow = '3D Dark Shadow';
  clName3DLight = '3D Light';
  clNameWindow = 'Window Background';
  clNameWindowFrame = 'Window Frame';
  clNameWindowText = 'Window Text';


const
  ColorToPretyName: array[0..46] of TIdentMapEntry = (
    (Value: clBlack; Name: clNameBlack),
    (Value: clMaroon; Name: clNameMaroon),
    (Value: clGreen; Name: clNameGreen),
    (Value: clOlive; Name: clNameOlive),
    (Value: clNavy; Name: clNameNavy),
    (Value: clPurple; Name: clNamePurple),
    (Value: clTeal; Name: clNameTeal),
    (Value: clGray; Name: clNameGray),
    (Value: clSilver; Name: clNameSilver),
    (Value: clRed; Name: clNameRed),
    (Value: clLime; Name: clNameLime),
    (Value: clYellow; Name: clNameYellow),
    (Value: clBlue; Name: clNameBlue),
    (Value: clFuchsia; Name: clNameFuchsia),
    (Value: clAqua; Name: clNameAqua),
    (Value: clWhite; Name: clNameWhite),
    (Value: clMoneyGreen; Name: clNameMoneyGreen),
    (Value: clSkyBlue; Name: clNameSkyBlue),
    (Value: clCream; Name: clNameCream),
    (Value: clMedGray; Name: clNameMedGray),

    (Value: clActiveBorder; Name: clNameActiveBorder),
    (Value: clActiveCaption; Name: clNameActiveCaption),
    (Value: clAppWorkSpace; Name: clNameAppWorkSpace),
    (Value: clBackground; Name: clNameBackground),
    (Value: clBtnFace; Name: clNameBtnFace),
    (Value: clBtnHighlight; Name: clNameBtnHighlight),
    (Value: clBtnShadow; Name: clNameBtnShadow),
    (Value: clBtnText; Name: clNameBtnText),
    (Value: clCaptionText; Name: clNameCaptionText),
    (Value: clDefault; Name: clNameDefault),
    (Value: clGrayText; Name: clNameGrayText),
    (Value: clHighlight; Name: clNameHighlight),
    (Value: clHighlightText; Name: clNameHighlightText),
    (Value: clInactiveBorder; Name: clNameInactiveBorder),
    (Value: clInactiveCaption; Name: clNameInactiveCaption),
    (Value: clInactiveCaptionText; Name: clNameInactiveCaptionText),
    (Value: clInfoBk; Name: clNameInfoBk),
    (Value: clInfoText; Name: clNameInfoText),
    (Value: clMenu; Name: clNameMenu),
    (Value: clMenuText; Name: clNameMenuText),
    (Value: clNone; Name: clNameNone),
    (Value: clScrollBar; Name: clNameScrollBar),
    (Value: cl3DDkShadow; Name: clName3DDkShadow),
    (Value: cl3DLight; Name: clName3DLight),
    (Value: clWindow; Name: clNameWindow),
    (Value: clWindowFrame; Name: clNameWindowFrame),
    (Value: clWindowText; Name: clNameWindowText) );

// TCustomColorBox ////////////////////////////////////////////////////////////

constructor TCustomColorBoxSE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := csOwnerDrawFixed;
  FStyle := DefaultFlexColorBoxStyle; 
  FSelectedColor := clBlack;
  FDefaultColor := clBlack;
  PopulateList;
end;

procedure TCustomColorBoxSE.CreateWnd;
begin
  inherited CreateWnd;
  if FNeedToPopulate then
    PopulateList;
end;

procedure TCustomColorBoxSE.Loaded;
begin
  inherited;
  ColorValue := FSelectedColor;
end;

{$IFNDEF DELPHI6_UP}
procedure TCustomColorBoxSE.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    CBN_CLOSEUP:
      CloseUp;
    CBN_SELCHANGE:
      begin
        Text := Items[ItemIndex];
        Click;
        Select;
      end;
    else
      inherited;
  end;
end;
{$ENDIF}

procedure TCustomColorBoxSE.CloseUp;
begin
  {$IFDEF DELPHI6_UP}
  inherited CloseUp;
  {$ENDIF}
  FListSelected := True;
end;

procedure TCustomColorBoxSE.ColorCallBack(const AName: String);
var
  I, LStart: Integer;
  LColor: TColor;
  LName: string;
begin
  LColor := StringToColor(AName);
  if (LColor = clNone) or (LColor = clDefault) then exit;
  if fcbPrettyNames in Style then
  begin
    if not IntToIdent(LColor, LName, ColorToPretyName) then
    begin
      if Copy(AName, 1, 2) = 'cl' then
        LStart := 3
      else
        LStart := 1;
      LName := '';
      for I := LStart to Length(AName) do
      begin
        case AName[I] of
          'A'..'Z':
            if LName <> '' then
              LName := LName + ' ';
        end;
        LName := LName + AName[I];
      end;
    end;
  end
  else
    LName := AName;
  Items.AddObject(LName, TObject(LColor));
end;

function TCustomColorBoxSE.ColorToName(const AColor: TColor): string;
var
  AName: string;
  I, LStart: Integer;
begin
  AName := ColorToString(AColor);
  if fcbPrettyNames in Style then
  begin
    if not IntToIdent(AColor, Result, ColorToPretyName) then
    begin
      if Copy(AName, 1, 2) = 'cl' then
        LStart := 3
      else
        LStart := 1;
      Result := '';
      for I := LStart to Length(AName) do
      begin
        case AName[I] of
          'A'..'Z':
            if Result <> '' then
              Result := Result + ' ';
        end;
        Result := Result + AName[I];
      end;
    end;
  end
  else
    Result := AName;
end;

procedure TCustomColorBoxSE.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);

  function ColorToBorderColor(AColor: TColor): TColor;
  type
    TColorQuad = record
      Red,
      Green,
      Blue,
      Alpha: Byte;
    end;
  begin
    if (TColorQuad(AColor).Red > 192) or
       (TColorQuad(AColor).Green > 192) or
       (TColorQuad(AColor).Blue > 192) then
      Result := clBlack
    else if odSelected in State then
      Result := clWhite
    else
      Result := AColor;
  end;

var
  LRect: TRect;
  LBackground: TColor;
  IsCustom: Boolean;
begin
  IsCustom := ColorType[Index] = fcbCustomColor;
  with Canvas do
  begin
    FillRect(Rect);
    LBackground := Brush.Color;
    LRect := Rect;
    LRect.Right := LRect.Bottom - LRect.Top + LRect.Left;
    InflateRect(LRect, -1, -1);
    if (Colors[Index] = clNone) and not IsCustom then with LRect do
    begin
     Brush.Style := bsSolid;
     Brush.Color := clWhite;
     Rectangle(Left, Top, Right, Bottom);
     Pen.Color := clBlack;
     Pen.Style := psSolid;
     MoveTo(Left, Top);
     LineTo(Right-1, Bottom-1);
     MoveTo(Right-1, Top);
     LineTo(Left, Bottom-1);
    end
    else
    begin
      if Colors[Index] = clNone
       then Brush.Color := clWhite
       else Brush.Color := Colors[Index];
      if Brush.Color = clDefault then
        Brush.Color := DefaultColor;
      FillRect(LRect);
      Brush.Color := ColorToBorderColor(ColorToRGB(Brush.Color));
      FrameRect(LRect);
    end;

    Brush.Color := LBackground;
    Rect.Left := LRect.Right + 5;

    TextRect(Rect, Rect.Left,
      Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(Items[Index])) div 2,
      Items[Index]);
  end;
end;

function TCustomColorBoxSE.GetColor(Index: Integer): TColor;
begin
  Result := TColor(Items.Objects[Index]);
end;

function TCustomColorBoxSE.GetColorName(Index: Integer): string;
begin
  Result := Items[Index];
end;

function TCustomColorBoxSE.GetColorType(Index: Integer): TFlexColorBoxStyles;
begin
 if (fcbCustomColor in FStyle) and (Index = Items.Count-1) then begin
  Result := fcbCustomColor;
  exit;
 end;
 if fcbNoneColor in FStyle then begin
  if Index = 0 then begin
   Result := fcbNoneColor;
   exit;
  end else
   dec(Index);
 end;
 if fcbDefaultColor in FStyle then begin
  if Index = 0 then begin
   Result := fcbDefaultColor;
   exit;
  end else
   dec(Index);
 end;
 if fcbStandardColors in FStyle then begin
  if Index < StandardColorsCount then begin
   Result := fcbStandardColors;
   exit;
  end else
   dec(Index, StandardColorsCount);
 end;
 if fcbExtendedColors in FStyle then begin
  if Index < ExtendedColorsCount then begin
   Result := fcbExtendedColors;
   exit;
  end{ else
   dec(Index, ExtendedColorsCount);}
 end;
 if fcbSystemColors in FStyle then
  Result := fcbSystemColors
 else
  // Unknown
  Result := fcbCustomColor;
end;

function TCustomColorBoxSE.GetCustomColor: TColor;
begin
 if (fcbCustomColor in FStyle) and (Items.Count > 0)
  then Result := TColor(Items.Objects[Items.Count-1])
  else Result := clBlack;
end;

function TCustomColorBoxSE.GetColorValue: TColor;
begin
  if HandleAllocated then
    if ItemIndex <> -1 then
      Result := Colors[ItemIndex]
    else
      Result := NoColorSelected
  else
    Result := FSelectedColor;
end;

procedure TCustomColorBoxSE.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FListSelected := False;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomColorBoxSE.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (fcbCustomColor in Style) and (Key = #13) and (ItemIndex = 0) then
  begin
    { If the user picked a custom color, force a select event to happen
      so the user can handle it }
    if PickCustomColor then Select;
    Key := #0;
  end;
end;

function TCustomColorBoxSE.PickCustomColor: Boolean;
var
  LColor: TColor;
begin
  with TColorDialog.Create(nil) do
    try
      Options := Options + [ cdFullOpen ];
      LColor := ColorToRGB(CustomColor{TColor(Items.Objects[0])});
      Color := LColor;
      //CustomColors.Text := Format('ColorA=%.8x', [LColor]);
      CustomColors.Assign(CustomColors);
      Result := Execute;
      if Result then
      begin
        //Items.Objects[0] := TObject(Color);
        CustomColors.Assign(CustomColors);
        CustomColor := Color;
        Self.Invalidate;
      end;
    finally
      Free;
    end;
end;

procedure TCustomColorBoxSE.PopulateList;
  procedure DeleteRange(const AMin, AMax: Integer);
  var
    I: Integer;
  begin
    for I := AMax downto AMin do
      Items.Delete(I);
  end;
  procedure DeleteColor(const AColor: TColor);
  var
    I: Integer;
  begin
    I := Items.IndexOfObject(TObject(AColor));
    if I <> -1 then
      Items.Delete(I);
  end;
var
  LSelectedColor, LCustomColor: TColor;
  ColorName: string;
begin
  if HandleAllocated then
  begin
    Items.BeginUpdate;
    try
      LCustomColor := clBlack;
      if (fcbCustomColor in Style) and (Items.Count > 0) then
        LCustomColor := CustomColor; //TColor(Items.Objects[0]);
      LSelectedColor := FSelectedColor;
      Items.Clear;
      GetColorValues(ColorCallBack);
      if fcbDefaultColor in Style then begin
        if FColorNames[fcbDefaultColor] <> ''
         then ColorName := FColorNames[fcbDefaultColor]
         else ColorName := ColorToName(clDefault);
        Items.InsertObject(0, ColorName, TObject(clDefault));
      end;
      if fcbNoneColor in Style then begin
        if FColorNames[fcbNoneColor] <> ''
         then ColorName := FColorNames[fcbNoneColor]
         else ColorName := ColorToName(clNone);
        Items.InsertObject(0, ColorName, TObject(clNone));
      end;
      if not (fcbSystemColors in Style) then
        DeleteRange(StandardColorsCount + ExtendedColorsCount, Items.Count - 1);
      if not (fcbExtendedColors in Style) then
        DeleteRange(StandardColorsCount, StandardColorsCount + ExtendedColorsCount - 1);
      if not (fcbStandardColors in Style) then
        DeleteRange(0, StandardColorsCount - 1);
      if fcbCustomColor in Style then begin
        if FColorNames[fcbCustomColor] <> ''
         then ColorName := FColorNames[fcbCustomColor]
         else ColorName := SFlexColorBoxCustomCaption;
        Items.AddObject(ColorName, TObject(LCustomColor));
      end;
      ColorValue := LSelectedColor;
    finally
      Items.EndUpdate;
      FNeedToPopulate := False;
    end;
  end
  else
    FNeedToPopulate := True;
end;

procedure TCustomColorBoxSE.Select;
begin
  if FListSelected then
  begin
    FListSelected := False;
    if (fcbCustomColor in Style) and
       (ColorType[ItemIndex] = fcbCustomColor) then begin
      ColorValue := FSelectedColor; 
      if PickCustomColor then
        ColorValue := CustomColor
      else
        exit;
    end else
      CustomColor := ColorValue;
  end;
  FSelectedColor := ColorValue;
  {$IFDEF DELPHI6_UP}
  inherited Select;
  {$ELSE}
  Change;  
  {$ENDIF}
end;

procedure TCustomColorBoxSE.SetCustomColor(const Value: TColor);
begin
 if (fcbCustomColor in FStyle) and (Items.Count > 0) then begin
  Items.Objects[Items.Count-1] := TObject(Value);
  Invalidate;
 end;
end;

procedure TCustomColorBoxSE.SetDefaultColor(const Value: TColor);
begin
  if Value <> FDefaultColor then
  begin
    FDefaultColor := Value;
    Invalidate;
  end;
end;

procedure TCustomColorBoxSE.SetColorValue(const AColor: TColor);
var
  I, Index: Integer;
begin
  if HandleAllocated then
  begin
    I := Items.IndexOfObject(TObject(AColor));
    if (I = -1) and (fcbCustomColor in Style) and (AColor <> NoColorSelected) then
    begin
      CustomColor{Items.Objects[0]} := AColor;
      I := 0;
    end
    else if (fcbCustomColor in Style) and (ColorType[I] = fcbCustomColor) then
    begin
      { Look for the color anywhere else but the first color before
        defaulting to selecting the "custom color". }
      for Index := 1 to Items.Count - 1 do
      begin
        if Items.Objects[Index] = TObject(AColor) then
        begin
          I := Index;
          Break;
        end;
      end;
    end;
    ItemIndex := I;
    if I <> Items.Count-1 then
      CustomColor := ColorValue;
  end;
  FSelectedColor := AColor;
end;

procedure TCustomColorBoxSE.SetStyle(AStyle: TFlexColorBoxStyle);
begin
  if AStyle <> Style then
  begin
    FStyle := AStyle;
    Enabled := (
      [fcbStandardColors, fcbExtendedColors,
       fcbSystemColors, fcbCustomColor] * FStyle ) <> [];
    PopulateList;
    if (Items.Count > 0) and (ItemIndex = -1) then
      ItemIndex := 0;
  end;
end;

function TCustomColorBoxSE.GetUserColorName(
  const Index: TFlexColorBoxStyles): string;
begin
 Result := FColorNames[Index];
end;

procedure TCustomColorBoxSE.SetUserColorName(const Index: TFlexColorBoxStyles;
  const Value: string);
begin
 if Value = FColorNames[Index] then exit;
 FColorNames[Index] := Value;
 PopulateList;
end;

function TCustomColorBoxSE.StoredUserColorName(
  const Index: TFlexColorBoxStyles): Boolean;
begin
 Result := FColorNames[Index] <> '';
end;

initialization
  CustomColors := TStringList.Create;

finalization
  CustomColors.Free;
  CustomColors := Nil;

end.
