unit fInspector;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImgList, FlexBase, FlexProps, FlexControls, FlexInspector;

const
  WM_REFRESH_DATA  = WM_USER + 1;

type
  TfmInspector = class(TForm)
    Panel1: TPanel;
    cbInspItems: TComboBox;
    imgCtrlIcons: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbInspItemsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbInspItemsChange(Sender: TObject);
  private
    { Private declarations }
    FActiveFlex: TFlexPanel;
    FInspector: TFlexInspector;
    function  GetControlIconIndex(AControl: TFlexControl): integer;
    procedure SetActiveFlex(const Value: TFlexPanel);
    procedure SetFlexControl(const Value: TFlexControl);
    function  GetFlexControl: TFlexControl;
    procedure WMRefreshData(var Message: TMessage); message WM_REFRESH_DATA;
  public
    { Public declarations }
    procedure UpdateData;
    procedure UpdateProps(Prop: TCustomProp);
    property  ActiveFlex: TFlexPanel read FActiveFlex write SetActiveFlex;
    property  Control: TFlexControl read GetFlexControl write SetFlexControl;
  end;

var
  fmInspector: TfmInspector;

implementation

{$R *.DFM}

uses
  ToolMngr, FlexActions;

procedure TfmInspector.FormCreate(Sender: TObject);
begin
 RegisterToolForm(Self);

 FInspector := TFlexInspector.Create(Self);
 FInspector.Align := alClient;
 FInspector.Parent := Self;
end;

procedure TfmInspector.FormDestroy(Sender: TObject);
begin
 UnRegisterToolForm(Self);
 fmInspector := Nil;
end;

procedure TfmInspector.FormShow(Sender: TObject);
begin
 // Avoid align bug
 cbInspItems.Align := alTop;
 cbInspItems.Width := Self.ClientWidth;
end;

procedure TfmInspector.SetActiveFlex(const Value: TFlexPanel);
begin
 if Value = FActiveFlex then exit;
 {if not Assigned(Value) then }Control := Nil;
 FActiveFlex := Value;
 UpdateData;
 UpdateProps(Nil);
end;

procedure TfmInspector.SetFlexControl(const Value: TFlexControl);
begin
 FInspector.Control := Value;
 if Assigned(FActiveFlex) and Assigned(FInspector.Control) then
  cbInspItems.ItemIndex := cbInspItems.Items.IndexOfObject(FInspector.Control)
 else
  cbInspItems.ItemIndex := -1;
end;

function TfmInspector.GetFlexControl: TFlexControl;
begin
  Result := FInspector.Control;
end;

procedure TfmInspector.UpdateData;
var Msg: TMsg;
begin
 if HandleAllocated then begin
   // Remove all existing refresh messages
   while PeekMessage(Msg, Handle, WM_REFRESH_DATA, WM_REFRESH_DATA, PM_REMOVE) do ;
   // Add new refresh message to the end
   PostMessage(Handle, WM_REFRESH_DATA, 0, 0);
 end;
end;

procedure TfmInspector.WMRefreshData(var Message: TMessage);
var SelControl, Control, NewControl: TFlexControl;
    StrList, LayersList: TStringList;
    Flex: TFlexPanel;
    Scheme: TFlexCustomScheme;
    PassRec: TPassControlRec;
    i, j, Level, DLevel: integer;
    AName, APrefix, NewPrefix: string;
begin
 StrList := Nil;
 cbInspItems.Items.BeginUpdate;
 try
{  if cbInspItems.ItemIndex >= 0
   then SelControl := cbInspItems.Items.Objects[cbInspItems.ItemIndex]
   else SelControl := Nil; }
  SelControl := Nil;
  StrList := TStringList.Create;
  Flex := ActiveFlex;
  if Assigned(Flex) and not (csDestroying in Flex.ComponentState) then begin
   if Flex.SelectedCount = 1 then SelControl := Flex.Selected[0];
   Scheme := Flex.ActiveScheme;
   if Assigned(Scheme) then begin
    APrefix := '';
    Control := Scheme;
    FirstControl(Control, PassRec);
    while Assigned(Control) do begin
     AName := Control.Name;
     StrList.AddObject(APrefix + AName, Control);
     Level := High(PassRec.Indexes);
     Control := NextControl(PassRec);
     DLevel := High(PassRec.Indexes) - Level;
     if DLevel = 0 then continue;
     NewPrefix := '';
     NewControl := Control;
     for i:=0 to Abs(DLevel)-1 do
      if DLevel > 0 then begin
       NewControl := NewControl.Parent;
       if not (NewControl is TFlexScheme) then
        NewPrefix := NewControl.Name + '.' + NewPrefix;
      end else begin
       j := Length(APrefix) - 1;
       while (j > 0) and (APrefix[j] <> '.') do dec(j);
       SetLength(APrefix, j);
      end;
     APrefix := APrefix + NewPrefix;
    end;
    StrList.Sort;
    i := StrList.IndexOfObject(Scheme);
    if i >= 0 then StrList.Move(i, 0);
   end;
   if Flex.Layers.Count > 0 then begin
    LayersList := TStringList.Create;
    try
     for i:=0 to Flex.Layers.Count-1 do
      LayersList.AddObject(Flex.Layers[i].Name, Flex.Layers[i]);
     LayersList.Sort;
     j := 0;
     if (StrList.Count > 0) and (StrList.Objects[0] is TFlexScheme) then inc(j);
     for i:=LayersList.Count-1 downto 0 do
      StrList.InsertObject(j, LayersList[i], LayersList.Objects[i]);
    finally
     LayersList.Free;
    end;
   end;
  end;
  cbInspItems.Items.Assign(StrList);
  cbInspItems.ItemIndex := cbInspItems.Items.IndexOfObject(SelControl);
  Self.Control := SelControl;
 finally
  cbInspItems.Items.EndUpdate;
  StrList.Free;
 end;
end;

procedure TfmInspector.UpdateProps(Prop: TCustomProp);
begin
 if Assigned(Prop) then FInspector.InvalidateProp(Prop);
end;

function TfmInspector.GetControlIconIndex(AControl: TFlexControl): integer;
var CType: TClass;
begin
 Result := -1;
 if not Assigned(AControl) then exit;
 CType := AControl.ClassType;
 if CType = TFlexScheme    then Result := 0 else
 if CType = TFlexLayer     then Result := 1 else
 if CType = TFlexBox       then Result := 2 else
 if CType = TFlexEllipse   then Result := 3 else
 if CType = TFlexCurve     then Result := 4 else
 if CType = TFlexText      then Result := 5 else
 if CType = TFlexPicture   then Result := 6 else
 if CType = TFlexGroup     then Result := 7 else
 if CType = TFlexConnector then Result := 9 
                           else Result := 8;
end;

procedure TfmInspector.cbInspItemsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var s: string;
    Idx: integer;
    FlexControl: TFlexControl;
    Org, Cli: TPoint;
begin
 with cbInspItems do begin
  Canvas.FillRect(Rect);
  FlexControl := TFlexControl(Items.Objects[Index]);
  Idx := GetControlIconIndex(FlexControl);
  if Idx >= 0 then begin
   imgCtrlIcons.Draw(Canvas, Rect.Left+2, Rect.Top+2, Idx);
  end;
  s := Items[Index];
  Canvas.TextOut(Rect.Left+22, Rect.Top +
                ((Rect.Bottom - Rect.Top) - Canvas.TextHeight(s)) div 2, s);
  GetDCOrgEx(Canvas.Handle, Org);
  Cli := ClientToScreen(Point(Top, Left));
  if (Index < Items.Count-1) and (Org.Y <> Cli.Y) and
     ((FlexControl is TFlexScheme) or (FlexControl is TFlexLayer)) then begin
   FlexControl := TFlexControl(Items.Objects[Index+1]);
   if not (FlexControl is TFlexScheme) and
      not (FlexControl is TFlexLayer) then
    with Canvas do begin
     Pen.Color := clBlack;
     Pen.Style := psSolid;
     Pen.Mode := pmCopy;
     MoveTo(Rect.Left, Rect.Bottom-1);
     LineTo(Rect.Right, Rect.Bottom-1);
    end;
  end;
 end;
end;

procedure TfmInspector.cbInspItemsChange(Sender: TObject);
var AControl: TFlexControl;
begin
 if not Assigned(FActiveFlex) then exit;
 AControl := TFlexControl(cbInspItems.Items.Objects[cbInspItems.ItemIndex]);
 with FActiveFlex do begin
  UnselectAll;
  Select(AControl);
 end;
 Control := AControl;
end;

end.
