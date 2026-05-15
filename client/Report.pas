{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, dm_general, ComCtrls,
  Grids, DBGrids, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid,
  dxCntner, frxClass, frxDBSet, frxPreview, frxDesgn, ExtCtrls, StdCtrls, Menus, DateUtils,
  RxMemDS, CreateReportTreeElement, frxDMPExport, frxExportODF, frxExportPDF,
  frxExportXML, frxExportXLS, frxExportHTML, frxExportText, frxExportRTF,
  frxExportImage, globalvars, frxBarcode, SPTForm;

type
  TReportFilter = class(TObject)
    ReportId : LongWord;
    ReportType : TReportTreeElement;
    Date : TDateTime;
    Tag : Longword;
  public
    procedure Assign(aReportFilter : TReportFilter);
  end;

  TReport = class(TSPTForm)
    frxReport: TfrxReport;
    frxArchiveDays: TfrxDBDataset;
    frxDesigner: TfrxDesigner;
    dtbReports: TZQuery;
    dtbReportsreport_id: TLargeintField;
    dtbReportsdata: TBlobField;
    dtbReportssql: TMemoField;
    dtbArchiveDays: TZReadOnlyQuery;
    dtbArchiveHours: TZReadOnlyQuery;
    dtbArchiveMonthes: TZReadOnlyQuery;
    frxArchiveHours: TfrxDBDataset;
    frxArchiveMonthes: TfrxDBDataset;
    dtbparamsreports: TZReadOnlyQuery;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxRTFExport1: TfrxRTFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxXLSExport1: TfrxXLSExport;
    frxXMLExport1: TfrxXMLExport;
    frxPDFExport1: TfrxPDFExport;
    frxODSExport1: TfrxODSExport;
    frxODTExport1: TfrxODTExport;
    function frxDesignerSaveReport(Report: TfrxReport;
      SaveAs: Boolean): Boolean;
    procedure frxDesignerShow(Sender: TObject);
    function frxReportUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    FDate : TDateTime;
    FLastStreamReport : TMemoryStream;
    FTitleReportName : string;
    function GetDelemiterSQL(const aStartDelemiterText, aEndDelemiterText, aText : string) : string;
  public
    constructor Create(AOwner : TComponent; APreview: TfrxPreview); reintroduce;
    destructor Destroy; override;
    function Preview(const aReportFilter : TReportFilter) : Boolean;
    function DesignReport(const reportId : LongWord; const reportName : string) : LongWord;
    procedure ExportToBMP;
    procedure ExportToJPEG;
    procedure ExportToTIFF;
    procedure ExportToRTE;
    procedure ExportToTEXT;
    procedure ExportToXLS;
    procedure ExportToXML;
    procedure ExportToPDF;
    procedure ExportToODS;
    procedure ExportToODT;
    procedure ExportToHTML;
    function GetDescriptionBMP : string;
    function GetDescriptionJPEG : string;
    function GetDescriptionTIFF : string;
    function GetDescriptionWORD : string;
    function GetDescriptionTEXT : string;
    function GetDescriptionXLS : string;
    function GetDescriptionXML : string;
    function GetDescriptionPDF : string;
    function GetDescriptionODS : string;
    function GetDescriptionODT : string;
    function GetDescriptionHTML : string;
  end;
  
var FReport : TReport;

implementation

uses frxRes, DBdata, DialogsEx;

{$R *.dfm}

constructor TReport.Create(AOwner: TComponent; APreview: TfrxPreview);
begin
  inherited Create(AOwner);
  frxReport.Preview := APreview;
  FLastStreamReport := TMemoryStream.Create;
  dtbArchiveHours.Connection := UDM.MySQLConnection;
  dtbArchiveDays.Connection := UDM.MySQLConnection;
  dtbArchiveMonthes.Connection := UDM.MySQLConnection;
  dtbReports.Connection := UDM.MySQLConnection;
  dtbparamsreports.Connection := UDM.MySQLConnection;
  //отключаю глобальное отображение frxDataSet
  frxReport.EngineOptions.UseGlobalDataSetList := False;
  frxReport.EnabledDataSets.Clear;
  frxReport.EnabledDataSets.Add(frxArchiveHours);
  frxReport.EnabledDataSets.Add(frxArchiveDays);
  frxReport.EnabledDataSets.Add(frxArchiveMonthes);
end;

destructor TReport.Destroy;
begin
  frxReport.Preview := nil;
  dtbArchiveHours.Close;
  dtbArchiveDays.Close;
  dtbArchiveMonthes.Close;
  dtbparamsreports.Close;
  dtbReports.Close;
  FLastStreamReport.Free;
  inherited Destroy;
end;

procedure TReport.ExportToBMP;
begin
  if frxReport.Export(frxBMPExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToHTML;
begin
  if frxReport.Export(frxHTMLExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToJPEG;
begin
  if frxReport.Export(frxJPEGExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToODS;
begin
  if frxReport.Export(frxODSExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToODT;
begin
  if frxReport.Export(frxODTExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToPDF;
begin
  if frxReport.Export(frxPDFExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToTEXT;
begin
  if frxReport.Export(frxSimpleTextExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToTIFF;
begin
  if frxReport.Export(frxSimpleTextExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToRTE;
begin
  if frxReport.Export(frxRTFExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToXLS;
begin
  if frxReport.Export(frxXLSExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

procedure TReport.ExportToXML;
begin
  if frxReport.Export(frxXMLExport1) then
  begin
    frxReport.Preview.RefreshReport;
    _MessageBox(Handle, PChar('Экспорт завершен'), 'Предупреждение', MB_YESNO + MB_ICONQUESTION);
  end;
end;

function TReport.DesignReport(const reportId : LongWord; const reportName : string) : LongWord;
var AZQuery : TZQuery;
    MainSQL : string;
    aStreamReport : TMemoryStream;
    newReportId : LongWord;
    newReport : Boolean;
begin
  Result := reportId;
  frxReport.Clear;
  FLastStreamReport.Clear;
  newReport := reportId = 0;
  if not newReport then
  begin
    aStreamReport := TMemoryStream.Create;
    try
      if dtbReports.Active then dtbReports.Close;
      dtbReports.ParamByName('report_id').AsInteger := reportId;
      dtbReports.Open;
      TBlobField(dtbReports.FieldByName('data')).SaveToStream(aStreamReport);
      MainSQL := dtbReports.FieldByName('sql').AsString;
      //close
      if dtbReports.Active then
        dtbReports.Close;
      if dtbArchiveDays.Active then
        dtbArchiveDays.Close;
      if dtbArchiveMonthes.Active then
        dtbArchiveMonthes.Close;
      //sql
      dtbArchiveHours.SQL.Text := GetDelemiterSQL('<HOUR>', '</HOUR>', MainSQL);
      dtbArchiveDays.SQL.Text := GetDelemiterSQL('<DAY>', '</DAY>', MainSQL);
      dtbArchiveMonthes.SQL.Text := GetDelemiterSQL('<MONTH>', '</MONTH>', MainSQL);
      //open
      if dtbArchiveHours.SQL.Text <> EmptyStr then
        dtbArchiveHours.Open;
      if dtbArchiveDays.SQL.Text <> EmptyStr then
        dtbArchiveDays.Open;
      if dtbArchiveMonthes.SQL.Text <> EmptyStr then
        dtbArchiveMonthes.Open;
      aStreamReport.Position := 0;
      frxReport.LoadFromStream(aStreamReport);
      FTitleReportName := reportName;
    finally
      aStreamReport.Free;
    end;
  end;
  frxReport.EngineOptions.DestroyForms := False;
  frxReport.DesignReport(True);
  if dtbReports.Active then dtbReports.Close;
  if not newReport then
  begin
    dtbReports.ParamByName('report_id').AsInteger := reportId;
    dtbReports.Open;
    dtbReports.Edit;
    UDBData.UpdateModUserNameOfReport(reportId, UDM.User);
  end else begin
    dtbReports.Open;
    dtbReports.Insert;
  end;
  FLastStreamReport.Position := 0;
  TBlobField(dtbReports.FieldByName('data')).LoadFromStream(FLastStreamReport);
  dtbReports.Post;
  dtbReports.Close;
  if newReport then
  begin
    AZQuery := UDM.CreateDataSet('SELECT LAST_INSERT_ID() LAST_INSERT_ID') as TZQuery;
    AZQuery.Open;
    try
      newReportId := AZQuery.FieldByName('LAST_INSERT_ID').AsInteger;
      UDBData.UpdateCreateUserNameOfReport(newReportId, UDM.User);
      UDBData.UpdateModUserNameOfReport(newReportId, UDM.User);
      AZQuery.Close;
    finally
      AZQuery.Free;
    end;
    Result := newReportId;
  end;
  if UDBData.InTransaction then
    UDBData.ComitTransaction;
end;

function TReport.frxDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
var DesignerForm : TfrxDesignerForm;
begin
  if SaveAs then
  begin
     DesignerForm := TfrxDesignerForm(frxReport.Designer);
     DesignerForm.SaveFile(True, False);
  end else begin
    FLastStreamReport.Clear;
    frxReport.SaveToStream(FLastStreamReport);
    DesignerForm.SaveCmd.Enabled := False;
  end;
end;

procedure TReport.frxDesignerShow(Sender: TObject);
var DesignerForm : TfrxDesignerForm;
begin
  FLastStreamReport.Clear;
  frxReport.SaveToStream(FLastStreamReport); //сохр. первонач. отчет
  DesignerForm := TfrxDesignerForm(frxReport.Designer);
  DesignerForm.Caption := 'MDClient - ' + FTitleReportName;
  DesignerForm.HelpMenu.Visible := False;
end;

function TReport.frxReportUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  if AnsiUpperCase(MethodName) = 'GETDATETIME' then
    Result := FormatDateTime('dd.MM.yyyy', FDate)
  else
  if AnsiUpperCase(MethodName) = 'GETMONTHNAME' then
    Result := LongMonthNames[MonthOf(FDate)];
end;

function TReport.GetDelemiterSQL(const aStartDelemiterText, aEndDelemiterText, aText : string) : string;
var sp, ep, nd : Integer;
begin
  Result := EmptyStr;
  sp := Pos(aStartDelemiterText, aText);
  ep := Pos(aEndDelemiterText, aText);
  nd := Length(aStartDelemiterText);
  if ep > sp then
     Result := Trim(System.Copy(aText, sp + nd, ep - sp - nd));
end;

function TReport.GetDescriptionBMP: string;
begin
  Result := frxBMPExport1.GetDescription;
end;

function TReport.GetDescriptionHTML: string;
begin
  Result := frxHTMLExport1.GetDescription;
end;

function TReport.GetDescriptionJPEG: string;
begin
  Result := frxJPEGExport1.GetDescription;
end;

function TReport.GetDescriptionODS: string;
begin
  Result := frxODSExport1.GetDescription;
end;

function TReport.GetDescriptionODT: string;
begin
  Result := frxODTExport1.GetDescription;
end;

function TReport.GetDescriptionPDF: string;
begin
  Result := frxPDFExport1.GetDescription;
end;

function TReport.GetDescriptionTEXT: string;
begin
  Result := frxSimpleTextExport1.GetDescription;
end;

function TReport.GetDescriptionTIFF: string;
begin
  Result := frxTIFFExport1.GetDescription;
end;

function TReport.GetDescriptionWORD: string;
begin
  Result := frxRTFExport1.GetDescription;
end;

function TReport.GetDescriptionXLS: string;
begin
  Result := frxXLSExport1.GetDescription;
end;

function TReport.GetDescriptionXML: string;
begin
  Result := frxXMLExport1.GetDescription;
end;

function TReport.Preview(const aReportFilter : TReportFilter) : Boolean;
var B : Boolean;
    MainSQL : string;
    aStreamReport : TMemoryStream;

    procedure Fill_DATETIME(const aZDataSet : TZReadOnlyQuery; aRF : TReportFilter);
    begin
      //полная дата
      if aZDataSet.Params.FindParam('d1') <> nil then
        aZDataSet.ParamByName('d1').AsDateTime := aRF.Date;
    end;

    procedure Fill_SQL_Param(aWrite, aRead : TZReadOnlyQuery);
    var aParam : TParam;
    begin
      aRead.First;
      while not aRead.Eof do
      begin
        aParam := aWrite.Params.FindParam(aRead.FieldByName('sql_param').AsString);
        if aParam <> nil then
          aParam.AsInteger := aRead.FieldByName('paramquery_id').AsInteger;
        aRead.Next;
      end;
    end;

begin
  B := False;
  FDate := aReportFilter.Date;
  if dtbReports.Active then dtbReports.Close;
  dtbReports.ParamByName('report_id').AsInteger := aReportFilter.ReportId;
  aStreamReport := TMemoryStream.Create;
  try
    dtbReports.Open;
    if dtbReports.IsEmpty or dtbReports.FieldByName('data').IsNull then Exit;
    TBlobField(dtbReports.FieldByName('data')).SaveToStream(aStreamReport);
    aStreamReport.Position := 0;
    frxReport.LoadFromStream(aStreamReport);
    B := True;
    MainSQL := dtbReports.FieldByName('sql').AsString;
    if B and (MainSQL <> EmptyStr) then
    begin
      //close
      if dtbArchiveHours.Active then
        dtbArchiveHours.Close;
      if dtbArchiveDays.Active then
        dtbArchiveDays.Close;
      if dtbArchiveMonthes.Active then
        dtbArchiveMonthes.Close;
      //sql
      dtbArchiveHours.SQL.Text := GetDelemiterSQL('<HOUR>', '</HOUR>', MainSQL);
      dtbArchiveDays.SQL.Text := GetDelemiterSQL('<DAY>', '</DAY>', MainSQL);
      dtbArchiveMonthes.SQL.Text := GetDelemiterSQL('<MONTH>', '</MONTH>', MainSQL);
      //заполняю параметры, относящиеся ко времени
      Fill_DATETIME(dtbArchiveHours, aReportFilter);
      Fill_DATETIME(dtbArchiveDays, aReportFilter);
      Fill_DATETIME(dtbArchiveMonthes, aReportFilter);
      if dtbparamsreports.Active then dtbparamsreports.Close;
      dtbparamsreports.ParamByName('report_id').AsInteger := dtbReports.FieldByName('report_id').AsInteger;
      dtbparamsreports.Open;
      //заполняю параметры, относящиеся к самим параметрам 
      Fill_SQL_Param(dtbArchiveHours, dtbparamsreports);
      Fill_SQL_Param(dtbArchiveDays, dtbparamsreports);
      Fill_SQL_Param(dtbArchiveMonthes, dtbparamsreports);
      //open
      if dtbArchiveHours.SQL.Text <> EmptyStr then
        dtbArchiveHours.Open;
      if dtbArchiveDays.SQL.Text <> EmptyStr then
        dtbArchiveDays.Open;
      if dtbArchiveMonthes.SQL.Text <> EmptyStr then
        dtbArchiveMonthes.Open;
    end;
    frxReport.OldStyleProgress := True;
    //добавляю процедупы, которые используются в отчетах
    frxReport.AddFunction('procedure GetDateTime()');
    frxReport.AddFunction('procedure GetMonthName()');
    frxReport.ShowReport;
    dtbReports.Close;
  finally
    aStreamReport.Free;
    Result := B;
  end;
end;

procedure TReportFilter.Assign(aReportFilter: TReportFilter);
begin
  ReportId := aReportFilter.ReportId;
  ReportType := aReportFilter.ReportType;
  Date := aReportFilter.Date;
  Tag := aReportFilter.Tag;
end;

end.
