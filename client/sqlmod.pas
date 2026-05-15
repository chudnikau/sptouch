{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit sqlmod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, DBCtrls, ActnList, ZSqlUpdate, dxExEdtr, dxCntner,
  dxTL, dxDBCtrl, dxDBGrid, dxDBTLCl, dxGrClms, SynEdit, SynDBEdit,
  SynEditHighlighter, SynHighlighterSQL, ImgList, HelpPic, MdExtCtrls, frxClass,
  frxPreview, frxDBSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, SPTForm;

type
  TFSQLMod = class(TSPTForm)
    Panel1: TPanel;
    dtbReports: TZQuery;
    dtsReports: TDataSource;
    dtbReportssql: TMemoField;
    ActionList: TActionList;
    dtbReportsreport_id: TLargeintField;
    Panel2: TPanel;
    Bevel1: TBevel;
    AddDiagramBtn: TSpeedButton;
    DelDiagramBtn: TSpeedButton;
    dtbParamsReports: TZQuery;
    dtsParamsReports: TDataSource;
    LabelCount: TLabel;
    ActionAdd: TAction;
    ActionDelete: TAction;
    tdbAllParams: TZReadOnlyQuery;
    dtbParamsReportsparamquery_id: TLargeintField;
    dtbParamsReportsreport_id: TLargeintField;
    dtbParamsReportssql_param: TStringField;
    dtbParamsReportsparamsqueries_name: TStringField;
    dtbParamsReportsDeviceName: TStringField;
    dtbParamsReportsspparam: TLargeintField;
    dtbParamsReportscanal: TLargeintField;
    dtbParamsReportsdescription: TStringField;
    tdbAllParamsparamquery_id: TLargeintField;
    tdbAllParamsparamsqueries_name: TStringField;
    tdbAllParamsDeviceName: TStringField;
    tdbAllParamsspparam: TLargeintField;
    tdbAllParamscanal: TLargeintField;
    tdbAllParamsdescription: TStringField;
    ActionCreaterSQL: TAction;
    SynSQLSyn: TSynSQLSyn;
    DBSQL: TDBSynEdit;
    Panel4: TPanel;
    CreaterSQLBtn: TSpeedButton;
    ShowSQLBtn: TSpeedButton;
    ImageList: TImageList;
    ComboSize: TComboBox;
    LabelSize: TLabel;
    UndoBtn: TSpeedButton;
    RedoBtn: TSpeedButton;
    SQLRedo: TAction;
    SQLUndo: TAction;
    dtbParamsReportssql_param_number: TLargeintField;
    HelpPic1: THelpPic;
    MdSplitter1: TMdSplitter;
    dtbReportsdata: TBlobField;
    OKBtn: TMdBitBtn;
    CancelBtn: TMdBitBtn;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridDBTableViewparamquery_id: TcxGridDBColumn;
    cxGridDBTableViewreport_id: TcxGridDBColumn;
    cxGridDBTableViewsql_param: TcxGridDBColumn;
    cxGridDBTableViewparamsqueries_name: TcxGridDBColumn;
    cxGridDBTableViewmeters_name: TcxGridDBColumn;
    cxGridDBTableViewspparam: TcxGridDBColumn;
    cxGridDBTableViewcanal: TcxGridDBColumn;
    cxGridDBTableViewdescription: TcxGridDBColumn;
    cxGridDBTableViewsql_param_number: TcxGridDBColumn;
    procedure ActionAddExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionDeleteUpdate(Sender: TObject);
    procedure dtbParamsReportsAfterOpen(DataSet: TDataSet);
    procedure dtbParamsReportsAfterRefresh(DataSet: TDataSet);
    procedure ActionCreaterSQLExecute(Sender: TObject);
    procedure ShowSQLBtnClick(Sender: TObject);
    procedure ComboSizeKeyPress(Sender: TObject; var Key: Char);
    procedure ComboSizeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboSizeChange(Sender: TObject);
    procedure SQLUndoExecute(Sender: TObject);
    procedure SQLRedoExecute(Sender: TObject);
    procedure SQLRedoUpdate(Sender: TObject);
    procedure SQLUndoUpdate(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; const AReportId : LongWord); reintroduce;
    destructor Destroy; override;
    function Execute : Boolean;
  end;

var
  FSQLMod: TFSQLMod;

implementation

uses dm_general, DBdata, QuerySearchList, SQLCreater, DialogsEx, Report;

{$R *.dfm}

{ TFSQLMod }

procedure TFSQLMod.ActionAddExecute(Sender: TObject);
var
  aGeneratedSQLParamName: string;
  oldRecNo, aMaxSQLParamIndex, p, n, V: Integer;
begin
  FQuerySearchList := TFQuerySearchList.Create(nil, tdbAllParams, 'paramquery_id');
  FQuerySearchList.Caption := 'Новый параметр запроса';
  try
    tdbAllParams.Close;
    tdbAllParams.ParamByName('report_id').AsInteger := dtbReports.FieldByName('report_id').AsInteger;
    tdbAllParams.Open;
    if FQuerySearchList.Execute then
    begin
      if tdbAllParams.FieldByName('paramquery_id').IsNull then Exit; //ничего не выбрано
      oldRecNo := dtbParamsReports.RecNo;
      dtbParamsReports.DisableControls;
      dtbParamsReports.First;
      aMaxSQLParamIndex := 0;
      while not dtbParamsReports.Eof do
      begin
        p := Pos('_', dtbParamsReports.FieldByName('sql_param').AsString);
        if p > 0 then
        begin
          n := Length(dtbParamsReports.FieldByName('sql_param').AsString) - p;
          V := StrToIntDef(Copy(dtbParamsReports.FieldByName('sql_param').AsString, p + 1, n), 0);
          if V > aMaxSQLParamIndex then
            aMaxSQLParamIndex := V;          
        end;
        dtbParamsReports.Next;
      end;
      dtbParamsReports.RecNo := oldRecNo;
      dtbParamsReports.EnableControls;
      aGeneratedSQLParamName := Format('P_%d', [aMaxSQLParamIndex + 1]);
      UDBData.AddParamQueryToReport(tdbAllParams.FieldByName('paramquery_id').AsInteger,
          dtbReports.FieldByName('report_id').AsInteger, aGeneratedSQLParamName);
      dtbParamsReports.Refresh;
      dtbParamsReports.Locate('sql_param', aGeneratedSQLParamName, [loCaseInsensitive]);
    end;
  finally
    tdbAllParams.Close;
    FQuerySearchList.Free;
  end;
end;

procedure TFSQLMod.ActionCreaterSQLExecute(Sender: TObject);
var
  i : Integer;
  SqlBuilded, SqlHourHead, SqlDayHead, SqlMonthHead,
  SqlHour, SqlDay, SqlMonth, SqlDayFooter : string;
begin
  FSQLCreater := TFSQLCreater.Create(nil);
  try
    if FSQLCreater.Execute then
    begin
      SqlHour := EmptyStr;
      SqlDay := EmptyStr;
      SqlDayFooter := EmptyStr;
      SqlMonth := EmptyStr;
      case FSQLCreater.SQLType of
         tSut : begin
              SqlHourHead := 'SELECT o.order';
              SqlDayHead := 'SELECT o.order';
              for i := 1 to FSQLCreater.RowCount do
              begin
                //hour
                SqlHour := Concat(SqlHour, #13#10,
                  Format(
                    'LEFT JOIN archivehours a%0:d ON a%0:d.hour = o.hour AND ' + #13#10 +
                    'a%0:d.year = YEAR(:d1) AND a%0:d.month = MONTH(:d1) AND a%0:d.day = DAY(:d1) AND a%0:d.paramquery_id = :P_%0:d',
                    [i]));
                SqlHourHead := SqlHourHead + Format(', a%0:d.value colv_%0:d', [i]);
                //day
                SqlDay := Concat(
                  SqlDay, #13#10,
                  Format('LEFT JOIN archivedays a%0:d ON a%0:d.day = o.order AND a%0:d.year = YEAR(:d1) AND a%0:d.month = MONTH(:d1) AND a%0:d.day = DAY(:d1) AND a%0:d.paramquery_ID = :P_%1:d',
                  [i, FSQLCreater.RowCount + i]));
                SqlDayHead := Concat(SqlDayHead, ', ', Format('a%0:d.value colv_%0:d', [i]));
              end;
              SqlHour := '<HOUR>' + #13#10 + SqlHourHead + ' FROM orders o ' + SqlHour + ' LIMIT 24' + #13#10 + '</HOUR>';
              SqlDay := '<DAY>'  + #13#10 + SqlDayHead + ' FROM orders o ' + SqlDay + ' WHERE o.order = DAY(:d1) LIMIT 1' + #13#10 + '</DAY>';
              SqlBuilded := SqlHour + #13#10 + SqlDay;
         end;
         tMonth : begin
              //реализовать конструктор
              SqlDayHead := 'SELECT o.order';
              SqlMonthHead := 'SELECT o.order';
              for i := 1 to FSQLCreater.RowCount do
              begin
                //day
                SqlDay := Concat(
                  SqlDay, #13#10,
                  Format('LEFT JOIN archivedays a%0:d ON a%0:d.day = o.order AND a%0:d.year = YEAR(:d1) AND a%0:d.month = MONTH(:d1) AND a%0:d.paramquery_ID = :P_%0:d',
                  [i, FSQLCreater.RowCount + i]));
                SqlDayHead := Concat(SqlDayHead, ', ', Format('a%0:d.value colv_%0:d', [i]));
                //month
                if SqlMonth <> EmptyStr then
                   SqlMonth := SqlMonth + #13#10;
                SqlMonth := Concat(SqlMonth, Format(
                  'LEFT JOIN archivemonthes a%0:d ON a%0:d.year = YEAR(:d1) AND a%0:d.month = MONTH(:d1) AND a%0:d.paramquery_id = :P_%1:d',
                  [i, FSQLCreater.RowCount + i]));
                SqlMonthHead := Concat(SqlMonthHead, ', ', Format('a%0:d.value colv_%0:d', [i]));
              end;
              SqlDay := '<DAY>'  + #13#10 + SqlDayHead + ' FROM orders o ' + SqlDay + SqlDayFooter + #13#10 + 'WHERE o.order <= DAY(LAST_DAY(:d1))' + #13#10 + '</DAY>';
              SqlMonth := '<MONTH> ' + #13#10 + SqlMonthHead + ' FROM orders o ' + #13#10 + SqlMonth + ' LIMIT 1' + #13#10 + '</MONTH>';
              SqlBuilded := SqlDay + #13#10 + SqlMonth;
         end;
         tYear : begin
            raise Exception.Create('Годовой конструктор не реализован.'); 
         end;
      end;
      DBSQL.Lines.Text := SqlBuilded;
    end;
  finally
    FSQLCreater.Free;
  end;
end;

procedure TFSQLMod.ActionDeleteExecute(Sender: TObject);
begin
  if _MessageBox(Handle, PChar('Вы уверены что хотите удалить?'),
        'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    UDBData.DeleteParamQueryFromReport(dtbParamsReports.FieldByName('paramquery_id').AsInteger,
        dtbParamsReports.FieldByName('report_id').AsInteger);
    dtbParamsReports.Refresh;
    dtbParamsReports.First;
  end;
end;

procedure TFSQLMod.ActionDeleteUpdate(Sender: TObject);
begin
  ActionDelete.Enabled := dtbParamsReports.RecordCount > 0;
end;

procedure TFSQLMod.ComboSizeChange(Sender: TObject);
begin
  DBSQL.Font.Size := StrToIntDef(ComboSize.Text, 10);
end;

procedure TFSQLMod.ComboSizeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TFSQLMod.ComboSizeKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

constructor TFSQLMod.Create(AOwner: TComponent; const AReportId : LongWord);
begin
  inherited Create(AOwner);
  dtbReports.Connection := UDM.MySQLConnection;
  dtbParamsReports.Connection := UDM.MySQLConnection;
  tdbAllParams.Connection := UDM.MySQLConnection;
  dtbReports.ParamByName('report_id').AsInteger := AReportId;
  dtbReports.Open;
  
  dtbParamsReports.Open;
  DBSQL.Visible := False;
  LabelSize.Visible := False;
  ComboSize.Visible := False;
  UndoBtn.Visible := False;
  RedoBtn.Visible := False;
end;

destructor TFSQLMod.Destroy;
begin
  dtbReports.Close;
  dtbParamsReports.Close;
  inherited Destroy;
end;

procedure TFSQLMod.dtbParamsReportsAfterOpen(DataSet: TDataSet);
begin
  LabelCount.Caption := IntToStr(dtbParamsReports.RecordCount);
end;

procedure TFSQLMod.dtbParamsReportsAfterRefresh(DataSet: TDataSet);
begin
  LabelCount.Caption := IntToStr(dtbParamsReports.RecordCount);
end;

function TFSQLMod.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
  if Result then
  begin
    try
      UDBData.UpdateSQLOfReport(dtbReports.FieldByName('report_id').AsInteger, DBSQL.Lines.Text);
      if UDBData.InTransaction then UDBData.ComitTransaction;
    except
      if UDBData.InTransaction then UDBData.RollBackTransaction;
    end;
  end else
    if UDBData.InTransaction then
      UDBData.RollBackTransaction;
end;

procedure TFSQLMod.ShowSQLBtnClick(Sender: TObject);
var
  Bitmap : TBitmap;
begin
  DBSQL.Visible := not DBSQL.Visible;
  LabelSize.Visible := DBSQL.Visible;
  ComboSize.Visible := DBSQL.Visible;
  UndoBtn.Visible := DBSQL.Visible;
  RedoBtn.Visible := DBSQL.Visible;
  Bitmap := TBitmap.Create;
  try
    if DBSQL.Visible then
      ImageList.GetBitmap(1, Bitmap)
    else
      ImageList.GetBitmap(0, Bitmap);
    ShowSQLBtn.Glyph.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

procedure TFSQLMod.SQLRedoExecute(Sender: TObject);
begin
  DBSQL.Redo;
end;

procedure TFSQLMod.SQLRedoUpdate(Sender: TObject);
begin
  SQLRedo.Enabled := DBSQL.RedoList.ItemCount > 0;
end;

procedure TFSQLMod.SQLUndoExecute(Sender: TObject);
begin
  DBSQL.Undo;
end;

procedure TFSQLMod.SQLUndoUpdate(Sender: TObject);
begin
  SQLUndo.Enabled := DBSQL.UndoList.ItemCount > 0;
end;

end.
