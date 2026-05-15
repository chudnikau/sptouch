/////////////////////////////////////////////////////////
//                                                     //
//  This unit written by our customer Delphidoc        //
//  Thanks!                                            //
//                                                     //
/////////////////////////////////////////////////////////
unit SVGExport;

interface

uses
  Windows,Classes,SysUtils,Graphics,StdCtrls,
  FlexBase,FlexControls,FlexProps,FlexUtils;

procedure ExportFxdToSVG(Flex: TFlexPanel; const FileName:string);

implementation

Function TeeStr(Num:Integer):String;
begin
  Str(Num,Result);
end;

Function FormatCoord(Coord:Integer):String;
var Module: integer;
begin
  Str(Coord div PixelScaleFactor,Result);
  Module := Coord mod PixelScaleFactor;
  if Module <> 0 then Result := Result + '.' + IntToStr(Module);
end;

Function SVGColor(AColor:TColor;Braces:boolean=true):String;
begin
  AColor:=ColorToRGB(AColor);
  case AColor of
    clBlack: result:='black';
    clWhite: result:='white';
    clRed: result:='red';
    clGreen: result:='green';
    clBlue: result:='blue';
    clYellow: result:='yellow';
    clGray: result:='gray';
    clNavy: result:='navy';
    clOlive: result:='olive';
    clLime: result:='lime';
    clTeal:  result:='teal';
    clSilver:  result:='silver';
    clPurple:  result:='purple';
    clFuchsia:  result:='fuchsia';
    clMaroon:  result:='maroon';
  else
     result:='rgb('+TeeStr(GetRValue(AColor))+','+
                     TeeStr(GetGValue(AColor))+','+
                     TeeStr(GetBValue(AColor))+')';
  end;
  if Braces then result := '"' + result + '"';
end;

Function PointToStr(X,Y:Integer):String;
begin
  //result:=IntToStr(X)+','+IntToStr(Y);
  result:=FormatCoord(X)+','+FormatCoord(Y);
end;

Function SVGPoints(const Left,Top: integer;
  const Points: Array of TPoint):String;
var t : Integer;
begin
  result:=' points="';
  for t:=Low(Points) to High(Points) do
      result:=result+PointToStr((Left + Points[t].X){ div 1000},(Top + Points[t].Y){ div 1000})+' ';
  result:=result+'"';
end;

Function SVGPen(Pen: TPenProp; Braces: boolean = true):String;
var bc: string;

  Function PenStyle:String;
  begin
    case Pen.Style of
      psDash: result:='4, 2';
      psDot: result:='2, 2';
      psDashDot: result:='4, 2, 2, 2';
      psDashDotDot: result:='4, 2, 2, 2, 2, 2';
    else
      result:='';
    end;
  end;

begin
  if Braces then bc := '"' else bc := '';
  if Pen.Style=psClear then
     result:=' stroke=' + bc + 'none' + bc
  else
  begin
    result:=' stroke=' + SVGColor(Pen.Color, Braces);

    if Pen.Width>1 then
       result:=result+' stroke-width='+ bc + FormatCoord(Pen.Width) + bc;
       //TeeStr(Pen.Width div 1000)+bc;

    if Pen.Style<>psSolid then
       result:=result+' stroke-dasharray='+bc+PenStyle+bc+' ';  //  fill="none" breaks brush ??
  end;
end;

Function SVGBrushPen(Brush:TBrushProp;Pen:TPenProp=nil;
  Brushes:TStrings=nil):String;
var Control: TFlexControl;
    Index: integer;
begin
  if Assigned(Brushes) then begin
    // Try to find brush style in list
    Control := Brush.Owner.Owner as TFlexControl;
    Index := Brushes.IndexOfObject(pointer(Control.IdProp.Value));
    if Index >= 0 then begin
      Result := 'fill:url(#' + Brushes[Index] +')';
       if Result <> '' then Result := Format(' style="%s"', [Result]);
    end;
  end else
    Index := -1;
  if Index < 0 then begin
    if Brush.Style<>bsClear then
    begin
      result:=' fill='+SVGColor(Brush.Color);
      if Brush.Color = clNone then
        result:=result+' fill-opacity="0"';
    end
    else
      result:=' fill="none"';
  end;
  
  if Pen <> nil then result:=result+SVGPen(Pen);
end;

function SVGFont(Font:TFontProp): string;

  function GetFontName(const aName: string):string;
  begin
    if aName = '宋体' then
      result := 'SimSun'
    else if aName = '黑体' then
      result := 'SimHei'
    else if aName = '仿宋_GB2312' then
      result := 'FangSong_GB2312'
    else if aName = '楷体_GB2312' then
      result := 'KaiTi_GB2312'
    else if aName = '幼圆' then
      result := 'YouYuan'
    else if aName = '华文宋体' then
      result := 'STSong'
    else if aName = '华文中宋' then
      result := 'STZhongsong'
    else if aName = '华文楷体' then
      result := 'STKaiti'
    else if aName = '华文仿宋'  then
      result := 'STFangsong'
    else if aName = '华文细黑' then
      result := 'STXihei'
    else if aName = '华文隶书' then
      result := 'STLiti'
    else if aName = '华文行楷' then
      result := 'STXingkai'
    else if aName = '华文新魏' then
      result := 'STXinwei'
    else if aName = '华文琥珀' then
      result := 'STHupo'
    else if aName = '华文彩云' then
      result := 'STCaiyun'
    else if aName = '方正姚体简体' then
      result := 'FZYaoTi'
    else if aName = '方正舒体简体' then
      result := 'FZShuTi'
    else if aName = '新宋体' then
      result := 'NSimSun'
    else if aName = '隶书' then
      result := 'LiSu'
    else
      result := aName;
  end;
begin
  result := ' font-family="' + GetFontName(Font.Name) + '" font-size="' +
    FormatCoord(Abs(Font.Size)) + 'pt" ';
    //IntToStr(Abs(Font.Size div 1000)) + 'pt" ';

  if fsItalic in Font.Style then
     result:=result+' font-style="italic"';

  if fsBold in Font.Style then
     result:=result+' font-weight="bold"';

  if fsUnderline in Font.Style then
     result:=result+' text-decoration="underline"'
  else if fsStrikeOut in Font.Style then
     result:=result+' text-decoration="line-through"';

  result:=result+' fill='+SVGColor(Font.Color);
end;

function GetTextWidth(aFont: TFontProp; const aText: string): integer;
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  Bmp.Canvas.Font.Size := aFont.Size div 1000;
  Bmp.Canvas.Font.Name := aFont.Name;
  Bmp.Canvas.Font.Style := aFont.Style;
  Bmp.Canvas.Font.Charset := aFont.Charset;
  result := Bmp.Canvas.TextWidth(aText);
  Bmp.Free;
end;

function GetTextHeight(aFont: TFontProp; const aText: string): integer;
var
  Bmp: TBitmap;
  TM: TTextMetric;  
begin
  Bmp := TBitmap.Create;
  Bmp.Canvas.Font.Size := aFont.Size div 1000;
  Bmp.Canvas.Font.Name := aFont.Name;
  Bmp.Canvas.Font.Style := aFont.Style;
  Bmp.Canvas.Font.Charset := aFont.Charset;
  result := Bmp.Canvas.TextHeight(aText);
  if GetTextMetrics(Bmp.Canvas.Handle, TM) then
   dec(Result, TM.tmDescent); // Move to baseline
  Bmp.Free;
end;


procedure ExportFxdToSVG(Flex: TFlexPanel; const FileName:string);
var
  List: TStrings;
  str,LStr, StyleName: string;
  Control: TFlexControl;
  PassRec: TPassControlRec;
  PO: TPaintOrder;
  LayerIdx, ControlIdx: integer;
  i,x,y,w,h,r: integer;
  Points: Array of TPoint;
  Prop: TCustomProp;
  Brushes: TStringList;
  StartColor, EndColor: TColor;
begin
  Brushes := Nil;
  List := TStringList.Create;
  try
    List.Add('<?xml version="1.0" encoding="UTF-8"?>');
    List.Add('<svg width="' + IntToStr(Flex.DocWidth div 1000) +
      '" height="' + IntToStr(Flex.DocHeight div 1000) + '">');
    // SVG defs section
    List.Add('<defs>');
    try
     Brushes := TStringList.Create;
     Control := Flex.ActiveScheme;
     FirstControl(Control, PassRec);
     while Assigned(Control) do
     begin
       // Check brush
       Prop := Control.Props['Brush'];
       if Assigned(Prop) and (Prop is TBrushProp) then with TBrushProp(Prop) do
        if not IsClear and IsPaintAlternate then begin
         // Try add brush style
         if (Method = bmGradient) and (Control.IdProp.Value <> 0) then begin
          // Create gradient brush
          if GradStyle = gsElliptic
           then LStr := 'radialGradient'
           else LStr := 'linearGradient';
          StyleName := Control.NameProp.Value + IntToStr(Control.IdProp.Value) +
            '_Brush';
          str := 'id="' + StyleName + '" gradientUnits="objectBoundingBox" ';
          case GradStyle of
           gsHorizontal  : str := str + 'x1="0" y1="0" x2="1" y2="0"';
           gsVertical    : str := str + 'x1="0" y1="0" x2="0" y2="1"';
           gsSquare      : str := str + 'x1="0" y1="0" x2="0" y2="0"'; // NOT IMPLEMENTED
           gsElliptic    : str := str + 'cx="0.5" cy="0.5" r="0.5" fx="0.5" fy="0.5"';
           gsTopLeft     : str := str + 'x1="0" y1="0" x2="1" y2="1"';
           gsTopRight    : str := str + 'x1="1" y1="0" x2="0" y2="1"';
           gsBottomLeft  : str := str + 'x1="0" y1="1" x2="1" y2="0"';
           gsBottomRight : str := str + 'x1="1" y1="1" x2="0" y2="0"';
          end;
          List.Add('<' + LStr + ' ' + str + '>');
          if GradStyle = gsElliptic then begin
           EndColor := GradBeginColor;
           StartColor := GradEndColor;
          end else begin
           StartColor := GradBeginColor;
           EndColor := GradEndColor;
          end;
          List.Add('<stop offset="0%" style="stop-color:' +
            SVGColor(StartColor,false) + '; stop-opacity:1"/>');
          List.Add('<stop offset="100%" style="stop-color:' +
            SVGColor(EndColor,false) + '; stop-opacity:1"/>');
          List.Add('</' + LStr + '>');
          Brushes.AddObject(StyleName, pointer(Control.IdProp.Value));
         end;
        end;

       // Next control
       Control := NextControl(PassRec);
     end;
     ClosePassRec(PassRec);
    finally
     List.Add('</defs>');
    end;
    // Scheme background
    List.Add('<rect x="0" y="0" width="'  + IntToStr(Flex.DocWidth div 1000) +
      '" height="'  + IntToStr(Flex.DocHeight div 1000) + '"' +
      SVGBrushPen(TFlexScheme(Flex.ActiveScheme).BrushProp, Nil, Brushes) +
      //'" fill=' + SVGColor(TFlexScheme(Flex.ActiveScheme).BrushProp.Color) +
      //' stroke=' + SVGColor(TFlexScheme(Flex.ActiveScheme).BrushProp.Color) +
      ' stroke="none" stroke-width="0" />');
    // SVG graphics section
    InitPaintOrder(PO);
    try
     Flex.ActiveScheme.CreatePaintOrder(PO);
     for LayerIdx:=0 to High(PO.LayerRefs) do begin
      ControlIdx := PO.LayerRefs[LayerIdx].First;
      while ControlIdx >= 0 do begin
       Control := PO.ControlRefs[ControlIdx].Control;
       //if Control.IsSelected then Control.SaveToFiler(Filer, IndentStep);
       FirstControl(Control, PassRec);
       while Assigned(Control) do
       begin
         if Control is TFlexBox then
         begin
           str := '<rect x = "' + IntToStr(Control.DocRect.Left div 1000) +
             '" y="' + IntToStr(Control.DocRect.Top div 1000) +  '" width="' +
             IntToStr(Control.Width div 1000) + '" height="' +
             IntToStr(Control.Height div 1000) + '" ' +
             SVGBrushPen(TFlexBox(Control).BrushProp,TFlexBox(Control).PenProp,Brushes);
           if TFlexBox(Control).RoundnessProp.Value > 0 then begin
             r := TFlexBox(Control).RoundnessProp.Value div (2*PixelScaleFactor);
             str := Format('%s rx="%d" ry="%d"', [str, r, r]);
           end;
           str := str + '/>';
           List.Add(str);
           if Control is TFlexText then
           begin
             x := Control.DocRect.Left div 1000;
             y := Control.DocRect.Bottom div 1000;
             w := Control.Width div 1000 - GetTextWidth(TFlexText(Control).FontProp,
               TFlexText(Control).TextProp.Text);
             h := Control.Height div 1000 - GetTextHeight(TFlexText(Control).FontProp,' ');
             if TFlexText(Control).Alignment = taRightJustify then
               x := x + w
             else if  TFlexText(Control).Alignment = taCenter then
               x := x + w div 2;
             if TFlexText(Control).Layout = tlTop then
               y := y - h
             else if  TFlexText(Control).Layout = tlCenter then
               y := y - h div 2;
             str := '<text x="' + IntToStr(x) + '" y="' + IntToStr(y) + '"' +
               SVGFont(TFlexText(Control).FontProp);
             str := str + '> ' +  TFlexText(Control).TextProp.Text +
               ' </text>';
             List.Add(str);
           end;
         end
         else if Control is TFlexEllipse then
         begin
           str := '<ellipse cx = "' + IntToStr((Control.DocRect.Right - Control.Width div 2) div 1000) +
             '" cy="' + IntToStr((Control.DocRect.Bottom - Control.Height div 2) div 1000) +
             '" rx="' + IntToStr(Control.Width div 2000) + '" ry="' +
             IntToStr(Control.Height div 2000) +  '" ' +
             SVGBrushPen(TFlexEllipse(Control).BrushProp,TFlexEllipse(Control).PenProp,Brushes) + '/>';
           List.Add(str);
         end
         else if Control is TFlexCurve then
         begin
           SetLength(Points,Control.PointCount);
           for i := 0 to Control.PointCount - 1 do
              Points[i] := Control.Points[i];
           if TFlexCurve(Control).IsSolidProp.Value then
              Str := '<polygon ' + SVGBrushPen(TFlexCurve(Control).BrushProp,TFlexCurve(Control).PenProp,Brushes)
           else
              Str := '<polyline fill="none" marker-start="url(#arrow)"' + SVGPen(TFlexCurve(Control).PenProp);
           str := str + SVGPoints(Control.DocRect.Left,Control.DocRect.Top,Points);
           SetLength(Points,0);

           str := str + '/>';
           List.Add(str);
         end
         else if Control is TFlexPicture then
         begin

         end;
         Control := NextControl(PassRec);
       end;
       ClosePassRec(PassRec);
       ControlIdx := PO.ControlRefs[ControlIdx].Next;
      end;
     end;
    finally
     ClearPaintOrder(PO);
    end;
    List.Add('</svg>');
    List.Text := AnsiToUtf8(List.Text);
    List.SaveToFile(FileName);
  finally
    List.Free;
    Brushes.Free;
  end;
end;

end.
