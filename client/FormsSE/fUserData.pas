unit fUserData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ActnList, ImgList, TreeInspector,
  FlexBase, FlexProps;

type
  TfmUserData = class(TForm)
    imgToolIcons: TImageList;
    tbrMain: TToolBar;
    tbNew: TToolButton;
    tbDelete: TToolButton;
    tbDelim: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbMoveUpClick(Sender: TObject);
    procedure tbMoveDownClick(Sender: TObject);
  private
    { Private declarations }
    FActiveFlex: TFlexPanel;
    FLastControl: TFlexControl;
    FUserProps: TTreeInspector;
    FChanging: boolean;
    FLastPropName: string;
    FLastEditingLabel: boolean;
    procedure CheckTools;
    procedure SetActiveFlex(const Value: TFlexPanel);
    function  GetSelControl: TFlexControl;
    procedure UserPropsChange(Sender: TObject; Node: TTreeNode);
    procedure UserPropsGetEditText(Sender: TObject; Node: TTreeNode;
      ALabel: boolean; var Text: string);
    procedure UserPropsSetEditText(Sender: TObject; Node: TTreeNode;
      ALabel: boolean; var Text: string);
  public
    { Public declarations }
    property  ActiveFlex: TFlexPanel read FActiveFlex write SetActiveFlex;
    property  SelControl: TFlexControl read GetSelControl;
    procedure UpdateData;
  end;

var
  fmUserData: TfmUserData;

implementation

{$R *.DFM}

uses
  ToolMngr;

procedure TfmUserData.FormCreate(Sender: TObject);
begin
 RegisterToolForm(Self);
 FUserProps := TTreeInspector.Create(Self);
 FUserProps.Align := alClient;
 FUserProps.Parent := Self;
 FUserProps.AllowLabelEdit := True;
 FUserProps.OnGetEditText := UserPropsGetEditText;
 FUserProps.OnSetEditText := UserPropsSetEditText;
 FUserProps.OnChange := UserPropsChange;
 CheckTools;
end;

procedure TfmUserData.FormDestroy(Sender: TObject);
begin
 UnRegisterToolForm(Self);
 fmUserData := Nil;
end;

procedure TfmUserData.CheckTools;
var DataExists: boolean;
    Control: TFlexControl;
begin
 Control := SelControl;
 if Assigned(Control)
  then DataExists := Control.UserData.LinesCount > 0
  else DataExists := False;
 tbNew.Enabled := Assigned(Control);
 tbDelete.Enabled := DataExists;
 if DataExists and Assigned(FUserProps.EditNode) then begin
  tbMoveUp.Enabled := FUserProps.EditNode <> FUserProps.Items.GetFirstNode;
  tbMoveDown.Enabled := FUserProps.EditNode.GetNext <> Nil;
 end else begin
  tbMoveUp.Enabled := False;
  tbMoveDown.Enabled := False;
 end;
end;

procedure TfmUserData.UpdateData;
var Control: TFlexControl;
    Index: integer;
    NewEditNode: TTreeNode;
begin
 if FChanging then exit;
 Control := SelControl;
 with FUserProps do begin
  if Assigned(FLastControl) then begin
   if Assigned(FUserProps.EditNode) then begin
    FLastPropName := FLastControl.UserData.Names[FUserProps.EditNode.Index];
    FLastEditingLabel := FUserProps.EditingLabel;
   end;
   if FLastControl <> Control then Editing := False;
  end;
  if Assigned(Control) then begin
   FLastControl := Control;
   PropertyCount := Control.UserData.LinesCount;
   NewEditNode := EditNode;
   if Items.Count > 0 then
    if FLastPropName <> '' then begin
     Index := Control.UserData.IndexOfName(FLastPropName);
     if Index >= 0 then
      NewEditNode := Items[Index]
     else
      NewEditNode := Items.GetFirstNode;
     FUserProps.EditingLabel := FLastEditingLabel;
    end else
     NewEditNode := Items.GetFirstNode;
   if NewEditNode <> EditNode then
    EditNode := NewEditNode
   else
    UpdateEdit(True);
  end else begin
   Items.Clear;
   EditNode := Nil;
   FLastControl := Control;
  end;
  Invalidate;
 end;
 CheckTools;
end;

function TfmUserData.GetSelControl: TFlexControl;
begin
 if Assigned(FActiveFlex) and (FActiveFlex.SelectedCount = 1)
  then Result := FActiveFlex.Selected[0]
  else Result := Nil;
end;

procedure TfmUserData.SetActiveFlex(const Value: TFlexPanel);
begin
 if Value = FActiveFlex then exit;
 if not Assigned(Value) then FLastControl := Nil;
 FActiveFlex := Value;
 UpdateData;
end;

procedure TfmUserData.UserPropsGetEditText(Sender: TObject;
  Node: TTreeNode; ALabel: boolean; var Text: string);
var Control: TFlexControl;
    Index: integer;
begin
 Control := SelControl;
 Index := Node.Index;
 if Assigned(Control) then
  if ALabel then
   Text := Control.UserData.Names[Index]
  else
   Text := Control.UserData.ValuesByIndex[Index];
end;

procedure TfmUserData.UserPropsSetEditText(Sender: TObject;
  Node: TTreeNode; ALabel: boolean; var Text: string);
var Index: integer;
    R: TRect;
begin
 if FChanging then exit;
 FChanging := True;
 try
  Index := Node.Index;
  if Assigned(FLastControl) then
   if ALabel
    then FLastControl.UserData.Names[Index] := Text
    else FLastControl.UserData.ValuesByIndex[Index] := Text;
  R := Node.DisplayRect(False);
  InvalidateRect(FUserProps.Handle, @R, False);
 finally
  FChanging := False;
 end;
end;

procedure TfmUserData.UserPropsChange(Sender: TObject; Node: TTreeNode);
begin
 CheckTools;
end;

procedure TfmUserData.tbNewClick(Sender: TObject);
var Control: TFlexControl;
    Index: integer;
begin
 Control := SelControl;
 if Assigned(Control) then begin
  FUserProps.ApplyEdit;
  Index := Control.UserData.Add('');
  if Index < FUserProps.Items.Count then begin
    FUserProps.EditNode := FUserProps.Items[Index];
    FUserProps.EditingLabel := True;
  end;
 end;
end;

procedure TfmUserData.tbDeleteClick(Sender: TObject);
var Control: TFlexControl;
    Index, ItemCount: integer;
begin
 Control := SelControl;
 if Assigned(Control) then begin
  Index := FUserProps.EditNode.Index;
  FUserProps.Selected := Nil;
  Control.UserData.Delete(Index);
  ItemCount := FUserProps.Items.Count;
  if Index < ItemCount then
    FUserProps.EditNode := FUserProps.Items[Index]
  else
  if ItemCount > 0 then
    FUserProps.EditNode := FUserProps.Items[ItemCount-1];
 end;
end;

procedure TfmUserData.tbMoveUpClick(Sender: TObject);
var Control: TFlexControl;
    Index: integer;
    s1, s2: string;
begin
 Control := SelControl;
 Index := FUserProps.EditNode.Index;
 if Assigned(Control) then with Control.UserData do begin
  FUserProps.ApplyEdit;
  FChanging := True;
  try
   s1 := Lines[Index-1];
   s2 := Lines[Index];
   Lines[Index-1] := s2;
   Lines[Index] := s1;
  finally
   FChanging := False;
  end;
  UpdateData;
  FUserProps.EditNode := FUserProps.Items[Index-1];
 end;                                                         
end;

procedure TfmUserData.tbMoveDownClick(Sender: TObject);
var Control: TFlexControl;
    Index: integer;
    s1, s2: string;
begin
 Control := SelControl;
 Index := FUserProps.EditNode.Index;
 if Assigned(Control) then with Control.UserData do begin
  FUserProps.ApplyEdit;
  FChanging := True;
  try
   s1 := Lines[Index];
   s2 := Lines[Index+1];
   Lines[Index] := s2;
   Lines[Index+1] := s1;
  finally
   FChanging := False;
  end;
  UpdateData;
  FUserProps.EditNode := FUserProps.Items[Index+1];
 end;
end;

end.
