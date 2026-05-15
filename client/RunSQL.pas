unit RunSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SynEditHighlighter, SynHighlighterSQL, SynEdit, SynDBEdit, ExtCtrls,
  StdCtrls, Buttons, Menus, dxBar, SynMemo, ZDataset;

type
  ERunSQL = class(Exception);

  TRunSQL = class(TForm)
    SynSQLSyn: TSynSQLSyn;
    Panel1: TPanel;
    BitBtn7: TBitBtn;
    BtnCancel: TBitBtn;
    OpenDialog: TOpenDialog;
    dxBarManager: TdxBarManager;
    N2: TdxBarButton;
    N3: TdxBarButton;
    N1: TdxBarSubItem;
    N5: TdxBarButton;
    N6: TdxBarButton;
    N4: TdxBarSubItem;
    MemoSqlScript: TSynMemo;
    SaveDialog: TSaveDialog;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  FRunSQL: TRunSQL;

implementation

uses dm_general, ZAbstractRODataset;

{$R *.dfm}

{ TFRunSQL }

procedure TRunSQL.N2Click(Sender: TObject);
begin
  if OpenDialog.Execute then
    MemoSqlScript.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TRunSQL.N3Click(Sender: TObject);
begin
  if SaveDialog.Execute then
    MemoSqlScript.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TRunSQL.N5Click(Sender: TObject);
begin
  with UDM.CreateDataSet(MemoSqlScript.Lines.Text) do
  try
    try
      Open;
    except
      on E : Exception do
        raise ERunSQL.Create('Ошибка в SQL скрипте. ' + E.Message);
    end;
  finally
    Free;
  end;
end;

procedure TRunSQL.N6Click(Sender: TObject);
begin
  with TZQuery(UDM.CreateDataSet(MemoSqlScript.Lines.Text)) do
  try
    try      
      ExecSQL;
    except
      on E : Exception do
        raise ERunSQL.Create('Ошибка в SQL скрипте. ' + E.Message);
    end;
  finally
    Free;
  end;
end;

end.
