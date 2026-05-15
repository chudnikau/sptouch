unit FlexInspector;

interface

uses
  Windows, Classes, Controls, ComCtrls, CommCtrl, StdCtrls, Messages, Graphics,
  TreeInspector, FlexBase, FlexProps;

type
  TCustomFlexInspector = class(TCustomTreeInspector)
  private
    FControl: TFlexControl;
    procedure SetControl(const Value: TFlexControl);
    function GetSelectedProp: TCustomProp;
    procedure SetSelectedProp(const Value: TCustomProp);
  protected
    function IndexOfNode(const Prop: TCustomProp): integer;
    function GetEditText(Node: TTreeNode; ALabel: boolean): string; override;
    procedure SetEditText(Node: TTreeNode; ALabel: boolean;
      var Value: string); override;
    function GetEditStyle(Node: TTreeNode;
      ALabel: boolean): TGridEditStyle; override;
    procedure GetEditList(Node: TTreeNode; Items: TStrings); override;
    function GetEditReadOnly(Node: TTreeNode;
      ALabel: boolean): boolean; override;
    procedure EditButtonPress(Node: TTreeNode); override;
    procedure EditCloseUp(Node: TTreeNode; ItemIndex: Integer;
      var Accept: Boolean); override;
    procedure DblClick; override;
  public
    procedure RebuildProperties;
    procedure InvalidateProp(Prop: TCustomProp);
    property  Control: TFlexControl read FControl write SetControl;
    property  SelectedProp: TCustomProp read GetSelectedProp
      write SetSelectedProp;
  end;

  TFlexInspector = class(TCustomFlexInspector)
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
    { Items must be published after OnGetImageIndex and OnGetSelectedIndex }
    property Items;
  end;

implementation

uses
 Forms, FlexActions;

// TCustomFlexInspector ///////////////////////////////////////////////////////

procedure TCustomFlexInspector.SetControl(const Value: TFlexControl);
begin
  if Value = FControl then exit;
  EditNode := Nil;
  FControl := Value;
  RebuildProperties;
end;

procedure TCustomFlexInspector.RebuildProperties;
var
  Prop: TCustomProp;
  SelectedName: string;
  i, Index, SelIndex: integer;
begin
  Items.BeginUpdate;
  try
    // Save selected property name
    Prop := SelectedProp;
    if Assigned(Prop) then SelectedName := Prop.Name;
    // Rebuild props
    Items.Clear;
    if Assigned(FControl) then begin
      SelIndex := -1;
      for i:=0 to FControl.Props.VisibleCount-1 do begin
        Prop := FControl.Props.VisibleProps[i];
        Index := Items.AddObject(Nil, '', Prop).Index;
        if Prop.Name = SelectedName then
          SelIndex := Index;
      end;
      // Try to restore selected property
      if SelIndex >= 0 then
        Selected := Items[SelIndex]
      else
      if Items.Count > 0 then
        Selected := Items[0]
      else
        Selected := Nil;
    end;
  finally
    Items.EndUpdate;
  end;
end;

function TCustomFlexInspector.GetSelectedProp: TCustomProp;
begin
  if Assigned(FControl) and Assigned(Selected) then
    Result := TCustomProp(Selected.Data)
  else
    Result := Nil;
end;

procedure TCustomFlexInspector.SetSelectedProp(const Value: TCustomProp);
var
  Index: integer;
begin
  if Assigned(Value) then begin
    Index := IndexOfNode(Value);
    if Index >= 0 then Selected := Items[Index];
  end else
    Selected := Nil;
end;

function TCustomFlexInspector.IndexOfNode(const Prop: TCustomProp): integer;
var
  i: integer;
begin
  Result := -1;
  for i:=0 to Items.Count-1 do
    if Items[i].Data = Prop then begin
      Result := i;
      break;
    end;
end;

function TCustomFlexInspector.GetEditText(Node: TTreeNode;
  ALabel: boolean): string;
begin
  if ALabel then
    Result := TCustomProp(Node.Data).Name
  else
    Result := TCustomProp(Node.Data).DisplayValue;
end;

procedure TCustomFlexInspector.SetEditText(Node: TTreeNode; ALabel: boolean;
  var Value: string);
var Prop: TCustomProp;
    R: TRect;
begin
  if ALabel or not Assigned(FControl) then Exit;
  Prop := Nil;
  try
    Prop := TCustomProp(Node.Data);
    if psReadOnly in Prop.Style then exit;
    if Prop.DisplayValue <> Value then begin
      FControl.Owner.History.BeginPanelGroup(TPanelPropsHistoryGroup);
      try
        Prop.DisplayValue := Value;
      finally
        FControl.Owner.History.EndPanelGroup(TPanelPropsHistoryGroup);
      end;
    end else
     exit;
 except
   Application.HandleException(Self);
   R := EditNode.DisplayRect(False);
   InvalidateRect(Handle, @R, False);
 end;
 if Assigned(Prop) then
 try
   Value := Prop.DisplayValue;
 except
   Value := '';
 end;
end;

function TCustomFlexInspector.GetEditStyle(Node: TTreeNode;
  ALabel: boolean): TGridEditStyle;
var
  Prop: TCustomProp;
begin
  if ALabel then
    Result := geSimple
  else begin
    Prop := TCustomProp(Node.Data);
    if psEditForm in Prop.Style then
      Result := geEllipsis
    else
    if Prop.IsEnum then
      Result := gePickList
    else
      Result := geSimple;
  end;
end;

procedure TCustomFlexInspector.GetEditList(Node: TTreeNode; Items: TStrings);
begin
  if not Assigned(FControl) or not Assigned(Selected) then exit;
  TCustomProp(Selected.Data).GetEnumList(Items);
end;

function TCustomFlexInspector.GetEditReadOnly(Node: TTreeNode;
  ALabel: boolean): boolean;
begin
  Result :=
    ALabel or (GetEditStyle(Node, False) <> geSimple) or
    (psReadOnly in TCustomProp(Node.Data).Style);
end;

procedure TCustomFlexInspector.InvalidateProp(Prop: TCustomProp);
var
  Index: integer;
  Node: TTreeNode;
  R: TRect;
  Value: string;
begin
  Index := IndexOfNode(Prop);
  if (Index < 0) then exit;
  Node := Items[Index];
  if Node = Selected then begin
    // Update editor
    Value := GetEditText(Node, False);
    if InplaceEdit.DropListVisible and Assigned(InplaceEdit.ActiveList) then
      with TInplaceListBox(InplaceEdit.ActiveList) do begin
        Index := Items.IndexOf(Value);
        ItemIndex := Index;
      end
    else
      InplaceEdit.Text := Value;
  end else begin
    if not Node.IsVisible then exit;
    R := Node.DisplayRect(False);
    R.Left := LabelsColWidth + 2;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TCustomFlexInspector.EditButtonPress(Node: TTreeNode);
begin
  if not Assigned(FControl) or not Assigned(Selected) then exit;
  TCustomProp(Selected.Data).Edit;
end;

procedure TCustomFlexInspector.EditCloseUp(Node: TTreeNode;
  ItemIndex: Integer; var Accept: Boolean);
var Value: string;
begin
 if not Assigned(FControl) or (ItemIndex < 0) then exit;
 Value := TInplaceListBox(InplaceEdit.ActiveList).Items[ItemIndex];
 SetEditText(Selected, False, Value);
end;

procedure TCustomFlexInspector.DblClick;
var Items: TStrings;
    Prop: TCustomProp;
    NewIndex: integer;
    Value: string;
begin
  inherited;
  if not Assigned(FControl) then exit;
  Prop := SelectedProp;
  if not Assigned(Prop) then exit;
  if Prop is TEnumProp then begin
    with TEnumProp(Prop) do
      if EnumIndex = EnumCount - 1
        then NewIndex := 0
        else NewIndex := EnumIndex + 1;
    Items := TStringList.Create;
    try
      TEnumProp(Prop).GetEnumList(Items);
      Value := Items[NewIndex];
    finally
      Items.Free;
    end;
    SetEditText(Selected, False, Value);
  end;
end;

end.
