{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit QuerySearchList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, dxEditor, dxEdLib, dxDBELib, StdCtrls, Buttons,
  ActnList, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid, DB,
  ZAbstractRODataset, ZDataset, ADODB, Grids, DBGrids, MdExtCtrls, SPTForm;

type
  EFQuerySearchList = class(Exception);
  
  TFQuerySearchList = class(TSPTForm)
    dtsDataSet: TDataSource;
    dxDBGrid: TdxDBGrid;
    LabelCount: TLabel;
    EditSearch: TEdit;
    Label1: TLabel;
    BtnOK: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    BtnRefresh: TMdBitBtn;
    CheckBoxOR: TMdCheckBox;
    procedure dxDBGridDblClick(Sender: TObject);
    procedure BtnRefreshClick(Sender: TObject);
  private
    FZQuery : TZReadOnlyQuery;
    FSearchStrings : TStringList;
    FOldFilterRecordEvent : TFilterRecordEvent;
  public
    function Execute : Boolean;
    procedure FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    constructor Create(AOwner: TComponent; AQuery : TZReadOnlyQuery;
      const aKeyField : string); reintroduce; overload;
    destructor Destroy; override;
  end;

var
  FQuerySearchList: TFQuerySearchList;

implementation

uses dm_general;

{$R *.dfm}

constructor TFQuerySearchList.Create(AOwner: TComponent; AQuery : TZReadOnlyQuery;
  const aKeyField : string);
begin
  inherited Create(AOwner);
  FSearchStrings := TStringList.Create;
  FZQuery := AQuery;
  FOldFilterRecordEvent := FZQuery.OnFilterRecord;
  FZQuery.OnFilterRecord := FilterRecord;
  dtsDataSet.DataSet := FZQuery;
  dxDBGrid.KeyField := aKeyField;
end;

destructor TFQuerySearchList.Destroy;
begin
  FZQuery.OnFilterRecord := FOldFilterRecordEvent;
  FSearchStrings.Free;
  inherited Destroy;
end;

procedure TFQuerySearchList.dxDBGridDblClick(Sender: TObject);
begin
  BtnOK.Click;
end;

function TFQuerySearchList.Execute: Boolean;
begin
  dxDBGrid.CreateDefaultColumns(FZQuery, dxDBGrid);
  LabelCount.Caption := IntToStr(FZQuery.RecordCount);
  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TFQuerySearchList.FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var i, j, n : Integer;
begin
  if Assigned(FOldFilterRecordEvent) then
    FOldFilterRecordEvent(DataSet, Accept);
  if FSearchStrings.Count > 0 then
  begin
    n := 0;
    for i := 0 to FSearchStrings.Count - 1 do
      for j := 0 to FZQuery.FieldCount - 1 do
        if FZQuery.Fields[j].Visible then
          if Pos(AnsiUpperCase(FSearchStrings[i]), AnsiUpperCase(FZQuery.Fields[j].AsString)) > 0 then
          begin
            Inc(n);
            Break;
          end;
    if CheckBoxOR.Checked then
      Accept := n > 0
    else
      Accept := n = FSearchStrings.Count;
  end else
    Accept := True;
end;

procedure TFQuerySearchList.BtnRefreshClick(Sender: TObject);
begin
  FSearchStrings.Delimiter := #32;
  FSearchStrings.DelimitedText := Trim(EditSearch.Text);
  FZQuery.Filtered := False;
  FZQuery.Filtered := True;
  LabelCount.Caption := IntToStr(FZQuery.RecordCount);
end;

end.
