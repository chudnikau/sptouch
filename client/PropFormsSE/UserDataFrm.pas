unit UserDataFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ActnList, ImgList, StdCtrls, Buttons, ExtCtrls, FlexProps,
  TreeInspector;

type
  TUserDataForm = class(TForm)
    imgToolIcons: TImageList;
    alMain: TActionList;
    acUserPropAdd: TAction;
    acUserPropDelete: TAction;
    acUserPropMoveUp: TAction;
    acUserPropMoveDown: TAction;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    panMain: TPanel;
    tbMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acUserPropAddExecute(Sender: TObject);
    procedure acUserPropDeleteExecute(Sender: TObject);
    procedure acUserPropMoveUpExecute(Sender: TObject);
    procedure acUserPropMoveDownExecute(Sender: TObject);
  private
    { Private declarations }
    FUserDataProp: TUserDataProp;
    FProps: TStringList;
    FUserProps: TTreeInspector;
    procedure UserPropsChange(Sender: TObject; Node: TTreeNode);
    procedure UserPropsGetEditText(Sender: TObject; Node: TTreeNode;
      ALabel: boolean; var Text: string);
    procedure UserPropsSetEditText(Sender: TObject; Node: TTreeNode;
      ALabel: boolean; var Text: string);
    procedure CheckTools;
  public
    { Public declarations }
  end;

var
  UserDataForm: TUserDataForm;

implementation

uses
  ToolMngr;

{$R *.DFM}

procedure TUserDataForm.FormCreate(Sender: TObject);
begin
 FProps := TStringList.Create;
 FUserProps := TTreeInspector.Create(Self);
 FUserProps.Align := alClient;
 FUserProps.Parent := panMain;
 FUserProps.AllowLabelEdit := True;
 FUserProps.LabelsColWidth := 80;
 FUserProps.OnGetEditText := UserPropsGetEditText;
 FUserProps.OnSetEditText := UserPropsSetEditText;
 FUserProps.OnChange := UserPropsChange;
end;

procedure TUserDataForm.FormDestroy(Sender: TObject);
begin
 FProps.Free;
end;

procedure TUserDataForm.FormShow(Sender: TObject);
begin
 if (Tag <> 0) and (TObject(Tag) is TUserDataProp) then
  FUserDataProp := TUserDataProp(Tag);
 if Assigned(FUserDataProp) then with FUserDataProp do begin
  AssignTo(FProps);
  FUserProps.PropertyCount := FProps.Count;
  if FProps.Count > 0 then
   FUserProps.EditNode := FUserProps.Items.GetFirstNode;
 end;
 CheckTools;
end;

procedure TUserDataForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (ModalResult <> mrOk) or not Assigned(FUserDataProp) then exit;
 FUserProps.ApplyEdit;
 FUserDataProp.Assign(FProps);
end;

procedure TUserDataForm.CheckTools;
var DataExists: boolean;
begin
 DataExists := FProps.Count > 0;
 acUserPropAdd.Enabled := true;
 acUserPropDelete.Enabled := DataExists;
 if DataExists and Assigned(FUserProps.EditNode) then begin
  acUserPropMoveUp.Enabled := FUserProps.EditNode.GetPrev <> Nil;
  acUserPropMoveDown.Enabled := FUserProps.EditNode.GetNext <> Nil;
 end else begin
  acUserPropMoveUp.Enabled := False;
  acUserPropMoveDown.Enabled := False;
 end;
end;

procedure TUserDataForm.UserPropsGetEditText(Sender: TObject;
  Node: TTreeNode; ALabel: boolean; var Text: string);
var Index, i: integer;
begin
 Index := Node.Index;
 if ALabel then
  Text := FProps.Names[Index]
 else begin
  Text := FProps[Index];
  i := Pos('=', Text);
  Text := copy(Text, i+1, MaxInt);
 end;
end;

procedure TUserDataForm.UserPropsSetEditText(Sender: TObject;
  Node: TTreeNode; ALabel: boolean; var Text: string);
var Index, i: integer;
    s: string;
    R: TRect;
begin
 Index := Node.Index;
 if ALabel then begin
  s := FProps[Index];
  i := Pos('=', s);
  FProps[Index] := Text + '=' + copy(s, i+1, MaxInt);
 end else
  FProps[Index] := FProps.Names[Index] + '=' + Text;
 R := Node.DisplayRect(False);
 InvalidateRect(FUserProps.Handle, @R, False);
end;

procedure TUserDataForm.UserPropsChange(Sender: TObject; Node: TTreeNode);
begin
 CheckTools;
end;

procedure TUserDataForm.acUserPropAddExecute(Sender: TObject);
var i: integer;
begin
 i := FProps.Add('');
 with FUserProps do begin
  PropertyCount := FProps.Count;
  EditNode := Items[i];
  EditingLabel := True;
 end;
 CheckTools;
end;

procedure TUserDataForm.acUserPropDeleteExecute(Sender: TObject);
var Index: integer;
begin
 with FUserProps do begin
  Index := EditNode.Index;
  EditNode := Nil;
  FProps.Delete(Index);
  PropertyCount := FProps.Count;
  if Index < FProps.Count then
   EditNode := Items[Index]
  else
  if FProps.Count > 0 then
   EditNode := Items[FProps.Count-1];
  Invalidate;
 end;
 CheckTools;
end;

procedure TUserDataForm.acUserPropMoveUpExecute(Sender: TObject);
var Index: integer;
begin
 with FUserProps do begin
  Index := EditNode.Index;
  EditNode := Nil;
  FProps.Move(Index, Index-1);
  EditNode := Items[Index-1];
  Invalidate;
 end;
 CheckTools;
end;

procedure TUserDataForm.acUserPropMoveDownExecute(Sender: TObject);
var Index: integer;
begin
 with FUserProps do begin
  Index := EditNode.Index;
  EditNode := Nil;
  FProps.Move(Index, Index+1);
  EditNode := Items[Index+1];
  Invalidate;
 end;
 CheckTools;
end;

initialization
  RegisterDefaultPropEditForm(TUserDataProp, TUserDataForm);

end.

