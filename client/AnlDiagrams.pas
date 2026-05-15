{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit AnlDiagrams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Buttons, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ExtCtrls,
  ActnList, HelpPic, MdExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, SPTForm;

type
  TModDiagrams = class(TSPTForm)
    dtbParams: TZReadOnlyQuery;
    dtbDiagrams: TZReadOnlyQuery;
    dtsDiagrams: TDataSource;
    dtbDiagramsdiagram_id: TLargeintField;
    dtbDiagramslvalue: TFloatField;
    dtbDiagramshvalue: TFloatField;
    dtbDiagramsname: TStringField;
    dtbDiagramsconsumerism_id: TLargeintField;
    dtbDiagramsdimensionname: TStringField;
    dtsParams: TDataSource;
    ActionList: TActionList;
    tdbAllParams: TZReadOnlyQuery;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Bevel1: TBevel;
    Panel6: TPanel;
    BtnAddDiagram: TSpeedButton;
    BtnDelDiagram: TSpeedButton;
    Panel7: TPanel;
    BtnAddParamDiagram: TSpeedButton;
    BtnDelParamDiagram: TSpeedButton;
    ActionAddDiagram: TAction;
    ActionDelDiagram: TAction;
    ActionModDiagram: TAction;
    ActionAddParam: TAction;
    ActionDelParam: TAction;
    ActionModParam: TAction;
    LabelCountDiagram: TLabel;
    LabelCountParams: TLabel;
    dtbParamsdiagram_id: TLargeintField;
    dtbParamsorder: TLargeintField;
    dtbParamscaption: TStringField;
    dtbParamscolor: TLargeintField;
    dtbParamswvalue: TFloatField;
    dtbParamsavalue: TFloatField;
    dtbParamsparamquery_id: TLargeintField;
    tdbAllParamsparamquery_id: TLargeintField;
    tdbAllParamsparamsqueries_name: TStringField;
    tdbAllParamsDeviceName: TStringField;
    tdbAllParamsspparam: TLargeintField;
    tdbAllParamscanal: TLargeintField;
    tdbAllParamsdescription: TStringField;
    dtbParamsspparam: TLargeintField;
    dtbParamscanal: TLargeintField;
    dtbParamsdescription: TStringField;
    dtbDiagramsanglelable: TIntegerField;
    BtnModDiagram: TSpeedButton;
    BtnModParamDiagram: TSpeedButton;
    HelpPic1: THelpPic;
    dtbParamspq_name: TStringField;
    dtbParamsm_name: TStringField;
    MdBitBtn1: TMdBitBtn;
    MdBitBtn2: TMdBitBtn;
    MdSplitter1: TMdSplitter;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1caption: TcxGridDBColumn;
    cxGrid1DBTableView1pq_name: TcxGridDBColumn;
    cxGrid1DBTableView1m_name: TcxGridDBColumn;
    cxGrid1DBTableView1diagram_id: TcxGridDBColumn;
    cxGrid1DBTableView1order: TcxGridDBColumn;
    cxGrid1DBTableView1color: TcxGridDBColumn;
    cxGrid1DBTableView1wvalue: TcxGridDBColumn;
    cxGrid1DBTableView1avalue: TcxGridDBColumn;
    cxGrid1DBTableView1paramquery_id: TcxGridDBColumn;
    cxGrid1DBTableView1spparam: TcxGridDBColumn;
    cxGrid1DBTableView1canal: TcxGridDBColumn;
    cxGrid1DBTableView1description: TcxGridDBColumn;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1diagram_id: TcxGridDBColumn;
    cxGrid2DBTableView1name: TcxGridDBColumn;
    cxGrid2DBTableView1lvalue: TcxGridDBColumn;
    cxGrid2DBTableView1hvalue: TcxGridDBColumn;
    cxGrid2DBTableView1consumerism_id: TcxGridDBColumn;
    cxGrid2DBTableView1dimensionname: TcxGridDBColumn;
    cxGrid2DBTableView1anglelable: TcxGridDBColumn;
    procedure DBGridDiagramscolorCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure ActionAddDiagramExecute(Sender: TObject);
    procedure ActionDelDiagramExecute(Sender: TObject);
    procedure ActionModDiagramExecute(Sender: TObject);
    procedure ActionAddParamExecute(Sender: TObject);
    procedure ActionDelParamExecute(Sender: TObject);
    procedure ActionModParamExecute(Sender: TObject);
    procedure DBGridDiagramsDblClick(Sender: TObject);
    procedure DBGridParamsDblClick(Sender: TObject);
    procedure dtbDiagramsAfterRefresh(DataSet: TDataSet);
    procedure dtbParamsAfterRefresh(DataSet: TDataSet);
    procedure dtbDiagramsAfterOpen(DataSet: TDataSet);
    procedure dtbParamsAfterOpen(DataSet: TDataSet);
    procedure ActionDelDiagramUpdate(Sender: TObject);
    procedure ActionModDiagramUpdate(Sender: TObject);
    procedure ActionDelParamUpdate(Sender: TObject);
    procedure ActionModParamUpdate(Sender: TObject);
    procedure DBGridParamscolorCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: string; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure ActionAddParamUpdate(Sender: TObject);
  private
    FConsId : LongWord;
  public
    function Execute : Boolean;
    constructor Create(AOwner: TComponent; const AConsId : LongWord); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses ModDiagram, QuerySearchList, dm_general, DBdata, ModParamDiagram;

{$R *.dfm}

procedure TModDiagrams.ActionAddDiagramExecute(Sender: TObject);
begin
  FModDiagram := TFModDiagram.Create(nil);
  FModDiagram.Caption := 'Создание новой диаграммы';
  with FModDiagram do
  try
    if Execute then
    begin
      UDBData.AddDiagram(LowValue, HighValue, FConsId, DiagramName, DimensionName, AngleLable);
      dtbDiagrams.Refresh;
      dtbDiagrams.Last;
    end;
  finally
    FModDiagram.Free;
  end;
end;

procedure TModDiagrams.ActionAddParamExecute(Sender: TObject);
begin
  FQuerySearchList := TFQuerySearchList.Create(nil, tdbAllParams, 'paramquery_id');
  FQuerySearchList.Caption := 'Новый параметр';
  try
    if not tdbAllParams.Active then
      tdbAllParams.Open;
    if FQuerySearchList.Execute then
    begin
      FParamDiagram := TFParamDiagram.Create(nil);
      if FParamDiagram.Execute then
      try
        UDBData.AddParamQueryToDiagram(
          dtbDiagrams.FieldByName('diagram_id').AsInteger,
          tdbAllParams.FieldByName('paramquery_id').AsInteger,
          FParamDiagram.ParamDiagramOrder,
          FParamDiagram.ParamDiagramColor,
          FParamDiagram.ParamDiagramCaption,
          FParamDiagram.ParamDiagramWarningValue,
          FParamDiagram.ParamDiagramAccidentValue);
        dtbParams.Refresh;
        dtbParams.Last;
      finally
        FParamDiagram.Free;
      end;
    end;
  finally
    tdbAllParams.Close;
    FQuerySearchList.Free;
  end;
end;

procedure TModDiagrams.ActionAddParamUpdate(Sender: TObject);
begin
  ActionAddParam.Enabled := dtbDiagrams.RecordCount > 0;
end;

procedure TModDiagrams.ActionDelDiagramExecute(Sender: TObject);
begin
  if MessageBox(Handle, 'Вы уверены что хотите удалить?',
        'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
//    UDBData.StartTransaction;
    UDBData.DeleteDiagram(dtbDiagrams.FieldByName('diagram_id').AsInteger);
    dtbDiagrams.Refresh;
    dtbDiagrams.First;
  end;
end;

procedure TModDiagrams.ActionDelDiagramUpdate(Sender: TObject);
begin
  ActionDelDiagram.Enabled := dtbDiagrams.RecordCount > 0;
end;

procedure TModDiagrams.ActionDelParamExecute(Sender: TObject);
begin
  if MessageBox(Handle, 'Вы уверены что хотите удалить?',
        'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
//    UDBData.StartTransaction;
    UDBData.DeleteParamQueryFromDiagram(
        dtbParams.FieldByName('diagram_id').AsInteger,
        dtbParams.FieldByName('paramquery_id').AsInteger);
    dtbParams.Refresh;
    dtbParams.First;
  end;
end;

procedure TModDiagrams.ActionDelParamUpdate(Sender: TObject);
begin
  ActionDelParam.Enabled := dtbParams.RecordCount > 0;
end;

procedure TModDiagrams.ActionModDiagramExecute(Sender: TObject);
var OldRecNo : Integer;
begin
 FModDiagram := TFModDiagram.Create(Self);
 FModDiagram.Caption := 'Редактирование свойст диаграммы';
 try
   FModDiagram.LowValue := dtbDiagrams.FieldByName('lvalue').AsFloat;
   FModDiagram.HighValue := dtbDiagrams.FieldByName('hvalue').AsFloat;
   FModDiagram.DiagramName := dtbDiagrams.FieldByName('name').AsString;
   FModDiagram.AngleLable := dtbDiagrams.FieldByName('anglelable').AsInteger;
   FModDiagram.DimensionName := dtbDiagrams.FieldByName('dimensionname').AsString;
   if FModDiagram.Execute then
   begin
     if not UDBData.InTransaction then
       UDBData.StartTransaction;
     UDBData.UpdateDiagram(
        dtbDiagrams.FieldByName('diagram_id').AsInteger,
        dtbDiagrams.FieldByName('consumerism_id').AsInteger,
        FModDiagram.LowValue,
        FModDiagram.HighValue,
        FModDiagram.DiagramName,
        FModDiagram.DimensionName,
        FModDiagram.AngleLable);
     OldRecNo := dtbDiagrams.RecNo;
     dtbDiagrams.Refresh;
     dtbDiagrams.RecNo := OldRecNo;
   end;
 finally
   FModDiagram.Free;
 end;
end;

procedure TModDiagrams.ActionModDiagramUpdate(Sender: TObject);
begin
  ActionModDiagram.Enabled := dtbDiagrams.RecordCount > 0;
end;

procedure TModDiagrams.ActionModParamExecute(Sender: TObject);
var OldRecNo : Integer;
begin
  FParamDiagram := TFParamDiagram.Create(nil);
  try
    FParamDiagram.ParamDiagramCaption := dtbParams.FieldByName('caption').AsString;
    FParamDiagram.ParamDiagramWarningValue := dtbParams.FieldByName('wvalue').AsFloat;
    FParamDiagram.ParamDiagramAccidentValue := dtbParams.FieldByName('avalue').AsFloat;
    FParamDiagram.ParamDiagramColor := dtbParams.FieldByName('color').AsInteger;
    FParamDiagram.ParamDiagramOrder := dtbParams.FieldByName('order').AsInteger;
    if FParamDiagram.Execute then
    begin
       UDBData.UpdateParamQueryOfDiagram(
          dtbParams.FieldByName('diagram_id').AsInteger,
          dtbParams.FieldByName('paramquery_id').AsInteger,
          FParamDiagram.ParamDiagramOrder,
          FParamDiagram.ParamDiagramColor,
          FParamDiagram.ParamDiagramCaption,
          FParamDiagram.ParamDiagramWarningValue,
          FParamDiagram.ParamDiagramAccidentValue);
       OldRecNo := dtbParams.RecNo;
       dtbParams.Refresh;
       dtbParams.RecNo := OldRecNo;
    end;
  finally
    FParamDiagram.Free;
  end;
end;

procedure TModDiagrams.ActionModParamUpdate(Sender: TObject);
begin
  ActionModParam.Enabled := dtbParams.RecordCount > 0;
end;

constructor TModDiagrams.Create(AOwner: TComponent; const AConsId : LongWord);
begin
  inherited Create(AOwner);
  dtbDiagrams.Connection := UDM.MySQLConnection;
  dtbParams.Connection := UDM.MySQLConnection;
  tdbAllParams.Connection := UDM.MySQLConnection;
  FConsId := AConsId;
  dtbDiagrams.ParamByName('consumerism_id').AsInteger := FConsId;
  dtbDiagrams.Open;
  dtbParams.Open;
end;

destructor TModDiagrams.Destroy;
begin
  dtbParams.Close;
  dtbDiagrams.Close;
  inherited;
end;

procedure TModDiagrams.dtbDiagramsAfterOpen(DataSet: TDataSet);
begin
  LabelCountDiagram.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TModDiagrams.dtbDiagramsAfterRefresh(DataSet: TDataSet);
begin
  LabelCountDiagram.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TModDiagrams.dtbParamsAfterOpen(DataSet: TDataSet);
begin
  LabelCountParams.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TModDiagrams.dtbParamsAfterRefresh(DataSet: TDataSet);
begin
  LabelCountParams.Caption := IntToStr(DataSet.RecordCount);
end;

procedure TModDiagrams.DBGridDiagramscolorCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  AColor := StrToIntDef(AText, TColor(clWhite));
end;

procedure TModDiagrams.DBGridDiagramsDblClick(Sender: TObject);
begin
  ActionModDiagram.Execute;
end;

procedure TModDiagrams.DBGridParamscolorCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: string; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
begin
  AColor := StrToIntDef(AText, TColor(clWhite));
end;

procedure TModDiagrams.DBGridParamsDblClick(Sender: TObject);
begin
  ActionModParam.Execute;
end;

function TModDiagrams.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
  if UDBData.InTransaction then
    if not Result then
      UDBData.RollBackTransaction
    else
      UDBData.ComitTransaction;
end;

end.
