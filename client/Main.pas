{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Series, StdCtrls, DBdata, ZDataset,
  dxExEdtr, dxCntner, dxTL, DB, TeeFunci, DbChart, ZAbstractRODataset,
  ZAbstractDataset, dm_general, Grids, DBGrids, ZAbstractTable, RxMemDS,
  dxDBCtrl, dxDBGrid, Menus, Buttons, ActnList, ColorGrd, ComCtrls,
  frxClass, frxPreview, TeePrevi,
  ButtonGroup, CategoryButtons, ImgList, ActnMan, ActnColorMaps, ToolWin,
  dxBar, IniFiles, TeeTools, TeePageNumTool, AppEvnts, bsSkinHint, ShellAPI,
  bsSkinCtrls, StatChar, TeeDownSampling, TeeXML, TeeDBEdit, TeeDBCrossTab, TeeURL,
  TeeSeriesTextEd, TeeSurfaceTool, TeeSeriesBandTool, TeeDragPoint,
  TeeDataTableTool, TeeGanttTool, TeeSelectorTool, TeeLegendScrollBar,
  TeeExtraLegendTool, TeeChartGrid, frxChart, frxDBSet, fs_iinterpreter, fs_ichartrtti,
  TeeSurfa, Contnrs, Lists, WinSock, CreateReportTreeElement,
  CreateAnalogTreeElement, dxDBTLCl, dxGrClms, globalvars, bsCalendar,
  bsSkinTabs, SountUtils, MdExtCtrls, AlarmForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, cxClasses, cxPC, SpDesignPanel,
  cxCustomData, cxStyles, cxTL, cxTextEdit, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  SCADAEditor, FlexBase, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox, SPTForm;

const
  //константы определяющие вид архивного графика на вкладке АРХИВ
  ARCHIVE_MIN_LEFT_AXIS = 1;
  ARCHIVE_MAX_LEFT_AXIS = 100;
  ARCHIVE_MIN_BOTTOM_AXIS = 1;
  ARCHIVE_STEP_RIGHT_SCROLL = 10;
  ARCHIVE_STEP_BOTTOM_SCROLL = 10;
  //файл экспорта данных диаграммы архивных показаний
  EXPORT_FILE_NAME = 'export.txt';
  //имя раздела файла конфигурации в котором хранятся свойства отображения диаграмм
  PROPERTY_DIAGRAM_KEY = 'DP';
  //формат строки, под которым хранятся позиции и размеры диаграмм (ХОСТ ID {Left, Top, Width, Height})
  DIAGRAM_POSITION_VAL = '%s %d %s';

type
  EMain = class(Exception);

  TBarSeriesE = class;

  TTabs = record
    Plan: Boolean;
    Archive: Boolean;
    Reports: Boolean;
  end;

  //измерение
  TDimensionParam = class
  private
    FID: Longint;
    FHistory: TObjectList;
    FMin: Double;
    FMax: Double;
    FCurrent: Double;
    FWarning: Double;
    FEmergency: Double;
    FColor: TColor;
    FDimensionName: string;
    FDeviceName: string;
    FCanal: Integer;
    FSelected: Boolean;
    FCaption: string;
  public
    property ID: Longint read FID write FID;
    property History: TObjectList read FHistory write FHistory;
    property Min: Double read FMin write FMin;
    property Max: Double read FMax write FMax;
    property Current: Double read FCurrent write FCurrent;
    property Warning: Double read FWarning write FWarning;
    property Emergency: Double read FEmergency write FEmergency;
    property Color: TColor read FColor write FColor;
    property DimensionName: string read FDimensionName write FDimensionName;
    property DeviceName: string read FDeviceName write FDeviceName;
    property Canal: Integer read FCanal write FCanal;
    property Selected: Boolean read FSelected write FSelected;
    property Caption: string read FCaption write FCaption;
    constructor Create; virtual;
    destructor Destroy; virtual;
  end;

  //диаграмма
  TChartE = class(TChart)
  private
    FID: Longint;
    function GetSelected(Index: Integer): Boolean;
    procedure SetSelected(Index: Integer; const Value: Boolean);
    function GetSelectedCount: Integer;
  public
    //серия значений
    function ValueSeries: TBarSeriesE;
    //серия максимального показания, только для вида
    function MaxValueSeries: TBarSeriesE;
    //очистить выделенные серии
    procedure ClearSelection;
    //выделенные элементы серии
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    //кол выделенных элементов
    property SelectedCount: Integer read GetSelectedCount;
    property ID: Longint read FID write FID;
  end;

  //свойства графика справа на вкладке архив выбранных параметров 
  TDimensionSeries = class(TDimensionParam)
  private
    FSeries: TChartSeries;
  public
    property Series: TChartSeries read FSeries write FSeries;
  end;

  //bar на диаграмме
  TBarSeriesE = class(TBarSeries)
  private
    FBarsList: TObjectList;
    function GetBar(Index: Integer): TDimensionParam;
    procedure SetBar(Index: Integer; const Value: TDimensionParam);
  public
    property Bars[Index: Integer]: TDimensionParam read GetBar write SetBar;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    function AddBar(const aValue: Double; const aLabel: string;
      const aColor: TColor; DimensionParam: TDimensionParam): Integer;
    function IndexOf(const aId: LongWord): Integer;
  published
    property Marks;
  end;

  TLineSeriesE = class(TLineSeries)
  private
    FID: Longint;
  public
    property ID: Longint read FID write FID;
  end;

  //элемент дерева
  TPlanNodeClass = class
  private
    FID: LongWord;
    FTreeElement: TPlanTreeElement;
  public
    property ID: LongWord read FID;
    constructor Create(const aID: LongWord; const aTreeElement: TPlanTreeElement);
    property TreeElement: TPlanTreeElement read FTreeElement;
  end;

  //элемент дерева
  TReportNodeClass = class
  private
    FID: LongWord;
    FTreeElement: TReportTreeElement;
    FReportID: LongWord;
  public
    property ID: LongWord read FID;
    constructor Create(const aID: LongWord; const aTreeElement: TReportTreeElement);
    property TreeElement: TReportTreeElement read FTreeElement;
    property ReportID: LongWord read FReportID write FReportID;
  end;

  TMain = class(TSPTForm)
    PlanTimer: TTimer;
    PrinterSetupDialog: TPrinterSetupDialog;
    Actions: TActionList;
    PrintArchive: TAction;
    StretchRight: TAction;
    StretchTop: TAction;
    ResetArchiveView: TAction;
    ReportPrint: TAction;
    ReportDesignAction: TAction;
    ImgPlanTree: TImageList;
    Panel5: TPanel;
    dxBarManager: TdxBarManager;
    N1: TdxBarButton;
    ImgPageControl: TImageList;
    ImgSutArchMod: TImageList;
    ActionOpenArchive: TAction;
    ImgReportTree: TImageList;
    ImgReportMod: TImageList;
    PlanAddNode: TAction;
    AnalogDeleteNode: TAction;
    AnalogModNode: TAction;
    AnalogModDiagrams: TAction;
    ReportAddNode: TAction;
    ReportDeleteNode: TAction;
    ReportModNode: TAction;
    PlanMenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    ReportMenu: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    N5: TMenuItem;
    FullForm: TAction;
    ReportFullForm: TAction;
    AnalogCollapse: TAction;
    AnalogExpand: TAction;
    ReportCollapse: TAction;
    ReportExpand: TAction;
    N3: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N7: TMenuItem;
    N11: TMenuItem;
    Panel: TPanel;
    LabelConnection: TLabel;
    ReportSQL: TAction;
    NarrowRight: TAction;
    NarrowTop: TAction;
    ShowScaleMarksArchive: TAction;
    AnalogfrxReport: TfrxReport;
    RxArchiveDisplayParams: TRxMemoryData;
    frxDisplayParams: TfrxDBDataset;
    paramquery_name: TStringField;
    DeviceName: TStringField;
    SPParam: TStringField;
    Canal: TStringField;
    dtsRxDisplayParams: TDataSource;
    Description: TStringField;
    unitSN: TStringField;
    RxArchiveDisplayParamshvalue: TStringField;
    RxArchiveDisplayParamsOrderNumber: TIntegerField;
    RxArchiveDisplayParamslvalue: TStringField;
    RxArchiveDisplayParamsParamqueryId: TIntegerField;
    TreeManage: TImageList;
    N2: TMenuItem;
    N4: TMenuItem;
    SQL1: TMenuItem;
    dxBarBtnAnalog: TdxBarButton;
    dxBarBtnArchive: TdxBarButton;
    dxBarBtnReports: TdxBarButton;
    dxBarSettings: TdxBarButton;
    ActionSettings: TAction;
    RxArchiveDisplayParamsBooShowSeries: TBooleanField;
    RxArchiveDisplayParamscolor: TIntegerField;
    StretchLeft: TAction;
    NarrowLeft: TAction;
    StretchBottom: TAction;
    NarrowBottom: TAction;
    ReportExport: TAction;
    ExportMenu: TPopupMenu;
    BMP1: TMenuItem;
    JPEG1: TMenuItem;
    TIFF1: TMenuItem;
    WORD1: TMenuItem;
    TEXT1: TMenuItem;
    XLS1: TMenuItem;
    XML1: TMenuItem;
    PDF1: TMenuItem;
    ODS1: TMenuItem;
    ODT1: TMenuItem;
    HTML1: TMenuItem;
    AnalogSearch: TAction;
    ReportSearch: TAction;
    DragScalePointArchive: TAction;
    ReportlFromArchive: TAction;
    PrintIncludeScaleArchive: TAction;
    ExportArchiveData: TAction;
    AlertArchive: TAction;
    dxBarShowAlertArchive: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    ActionCheckedArchiveParams: TAction;
    ImageList: TImageList;
    PlanSaveAll: TAction;
    PageControl: TcxPageControl;
    cxTabSheet_1: TcxTabSheet;
    cxTabSheet_2: TcxTabSheet;
    cxTabSheet_3: TcxTabSheet;
    PanelAnalogTree: TPanel;
    ToolBarAnalogTree: TToolBar;
    AnalogTreeToolBtnAdd: TToolButton;
    AnalogTreeToolBtnDel: TToolButton;
    AnalogTreeToolBtnMod: TToolButton;
    ToolButton6: TToolButton;
    PlanTree: TcxTreeList;
    AnalogTreeColumn1: TcxTreeListColumn;
    AnalogTreeColumn2: TcxTreeListColumn;
    MdSplitter1: TMdSplitter;
    Panel3: TPanel;
    MdSplitter2: TMdSplitter;
    ProductInfo: TLabel;
    BarDiagrams: TToolBar;
    ToolButton29: TToolButton;
    ToolButton20: TToolButton;
    SaveAllBtn: TToolButton;
    RollPanel: TbsSkinPaintPanel;
    cxPageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    CurrentBarInfoValueLabel: TLabel;
    CurrentBarInfoValue: TLabel;
    MinBarInfoValue: TLabel;
    MaxBarInfoValue: TLabel;
    BarInfoDeviceName: TLabel;
    CanalBarInfo: TLabel;
    MinBarInfoValueLabel: TLabel;
    MaxBarInfoValueLabel: TLabel;
    BarInfoDeviceNameLabel: TLabel;
    CanalBarInfoLabel: TLabel;
    cxTabSheet2: TcxTabSheet;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ChartInfoBarArchive: TChart;
    ToolBar2: TToolBar;
    ToolBtnOpenArchive: TToolButton;
    ToolBtnPrintArchive: TToolButton;
    ToolBtnResetArchive: TToolButton;
    ToolBtnShowMarksArchive: TToolButton;
    ToolBtnDragPointArchive: TToolButton;
    ToolBtnPrintScaleArchive: TToolButton;
    ToolBtnExportDataArchive: TToolButton;
    PanelCrossValue: TPanel;
    TagCrossTime: TLabel;
    ScrollBox2: TScrollBox;
    PanelCrossValues: TPanel;
    MdSplitter5: TMdSplitter;
    PanelChart: TPanel;
    ArchiveChart: TChart;
    ChartDragPointTool: TDragPointTool;
    PanelBottomAnalogScroll: TPanel;
    BtnSRight: TSpeedButton;
    BtnNRight: TSpeedButton;
    BtnSLeft: TSpeedButton;
    BtnNLeft: TSpeedButton;
    BottomScroll: TScrollBar;
    PanelRightAnalogScroll: TPanel;
    BtnSBottom: TSpeedButton;
    BtnNBottom: TSpeedButton;
    BtnSTop: TSpeedButton;
    BtnNTop: TSpeedButton;
    RightScroll: TScrollBar;
    MdSplitter3: TMdSplitter;
    PanelTreeReport: TPanel;
    ToolBarReportTree: TToolBar;
    ReportTreeToolBtnAdd: TToolButton;
    ReportTreeToolBtnDel: TToolButton;
    ReportTreeToolBtnMod: TToolButton;
    ToolButton7: TToolButton;
    PanelFromArchive: TPanel;
    bsSkinMonthCalendar: TbsSkinMonthCalendar;
    ReportTree: TcxTreeList;
    dxTLReportColumn1: TcxTreeListColumn;
    dxTLReportColumn2: TcxTreeListColumn;
    MdSplitter4: TMdSplitter;
    ScrollBox1: TScrollBox;
    FRPreview: TfrxPreview;
    PanelReportInfo: TPanel;
    Label1: TLabel;
    ToolBar6: TToolBar;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton13: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    bsSkinPaintPanel1: TbsSkinPaintPanel;
    Panel2: TPanel;
    SelectAllBtn: TMdBitBtn;
    GridDisplayParams: TcxGrid;
    GridDisplayParamsDBTableView: TcxGridDBTableView;
    GridDisplayParamsDBTableViewparamquery_id: TcxGridDBColumn;
    GridDisplayParamsDBTableViewBooShowSeries: TcxGridDBColumn;
    GridDisplayParamsDBTableViewOrderNumber: TcxGridDBColumn;
    GridDisplayParamsDBTableViewcolor: TcxGridDBColumn;
    GridDisplayParamsDBTableViewparamquery_name: TcxGridDBColumn;
    GridDisplayParamsDBTableViewMeterName: TcxGridDBColumn;
    GridDisplayParamsDBTableViewSPParam: TcxGridDBColumn;
    GridDisplayParamsDBTableViewCanal: TcxGridDBColumn;
    GridDisplayParamsDBTableViewDescription: TcxGridDBColumn;
    GridDisplayParamsDBTableViewlvalue: TcxGridDBColumn;
    GridDisplayParamsDBTableViewhvalue: TcxGridDBColumn;
    GridDisplayParamsDBTableViewunitSN: TcxGridDBColumn;
    GridDisplayParamsLevel: TcxGridLevel;
    ScrollBox3: TScrollBox;
    SpDesignArea: TSpDesignPanel;
    DesignAreaBtn: TToolButton;
    DesignArea: TAction;
    Panel1: TPanel;
    OpenDialog: TOpenDialog;
    ToolButton1: TToolButton;
    LoadPlan: TAction;
    PlanLastUpdateLabel: TLabel;
    procedure PlanTimerTimer(Sender: TObject);
    procedure ReportPrintExecute(Sender: TObject);
    procedure ReportPrintUpdate(Sender: TObject);
    procedure ReportDesignActionExecute(Sender: TObject);
    procedure ArchiveChartAfterDraw(Sender: TObject);
    procedure DisplayValuesBeforeDrawButton(Sender: TObject; Index: Integer;
      Canvas: TCanvas; Rect: TRect; State: TButtonDrawState);
    procedure StretchRightExecute(Sender: TObject);
    procedure StretchTopExecute(Sender: TObject);
    procedure ResetArchiveViewExecute(Sender: TObject);
    procedure PrintArchiveExecute(Sender: TObject);
    procedure PrintArchiveUpdate(Sender: TObject);
    procedure ResetArchiveViewUpdate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ActionOpenArchiveExecute(Sender: TObject);
    procedure ReportDesignActionUpdate(Sender: TObject);
    procedure Panel3DockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure PlanAddNodeExecute(Sender: TObject);
    procedure AnalogDeleteNodeExecute(Sender: TObject);
    procedure AnalogModNodeExecute(Sender: TObject);
    procedure AnalogModDiagramsExecute(Sender: TObject);
    procedure ReportAddNodeExecute(Sender: TObject);
    procedure ReportDeleteNodeExecute(Sender: TObject);
    procedure ReportModNodeExecute(Sender: TObject);
    procedure PlanAddNodeUpdate(Sender: TObject);
    procedure AnalogDeleteNodeUpdate(Sender: TObject);
    procedure AnalogModDiagramsUpdate(Sender: TObject);
    procedure ReportDeleteNodeUpdate(Sender: TObject);
    procedure ReportModNodeUpdate(Sender: TObject);
    procedure AnalogModNodeUpdate(Sender: TObject);
    procedure ReportAddNodeUpdate(Sender: TObject);
    procedure FullFormExecute(Sender: TObject);
    procedure AnalogCollapseExecute(Sender: TObject);
    procedure ReportCollapseExecute(Sender: TObject);
    procedure AnalogExpandExecute(Sender: TObject);
    procedure ReportExpandExecute(Sender: TObject);
    procedure ReportFullFormExecute(Sender: TObject);
    procedure ReportSQLExecute(Sender: TObject);
    procedure ReportSQLUpdate(Sender: TObject);
    procedure NarrowRightExecute(Sender: TObject);
    procedure NarrowTopExecute(Sender: TObject);
    procedure ShowScaleMarksArchiveExecute(Sender: TObject);
    procedure AnalogfrxReportBeforePrint(Sender: TfrxReportComponent);
    function AnalogfrxReportUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure dxBarBtnAnalogClick(Sender: TObject);
    procedure dxBarBtnArchiveClick(Sender: TObject);
    procedure dxBarBtnReportsClick(Sender: TObject);
    procedure ActionSettingsExecute(Sender: TObject);
    procedure StretchTopUpdate(Sender: TObject);
    procedure StretchRightUpdate(Sender: TObject);
    procedure NarrowTopUpdate(Sender: TObject);
    procedure NarrowRightUpdate(Sender: TObject);
    procedure ShowScaleMarksArchiveUpdate(Sender: TObject);
    procedure GridDisplayParamsBooShowSeriesToggleClick(Sender: TObject;
      const Text: string; State: TdxCheckBoxState);
    procedure StretchBottomUpdate(Sender: TObject);
    procedure NarrowBottomUpdate(Sender: TObject);
    procedure StretchLeftUpdate(Sender: TObject);
    procedure NarrowLeftUpdate(Sender: TObject);
    procedure StretchBottomExecute(Sender: TObject);
    procedure NarrowBottomExecute(Sender: TObject);
    procedure NarrowLeftExecute(Sender: TObject);
    procedure StretchLeftExecute(Sender: TObject);
    procedure BottomScrollChange(Sender: TObject);
    procedure RightScrollChange(Sender: TObject);
    procedure ReportExportUpdate(Sender: TObject);
    procedure BMP1Click(Sender: TObject);
    procedure JPEG1Click(Sender: TObject);
    procedure TIFF1Click(Sender: TObject);
    procedure WORD1Click(Sender: TObject);
    procedure TEXT1Click(Sender: TObject);
    procedure XLS1Click(Sender: TObject);
    procedure XML1Click(Sender: TObject);
    procedure PDF1Click(Sender: TObject);
    procedure ODS1Click(Sender: TObject);
    procedure ODT1Click(Sender: TObject);
    procedure HTML1Click(Sender: TObject);
    procedure AnalogSearchExecute(Sender: TObject);
    procedure ReportSearchExecute(Sender: TObject);
    procedure AnalogSearchUpdate(Sender: TObject);
    procedure ReportSearchUpdate(Sender: TObject);
    procedure DragScalePointArchiveExecute(Sender: TObject);
    procedure DragScalePointArchiveUpdate(Sender: TObject);
    procedure ReportlFromArchiveExecute(Sender: TObject);
    procedure bsSkinMonthCalendarNumberClick(Sender: TObject);
    procedure PrintIncludeScaleArchiveUpdate(Sender: TObject);
    procedure ArchiveChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ArchiveChartKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ArchiveChartClick(Sender: TObject);
    procedure ExportArchiveDataExecute(Sender: TObject);
    procedure ExportArchiveDataUpdate(Sender: TObject);
    procedure AlertArchiveExecute(Sender: TObject);
    procedure ActionCheckedArchiveParamsUpdate(Sender: TObject);
    procedure ArchiveChartMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ToolButton9Click(Sender: TObject);
    procedure cxPageControlChange(Sender: TObject);
    procedure PlanSaveAllExecute(Sender: TObject);
    procedure BtnUseDesignStepClick(Sender: TObject);
    procedure SpDesignAreaClick(Sender: TObject);
    procedure PlanTreeColumnHeaderClick(Sender: TcxCustomTreeList;
      AColumn: TcxTreeListColumn);
    procedure PlanTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PlanTreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PlanTreeGetDragDropText(Sender: TcxCustomTreeList;
      ANode: TcxTreeListNode; var AText: string);
    procedure PlanTreeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PlanTreeFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure ReportTreeFocusedNodeChanged(Sender: TcxCustomTreeList;
      APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure ReportTreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ReportTreeGetDragDropText(Sender: TcxCustomTreeList;
      ANode: TcxTreeListNode; var AText: string);
    procedure ReportTreeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ReportTreeColumnHeaderClick(Sender: TcxCustomTreeList;
      AColumn: TcxTreeListColumn);
    procedure ReportTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure GridDisplayParamsDBTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure GridDisplayParamsDBTableViewcolorCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure PlanSaveAllUpdate(Sender: TObject);
    procedure SpDesignAreaSave(Sender: TObject);
    procedure DesignAreaExecute(Sender: TObject);
    procedure DesignAreaUpdate(Sender: TObject);
    procedure GridDisplayParamsDBTableView1BooShowSeriesPropertiesChange(
      Sender: TObject);
    procedure ReportlFromArchiveUpdate(Sender: TObject);
    procedure LoadPlanExecute(Sender: TObject);
    procedure LoadPlanUpdate(Sender: TObject);
    procedure ActionCheckedArchiveParamsExecute(Sender: TObject);
  private
    FArchiveGroupName: string;
    FArchiveChoosed: Boolean;
    FlagFlashWindow: Boolean;
    FArchiveDateTimeStart, FArchiveDateTimeEnd: Double;
    FArchiveCurrentBottomAxisValue, FArchiveCurrentLeftAxisValue: Double;
    FVisibleCrossLine: Boolean;
    FArchiveViewList: TObjectList;
    ScrollBottomStart, ScrollBottomEnd, ScrollLeftStart, ScrollLeftEnd : Double;
    FStepBottomAxis: Integer;
    //FFindStrAnalog,
    FFindStrReport: string;
    ChartTool: TCursorTool;
    FIniConfig: TIniConfig;
    FInfoArchiveLabel : TLabel;
    AlertForm: TAlertForm;
    FSCADAEditor: TSCADAEditor;
    procedure ResetArchiveScroll;
    procedure ExpandAll(const TreeList: TcxTreeList);
    function CurrentID(const TreeList: TcxTreeList): LongWord;
    procedure ClearTreeListData(const TreeList: TcxTreeList);
    procedure SeriesClick(Sender: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ResetHighlightBars;
    procedure GetBarStyle(Sender: TCustomBarSeries; ValueIndex: Integer; var TheBarStyle: TBarStyle);
    procedure RefreshConnectionInfo;
    //Plan**********************************************************************
    procedure BuildPlanTree;
    procedure ClearPlanArea;
    procedure CreatePlanDiagram(const ID: LongWord);

    procedure RefreshPlan;
    procedure RefreshPlanTree(const EnabledRefresh: Boolean);
    procedure RefreshPlanBar(const EnabledRefresh: Boolean);
    procedure RefreshPlanInfo(const EnabledRefresh: Boolean);
    procedure RefreshPlanInfoParam(const EnabledRefresh: Boolean);
    procedure RefreshPlanInfoArchive(const EnabledRefresh: Boolean);

    //Archive*******************************************************************
    procedure LoadArchiveData(const GroupParamQueryID: LongWord; const DateTimeStart, DateTimeEnd: TDateTime);
    procedure RefreshCrossValue(CursorTool: TCursorTool);
    procedure DrawArchiveTextInterval;
    function GetArchiveCurrentRightAxis: TDimensionParam;
    function GetArchiveCurrentSeries: TChartSeries;
    function FindArchiveRightAxis(const ParamQueryID: LongWord): TDimensionSeries;
    procedure AdjustArchiveRightAxis(RightAxis: TDimensionParam);
    procedure RestoreArchiveLine;

    //Report********************************************************************
    procedure BuildReportTree;
    function ReportDesign(const ReportID: LongWord; const ReportName: string): LongWord;
    procedure CreateReportPeriod(InputNode: TcxTreeListNode; const ReportID: LongWord; const aReportTreeElement: TReportTreeElement);

    //Tabs**********************************************************************
    procedure SaveTabs(const Analog, Archive, Reports: Boolean);
    function LoadTabs: TTabs;

    //Others********************************************************************
    function FindNodeByStr(TreeList: TcxTreeList; FocusedNodeStart, FocusedNodeEnd: TcxTreeListNode; const FindStr: string): Boolean;
    procedure ChartToolChange(Sender: TCursorTool; X, Y: Integer; const XValue, YValue: Double; Series: TChartSeries; ValueIndex: Integer);
    procedure GetMarkText(Sender: TChartSeries; ValueIndex: Integer; var MarkText: string);
    procedure GetMarkTextAnalogArchive(Sender: TChartSeries; ValueIndex: Integer; var MarkText: string);
    function NodeType(Node : TcxTreeListNode): Byte;
    procedure ShowAlertForm(const AlertText: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

var
  FMain: TMain;

implementation

{$R *.dfm}

uses
  DateUtils, ChooseANL, Types, TeCanvas, About, ModReportTreeElement, AnlDiagrams,
  Commctrl, APIBalloon, sqlmod, globalmethods, Report, Settings, DialogsEx,
  ModAnalogTreeElement, Log, RunSQL, ArchiveAlarmsDlg, ObjectInspector, dxsbar,
  RegObject, MdProgress;

constructor TMain.Create(AOwner: TComponent);
var
  aUseAdminView : Boolean;
  aTabs : TTabs;
begin
  inherited Create(AOwner);
  FlagFlashWindow := False;
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  cxPageControl.ActivePage := cxTabSheet1;
  //ChartTool
  ChartTool := TCursorTool.Create(Self);
  ChartTool.ParentChart := ArchiveChart;
  ChartTool.OnChange := ChartToolChange;
  ChartTool.Style := cssVertical;
  ChartTool.Active := False;

  PanelReportInfo.Hide;
  PanelFromArchive.Hide;
  ChartDragPointTool.Active := False;
//  AnalogArea.Color := clWhite;
  FArchiveChoosed := False;
  ProductInfo.Caption := EmptyStr;
//  ProductInfo.ParentColor := True;
  PageControl.ActivePage := cxTabSheet_1;
  //частота обновления
  PlanTimer.Interval := FIniConfig.GetIniInt(SETTING_KEY, UPDATE_INTERVAL_VAL, 30000);

  PlanTimer.Enabled := True;
//  LabelCountParams.Caption := '0';
  {$IFDEF USE_ADMIN}
  aUseAdminView := True;
  PlanTree.DragMode := dmAutomatic;
  ReportTree.DragMode := dmAutomatic;
  {$ELSE}
  aUseAdminView := False;
  dxTLAnalog.DragMode := dmManual;
  dxTLReport.DragMode := dmManual;
  {$ENDIF}
  //Analog
  AnalogTreeToolBtnAdd.Visible := aUseAdminView;
  AnalogTreeToolBtnDel.Visible := aUseAdminView;
  AnalogTreeToolBtnMod.Visible := aUseAdminView;
  AnalogModDiagrams.Visible := aUseAdminView;
  PlanAddNode.Visible := aUseAdminView;
  AnalogDeleteNode.Visible := aUseAdminView;
  AnalogModNode.Visible := aUseAdminView;
  //Archive
  ToolBtnShowMarksArchive.Visible := aUseAdminView;
  ToolBtnDragPointArchive.Visible := aUseAdminView;
  TagCrossTime.Caption := EmptyStr;
  //Report
  ReportTreeToolBtnAdd.Visible := aUseAdminView;
  ReportTreeToolBtnDel.Visible := aUseAdminView;
  ReportTreeToolBtnMod.Visible := aUseAdminView;
  ReportDesignAction.Visible := aUseAdminView;
  ReportSQL.Visible := aUseAdminView;
  ReportAddNode.Visible := aUseAdminView;
  ReportDeleteNode.Visible := aUseAdminView;
  ReportModNode.Visible := aUseAdminView;
  //Tabs
  aTabs := LoadTabs;
  dxBarBtnAnalog.Down := aTabs.Plan;
  dxBarBtnArchive.Down := aTabs.Archive;
  dxBarBtnReports.Down := aTabs.Reports;
//  PageAnalog.TabVisible := dxBarBtnAnalog.Down;
//  PageArchive.TabVisible := dxBarBtnArchive.Down;
//  PageReports.TabVisible := dxBarBtnReports.Down;
  //Menu
  ActionSettings.Visible := aUseAdminView;

  RxArchiveDisplayParams.Open;
  FAPIBalloon := TAPIBalloon.Create(Self);
  FAPIBalloon.TimeOut := 3000;
  FAPIBalloon.BalloonIcon := bInfo;
  FArchiveViewList := TObjectList.Create(True);
  FReport := TReport.Create(nil, FRPreview);

  BuildPlanTree;
  BuildReportTree;
  if Assigned(PlanTree.TopNode) then PlanTree.TopNode.Focused := True;
  if Assigned(ReportTree.TopNode) then ReportTree.TopNode.Focused := True;

  RefreshPlan;

  PanelBottomAnalogScroll.Hide;
  PanelRightAnalogScroll.Hide;

  //Заполнение имен меню экспорта
  BMP1.Caption := FReport.GetDescriptionBMP;
  JPEG1.Caption := FReport.GetDescriptionJPEG;
  TIFF1.Caption := FReport.GetDescriptionTIFF;
  WORD1.Caption := FReport.GetDescriptionWORD;
  TEXT1.Caption := FReport.GetDescriptionTEXT;
  XLS1.Caption := FReport.GetDescriptionXLS;
  XML1.Caption := FReport.GetDescriptionXML;
  PDF1.Caption := FReport.GetDescriptionPDF;
  ODS1.Caption := FReport.GetDescriptionODS;
  ODT1.Caption := FReport.GetDescriptionODT;
  HTML1.Caption := FReport.GetDescriptionHTML;
end;

procedure TMain.DesignAreaExecute(Sender: TObject);
begin
  SpDesignArea.DesignView := DesignAreaBtn.Down;
end;

procedure TMain.DesignAreaUpdate(Sender: TObject);
begin
  DesignArea.Enabled := TPlanTreeElement(NodeType(PlanTree.FocusedNode)) = ataElement;
end;

destructor TMain.Destroy;
begin
  if SpDesignArea.Designed then
  begin
    if _MessageBox(Handle, PChar('Сохранить изменения?'),
              'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
      PlanSaveAll.Execute;
  end;
  ClearTreeListData(PlanTree);
  ClearTreeListData(ReportTree);
  if RxArchiveDisplayParams.Active then
    RxArchiveDisplayParams.Close;
  FReport.Free;
  FArchiveViewList.Free;
  FAPIBalloon.Close;
  FAPIBalloon.Free;
  PlanTimer.Enabled := False;
  FIniConfig.Free;
  FSCADAEditor.Free;
  if Assigned(AlertForm) then AlertForm.Free;
  inherited Destroy;
end;

procedure TMain.RefreshConnectionInfo;
begin
  if UDBData.MySQLPingServer then
  begin
    LabelConnection.Font.Color := clGreen;
    LabelConnection.Caption := Format('Связь работает нормально. Подкл=%s; Пользов=%s', [UDM.HostDes, UDM.User])
  end else begin
    LabelConnection.Font.Color := clRed;
    LabelConnection.Caption := Format('Нет связи. Подкл=%s; Пользов=%s', [UDM.HostDes, UDM.User]);
  end;
end;

procedure TMain.PlanAddNodeExecute(Sender: TObject);
var
  FocusedNode, Node : TcxTreeListNode;
  LastId, SubId : LongWord;
  ImageIndex : Integer;
  PlanForm: TPlanTreeElementForm;
  PlanElement: TModPlanTreeElement;

  function AddChildLastNode(const aFN: TcxTreeListNode; aChoosenElement: TPlanTreeElement): TcxTreeListNode;
  var
    aN, fixN : TcxTreeListNode;
  begin
    fixN := nil;
    aN := aFN.GetFirstChild;
    while not Assigned(aN) do
    begin
      if TPlanNodeClass(aN.Data).FTreeElement <= aChoosenElement then fixN := aN;
      aN := aN.GetNextSibling;
    end;
    if fixN = nil then //если нет групп добавляю вверх
      Result := aFN.AddChildFirst
    else
    if fixN.GetNextSibling = nil then //если только группы добавляю в конец
      Result := aFN.AddChild
    else
      Result := aFN.InsertChild(fixN.GetNextSibling); //добавляю в конец групп
    aFN.Expand(False);  
  end;

begin
  FocusedNode := PlanTree.FocusedNode;
  PlanForm := TPlanTreeElementForm.Create(nil);
  try
    if PlanForm.Execute then
    begin
      PlanElement := TModPlanTreeElement.Create(nil);
      try
        if PlanElement.Execute then
        begin
          if not Assigned(FocusedNode) then
             Node := PlanTree.Add
          else
             case PlanForm.ChoosenElement of
               ataGroup   : Node := AddChildLastNode(FocusedNode, ataGroup);
               ataElement : Node := AddChildLastNode(FocusedNode, ataElement);
             end;
          Node.Texts[0] := PlanElement.ElementName;
          Node.Texts[1] := PlanElement.ElementDescription;
          SubId := 0;
          if Assigned(FocusedNode) then
            SubId := TPlanNodeClass(FocusedNode.Data).FId;
          try
            LastId := UDBData.AddConsumerism(PlanElement.ElementName,
                 PlanElement.ElementDescription, 0, SubId, Integer(PlanForm.ChoosenElement), 1);
            if UDBData.InTransaction then UDBData.ComitTransaction;
          except
            if UDBData.InTransaction then UDBData.RollBackTransaction; 
          end;
          ImageIndex := -1;
          case PlanForm.ChoosenElement of
             ataGroup : begin
                Node.Data := TPlanNodeClass.Create(LastId, ataGroup);
                ImageIndex := 0;
             end;
             ataElement : begin
                Node.Data := TPlanNodeClass.Create(LastId, ataElement);
                ImageIndex := 1;
             end;
          end;
          Node.ImageIndex := ImageIndex;
          Node.SelectedIndex := ImageIndex;
          Node.Focused := True;
        end;
      finally
        PlanElement.Free;
      end;
    end;
  finally
    PlanForm.Free;
  end;
end;

procedure TMain.AnalogModDiagramsExecute(Sender: TObject);
var
  FocusedNode: TcxTreeListNode;
  CustId: LongWord;
begin
  FocusedNode := PlanTree.FocusedNode;
  if TPlanTreeElement(NodeType(FocusedNode)) = ataElement then
  begin
    CustId := TPlanNodeClass(FocusedNode.Data).FId;
    with TModDiagrams.Create(Self, CustId) do
    try
      if Execute then
      begin
        ClearPlanArea;
        CreatePlanDiagram(CurrentID(PlanTree));
        RefreshPlan;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TMain.AnalogModDiagramsUpdate(Sender: TObject);
begin
  AnalogModDiagrams.Enabled := (TPlanTreeElement(NodeType(PlanTree.FocusedNode)) = ataElement) and not SpDesignArea.DesignView;
end;

procedure TMain.AnalogModNodeExecute(Sender: TObject);
var
  Node: TcxTreeListNode;
  ID: LongWord;
begin
  Node := PlanTree.FocusedNode;
  if Assigned(Node) then
  begin
    with TModPlanTreeElement.Create(nil) do
    try
      ElementName := Node.Texts[0];
      ElementDescription := Node.Texts[1];
      if Execute then
      begin
        try
          ID := TPlanNodeClass(Node.Data).ID;

          UDBData.UpdateConsName(ID, ElementName);
          UDBData.UpdateConsDescription(ID, ElementDescription);

          Node.Texts[0] := ElementName;
          Node.Texts[1] := ElementDescription;

          if TPlanTreeElement(NodeType(Node)) = ataElement then
            ProductInfo.Caption := ElementDescription
          else
            ProductInfo.Caption := EmptyStr;

          if UDBData.InTransaction then
            UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then
            UDBData.RollBackTransaction;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TMain.AnalogModNodeUpdate(Sender: TObject);
begin
  AnalogModNode.Enabled := PlanTree.FocusedNode <> nil;
end;

procedure TMain.ReportModNodeExecute(Sender: TObject);
var
  FocusedNode: TcxTreeListNode;
  CustId: LongWord;
  ReportNodeClass: TReportNodeClass;
  DifTypeReportValue: Boolean;
begin
  FocusedNode := ReportTree.FocusedNode;
  ReportNodeClass := FocusedNode.Data;
  if (FocusedNode <> nil) and (TObject(FocusedNode.Data) is TReportNodeClass) then
  begin
    FModReportTreeElement := TModReportTreeElement.Create(nil);
    try
      FModReportTreeElement.ElementName := FocusedNode.Texts[0];
      FModReportTreeElement.ElementDescription := FocusedNode.Texts[1];
      if ReportNodeClass.FTreeElement = rtaGroup then
        FModReportTreeElement.EnableChecks(True, False, False, False, False)
      else
        FModReportTreeElement.EnableChecks(False, True, True, True, True);
      FModReportTreeElement.ChoosenElement := ReportNodeClass.FTreeElement;
      if FModReportTreeElement.Execute then
      begin
        CustId := TReportNodeClass(FocusedNode.Data).FId;
        try
          UDBData.UpdateConsName(CustId, FModReportTreeElement.ElementName);
          UDBData.UpdateConsDescription(CustId, FModReportTreeElement.ElementDescription);
          DifTypeReportValue := FModReportTreeElement.ChoosenElement <> ReportNodeClass.TreeElement;
          if DifTypeReportValue then
            UDBData.UpdateConsType(CustId, Integer(FModReportTreeElement.ChoosenElement));
          if UDBData.InTransaction then UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then UDBData.RollBackTransaction;
        end;

        if DifTypeReportValue then
          _MessageBox(Handle, PChar('Изменения вступят после перезагрузки программы!'), 'Предупреждение', MB_OK + MB_ICONQUESTION);

        FocusedNode.Texts[0] := FModReportTreeElement.ElementName;
        FocusedNode.Texts[1] := FModReportTreeElement.ElementDescription;
      end;
    finally
      FModReportTreeElement.Free;
    end;
  end;
end;

procedure TMain.ReportModNodeUpdate(Sender: TObject);
begin
  with ReportTree do
    ReportModNode.Enabled := Assigned(FocusedNode) and (TObject(FocusedNode.Data) is TReportNodeClass);
end;

procedure TMain.PlanAddNodeUpdate(Sender: TObject);
begin
  with PlanTree do
    ReportAddNode.Enabled := not Assigned(FocusedNode) or (TPlanTreeElement(NodeType(FocusedNode)) = ataGroup);
end;

procedure TMain.ReportAddNodeExecute(Sender: TObject);
var
  FocusedNode, Node: TcxTreeListNode;
  NewID, SubID: LongWord;
  ReportID: LongWord;
  ReportNodeClass: TReportNodeClass;

  function AddChildLastNode(const FN: TcxTreeListNode;
    ChoosenElement: TReportTreeElement): TcxTreeListNode;
  var
    aN, fixN: TcxTreeListNode;
  begin
    fixN := nil;
    aN := FN.GetFirstChild;
    while aN <> nil do
    begin
      if TReportTreeElement(NodeType(aN)) <= ChoosenElement then
        fixN := aN;
      aN := aN.GetNextSibling;
    end;
    if fixN = nil then //если нет групп добавляю вверх
      Result := FN.AddChildFirst
    else
    if fixN.GetNextSibling = nil then //если только группы добавляю в конец
      Result := FN.AddChild
    else
      Result := FN.InsertChild(fixN.GetNextSibling); //добавляю в конец групп
    FN.Expand(False);
  end;
    
begin
  FocusedNode := ReportTree.FocusedNode;
  FCreateReportTreeElement := TCreateReportTreeElement.Create(nil);
  if FCreateReportTreeElement.Execute then
  try
    SubID := 0;
    if FocusedNode <> nil  then
      SubID := TReportNodeClass(FocusedNode.Data).FId;
    case FCreateReportTreeElement.ChoosenElement of
      rtaGroup : begin
        try
          NewID := UDBData.AddConsumerism(FCreateReportTreeElement.ElementName,
            FCreateReportTreeElement.ElementDescription, 0, SubID, Integer(rtaGroup), 2);
          if UDBData.InTransaction then UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then UDBData.RollBackTransaction;
        end;
        if FocusedNode = nil then
           Node := ReportTree.Add
        else
           Node := AddChildLastNode(FocusedNode, rtaGroup);
        Node.Texts[0] := FCreateReportTreeElement.ElementName;
        Node.Texts[1] := FCreateReportTreeElement.ElementDescription;
        Node.Data := TReportNodeClass.Create(NewID, rtaGroup);
        Node.Focused := True;
        Node.ImageIndex := 0;
        Node.SelectedIndex := 0;
      end;
      rtaDay : begin
        ReportID := ReportDesign(0, 'Отчет за сутки');
        try
          NewID := UDBData.AddConsumerism(FCreateReportTreeElement.ElementName,
            FCreateReportTreeElement.ElementDescription, ReportID, SubID, Integer(rtaDay), 2);
          if UDBData.InTransaction then UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then UDBData.RollBackTransaction;
        end;
        if FocusedNode = nil then
           Node := ReportTree.Add
        else
           Node := AddChildLastNode(FocusedNode, rtaDay);
        CreateReportPeriod(Node, ReportID, rtaDay);
        ReportNodeClass := TReportNodeClass.Create(NewID, rtaDay);
        ReportNodeClass.FReportId := ReportID;
        Node.Texts[0] := FCreateReportTreeElement.ElementName;
        Node.Texts[1] := FCreateReportTreeElement.ElementDescription;
        Node.Data := ReportNodeClass;
        Node.Focused := True;
        Node.ImageIndex := 1;
        Node.SelectedIndex := 1;
      end;
      rtaMonth : begin
        ReportID := ReportDesign(0, 'Отчет за месяц');
        try
          NewID := UDBData.AddConsumerism(FCreateReportTreeElement.ElementName,
            FCreateReportTreeElement.ElementDescription, ReportID, SubID, Integer(rtaMonth), 2);
          if UDBData.InTransaction then UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then UDBData.RollBackTransaction;
        end;
        if FocusedNode = nil then
           Node := ReportTree.Add
        else
           Node := AddChildLastNode(FocusedNode, rtaMonth);
        CreateReportPeriod(Node, ReportID, rtaMonth);
        ReportNodeClass := TReportNodeClass.Create(NewID, rtaMonth);
        ReportNodeClass.FReportId := ReportID;
        Node.Texts[0] := FCreateReportTreeElement.ElementName;
        Node.Texts[1] := FCreateReportTreeElement.ElementDescription;
        Node.Data := ReportNodeClass;
        Node.Focused := True;
        Node.ImageIndex := 1;
        Node.SelectedIndex := 1;
      end;
      rtaYear : begin
        ReportID := ReportDesign(0, 'Отчет за год');
        try
          NewID := UDBData.AddConsumerism(FCreateReportTreeElement.ElementName,
            FCreateReportTreeElement.ElementDescription, ReportID, SubID, Integer(rtaYear), 2);
          if UDBData.InTransaction then UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then UDBData.RollBackTransaction;
        end;
        if FocusedNode = nil then
           Node := ReportTree.Add
        else
           Node := AddChildLastNode(FocusedNode, rtaYear);
        CreateReportPeriod(Node, ReportID, rtaYear);
        ReportNodeClass := TReportNodeClass.Create(NewID, rtaYear);
        ReportNodeClass.FReportId := ReportID;
        Node.Texts[0] := FCreateReportTreeElement.ElementName;
        Node.Texts[1] := FCreateReportTreeElement.ElementDescription;
        Node.Data := ReportNodeClass;
        Node.Focused := True;
        Node.ImageIndex := 1;
        Node.SelectedIndex := 1;
      end;
      rtaSimple : begin
        ReportID := ReportDesign(0, 'Простой отчет');
        try
          NewID := UDBData.AddConsumerism(FCreateReportTreeElement.ElementName,
            FCreateReportTreeElement.ElementDescription, ReportID, SubID, Integer(rtaSimple), 2);
          if UDBData.InTransaction then UDBData.ComitTransaction;
        except
          if UDBData.InTransaction then UDBData.RollBackTransaction;
        end;
        if FocusedNode = nil then
           Node := ReportTree.Add
        else
           Node := AddChildLastNode(FocusedNode, rtaSimple);
        ReportNodeClass := TReportNodeClass.Create(NewID, rtaSimple);
        ReportNodeClass.FReportId := ReportID;
        Node.Texts[0] := FCreateReportTreeElement.ElementName;
        Node.Texts[1] := FCreateReportTreeElement.ElementDescription;
        Node.Data := ReportNodeClass;
        Node.Focused := True;
        Node.ImageIndex := 2;
        Node.SelectedIndex := 2;
      end;
    end;
    Node.Expand(True);
  finally
    FCreateReportTreeElement.Free;
  end;
end;

procedure TMain.ReportAddNodeUpdate(Sender: TObject);
begin
  with ReportTree do
    ReportAddNode.Enabled := not Assigned(FocusedNode) or (TReportTreeElement(NodeType(FocusedNode)) = rtaGroup);
end;

procedure TMain.FullFormExecute(Sender: TObject);
begin
  FAPIBalloon.Close;
  PanelAnalogTree.Visible := not ToolButton20.Down;
  RollPanel.RollUpState := ToolButton20.Down;
  if ToolButton20.Down then
  begin
    FAPIBalloon.Title := 'Подсказка';
    FAPIBalloon.Prompt.Text := 'Для восстановления прежнего вида нажмите на эту кнопку';
    FAPIBalloon.Show(ToolButton20);
  end;
end;

procedure TMain.AnalogCollapseExecute(Sender: TObject);
begin
  PlanTree.FocusedNode.Collapse(True);
end;

procedure TMain.ReportCollapseExecute(Sender: TObject);
begin
  ReportTree.FocusedNode.Collapse(True);
end;

procedure TMain.ActionCheckedArchiveParamsExecute(Sender: TObject);
var
  OldRecNo, SeriesI: Integer;
begin
  //Выделю все series***********************************************************
  OldRecNo := RxArchiveDisplayParams.RecNo;
  RxArchiveDisplayParams.DisableControls;
  RxArchiveDisplayParams.First;
  while not RxArchiveDisplayParams.Eof do
  begin
    RxArchiveDisplayParams.Edit;
    RxArchiveDisplayParams.FieldByName('BooShowSeries').AsBoolean := True;
    //Ищу серию*****************************************************************
    for SeriesI := 0 to ArchiveChart.SeriesCount - 1 do
    begin
      if ArchiveChart.Series[SeriesI].Tag = RxArchiveDisplayParams.RecNo then
      begin
        ArchiveChart.Series[SeriesI].Visible := True;
        Break;
      end;
    end;
    RxArchiveDisplayParams.Next;
  end;
  RxArchiveDisplayParams.RecNo := OldRecNo;
  RxArchiveDisplayParams.EnableControls;
  //Обновляю данные cross line**************************************************
  RefreshCrossValue(ChartTool);
end;

procedure TMain.ActionCheckedArchiveParamsUpdate(Sender: TObject);
begin
  ActionCheckedArchiveParams.Enabled := FArchiveChoosed;
end;

procedure TMain.AnalogDeleteNodeExecute(Sender: TObject);
var
  Node: TcxTreeListNode;
begin
  Node := PlanTree.FocusedNode;
  if not Assigned(Node) then Exit;
  if _MessageBox(Handle, 'Вы уверены, что хотите удалить этот элемент?',
    'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    try
      UDBData.DeleteCons(TPlanNodeClass(Node.Data).FId);
      if Node.Parent <> nil then
        Node.Parent.Focused := True;
      Node.Free;
      if UDBData.InTransaction then
        UDBData.ComitTransaction;
    except
      if UDBData.InTransaction then
        UDBData.RollBackTransaction;
    end;
  end;
end;

procedure TMain.AnalogDeleteNodeUpdate(Sender: TObject);
begin
  AnalogDeleteNode.Enabled := PlanTree.FocusedNode <> nil;
end;

procedure TMain.ReportDeleteNodeExecute(Sender: TObject);
var
  FocusedNode: TcxTreeListNode;
  CustId: LongWord;
begin
  FocusedNode := ReportTree.FocusedNode;
  if (FocusedNode <> nil) and (TObject(FocusedNode.Data) is TReportNodeClass) then
  begin
    if _MessageBox(Handle, 'Вы уверены что хотите удалить этот элемент?',
       'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      CustId := TReportNodeClass(FocusedNode.Data).FId;
      try
        UDBData.DeleteCons(CustId);
        UDBData.DeleteNotRelatedReports;
        if UDBData.InTransaction then UDBData.ComitTransaction;
      except
        if UDBData.InTransaction then UDBData.RollBackTransaction;
      end;
      FRPreview.Clear;
      FocusedNode.Free;
    end;
  end;
end;

procedure TMain.ReportDeleteNodeUpdate(Sender: TObject);
begin
  with ReportTree do
    ReportDeleteNode.Enabled := Assigned(FocusedNode) and (TObject(FocusedNode.Data) is TReportNodeClass);
end;

procedure TMain.AnalogExpandExecute(Sender: TObject);
begin
  PlanTree.FocusedNode.Expand(True);
end;

procedure TMain.ReportExpandExecute(Sender: TObject);
begin
  ReportTree.FocusedNode.Expand(True);
end;

procedure TMain.ReportExportUpdate(Sender: TObject);
begin
  if Assigned(ReportTree.FocusedNode) then
    ReportExport.Enabled := TObject(ReportTree.FocusedNode.Data) is TReportFilter;
end;

procedure TMain.StretchBottomExecute(Sender: TObject);
var
  aMin, aMax: Double;
begin
  //left axis
  aMin := ArchiveChart.LeftAxis.Minimum + ARCHIVE_STEP_RIGHT_SCROLL; //10%
  aMax := ArchiveChart.LeftAxis.Maximum;
  if (aMax - aMin) >= ARCHIVE_STEP_RIGHT_SCROLL then
  begin
    ArchiveChart.LeftAxis.SetMinMax(aMin, aMax);
    //right axis
    aMin := ArchiveChart.RightAxis.Minimum + GetArchiveCurrentRightAxis.Max / 100 * ARCHIVE_STEP_RIGHT_SCROLL;
    aMax := ArchiveChart.RightAxis.Maximum;
    ArchiveChart.RightAxis.SetMinMax(aMin, aMax);
    //scroll
    RightScroll.PageSize := RightScroll.PageSize - ARCHIVE_STEP_RIGHT_SCROLL;
  end;
end;

procedure TMain.StretchBottomUpdate(Sender: TObject);
begin
  StretchBottom.Enabled := FArchiveChoosed;
end;

procedure TMain.StretchLeftExecute(Sender: TObject);
var
  aMin, aMax: Double;
begin
  aMin := ArchiveChart.BottomAxis.Minimum + EncodeTime(0, FStepBottomAxis, 0, 0);
  aMax := ArchiveChart.BottomAxis.Maximum;
  if MinutesBetween(aMin, aMax) >= 120 then
  begin
    aMax := ArchiveChart.BottomAxis.Maximum;
    ArchiveChart.BottomAxis.SetMinMax(aMin, aMax);
    BottomScroll.PageSize := BottomScroll.PageSize - FStepBottomAxis;
    BottomScroll.Position := BottomScroll.Position + FStepBottomAxis;
  end;
end;

procedure TMain.StretchLeftUpdate(Sender: TObject);
begin
  StretchLeft.Enabled := FArchiveChoosed;
end;

procedure TMain.StretchRightExecute(Sender: TObject);
var
  aMin, aMax: Double;
begin
  aMin := ArchiveChart.BottomAxis.Minimum;
  aMax := ArchiveChart.BottomAxis.Maximum - EncodeTime(0, FStepBottomAxis, 0, 0);
  if MinutesBetween(aMin, aMax) >= 120 then
  begin
    ArchiveChart.BottomAxis.SetMinMax(aMin, aMax);
    BottomScroll.PageSize := BottomScroll.PageSize - FStepBottomAxis;
  end;
end;

procedure TMain.StretchRightUpdate(Sender: TObject);
begin
  StretchRight.Enabled := FArchiveChoosed;
end;

procedure TMain.DragScalePointArchiveExecute(Sender: TObject);
begin
  ChartDragPointTool.Active := ToolBtnDragPointArchive.Down;
  ChartDragPointTool.Series := GetArchiveCurrentSeries;
end;

procedure TMain.DragScalePointArchiveUpdate(Sender: TObject);
begin
  DragScalePointArchive.Enabled := FArchiveChoosed;
end;

procedure TMain.ExportArchiveDataExecute(Sender: TObject);
begin
  if Shellexecute(Handle, 'open', PChar(GetWindowsTempPath + EXPORT_FILE_NAME), nil, nil, SW_RESTORE) <= 32 then
    raise EMain.Create('Не удается отобразить экспорт данных.');
end;

procedure TMain.ExportArchiveDataUpdate(Sender: TObject);
begin
  ExportArchiveData.Enabled := FArchiveChoosed;
end;

procedure TMain.ActionOpenArchiveExecute(Sender: TObject);
var
  CalcStepMin: Integer;
  ArchiveForm: TChooseArchiveForm;
begin
  ArchiveForm := TChooseArchiveForm.Create(nil);
  try
    if ArchiveForm.Execute then
    begin
      FArchiveGroupName := EmptyStr;
      TagCrossTime.Caption := EmptyStr;
      //прячу cross
      ChartTool.Active := False;
      //график не выбран
      FArchiveChoosed := False;
      //оси не видны
      ArchiveChart.Axes.Hide;
//      LabelCountParams.Caption := '0';
      FArchiveDateTimeStart := 0;
      FArchiveDateTimeEnd := 0;
      ShowProgressMessage('Формируются архивные данные');
      try
        LoadArchiveData(ArchiveForm.ParamGroupId, ArchiveForm.DateTimeStart, ArchiveForm.DateTimeEnd);
      finally
        CloseProgress;
      end;
      if RxArchiveDisplayParams.IsEmpty then
        raise EMain.Create('Группа не имеет параметров.');
      FArchiveChoosed := True;
      ArchiveChart.Axes.Visible := True;
//      LabelCountParams.Caption := IntToStr(RxArchiveDisplayParams.RecordCount);
      //имя выбранной группы
      FArchiveGroupName := ArchiveForm.GroupName;
      //дата начала
      FArchiveDateTimeStart := ArchiveForm.DateTimeStart;
      //дата окончания
      FArchiveDateTimeEnd := ArchiveForm.DateTimeEnd;
      with ArchiveChart do
      begin
        //LeftAxis
        LeftAxis.SetMinMax(ARCHIVE_MIN_LEFT_AXIS, ARCHIVE_MAX_LEFT_AXIS);
        LeftAxis.Grid.Color := $00CFD7DA;
        //Шаг отображения labels  
        LeftAxis.Increment := 10;
        //BottomAxis
        BottomAxis.DateTimeFormat := 'hh:mm';
        BottomAxis.SetMinMax(FArchiveDateTimeStart, FArchiveDateTimeEnd);
        BottomAxis.Increment := DateTimeStep[dtOneHour];
        //колличество MinorTick между часами на графике
        BottomAxis.MinorTickCount := 1;
        BottomAxis.Grid.Color := $00CFD7DA;
        //RightAxis
        RightAxis.Grid.Hide;
        AnimatedZoom := False;
        AllowPanning := pmNone;
      end;
      //cross
      ChartTool.OnChange := nil;
      ChartTool.XValue := 1;     //<<< --- ошибка в компоненте. при 0 не кладется XValue
      ChartTool.XValue := (FArchiveDateTimeStart + FArchiveDateTimeEnd) / 2;
      ChartTool.OnChange := ChartToolChange;
      ChartTool.Active := True;
      RefreshCrossValue(ChartTool);
      //scrolls
      ScrollBottomStart := ArchiveChart.BottomAxis.Minimum;
      ScrollBottomEnd := ArchiveChart.BottomAxis.Maximum;
      ScrollLeftStart := ArchiveChart.LeftAxis.Minimum;
      ScrollLeftEnd := ArchiveChart.LeftAxis.Maximum;
      //сбрасываю скролы архива
      ResetArchiveScroll;
      //скрол нижней шкалы состав. 10% от общего выбранного диапазона
      CalcStepMin := Trunc(MinutesBetween(ArchiveForm.DateTimeStart, ArchiveForm.DateTimeEnd) / 100 * ARCHIVE_STEP_BOTTOM_SCROLL);
      if CalcStepMin > 59 then
        CalcStepMin := 59
      else
        if CalcStepMin = 0 then
          CalcStepMin := 1;
      FStepBottomAxis := CalcStepMin;
      //шаг большого скрола
      BottomScroll.LargeChange := CalcStepMin;
      RightScroll.LargeChange := ARCHIVE_STEP_RIGHT_SCROLL;
      FArchiveCurrentLeftAxisValue := ARCHIVE_MAX_LEFT_AXIS / 2;
      FArchiveCurrentBottomAxisValue := (FArchiveDateTimeStart + FArchiveDateTimeEnd) / 2;
      //cross линия на графике архива видна
      FVisibleCrossLine := True;
      ToolBtnShowMarksArchive.Down := False;
      PanelRightAnalogScroll.Show;
//      PanelAnalogViewParams.Show;              //отображаю таблицу параметров (align=bottom)
//      SplitterAnalog.Show;                     //отображаю spliter (align=bottom)
      PanelBottomAnalogScroll.Show;            //отображаю scrooll (align=bottom)
    end;
  finally
    ArchiveChart.AxisVisible := FArchiveChoosed;
    if not ArchiveChart.Focused then Windows.SetFocus(ArchiveChart.Handle);
    ArchiveForm.Free;
  end;
end;

procedure TMain.PrintIncludeScaleArchiveUpdate(Sender: TObject);
begin
  PrintIncludeScaleArchive.Enabled := FArchiveChoosed;
end;

procedure TMain.ResetArchiveScroll;
var
  MinsBetween: Int64;
begin
  //scrolls
  MinsBetween := MinutesBetween(FArchiveDateTimeStart, FArchiveDateTimeEnd);
  BottomScroll.PageSize := 0;
  BottomScroll.SetParams(ARCHIVE_MIN_BOTTOM_AXIS, ARCHIVE_MIN_BOTTOM_AXIS, MinsBetween);
  BottomScroll.PageSize := MinsBetween;
  BottomScroll.Position := ARCHIVE_MIN_BOTTOM_AXIS;
  RightScroll.PageSize := 0;
  RightScroll.SetParams(ARCHIVE_MIN_LEFT_AXIS, ARCHIVE_MIN_LEFT_AXIS, ARCHIVE_MAX_LEFT_AXIS);
  RightScroll.PageSize := ARCHIVE_MAX_LEFT_AXIS;
  RightScroll.Position := ARCHIVE_MIN_LEFT_AXIS;
  //axis
  ArchiveChart.LeftAxis.SetMinMax(0, ARCHIVE_MAX_LEFT_AXIS);
  ArchiveChart.BottomAxis.SetMinMax(FArchiveDateTimeStart, FArchiveDateTimeEnd);
end;

procedure TMain.PrintArchiveExecute(Sender: TObject);
var
  i, recNo: Word;
  CurSeries: TChartSeries;
begin
  {
  frxChartView := TfrxChartView(AnalogFRXReport.FindObject('ReportChart'));
  frxChartView.Chart.RightAxis.Visible := False;
  }
  if not FileExists(REPOARCHIVE_PATH) then
    raise EMain.Create('Не могу найти отчет для формирования архивных показаний.');
  recNo := RxArchiveDisplayParams.RecNo;
  RxArchiveDisplayParams.DisableControls;  //чтобы не возникало событие onChangeNodeEx
  //скрываю cross линию
  ChartTool.Visible := False;
  //убираю утолщение графика
  if not ToolBtnPrintScaleArchive.Down then RestoreArchiveLine;
  //отображаю цифровые подписи для каждого графика
  for i := 0 to ArchiveChart.SeriesCount - 1 do
    ArchiveChart.Series[i].Marks.Show;
  AnalogFRXReport.AddFunction('procedure GetDateInterval');
  AnalogFRXReport.LoadFromFile(REPOARCHIVE_PATH);
  AnalogFRXReport.ShowReport(False);
  RxArchiveDisplayParams.RecNo := recNo;
  RxArchiveDisplayParams.EnableControls;
  //скрываю цифровые подписи для каждого графика
  for i := 0 to ArchiveChart.SeriesCount - 1 do
    ArchiveChart.Series[i].Marks.Hide;
  //восстанавливаю утолщение активного графика
  if not ToolBtnPrintScaleArchive.Down then
  begin
    CurSeries := GetArchiveCurrentSeries;
    if (CurSeries <> nil) and FArchiveChoosed then
      TLineSeries(CurSeries).LinePen.Width := 2;
  end;
  //отображаю cross линию
  ChartTool.Visible := True;
end;

function TMain.AnalogfrxReportUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  if AnsiUpperCase(MethodName) = AnsiUpperCase('GetDateInterval') then
      Result := 'c ' + FormatDateTime('dd.MM.yyyy hh:mm', ArchiveChart.BottomAxis.Minimum) + ' по ' +
                           FormatDateTime('dd.MM.yyyy hh:mm', ArchiveChart.BottomAxis.Maximum);
end;

procedure TMain.PrintArchiveUpdate(Sender: TObject);
begin
  PrintArchive.Enabled := FArchiveChoosed;
end;

function TMain.GetArchiveCurrentRightAxis : TDimensionParam;
begin
  Result := FindArchiveRightAxis(RxArchiveDisplayParams.FieldByName('paramquery_id').AsInteger);
end;

function TMain.GetArchiveCurrentSeries: TChartSeries;
var
  ArchiveRightAxis : TDimensionSeries;
begin
  Result := nil;
  ArchiveRightAxis := FindArchiveRightAxis(RxArchiveDisplayParams.FieldByName('paramquery_id').AsInteger);
  if ArchiveRightAxis <> nil then Result := ArchiveRightAxis.Series;
end;

procedure TMain.GetBarStyle(Sender: TCustomBarSeries; ValueIndex: Integer;
  var TheBarStyle: TBarStyle);
begin
  if not SpDesignArea.DesignView then
  begin
    if TChartE(Sender.Owner).Selected[ValueIndex] then
       //ширина границы выделенного бара
       TChart(Sender.Owner).Canvas.Pen.Width := 5
    else
       TChart(Sender.Owner).Canvas.Pen.Width := Sender.BarPen.Width;
  end;
end;

function TMain.FindArchiveRightAxis(const ParamQueryID: LongWord) : TDimensionSeries;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FArchiveViewList.Count - 1 do
    if TDimensionSeries(FArchiveViewList[i]).ID = ParamQueryID then
    begin
      Result := FArchiveViewList[i] as TDimensionSeries;
      Break;
    end;
end;

procedure TMain.ReportFullFormExecute(Sender: TObject);
begin
  FAPIBalloon.Close;
  PanelTreeReport.Visible := not ToolButton40.Down;
  if ToolButton40.Down then
  begin
    FAPIBalloon.Title := 'Подсказка';
    FAPIBalloon.Prompt.Text := 'Для восстановления прежнего вида нажмите на эту кнопку еще раз';
    FAPIBalloon.Show(ToolButton40);
  end;
end;

procedure TMain.ResetArchiveViewExecute(Sender: TObject);
begin
  ResetArchiveScroll;
  FArchiveCurrentBottomAxisValue := (FArchiveDateTimeStart + FArchiveDateTimeEnd) / 2;
  ArchiveChart.Refresh;
end;

procedure TMain.ResetArchiveViewUpdate(Sender: TObject);
begin
  ResetArchiveView.Enabled := FArchiveChoosed;
end;

procedure TMain.NarrowBottomExecute(Sender: TObject);
var aMin, aMax: Double;
begin
  //left axis
  aMin := ArchiveChart.LeftAxis.Minimum - ARCHIVE_STEP_RIGHT_SCROLL; //10%
  aMax := ArchiveChart.LeftAxis.Maximum;
  if aMin >= ScrollLeftStart then
  begin
    ArchiveChart.LeftAxis.SetMinMax(aMin, aMax);
    //right axis
    aMin := ArchiveChart.RightAxis.Minimum - GetArchiveCurrentRightAxis.Max / 100 * ARCHIVE_STEP_RIGHT_SCROLL;
    aMax := ArchiveChart.RightAxis.Maximum;
    ArchiveChart.RightAxis.SetMinMax(aMin, aMax);
    //scroll
    RightScroll.PageSize := RightScroll.PageSize + ARCHIVE_STEP_RIGHT_SCROLL;
  end;
end;

procedure TMain.NarrowBottomUpdate(Sender: TObject);
begin
  NarrowBottom.Enabled := FArchiveChoosed;
end;

procedure TMain.NarrowLeftExecute(Sender: TObject);
var aMin, aMax: Double;
begin
  aMin := ArchiveChart.BottomAxis.Minimum - EncodeTime(0, FStepBottomAxis, 0, 0);
  if aMin >= ScrollBottomStart then
  begin
    aMax := ArchiveChart.BottomAxis.Maximum;
    ArchiveChart.BottomAxis.SetMinMax(aMin, aMax);
    BottomScroll.PageSize := BottomScroll.PageSize + FStepBottomAxis;
    BottomScroll.Position := BottomScroll.Position - FStepBottomAxis;
  end;
end;

procedure TMain.NarrowLeftUpdate(Sender: TObject);
begin
  NarrowLeft.Enabled := FArchiveChoosed;
end;

procedure TMain.NarrowRightExecute(Sender: TObject);
var aMin, aMax: Double;
begin
  aMin := ArchiveChart.BottomAxis.Minimum;
  aMax := ArchiveChart.BottomAxis.Maximum + EncodeTime(0, FStepBottomAxis, 0, 0);
  if aMax <= ScrollBottomEnd then
  begin
    ArchiveChart.BottomAxis.SetMinMax(aMin, aMax);
    BottomScroll.PageSize := BottomScroll.PageSize + FStepBottomAxis;
  end;
end;

procedure TMain.NarrowRightUpdate(Sender: TObject);
begin
  NarrowRight.Enabled := FArchiveChoosed;
end;

procedure TMain.NarrowTopExecute(Sender: TObject);
var aMin, aMax: Double;
begin
  //left axis
  aMin := ArchiveChart.LeftAxis.Minimum;
  aMax := ArchiveChart.LeftAxis.Maximum + ARCHIVE_STEP_RIGHT_SCROLL;
  if aMax <= ScrollLeftEnd then
  begin
    ArchiveChart.LeftAxis.SetMinMax(aMin, aMax);
    //right axis
    aMin := ArchiveChart.RightAxis.Minimum;
    aMax := ArchiveChart.RightAxis.Maximum + GetArchiveCurrentRightAxis.Max / 100 * ARCHIVE_STEP_RIGHT_SCROLL;
    ArchiveChart.RightAxis.SetMinMax(aMin, aMax);
    //scroll
    RightScroll.PageSize := RightScroll.PageSize + ARCHIVE_STEP_RIGHT_SCROLL;
    RightScroll.Position := RightScroll.Position - ARCHIVE_STEP_RIGHT_SCROLL;
  end;
end;

procedure TMain.NarrowTopUpdate(Sender: TObject);
begin
  NarrowTop.Enabled := FArchiveChoosed;
end;

procedure TMain.ODS1Click(Sender: TObject);
begin
  FReport.ExportToODS;
end;

procedure TMain.ODT1Click(Sender: TObject);
begin
  FReport.ExportToODT;
end;

procedure TMain.GetMarkText(Sender: TChartSeries; ValueIndex: Integer;
  var MarkText: string);
begin
  MarkText := IntToStr(Sender.Tag);
end;

procedure TMain.GetMarkTextAnalogArchive(Sender: TChartSeries;
  ValueIndex: Integer; var MarkText: string);
begin
  MarkText := Sender.Title;
end;

procedure TMain.GridDisplayParamsBooShowSeriesToggleClick(Sender: TObject;
  const Text: string; State: TdxCheckBoxState);
begin
  raise Exception.Create('Временно закрыл на подмену dx на cx');
//  if GetArchiveCurrentSeries <> nil then GetArchiveCurrentSeries.Visible := State = cbsChecked;
//  RxArchiveDisplayParams.FieldByName('BooShowSeries').AsBoolean := State = cbsChecked;
//  RefreshCrossValue(ChartTool);
end;

procedure TMain.RestoreArchiveLine;
var
  i : Integer;
begin
  for i := 0 to FArchiveViewList.Count - 1 do
    TLineSeries(TDimensionSeries(FArchiveViewList[i]).Series).Pen.Width := 1;
end;

procedure TMain.HTML1Click(Sender: TObject);
begin
  FReport.ExportToHTML;
end;

procedure TMain.TIFF1Click(Sender: TObject);
begin
  FReport.ExportToTIFF;
end;

procedure TMain.BtnUseDesignStepClick(Sender: TObject);
begin
//  SpDesignArea.UseStep := BtnUseDesignStep.Down;
end;

procedure TMain.ToolButton9Click(Sender: TObject);
begin
  RefreshPlan;
end;

procedure TMain.JPEG1Click(Sender: TObject);
begin
  FReport.ExportToJPEG;
end;

function TMain.FindNodeByStr(TreeList: TcxTreeList; FocusedNodeStart, FocusedNodeEnd: TcxTreeListNode;
  const FindStr : string): Boolean;
begin
  Result := False;
  while FocusedNodeStart <> FocusedNodeEnd do
  begin
    if Pos(AnsiUpperCase(FindStr), AnsiUpperCase(FocusedNodeStart.Texts[0])) > 0 then
    begin
      FocusedNodeStart.Expand(True);
      FocusedNodeStart.Focused := True;
      Result := True;
      Break;
    end;
    FocusedNodeStart := FocusedNodeStart.GetNext;
  end;
end;

procedure TMain.AnalogSearchExecute(Sender: TObject);
var
  Node: TcxTreeListNode;
  FindStr: string;
begin
  if _InputQuery('Поиск элемента', 'Строка поиска', FindStr) then
  begin
    Node := PlanTree.FocusedNode;
    if not FindNodeByStr(PlanTree, Node.GetNext, nil, FindStr) then
    if not FindNodeByStr(PlanTree, PlanTree.TopNode, Node, FindStr) then
      _MessageBox(Handle, PChar('Искомый элемент не найден !!!'), 'Предупреждение', MB_OK + MB_ICONQUESTION);
  end;
end;

procedure TMain.AnalogSearchUpdate(Sender: TObject);
begin
  AnalogSearch.Enabled := PlanTree.Count > 0;
end;

procedure TMain.ActionSettingsExecute(Sender: TObject);
var
  fSettings: TSettings;
begin
  fSettings := TSettings.Create(nil);
  try
    fSettings.Execute;
  finally
    fSettings.Free;
  end;
end;

procedure TMain.ShowAlertForm(const AlertText: string);
begin
  if not Assigned(AlertForm) then AlertForm := TAlertForm.Create(nil);
  AlertForm.AlertText := AlertText;
  //Восстанавливаю все свернутые окна приложения до нормального размера*********
  Application.Restore;
  AlertForm.Show;
end;

procedure TMain.ShowScaleMarksArchiveExecute(Sender: TObject);
var i: Integer;
begin
  for i := 0 to ArchiveChart.SeriesCount - 1 do
  begin
    with ArchiveChart.Series[i] as TLineSeries do
    begin
      Pointer.Style := psStar;
      Pointer.Show;
      Pointer.HorizSize := 2;
      Pointer.VertSize := 2;
      Pointer.Visible := ToolBtnShowMarksArchive.Down;
    end;
  end;
end;

procedure TMain.ShowScaleMarksArchiveUpdate(Sender: TObject);
begin
  ShowScaleMarksArchive.Enabled := FArchiveChoosed;
end;

procedure TMain.SpDesignAreaClick(Sender: TObject);
begin
//  if Assigned(FObjectInspector) then FObjectInspector.DesignControl := SpDesignArea;
end;

procedure TMain.SpDesignAreaSave(Sender: TObject);
var
  IniFile: TIniFile;
  i: Integer;
  Chart: TChartE;
begin
  IniFile := TIniFile.Create(GetConfigIniFile);
  try
    for i := 0 to SpDesignArea.ControlCount - 1 do
      if SpDesignArea.Controls[i] is TChart then
      begin
        Chart := TChartE(SpDesignArea.Controls[i]);
        IniFile.WriteInteger(PROPERTY_DIAGRAM_KEY, Format(DIAGRAM_POSITION_VAL, [UDM.Host, Chart.ID, 'Left']), Chart.Left);
        IniFile.WriteInteger(PROPERTY_DIAGRAM_KEY, Format(DIAGRAM_POSITION_VAL, [UDM.Host, Chart.ID, 'Top']), Chart.Top);
        IniFile.WriteInteger(PROPERTY_DIAGRAM_KEY, Format(DIAGRAM_POSITION_VAL, [UDM.Host, Chart.ID, 'Width']), Chart.Width);
        IniFile.WriteInteger(PROPERTY_DIAGRAM_KEY, Format(DIAGRAM_POSITION_VAL, [UDM.Host, Chart.ID, 'Height']), Chart.Height);
      end;
  finally
    IniFile.Free;
  end;
end;

procedure TMain.ReportSearchExecute(Sender: TObject);
var
  FixNode: TcxTreeListNode;
begin
  if _InputQuery('Поиск элемента', 'Строка поиска', FFindStrReport) then
  begin
    FixNode := ReportTree.FocusedNode;
    if (FixNode <> nil) and (not FindNodeByStr(ReportTree, FixNode.GetNext, nil, FFindStrReport)) then
    if not FindNodeByStr(ReportTree, ReportTree.TopNode, FixNode, FFindStrReport) then
      _MessageBox(Handle, PChar('Искомый элемент не найден!!!'), 'Предупреждение', MB_OK + MB_ICONQUESTION);
  end;
end;

procedure TMain.ReportSearchUpdate(Sender: TObject);
begin
  ReportSearch.Enabled := ReportTree.Count > 0;
end;

procedure TMain.ReportlFromArchiveExecute(Sender: TObject);
begin
  PanelFromArchive.Visible := ToolButton8.Down;
end;

procedure TMain.ReportlFromArchiveUpdate(Sender: TObject);
begin
  with ReportTree do
  if Assigned(FocusedNode) then
    ReportlFromArchive.Enabled := TObject(FocusedNode.Data) is TReportFilter;
end;

procedure TMain.ReportSQLExecute(Sender: TObject);
var
  ReportNodeClass: TReportNodeClass;
  ConsID: LongWord;
  ReportValue: Variant;
begin
  ReportNodeClass := ReportTree.FocusedNode.Data;
  ConsID := ReportNodeClass.FId;
  ReportValue := UDBData.GetVariantVal('SELECT report_id FROM consumerism WHERE consumerism_id = :id', [ConsID], 'report_id');
  if VarIsNull(ReportValue) then Exit;  
  FSQLMod := TFSQLMod.Create(nil, ReportValue);
  try
    FSQLMod.Execute;
  finally
    FSQLMod.Free;
  end;
end;

procedure TMain.ReportSQLUpdate(Sender: TObject);
begin
  with ReportTree do
  if Assigned(FocusedNode) then
    ReportSQL.Enabled := (TObject(FocusedNode.Data) is TReportNodeClass) and
      (TReportNodeClass(FocusedNode.Data).FTreeElement <> rtaGroup) and
        not (TObject(FocusedNode.Data) is TReportFilter);
end;

procedure TMain.RightScrollChange(Sender: TObject);
var P: Integer;
    aDMin, aDMax: Double;
    aIMin, aIMax: Integer;
begin
  P := RightScroll.Position - 1;
  if (P <= (RightScroll.Max - RightScroll.PageSize)) and (RightScroll.PageSize > 0) then
  begin
    //left
    aIMax := 100 - P;
    aIMin := RightScroll.Max - RightScroll.PageSize - P;
    ArchiveChart.LeftAxis.SetMinMax(aIMin, aIMax);
    //right
    aDMax := GetArchiveCurrentRightAxis.Max / 100 * aIMax;
    aDMin := GetArchiveCurrentRightAxis.Max / 100 * aIMin;
    ArchiveChart.RightAxis.SetMinMax(aDMax, aDMin);
  end else
    RightScroll.Position := RightScroll.Max - RightScroll.PageSize + 1;
end;

procedure TMain.StretchTopExecute(Sender: TObject);
var
  aMin, aMax: Double;
begin
  //left axis
  aMin := ArchiveChart.LeftAxis.Minimum;
  aMax := ArchiveChart.LeftAxis.Maximum - ARCHIVE_STEP_RIGHT_SCROLL;
  if (aMax - aMin) >= ARCHIVE_STEP_RIGHT_SCROLL then
  begin
    ArchiveChart.LeftAxis.SetMinMax(aMin, aMax);
    //right axis
    aMin := ArchiveChart.RightAxis.Minimum;
    aMax := ArchiveChart.RightAxis.Maximum - GetArchiveCurrentRightAxis.Max / 100 * ARCHIVE_STEP_RIGHT_SCROLL;
    ArchiveChart.RightAxis.SetMinMax(aMin, aMax);
    //scroll
    RightScroll.PageSize := RightScroll.PageSize - ARCHIVE_STEP_RIGHT_SCROLL;
    RightScroll.Position := RightScroll.Position + ARCHIVE_STEP_RIGHT_SCROLL;
  end;
end;

procedure TMain.StretchTopUpdate(Sender: TObject);
begin
  StretchTop.Enabled := FArchiveChoosed;
end;

procedure TMain.WORD1Click(Sender: TObject);
begin
  FReport.ExportToRTE;
end;

procedure TMain.XLS1Click(Sender: TObject);
begin
  FReport.ExportToXLS;
end;

procedure TMain.XML1Click(Sender: TObject);
begin
  FReport.ExportToXML;
end;

procedure TMain.AdjustArchiveRightAxis(RightAxis: TDimensionParam);
var MinValue, MaxValue: Double;
begin
  if RightAxis = nil then Exit;
  //минимальное значение
  if ArchiveChart.LeftAxis.Minimum > 0 then
     MinValue := RightAxis.Max / 100 * ArchiveChart.LeftAxis.Minimum
  else
     MinValue := 0;
  //максимальное значение
  if ArchiveChart.LeftAxis.Maximum > 0 then
     MaxValue := RightAxis.Max / 100 * ArchiveChart.LeftAxis.Maximum
  else
     MaxValue := RightAxis.Max;
  ArchiveChart.RightAxis.SetMinMax(MinValue, MaxValue);
  //меняю шаг значений
  ArchiveChart.RightAxis.Increment := MaxValue / 8;
  //properties
//  ArchiveChart.RightAxis.Title.Caption := aArchiveScaleClass.Title;
  ArchiveChart.RightAxis.Title.Caption := RightAxis.DimensionName;
  ArchiveChart.RightAxis.Axis.Color := RightAxis.Color;
  ArchiveChart.RightAxis.Axis.Width := 5;
end;

procedure TMain.AlertArchiveExecute(Sender: TObject);
begin
  FArchiveAlarmsDlg := TAlertArchiveDlg.Create(Self);
  try
    FArchiveAlarmsDlg.ShowModal;
  finally
    FArchiveAlarmsDlg.Free;
  end;
end;

procedure TMain.AnalogfrxReportBeforePrint(Sender: TfrxReportComponent);
var MetaFile: TMetaFile;
begin
  if Sender.Name = 'PictureTeeChart' then
  try
    ArchiveChart.RightAxis.Visible := ToolBtnPrintScaleArchive.Down;
    FVisibleCrossLine := ToolBtnPrintScaleArchive.Down; //отображ cross зависит от кнопки ToolButtonPrintSacle
    MetaFile := ArchiveChart.TeeCreateMetafile(True,
        Rect(0, 0, Round(Sender.Width), Round(Sender.Height)));
    try
      TfrxPictureView(Sender).Picture.Assign(MetaFile);
    finally
      MetaFile.Free;
    end;
  finally
    ArchiveChart.RightAxis.Visible := True; //отображ. scale линию справа
    FVisibleCrossLine := True; //отображ. cross на графике
  end;
end;

procedure TMain.ArchiveChartAfterDraw(Sender: TObject);
begin
  if FArchiveChoosed then DrawArchiveTextInterval;
end;

procedure TMain.ArchiveChartClick(Sender: TObject);
begin
  if not ArchiveChart.Focused then
    Windows.SetFocus(ArchiveChart.Handle);
end;

procedure TMain.ArchiveChartKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_LEFT : ChartTool.XValue := IncMinute(ChartTool.XValue, -1);
    VK_RIGHT : ChartTool.XValue := IncMinute(ChartTool.XValue, +1);
  end;
end;

procedure TMain.ArchiveChartMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var IsLeft: Boolean;
begin
  if FArchiveChoosed then
  begin
    IsLeft := ssLeft in Shift;
    if IsLeft then
    begin
      Windows.SetCursor(Screen.Cursors[crHSplit]);
    end;
    ChartTool.FollowMouse := IsLeft;
  end;
end;

procedure TMain.ArchiveChartMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  //Запретить прокрутку scroll мышью, стандартное свойство, не всегда работает**
  Handled := True;
end;

procedure TMain.DrawArchiveTextInterval;
var
  Interval: string;
  RectOut: TRect;
  aTop, aLeft: Integer;
begin
  with ArchiveChart.Canvas.Font do
  begin
    Color := clSilver;
    Size := 20;
    Style := Style + [fsBold];
  end;
  Interval := FormatDateTime('DD.MM.YYYY hh:mm', ArchiveChart.BottomAxis.Minimum) + ' - ' +
      FormatDateTime('hh:mm', ArchiveChart.BottomAxis.Maximum) + ' "' + FArchiveGroupName + '"';
  aTop := 10;
  aLeft := (ArchiveChart.ClientWidth - ArchiveChart.Canvas.TextWidth(Interval)) div 2;
  RectOut.TopLeft := Point(aLeft, aTop);
  RectOut.Right := aLeft + ArchiveChart.Canvas.TextWidth(Interval);
  RectOut.Bottom := aTop + ArchiveChart.Canvas.TextHeight(Interval);
  DrawText(ArchiveChart.Canvas.Handle, PChar(Interval),
    Length(Interval), RectOut, DT_CENTER);
end;

procedure TMain.BMP1Click(Sender: TObject);
begin
  FReport.ExportToBMP;
end;

procedure TMain.BottomScrollChange(Sender: TObject);
var aH, aM: Word;
    P: Integer;
    aMin, aMax: Double;
begin
  P := BottomScroll.Position - 1;
  if (P <= (BottomScroll.Max - BottomScroll.PageSize)) and (BottomScroll.PageSize > 0) then
  begin
    aH := P div 60;             //час
    aM := P - aH * 60;          //мин
    aMin := ScrollBottomStart + EncodeTime(aH, aM, 0, 0);
    aMax := aMin + ArchiveChart.BottomAxis.Maximum - ArchiveChart.BottomAxis.Minimum;
    ArchiveChart.BottomAxis.SetMinMax(aMin, aMax);
  end else BottomScroll.Position := BottomScroll.Max - BottomScroll.PageSize + 1;
end;

procedure TMain.bsSkinMonthCalendarNumberClick(Sender: TObject);
var
  OriginalReportFilter, ReportFilter: TReportFilter;
  FocusedNode: TcxTreeListNode;
begin
  if FRPreview.PreviewPages <> nil then FRPreview.Clear;
  PanelReportInfo.Show;
  FocusedNode := ReportTree.FocusedNode;
  if FocusedNode <> nil then
  begin
     if TObject(FocusedNode.Data) is TReportFilter then
     begin
       OriginalReportFilter := FocusedNode.Data;
       ReportFilter := TReportFilter.Create;
       try
         ReportFilter.Assign(OriginalReportFilter);
         ShowProgressMessage('Формируется отчет');
         ReportFilter.Date := bsSkinMonthCalendar.Date;
         if not FReport.Preview(ReportFilter) then FRPreview.Clear;
       finally
         CloseProgress;
         ReportFilter.Free;
       end;
     end else
        FRPreview.Clear;
  end;
end;

procedure TMain.ResetHighlightBars;
var
  i: Integer;
  Chart: TChartE;
begin
  for i := 0 to SpDesignArea.ControlCount - 1 do
    if SpDesignArea.Controls[i] is TChartE then
    begin
      Chart := TChartE(SpDesignArea.Controls[i]);
      Chart.ClearSelection;
      Chart.Refresh;
    end;
end;

procedure TMain.PlanSaveAllExecute(Sender: TObject);
begin
  SpDesignArea.Save;
end;

procedure TMain.PlanSaveAllUpdate(Sender: TObject);
begin
  PlanSaveAll.Enabled := (TPlanTreeElement(NodeType(PlanTree.FocusedNode)) = ataElement) and
    SpDesignArea.Designed;
end;

procedure TMain.SaveTabs(const Analog, Archive, Reports: Boolean);
begin
  FIniConfig.SetIniInt(SETTING_KEY, ANALOG_VIEW_PAGE_VAL, Integer(Analog));
  FIniConfig.SetIniInt(SETTING_KEY, ARCHIVE_VIEW_PAGE_VAL, Integer(Archive));
  FIniConfig.SetIniInt(SETTING_KEY, REPORTS_VIEW_PAGE_VAL, Integer(Reports));
end;

procedure TMain.SeriesClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Chart: TChartE;
begin
  //Сбрасываю все выделения на Bar-ах
  if not (ssCtrl in Shift) then ResetHighlightBars;
  //Определяю на какой диаграмме нажали
  Chart := TChartE(Sender.Owner);
  //на диаграмме выделили бар
  Chart.Selected[ValueIndex] := True;
  RefreshPlan;
  Chart.Refresh;
end;

procedure TMain.BuildPlanTree;

  procedure CreateTree(const ID: LongWord; CurNode: TcxTreeListNode);
  var
    ZQuery: TZQuery;
    SQL: string;
    Node: TcxTreeListNode;
    TreeElement: TPlanTreeElement;
  begin
    if ID = 0 then
      SQL := 'SELECT * FROM consumerism ' +
             'WHERE subconsumerism_id IS NULL AND tree = 1 ' +
             'ORDER BY type, consumerism_id'
    else
      SQL := 'SELECT * FROM consumerism ' +
             'WHERE subconsumerism_id = :subconsumerism_id AND tree = 1 ' +
             'ORDER BY type, consumerism_id';
    ZQuery := UDM.CreateDataSet(SQL) as TZQuery;
    try
      if ID > 0 then
        ZQuery.ParamByName('subconsumerism_id').AsInteger := ID;
      ZQuery.Open;
      while not ZQuery.Eof do
      begin
        if CurNode = nil then
          Node := PlanTree.Add
        else
          Node := CurNode.AddChild;
        TreeElement := TPlanTreeElement(ZQuery.FieldByName('type').AsInteger);
        case TreeElement of
          ataGroup : begin
               Node.Data := TPlanNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, ataGroup);
               Node.ImageIndex := 0;
               Node.SelectedIndex := 0;
          end;
          ataElement : begin
               Node.Data := TPlanNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, ataElement);
               Node.ImageIndex := 1;
               Node.SelectedIndex := 1;
          end;
        end;
        Node.Texts[0] := ZQuery.FieldByName('name').AsString;
        Node.Texts[1] := ZQuery.FieldByName('description').AsString;
        CreateTree(ZQuery.FieldByName('consumerism_id').AsInteger, Node);
        ZQuery.Next;
      end;
      ZQuery.Close;
    finally
      ZQuery.Free;
    end;
  end;

begin
  CreateTree(0, nil);
end;

procedure TMain.RefreshPlanTree(const EnabledRefresh: Boolean);
const
  ST_GOOD = 1;
  ST_WARNING = 2;
  ST_BAD = 3;

var
  AnalogNode, AnalogDrawNode: TcxTreeListNode;
  aSQL: string;
  DataSet: TDataSet;
  SignWarning, SignEmergency: Boolean;
  Info: FLASHWINFO;

begin
  SignWarning := False;
  SignEmergency := False;

  //Восстанавливаю все иконки в дереве по умолчанию*****************************
  AnalogNode := PlanTree.TopNode;
  while AnalogNode <> nil do
  begin
    case TPlanTreeElement(NodeType(AnalogNode)) of
      ataGroup : begin
          AnalogNode.ImageIndex := 0;
          AnalogNode.SelectedIndex := 0;
      end;
      ataElement : begin
          AnalogNode.ImageIndex := 1;
          AnalogNode.SelectedIndex := 1;
      end;
    end;
    AnalogNode := AnalogNode.GetNext;
  end;
  cxTabSheet_1.ImageIndex := 0;

  if not EnabledRefresh then Exit;

  aSQL := 'SELECT a.consumerism_id, MAX(a.alert_type) AS alert_type ' +
          'FROM analog_alert a ' +
          'INNER JOIN consumerism c ON c.consumerism_id = a.consumerism_id ' +
          'WHERE c.tree = 1 ' +
          'GROUP BY a.consumerism_id';
  DataSet := UDM.CreateDataSet(aSQL);
  try
    DataSet.Open;
    while not DataSet.Eof do
    begin
      AnalogNode := PlanTree.TopNode;
      while AnalogNode <> nil do
      begin
        if (TPlanTreeElement(NodeType(AnalogNode)) = ataElement) and
          (TPlanNodeClass(AnalogNode.Data).FId = DataSet.FieldByName('consumerism_id').AsInteger) then
        begin
          AnalogDrawNode := AnalogNode;
          while AnalogDrawNode <> nil do
          begin
            case DataSet.FieldByName('alert_type').AsInteger of
                ST_GOOD: begin
                    if TPlanTreeElement(NodeType(AnalogDrawNode)) = ataElement then
                    begin
                      AnalogDrawNode.ImageIndex := 3;                 //GOOD
                      AnalogDrawNode.SelectedIndex := 3;              //GOOD
                    end else begin
                      if (AnalogDrawNode.ImageIndex <> 4 {WARNING}) and (AnalogDrawNode.ImageIndex <> 6 {BAD}) then
                      begin
                        AnalogDrawNode.ImageIndex := 2;               //GOOD
                        AnalogDrawNode.SelectedIndex := 2;            //GOOD
                      end;
                    end;
                end;
                ST_WARNING: begin
                    if TPlanTreeElement(NodeType(AnalogDrawNode)) = ataElement then
                    begin
                      AnalogDrawNode.ImageIndex := 5;               //WARNING
                      AnalogDrawNode.SelectedIndex := 5;            //WARNING
                    end else begin
                      if AnalogDrawNode.ImageIndex <> 6 {BAD} then
                      begin
                        AnalogDrawNode.ImageIndex := 4;             //WARNING
                        AnalogDrawNode.SelectedIndex := 4;          //WARNING
                      end;
                    end;
                    SignWarning := True;
                end;
                ST_BAD: begin
                    if TPlanTreeElement(NodeType(AnalogDrawNode)) = ataElement then
                    begin
                      AnalogDrawNode.ImageIndex := 7;                 //BAD
                      AnalogDrawNode.SelectedIndex := 7;              //BAD
                    end else begin
                      AnalogDrawNode.ImageIndex := 6;                 //BAD
                      AnalogDrawNode.SelectedIndex := 6;              //BAD
                    end;
                    SignEmergency := True;
                end;
            end;
            AnalogDrawNode := AnalogDrawNode.Parent;
          end;
        end;
        AnalogNode := AnalogNode.GetNext;
      end;
      DataSet.Next;
    end;
    DataSet.Close;
  finally
    DataSet.Free;
  end;

  //Устанавливаю иконку на вкладке мнемосхемы***********************************
  if SignWarning and (not SignEmergency) then
  begin
     if cxTabSheet_1.ImageIndex <> 3 then cxTabSheet_1.ImageIndex := 3;
  end else
  if (not SignWarning) and SignEmergency then
  begin
    if cxTabSheet_1.ImageIndex <> 4 then cxTabSheet_1.ImageIndex := 4;
  end;

  //Подсвечиваю statusbar в windows*********************************************
  FillChar(Info, SizeOf(Info), 0);
  Info.cbSize := SizeOf(FLASHWINFO);
  Info.hwnd := Application.Handle;
  //Мерцать при предупреждающих и аварийных ситуациях***************************
  if SignWarning or SignEmergency then
  begin
    if not FlagFlashWindow then
    begin
      //Частота мерцания********************************************************
      Info.dwTimeout := 500;
      Info.dwFlags := FLASHW_ALL or FLASHW_TIMER;
      FlashWindowEx(Info);
      FlagFlashWindow := True;           //Флаг включено************************
    end;
  end else begin
    if FlagFlashWindow then
    begin
      Info.dwFlags := FLASHW_STOP;
      FlashWindowEx(Info);
      FlagFlashWindow := False;          //Флаг отключено***********************
    end;
  end;

  SignWarning := SignWarning and Boolean(FIniConfig.GetIniInt(SETTING_KEY, INI_APP_W_ALERT_FORM, 0));
  SignEmergency := SignEmergency and Boolean(FIniConfig.GetIniInt(SETTING_KEY, INI_APP_E_ALERT_FORM, 0));

  if (SignWarning or SignEmergency) and not Application.Active then
    ShowAlertForm('Программа SpTouch обнаружила внештатную ситуацию.' + #13#10 + 'Эта ситуация была записана в архив.');
end;

procedure TMain.CreateReportPeriod(InputNode : TcxTreeListNode;
  const ReportID : LongWord; const aReportTreeElement : TReportTreeElement);
var
  YearI, MonthI, DayI: Integer;
  Node: TcxTreeListNode;
  MonthName, DayName: string;
  aDay, aMonth, aYear: Extended;
  ReportFilter: TReportFilter;
begin
   case aReportTreeElement of
     rtaDay : begin
       for DayI := 0 to UDBData.GetDayViewReportCount - 1 do
       begin
         Node := InputNode.AddChild;
         aDay := IncDay(UDBData.GetServerDateTime, -DayI);
         DayName := DateToStr(aDay);
         Node.Texts[0] := DayName;
         ReportFilter := TReportFilter.Create;
         ReportFilter.ReportId := ReportID;
         ReportFilter.ReportType := rtaDay;
         ReportFilter.Date := DateUtils.StartOfADay(YearOf(aDay), MonthOf(aDay), DayOf(aDay));
         Node.Data := ReportFilter;
         Node.ImageIndex := 1;
         Node.SelectedIndex := 1;
       end;
     end;
     rtaMonth : begin
       for MonthI := 0 to UDBData.GetMonthViewReportCount - 1 do
       begin
         Node := InputNode.AddChild;
         //получ. дату сдвинутую на -Month
         aMonth := IncMonth(UDBData.GetServerDateTime, -MonthI);
         case MonthOf(aMonth) of
             1 : MonthName := 'За январь';
             2 : MonthName := 'За февраль';
             3 : MonthName := 'За март';
             4 : MonthName := 'За апрель';
             5 : MonthName := 'За май';
             6 : MonthName := 'За июнь';
             7 : MonthName := 'За июль';
             8 : MonthName := 'За август';
             9 : MonthName := 'За сентябрь';
             10 : MonthName := 'За октябрь';
             11 : MonthName := 'За ноябрь';
             12 : MonthName := 'За декабрь';
         end;
         if YearOf(aMonth) < YearOf(UDBData.GetServerDateTime) then
            MonthName := MonthName + ' (' +
              FormatDateTime('yyyy', aMonth) + ')';
         Node.Texts[0] := MonthName;
         ReportFilter := TReportFilter.Create;
         ReportFilter.ReportId := ReportID;
         ReportFilter.ReportType := rtaMonth;
         ReportFilter.Date := StartOfAMonth(YearOf(aMonth), MonthOf(aMonth));
         Node.Data := ReportFilter;
         Node.ImageIndex := 1;
         Node.SelectedIndex := 1;
       end;
     end;
     rtaYear : begin
       for YearI := 0 to UDBData.GetYearViewReportCount - 1 do
       begin
         Node := InputNode.AddChild;
         aYear := IncYear(UDBData.GetServerDateTime, -YearI);
         Node.Texts[0] := IntToStr(YearOf(aYear));
         ReportFilter := TReportFilter.Create;
         ReportFilter.ReportId := ReportID;
         ReportFilter.ReportType := rtaYear;
         ReportFilter.Date := StartOfTheYear(aYear);
         Node.Data := ReportFilter;
         Node.ImageIndex := 1;
         Node.SelectedIndex := 1;
       end;
     end;
   end;
end;

procedure TMain.BuildReportTree;

  procedure CreateTree(const aConsumerismId : LongWord; aCurNode : TcxTreeListNode);
  var
    ZQuery : TZQuery;
    SQL: string;
    Node: TcxTreeListNode;
    ReportTreeElement: TReportTreeElement;
    ReportNodeClass: TReportNodeClass;
  begin
    SQL :=
    'SELECT c.consumerism_id,                ' +
    '       c.report_id,                     ' +
    '       c.name,                          ' +
    '       c.description,                   ' +
    '       c.type                           ' +
    'FROM consumerism c                          ' +
    'LEFT JOIN reports r ON r.report_id = c.report_id                                      ' +
    'WHERE IF(:subconsumerism_id = 0, c.subconsumerism_id IS NULL, c.subconsumerism_id = :subconsumerism_id) ' +
    'AND c.tree = 2 ORDER BY c.type, c.consumerism_id                      ';
    ZQuery := UDM.CreateDataSet(SQL) as TZQuery;
    try
      ZQuery.ParamByName('subconsumerism_id').AsInteger := aConsumerismId;
      ZQuery.Open;
      while not ZQuery.Eof do
      begin
        if ACurNode = nil then
          Node := ReportTree.Add
        else
          Node := ACurNode.AddChild;
        ReportTreeElement := TReportTreeElement(ZQuery.FieldByName('type').AsInteger);
        case ReportTreeElement of
          rtaGroup : begin
                ReportNodeClass := TReportNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, rtaGroup);
                ReportNodeClass.FReportId := ZQuery.FieldByName('report_id').AsInteger;
                Node.Data := ReportNodeClass;
                Node.ImageIndex := 0;
                Node.SelectedIndex := 0;
                CreateReportPeriod(Node, ZQuery.FieldByName('report_id').AsInteger, rtaGroup);
          end;
          rtaDay : begin
                ReportNodeClass := TReportNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, rtaDay);
                ReportNodeClass.FReportId := ZQuery.FieldByName('report_id').AsInteger;
                Node.Data := ReportNodeClass;
                Node.ImageIndex := 1;
                Node.SelectedIndex := 1;
                CreateReportPeriod(Node, ZQuery.FieldByName('report_id').AsInteger, rtaDay);
          end;
          rtaMonth : begin
                ReportNodeClass := TReportNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, rtaMonth);
                ReportNodeClass.FReportId := ZQuery.FieldByName('report_id').AsInteger;
                Node.Data := ReportNodeClass;
                Node.ImageIndex := 1;
                Node.SelectedIndex := 1;
                CreateReportPeriod(Node, ZQuery.FieldByName('report_id').AsInteger, rtaMonth);
          end;
          rtaYear : begin
                ReportNodeClass := TReportNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, rtaYear);
                ReportNodeClass.FReportId := ZQuery.FieldByName('report_id').AsInteger;
                Node.Data := ReportNodeClass;
                Node.ImageIndex := 1;
                Node.SelectedIndex := 1;
                CreateReportPeriod(Node, ZQuery.FieldByName('report_id').AsInteger, rtaYear);
          end;
          rtaSimple : begin
                ReportNodeClass := TReportNodeClass.Create(ZQuery.FieldByName('consumerism_id').AsInteger, rtaSimple);
                ReportNodeClass.FReportId := ZQuery.FieldByName('report_id').AsInteger;
                Node.Data := ReportNodeClass;
                Node.ImageIndex := 2;
                Node.SelectedIndex := 2;
          end;
        end;
        Node.Texts[0] := ZQuery.FieldByName('name').AsString;
        Node.Texts[1] := ZQuery.FieldByName('description').AsString;
        CreateTree(ZQuery.FieldByName('consumerism_id').AsInteger, Node);
        ZQuery.Next;
      end;
      ZQuery.Close;
    finally
      ZQuery.Free;
    end;
  end;

begin
  CreateTree(0, nil);
end;

procedure TMain.ChartToolChange(Sender: TCursorTool; X, Y: Integer; const XValue,
  YValue: Double; Series: TChartSeries; ValueIndex: Integer);
begin
  RefreshCrossValue(Sender);
end;

function TMain.NodeType(Node: TcxTreeListNode): Byte;
var
  Obj: TObject;
begin
  Result := 0;
  if (Node = nil) or (Node.Data = nil) then Exit;
  Obj := TObject(Node.Data);
  if Obj is TPlanNodeClass then
    Result := Integer(TPlanNodeClass(Obj).FTreeElement)
  else
    if Obj is TReportNodeClass then
      Result := Integer(TReportNodeClass(Obj).FTreeElement);
end;

procedure TMain.RefreshCrossValue(CursorTool: TCursorTool);
var
  i, i1, i2, SeriesI, ArchiveI: Integer;
  x1, x2, y1, y2, nominator, denominator, v: Double;
  RightAxis: TDimensionSeries;
  LabelControl: TLabel;

  function RoundEx(const aValue: Double; const Precision: Byte): Double;
  var ScaledFractPart, Temp: Double;
  begin
    ScaledFractPart := Frac(aValue) * Precision;
    Temp := Frac(ScaledFractPart);
    ScaledFractPart := Int(ScaledFractPart);
    if Temp >= 0.5 then
      ScaledFractPart := ScaledFractPart + 1;
    if Temp <= -0.5 then
      ScaledFractPart := ScaledFractPart - 1;
    Result := Int(aValue) + ScaledFractPart / Precision;
  end;

begin
  TagCrossTime.Caption := FormatDateTime('hh:mm', CursorTool.XValue);

  //Обойду все series и выведу показаний на панель располож справа графика
  SeriesI := 0;
  while SeriesI < ArchiveChart.SeriesCount do
  begin
    v := 0;
    i1 := 0;
    i2 := ArchiveChart.Series[SeriesI].XValues.Count - 1;
    if ArchiveChart.Series[SeriesI].Visible and
     (CursorTool.XValue >= ArchiveChart.Series[SeriesI].MinXValue) and
       (CursorTool.XValue <= ArchiveChart.Series[SeriesI].MaxXValue) and (i2 > 0) then
    begin
      //Отыскиваю ближайшие точки на графике относительно текущей***************
      repeat
        i := (i1 + i2) div 2;
        if CursorTool.XValue > ArchiveChart.Series[SeriesI].XValue[i] then
          i1 := i
        else
          i2 := i;
      until (i2 - i1) <= 1;

      x1 := ArchiveChart.Series[SeriesI].XValue[i1];
      x2 := ArchiveChart.Series[SeriesI].XValue[i2];
      y1 := ArchiveChart.Series[SeriesI].YValue[i1];
      y2 := ArchiveChart.Series[SeriesI].YValue[i2];

      //По формуле определяю пересечение с cross right axis*********************
      nominator := (x2 - x1) * (y2 - y1);
      denominator := x2 - x1;
      if denominator = 0 then denominator := 1;
      v := nominator / denominator + y1;
    end;

    //Ищу связанный объект с series*********************************************
    RightAxis := nil;
    for ArchiveI := 0 to FArchiveViewList.Count - 1 do
    begin
      if TDimensionSeries(FArchiveViewList[ArchiveI]).FSeries = ArchiveChart.Series[SeriesI] then
      begin
        RightAxis := TDimensionSeries(FArchiveViewList[ArchiveI]);
        Break;
      end;
    end;

    //Пересчитываю процент в значение*******************************************
    v := RightAxis.Max / 100 * v;

    //Использую существующую label**********************************************
    LabelControl := nil;
    if SeriesI < PanelCrossValues.ComponentCount then
      LabelControl := TLabel(PanelCrossValues.Components[SeriesI]);

    //Создаю компоненты*********************************************************
    if not Assigned(LabelControl) then
    begin
      LabelControl := TLabel.Create(PanelCrossValues);
      with LabelControl do
      begin
        Top := (PanelCrossValues.ComponentCount - 1) * 25;
        Parent := PanelCrossValues;
        AutoSize := False;
        Transparent := True;
        Height := 25;
        Font.Size := 14;
        Font.Style := [fsBold];
        ControlStyle := ControlStyle + [csOpaque];
      end;
    end;

    //Отображу значения crossline в виде label списка***************************
    with LabelControl do
    begin
      if RightAxis.ID = RxArchiveDisplayParams.FieldByName('paramquery_id').AsInteger then
        Font.Color := RightAxis.Color
      else
        Font.Color := Lighter(RightAxis.Color, 50);
      Width := PanelCrossValues.Width;
      Caption := FloatToStr(RoundEx(v, 100)) + #9 + RightAxis.DimensionName;
    end;
    Inc(SeriesI);
  end;

  //Удалю лишние label с панели*************************************************
  while PanelCrossValues.ComponentCount > SeriesI do
    PanelCrossValues.Components[PanelCrossValues.ComponentCount - 1].Free;

  //Задаю высоту панели*********************************************************
  if PanelCrossValues.ComponentCount > 0 then
    PanelCrossValues.Height := PanelCrossValues.ComponentCount * TControl(PanelCrossValues.Components[0]).Height;
end;

procedure TMain.ClearPlanArea;
var
  i: Integer;
begin
  i := SpDesignArea.ComponentCount - 1;
  while i >= 0 do
  begin
    SpDesignArea.Components[i].Free;
    Dec(i);
  end;
end;

procedure TMain.ClearTreeListData(const TreeList : TcxTreeList);
var
  Node: TcxTreeListNode;
begin
  if TreeList = nil then Exit;
  Node := TreeList.TopNode;
  while Node <> nil do
  begin
     if Node.Data <> nil then
     begin
        TObject(Node.Data).Free;
     end;
     Node := Node.GetNext;
  end;
end;

procedure TMain.dxBarBtnAnalogClick(Sender: TObject);
begin
  cxTabSheet_1.TabVisible := dxBarBtnAnalog.Down;
  SaveTabs(dxBarBtnAnalog.Down, dxBarBtnArchive.Down, dxBarBtnReports.Down);
  if cxTabSheet_1.TabVisible then
    PageControl.ActivePage := cxTabSheet_1;
end;

procedure TMain.dxBarBtnArchiveClick(Sender: TObject);
begin
  cxTabSheet_2.TabVisible := dxBarBtnArchive.Down;
  SaveTabs(dxBarBtnAnalog.Down, dxBarBtnArchive.Down, dxBarBtnReports.Down);
  if cxTabSheet_2.TabVisible then
    PageControl.ActivePage := cxTabSheet_2;
end;

procedure TMain.dxBarBtnReportsClick(Sender: TObject);
begin
  cxTabSheet_3.TabVisible := dxBarBtnReports.Down;
  SaveTabs(dxBarBtnAnalog.Down, dxBarBtnArchive.Down, dxBarBtnReports.Down);
  if cxTabSheet_3.TabVisible then
    PageControl.ActivePage := cxTabSheet_3;
end;

procedure TMain.PlanTreeColumnHeaderClick(Sender: TcxCustomTreeList;
  AColumn: TcxTreeListColumn);
begin
  ExpandAll(PlanTree);
  ClearPlanArea;
end;

procedure TMain.PlanTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  NodeDrop, NodeDrag: TcxTreeListNode;
  ConsID, SubConsID: LongWord;
begin
  NodeDrop := PlanTree.GetNodeAt(X, Y);
  NodeDrag := PlanTree.FocusedNode;
  ConsID := TReportNodeClass(NodeDrag.Data).FId;
  SubConsID := TReportNodeClass(NodeDrop.Data).FId;
  NodeDrag.MoveTo(NodeDrop, tlamAddChildFirst);
  try
    UDBData.UpdateConsSubId(ConsID, SubConsID);
    if UDBData.InTransaction then
      UDBData.ComitTransaction;
  except
    if UDBData.InTransaction then
      UDBData.RollBackTransaction;
  end;
end;

procedure TMain.PlanTreeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Node: TcxTreeListNode;
begin
  Accept := False;
  Node := PlanTree.GetNodeAt(X, Y);
  if Assigned(Node) then
    if TObject(Node.Data) is TPlanNodeClass then
      if TPlanTreeElement(NodeType(Node)) = ataGroup then Accept := True;
end;

procedure TMain.PlanTreeFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  if SpDesignArea.Designed then
    if _MessageBox(Handle, PChar('Сохранить изменения?'),
      'Предупреждение', MB_YESNO + MB_ICONQUESTION) = IDYES then
        SpDesignArea.Save
    else
      SpDesignArea.Cancel;

  PlanTimer.Enabled := False;

  DesignAreaBtn.Down := False;
  SpDesignArea.DesignView := False;

  ClearPlanArea;
  CreatePlanDiagram(CurrentID(PlanTree));
  RefreshPlan;

  if TPlanTreeElement(NodeType(PlanTree.FocusedNode)) = ataElement then
    ProductInfo.Caption := PlanTree.FocusedNode.Texts[1]
  else
    ProductInfo.Caption := EmptyStr;

  PlanTimer.Enabled := True;
end;

procedure TMain.PlanTreeGetDragDropText(Sender: TcxCustomTreeList;
  ANode: TcxTreeListNode; var AText: string);
begin
  AText := ANode.Texts[0];
end;

procedure TMain.PlanTreeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  S: string;
begin
  if Assigned(PlanTree.GetNodeAt(X, Y)) then
  begin
    S := PlanTree.GetNodeAt(X, Y).Texts[1];
    if S <> PlanTree.Hint then Application.CancelHint;
    PlanTree.Hint := S;
    PlanTree.ShowHint := True;
  end else begin
    Application.CancelHint;
    PlanTree.Hint := EmptyStr;
    PlanTree.ShowHint := False;
  end;
end;

procedure TMain.TEXT1Click(Sender: TObject);
begin
  FReport.ExportToTEXT;
end;

procedure TMain.ExpandAll(const TreeList : TcxTreeList);
var
  Node: TcxTreeListNode;
  Flag: Boolean;
begin
  Node := TreeList.TopNode;
  if Assigned(Node) then
  begin
    Flag := TreeList.Columns[0].Caption.Text = '+';
    if Flag then
    begin
      Node.Collapse(True);
      TreeList.Columns[0].Caption.Text := '-';
    end else begin
      Node.Expand(True);
      TreeList.Columns[0].Caption.Text := '+';
    end;
  end;
end;

procedure TMain.ReportTreeColumnHeaderClick(Sender: TcxCustomTreeList;
  AColumn: TcxTreeListColumn);
var
  Node: TcxTreeListNode;
begin
//  if AColumn = dxTLReportColumnName then
//  begin
    ExpandAll(ReportTree);
    Node := ReportTree.FocusedNode;
    if (Node = nil) or (Node.Data = nil) then FRPreview.Clear;
//  end;
end;

procedure TMain.ReportTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  NodeDrop, NodeDrag: TcxTreeListNode;
  ConsID, SubConsID: LongWord;
begin
  NodeDrop := ReportTree.GetNodeAt(X, Y);
  NodeDrag := ReportTree.FocusedNode;
  ConsID := TReportNodeClass(NodeDrag.Data).FId;
  SubConsID := TReportNodeClass(NodeDrop.Data).FId;
  NodeDrag.MoveTo(NodeDrop, tlamAddChildFirst);
  UDBData.UpdateConsSubId(ConsID, SubConsID);
  if UDBData.InTransaction then
    UDBData.ComitTransaction;
end;

procedure TMain.ReportTreeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  NodeDrop, NodeDrag: TcxTreeListNode;
begin
  Accept := False;
  NodeDrag := ReportTree.FocusedNode;
  if not (TObject(NodeDrag.Data) is TReportFilter) then
  begin
    NodeDrop := ReportTree.GetNodeAt(X, Y);
    if NodeDrop <> nil then
    if TObject(NodeDrop.Data) is TReportNodeClass then
      Accept := TReportTreeElement(NodeType(NodeDrop)) = rtaGroup;
  end;
end;

procedure TMain.ReportTreeFocusedNodeChanged(Sender: TcxCustomTreeList;
  APrevFocusedNode, AFocusedNode: TcxTreeListNode);
var
  ReportFilter: TReportFilter;
  FocusedNode: TcxTreeListNode;
begin
  if FRPreview.PreviewPages <> nil then FRPreview.Clear;
  PanelReportInfo.Hide;
  bsSkinMonthCalendar.DrawElement := [];
  FocusedNode := ReportTree.FocusedNode;
  if Assigned(FocusedNode) then
  begin
     if TObject(FocusedNode.Data) is TReportFilter then
     begin
       ReportFilter := FocusedNode.Data;
       case ReportFilter.ReportType of
         rtaDay : bsSkinMonthCalendar.DrawElement := [daMonth, daDay];
         rtaMonth : bsSkinMonthCalendar.DrawElement := [daMonth];
       end;
       bsSkinMonthCalendar.Date := ReportFilter.Date;
       ShowProgressMessage('Формируется отчет');
       try
         if not FReport.Preview(ReportFilter) then FRPreview.Clear;
         Application.ProcessMessages;
       finally
         CloseProgress;
       end;
     end else
     if TReportTreeElement(NodeType(FocusedNode)) = rtaSimple then
     begin
       ReportFilter := TReportFilter.Create;
       try
         ReportFilter.ReportId := TReportNodeClass(FocusedNode.Data).FReportId;
         if not FReport.Preview(ReportFilter) then
           FRPreview.Clear;
       finally
         ReportFilter.Free;
       end;
     end else
        FRPreview.Clear;
  end;
end;

procedure TMain.ReportTreeGetDragDropText(Sender: TcxCustomTreeList;
  ANode: TcxTreeListNode; var AText: string);
begin
  AText := ANode.Texts[0];
end;

procedure TMain.ReportTreeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  S: string;
begin
 if ReportTree.GetNodeAt(X, Y) <> nil then
 begin
   S := ReportTree.GetNodeAt(X, Y).Texts[1];
   if S <> ReportTree.Hint then
     Application.CancelHint;
   ReportTree.Hint := S;
   ReportTree.ShowHint := True;
 end else begin
   Application.CancelHint;
   ReportTree.Hint := EmptyStr;
   ReportTree.ShowHint := False;
 end;
end;

procedure TMain.RefreshPlanInfo(const EnabledRefresh: Boolean);
begin
  if cxPageControl.ActivePage = cxTabSheet1 then
    RefreshPlanInfoParam(EnabledRefresh) //обновляю параметры
  else
    if cxPageControl.ActivePage = cxTabSheet2 then
      RefreshPlanInfoArchive(EnabledRefresh);  //обновляю архив параметра с начала суток
end;

procedure TMain.RefreshPlanInfoArchive(const EnabledRefresh: Boolean);
var
  aSQL : string;
  Chart: TChartE;
  i, aBarIndex: Integer;
  BarDataClass: TDimensionParam;
  zDataSet : TZQuery;
  Series : TLineSeriesE;
  oldMax: Double;
begin
  ChartInfoBarArchive.SeriesList.Clear;
  //сбрасываю левую ось. далее буду определяю максимум по выделенным параметрам
  ChartInfoBarArchive.LeftAxis.SetMinMax(0, 0);  
  ChartInfoBarArchive.Visible := False;
  //надпись формирую данные ...
  if not Assigned(FInfoArchiveLabel) then
  begin  
    FInfoArchiveLabel := TLabel.Create(Self);
    FInfoArchiveLabel.Parent := cxTabSheet2;
    FInfoArchiveLabel.Align := alClient;
    FInfoArchiveLabel.Alignment := taCenter;
    FInfoArchiveLabel.Font.Style := [fsBold];
    FInfoArchiveLabel.Layout := tlCenter;
  end;
  FInfoArchiveLabel.Visible := False;
  if (not EnabledRefresh) or (TPlanTreeElement(NodeType(PlanTree.FocusedNode)) <> ataElement) then Exit;
  //вывожу указанный параметр за текущее сутки. использую индексированные поля
  aSQL := 'SELECT paramquery_id, date, value                              ' +
          'FROM anlarchive                                                ' +
          'WHERE paramquery_id = :paramquery_id AND DATE(date) = CURDATE()';
  for i := 0 to SpDesignArea.ControlCount - 1 do
    if SpDesignArea.Controls[i] is TChartE then
    begin
      Chart := TChartE(SpDesignArea.Controls[i]);
      for aBarIndex := 0 to Chart.ValueSeries.Count - 1 do
      begin
        if Chart.Selected[aBarIndex] then
        begin
          FInfoArchiveLabel.Caption := 'Формирую данные...';
          FInfoArchiveLabel.Visible := True;
          //Определил какой Bar на диаграмме выделен
          BarDataClass := TDimensionParam(Chart.ValueSeries.FBarsList[aBarIndex]);
          with ChartInfoBarArchive do
          begin
            LeftAxis.Automatic := False;
            MarginUnits := muPixels;
            MarginLeft := 4;
            MarginBottom := 0;
            MarginTop := 8;
            MarginRight := 4;
            BottomAxis.DateTimeFormat := 'hh:mm';
            LeftAxis.Axis.Width := 1;
            LeftAxis.ExactDateTime := False;
            LeftAxis.Ticks.Visible := False;
            LeftAxis.Title.Font.Style := [fsBold];
            LeftAxis.LabelsSize := 25;
            //Интервал отображения шага между label
            LeftAxis.Grid.Style := psDashDotDot;
            LeftAxis.Grid.SmallDots := True;
            LeftAxis.Grid.SmallSpace := 5;
            BottomAxis.Ticks.Visible := False;
            View3D := False;
            Zoom.Allow := False;
            Legend.Visible := False;
            Title.Visible := False;
            RightAxis.Visible := False;
            TopAxis.Visible := False;
            oldMax := BarDataClass.Max;
            if oldMax < LeftAxis.Maximum then oldMax := LeftAxis.Maximum;
            LeftAxis.SetMinMax(-oldMax, oldMax);
          end;
          //создаю серию
          Series := TLineSeriesE.Create(ChartInfoBarArchive);
          with Series do
          begin
            ID := BarDataClass.ID;
            OnGetMarkText := GetMarkTextAnalogArchive;
            SeriesColor := BarDataClass.Color;
            Marks.Visible := True;
            Marks.Clip := True;
            Marks.Callout.Length := 0;
            Marks.Callout.Distance := -7;
            Marks.Font.Size := 10;
            Marks.Font.Name := 'Lucida Console';
            Marks.Transparent := True;
            LinePen.Width := 1;
            XValues.DateTime := True;
            VertAxis := aBothVertAxis;
            SeriesColor := BarDataClass.Color;
            Title := BarDataClass.Caption;
          end;
          //заполняю параметрами серию на диаграмме
          zDataSet := TZQuery(UDM.CreateDataSet(aSQL));
          try
            zDataSet.ParamByName('paramquery_id').AsInteger := BarDataClass.ID;
            zDataSet.Open;
            ChartInfoBarArchive.BottomAxis.SetMinMax(StartOfTheDay(zDataSet.FieldByName('date').AsDateTime),
              EndOfTheDay(zDataSet.FieldByName('date').AsDateTime));
            while not zDataSet.Eof do
            begin
              //дорисую график вначале и в конце
              if (MinuteOfTheDay(zDataSet.FieldByName('date').AsDateTime) <= 15) then
                if zDataSet.RecNo = 1 then
                  Series.AddXY(ChartInfoBarArchive.BottomAxis.Minimum, zDataSet.FieldByName('value').AsFloat)
                else
                  if zDataSet.RecNo = Pred(zDataSet.RecordCount) then
                    Series.AddXY(ChartInfoBarArchive.BottomAxis.Maximum, zDataSet.FieldByName('value').AsFloat);
              //вывожу значение на графике
              Series.AddXY(zDataSet.FieldByName('date').AsDateTime, zDataSet.FieldByName('value').AsFloat);
              zDataSet.Next;
            end;
            //имя графика на самом графике
            Series.Marks.DrawEvery := Round(zDataSet.RecordCount / 100 * 30); //каждый 30%
            zDataSet.Close;
          finally
            zDataSet.Free;
          end;
          ChartInfoBarArchive.AddSeries(Series);
          ChartInfoBarArchive.Visible := True;  //покажу график
          FInfoArchiveLabel.Visible := False;
        end else begin
          FInfoArchiveLabel.Caption := 'Не выбран параметр';
          FInfoArchiveLabel.Visible := True;
        end;
      end;
    end;
end;

procedure TMain.RefreshPlan;
begin
  RefreshPlanTree(not SpDesignArea.DesignView);
  RefreshPlanBar(not SpDesignArea.DesignView);
  RefreshPlanInfo(not SpDesignArea.DesignView);
  RefreshPlanInfoParam(not SpDesignArea.DesignView);
  RefreshPlanInfoArchive(not SpDesignArea.DesignView);
  RefreshConnectionInfo;
  PlanLastUpdateLabel.Caption := TimeToStr(Now);
end;

procedure TMain.RefreshPlanBar(const EnabledRefresh : Boolean);
var
  i, aBarIndex: Integer;
  SQL: string;
  aZQuery: TZQuery;
  Chart: TChartE;
  barColor: TColor;
  BarParam: TDimensionParam;
  Node: TcxTreeListNode;
  AnalogNodeClass: TPlanNodeClass;
begin
  if not EnabledRefresh then Exit;
  Node := PlanTree.FocusedNode;
  if TPlanTreeElement(NodeType(Node)) <> ataElement then Exit;
  ASSERT(TObject(Node.Data) is TPlanNodeClass);
  AnalogNodeClass := TPlanNodeClass(Node.Data);
  SQL := 'SELECT pq.paramquery_id,                                                   ' +
         ' pd.diagram_id,                                                            ' +
         ' pd.order,                                                                 ' +
         ' pd.color,                                                                 ' +
         ' pd.caption,                                                               ' +
         ' pd.avalue,                                                                ' +
         ' pd.wvalue,                                                                ' +
         ' CASE                                                                      ' +
         ' WHEN TIMESTAMPDIFF(MINUTE, pq.lastvalueupdate, NOW()) <= 10 THEN pq.value ' +
         ' ELSE 0                                                                    ' +
         ' END AS value,                                                             ' +
         ' m.description AS meter_description,                                       ' +
         ' m.name AS meter_name,                                                     ' +
         ' d.dimensionname,                                                          ' +
         ' p.canal,                                                                  ' +
         ' pq.name AS paramquery_name,                                               ' +
         ' d.lvalue,                                                                 ' +
         ' d.hvalue                                                                  ' +
         'FROM paramsqueries pq                                                      ' +
         'INNER JOIN params p ON p.param_id = pq.param_id                            ' +
         'INNER JOIN paramsdiagrams pd ON pd.paramquery_id = pq.paramquery_id        ' +
         'INNER JOIN diagrams d ON d.diagram_id = pd.diagram_id                      ' +
         'INNER JOIN meters m ON m.meter_id = pq.meter_id                            ' +
         'WHERE d.consumerism_id = :consumerism_id                                   ' +
         'ORDER BY pd.diagram_id, pd.order';
  aZQuery := UDM.CreateDataSet(SQL) as TZQuery;
  try
    aZQuery.ParamByName('consumerism_id').AsInteger := AnalogNodeClass.ID;
    aZQuery.Open;
    while not aZQuery.Eof do
    begin
      for i := 0 to SpDesignArea.ControlCount - 1 do
        if SpDesignArea.Controls[i] is TChartE then
        begin
          Chart := TChartE(SpDesignArea.Controls[i]);
          with Chart, aZQuery do
          begin
            if ID = FieldByName('diagram_id').AsInteger then
            begin
              aBarIndex := ValueSeries.IndexOf(FieldByName('paramquery_id').AsInteger);
              if aBarIndex <> -1 then
                BarParam := ValueSeries.Bars[aBarIndex]
              else begin
                BarParam := TDimensionParam.Create;
                aBarIndex := ValueSeries.AddBar(FieldByName('value').AsFloat,
                  FieldByName('caption').AsString, FieldByName('color').AsInteger, BarParam);
                MaxValueSeries.AddBar(FieldByName('hvalue').AsFloat, EmptyStr, $00F4F4F4, nil);
              end;
              with BarParam do
              begin
                ID := FieldByName('paramquery_id').AsInteger;
                Caption := FieldByName('caption').AsString;
                Min := FieldByName('lvalue').AsFloat;
                Max := FieldByName('hvalue').AsFloat;
                //текущее показание
                Current := FieldByName('value').AsFloat;
                //предупреждающее показание
                Warning := FieldByName('wvalue').AsFloat;
                //аварийное показание
                Emergency := FieldByName('avalue').AsFloat;
                //описание прибора
                DeviceName := FieldByName('meter_description').AsString {$IFDEF USE_ADMIN} + ' "' + FieldByName('meter_name').AsString + '"' {$ENDIF};
                //имя параметра
                DimensionName := FieldByName('dimensionname').AsString;
                //трубопровод
                Canal := FieldByName('canal').AsInteger;
                //сигнализация
                if (Emergency <> 0) and (Current >= Emergency) then
                begin
                  //красный бар
                  BarColor := clRed;
                end else
                if (Warning <> 0) and (Current >= Warning) then
                  //желтый бар
                  BarColor := clYellow
                else
                  //нормальный бар
                  BarColor := FieldByName('color').AsInteger;

                Color := BarColor;
                ValueSeries.YValues[aBarIndex] := Current;
                ValueSeries.ValueMarkText[aBarIndex] := FieldByName('caption').AsString;
                ValueSeries.ValueColor[aBarIndex] := BarColor;
                MaxValueSeries.YValues[aBarIndex] := BarParam.Max;
                MaxValueSeries.ValueColor[aBarIndex] := $00F4F4F4;
              end;
            end;
          end;
        end;
      aZQuery.Next;
    end;
    aZQuery.Close;
  finally
    aZQuery.Free;
  end;
end;

procedure TMain.RefreshPlanInfoParam(const EnabledRefresh: Boolean);
const
  PARAM_NOT_SELECTED = 'Не выбран параметр';
var
  Chart: TChartE;
  i, aBarIndex: Integer;
  BarDataClass: TDimensionParam;
  aNode : TcxTreeListNode;
  aShow : Boolean;
begin
  aNode := PlanTree.FocusedNode;

  aShow := TPlanTreeElement(NodeType(aNode)) = ataElement;

  CurrentBarInfoValue.Caption := PARAM_NOT_SELECTED;
  MinBarInfoValue.Caption := PARAM_NOT_SELECTED;
  MaxBarInfoValue.Caption := PARAM_NOT_SELECTED;
  BarInfoDeviceName.Caption := PARAM_NOT_SELECTED;
  CanalBarInfo.Caption := PARAM_NOT_SELECTED;

  CurrentBarInfoValueLabel.Visible := aShow;
  MinBarInfoValueLabel.Visible := aShow;
  MaxBarInfoValueLabel.Visible := aShow;
  BarInfoDeviceNameLabel.Visible := aShow;
  CanalBarInfoLabel.Visible := aShow;

  CurrentBarInfoValue.Visible := aShow;
  MinBarInfoValue.Visible := aShow;
  MaxBarInfoValue.Visible := aShow;
  BarInfoDeviceName.Visible := aShow;
  CanalBarInfo.Visible := aShow;

  if (not EnabledRefresh) or (TPlanTreeElement(NodeType(aNode)) <> ataElement) then Exit;

  for i := 0 to SpDesignArea.ControlCount - 1 do
    if SpDesignArea.Controls[i] is TChartE then
    begin
      Chart := TChartE(SpDesignArea.Controls[i]);
      //текущий Bar на диаграмме
      for aBarIndex := 0 to Chart.ValueSeries.Count - 1 do
      begin
        if Chart.Selected[aBarIndex] then
        begin
          BarDataClass := TDimensionParam(Chart.ValueSeries.Bars[aBarIndex]);
          //Заголовок
          CurrentBarInfoValue.Caption := FloatToStr(BarDataClass.Current) + #32 + BarDataClass.DimensionName;
          //Минимальное значение
          MinBarInfoValue.Caption := FloatToStr(BarDataClass.Warning) + #32 + BarDataClass.DimensionName;
          //Максимальное значение
          MaxBarInfoValue.Caption := FloatToStr(BarDataClass.Emergency) + #32 + BarDataClass.DimensionName;
          //Прибор
          BarInfoDeviceName.Caption := BarDataClass.DeviceName;
          //Трубопровод
          CanalBarInfo.Caption := IntToStr(BarDataClass.Canal);
          if FAPIBalloon.Showing then FAPIBalloon.Close;
        end;
      end;
    end;
end;

procedure TMain.LoadArchiveData(const GroupParamQueryID : LongWord;
  const DateTimeStart, DateTimeEnd : TDateTime);
var
  DSParamGroup, DSAnlData: TZQuery;
  Series: TLineSeries;
  DivValue: Double;
  ArchiveRightAxis: TDimensionSeries;
  aDV: Integer;
  sv: Double;
  ExportChart: TStringList;
begin
  FArchiveViewList.Clear;
  ExportChart := TStringList.Create;
  try
    DSParamGroup := UDBData.GetParamsQueryOfArchiveGroup(GroupParamQueryID) as TZQuery;
    try
      //RxArchiveDisplayParams.DisableControls - не использовать
      //dtsRxDisplayParams.DataSet := nil;

      RxArchiveDisplayParams.DisableControls;
      RxArchiveDisplayParams.EmptyTable;
      ArchiveChart.SeriesList.Clear;

      DSParamGroup.Open;
      while not DSParamGroup.Eof do
      begin
        RxArchiveDisplayParams.Append;

        RxArchiveDisplayParams.FieldByName('paramquery_id').AsInteger := DSParamGroup.FieldByName('paramquery_id').AsInteger;
        RxArchiveDisplayParams.FieldByName('orderNumber').AsInteger := DSParamGroup.RecNo;
        RxArchiveDisplayParams.FieldByName('paramquery_name').AsString := DSParamGroup.FieldByName('paramquery_name').AsString;
        RxArchiveDisplayParams.FieldByName('meterName').AsString := DSParamGroup.FieldByName('name').AsString;
        RxArchiveDisplayParams.FieldByName('sPParam').AsString := DSParamGroup.FieldByName('spparam').AsString;
        RxArchiveDisplayParams.FieldByName('canal').AsString := DSParamGroup.FieldByName('canal').AsString;
        RxArchiveDisplayParams.FieldByName('description').AsString := DSParamGroup.FieldByName('description').AsString;
        RxArchiveDisplayParams.FieldByName('unitSN').AsString := DSParamGroup.FieldByName('unitSN').AsString;
        RxArchiveDisplayParams.FieldByName('hvalue').AsString := DSParamGroup.FieldByName('hvalue').AsString;
        RxArchiveDisplayParams.FieldByName('lvalue').AsString := DSParamGroup.FieldByName('lvalue').AsString;
        RxArchiveDisplayParams.FieldByName('booShowSeries').AsBoolean := True;
        RxArchiveDisplayParams.FieldByName('color').AsInteger := DSParamGroup.FieldByName('color').AsInteger;

        //Series
        Series := TLineSeries.Create(ArchiveChart);
        Series.OnGetMarkText := GetMarkText;
        Series.Pointer.Brush.Color := TColor(DSParamGroup.FieldByName('color').AsInteger);
        Series.Marks.Clip := True;
        Series.Marks.Callout.Length := 0;
        Series.Marks.Callout.Distance := -7;
        Series.Marks.Font.Size := 10;
        Series.Marks.Transparent := True;
        Series.Pointer.Pen.Color := TColor(DSParamGroup.FieldByName('color').AsInteger);
        Series.XValues.DateTime := True;
        Series.VertAxis := aBothVertAxis;
        Series.SeriesColor := TColor(DSParamGroup.FieldByName('color').AsInteger);
        Series.Tag := DSParamGroup.RecNo;  //номер графика
        
        ArchiveChart.AddSeries(Series);

        ArchiveRightAxis := TDimensionSeries.Create;
        ArchiveRightAxis.Series := Series;

        ArchiveRightAxis.ID := DSParamGroup.FieldByName('paramquery_id').AsInteger;
        ArchiveRightAxis.Min := DSParamGroup.FieldByName('lvalue').AsFloat;
        ArchiveRightAxis.Max := DSParamGroup.FieldByName('hvalue').AsFloat;
        ArchiveRightAxis.Color := TColor(DSParamGroup.FieldByName('color').AsInteger);
        ArchiveRightAxis.DimensionName := DSParamGroup.FieldByName('unitSN').AsString;

        FArchiveViewList.Add(ArchiveRightAxis);

        RxArchiveDisplayParams.Post;

        DSAnlData := UDBData.GetParamQueryArchive(DSParamGroup.FieldByName('paramquery_id').AsInteger, DateTimeStart, DateTimeEnd) as TZQuery;
        try
          DSAnlData.Open;
          while not DSAnlData.Eof do
          begin
            if ArchiveRightAxis.Max = 0 then
              DivValue := 1
            else
              DivValue := ArchiveRightAxis.Max;
            ExportChart.Add(DSAnlData.FieldByName('date').AsString + #9 +
              DSParamGroup.FieldByName('paramquery_name').AsString + #9 +
              DSAnlData.FieldByName('value').AsString);
            sv := DSAnlData.FieldByName('value').AsFloat * 100 / DivValue;
            Series.AddXY(DSAnlData.FieldByName('date').AsDateTime, sv);

            //Добавляю точки вначале и в конце графика при отображении архива
            //Это визуально скроет разрывы графика вначале и в конце заданного интервала
            if (MinutesBetween(DateTimeStart, DSAnlData.FieldByName('date').AsDateTime) <= 15) and (DSAnlData.RecNo = 1) then
              Series.AddXY(DateTimeStart, sv);
            if (MinutesBetween(DSAnlData.FieldByName('date').AsDateTime, DateTimeEnd) <= 15) and
                 (DSAnlData.RecNo = Pred(DSAnlData.RecordCount)) then
                   Series.AddXY(DateTimeEnd, sv);

            DSAnlData.Next;
          end;
          aDV := Trunc(Series.XValues.Count * 0.1);
          if aDV = 0 then
            aDV := 1;
          Series.Marks.DrawEvery := aDV;
          DSAnlData.Close;
        finally
          DSAnlData.Free;
        end;
        DSParamGroup.Next;
      end;
      DSParamGroup.Close;
      //сохраняю экспорт в tmp windows каталоге
      ExportChart.SaveToFile(GetWindowsTempPath + EXPORT_FILE_NAME);
    finally
      RxArchiveDisplayParams.First;
      RxArchiveDisplayParams.EnableControls;
      
//      dtsRxDisplayParams.DataSet := RxArchiveDisplayParams;
      DSParamGroup.Free;
    end;
  finally
    ExportChart.Free;
  end;
end;

procedure TMain.LoadPlanExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    SpDesignArea.Picture.LoadFromFile(OpenDialog.FileName);
end;

procedure TMain.LoadPlanUpdate(Sender: TObject);
begin
  LoadPlan.Enabled := TPlanTreeElement(NodeType(PlanTree.FocusedNode)) = ataElement;
end;

function TMain.LoadTabs: TTabs;
begin
  Result.Plan := Boolean(FIniConfig.GetIniInt(SETTING_KEY, ANALOG_VIEW_PAGE_VAL, 0));
  Result.Archive := Boolean(FIniConfig.GetIniInt(SETTING_KEY, ARCHIVE_VIEW_PAGE_VAL, 0));
  Result.Reports := Boolean(FIniConfig.GetIniInt(SETTING_KEY, REPORTS_VIEW_PAGE_VAL, 0));
end;

procedure TMain.N1Click(Sender: TObject);
begin
  TFAbout.ShowFormAbout('MdClient');
end;

procedure TMain.Panel3DockDrop(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer);
begin
  TPanel(Sender).Height := 150;
end;

procedure TMain.PDF1Click(Sender: TObject);
begin
  FReport.ExportToPDF;
end;

procedure TMain.ReportDesignActionExecute(Sender: TObject);
var
  ReportId : LongWord;
  Node : TcxTreeListNode;
  ReportNodeClass : TReportNodeClass;
  ReportName : string;
begin
  Node := ReportTree.FocusedNode;
  if Assigned(Node) and (TObject(Node.Data) is TReportNodeClass) then
  begin
    if Assigned(FRPreview.PreviewPages) then
      FRPreview.Clear;
    ReportNodeClass := Node.Data;
    ReportId := ReportNodeClass.FReportId;
    ReportName := Node.Texts[0];
    ReportDesign(ReportId, ReportName);
  end;
end;

procedure TMain.ReportDesignActionUpdate(Sender: TObject);
begin
  with ReportTree do
  if Assigned(FocusedNode) then
    ReportDesignAction.Enabled := (TObject(FocusedNode.Data) is TReportNodeClass) and
      (TReportNodeClass(FocusedNode.Data).FTreeElement <> rtaGroup) and
        not (TObject(FocusedNode.Data) is TReportFilter);
end;

procedure TMain.ReportPrintExecute(Sender: TObject);
begin
  FRPreview.Print;
end;

procedure TMain.ReportPrintUpdate(Sender: TObject);
begin
  with ReportTree do
  if Assigned(FocusedNode) then
    ReportPrint.Enabled := TObject(FocusedNode.Data) is TReportFilter;
end;

function TMain.CurrentID(const TreeList: TcxTreeList): LongWord;
var
  Node: TcxTreeListNode;
begin
  Result := 0;
  Node := TreeList.FocusedNode;
  if Node = nil then
    Exit;  
  if TObject(Node.Data) is TReportNodeClass then
    Result := TReportNodeClass(Node.Data).ID
  else
  if TObject(Node.Data) is TPlanNodeClass then
    Result := TPlanNodeClass(Node.Data).ID;
end;

procedure TMain.GridDisplayParamsDBTableView1BooShowSeriesPropertiesChange(
  Sender: TObject);
begin
  if GetArchiveCurrentSeries <> nil then
    GetArchiveCurrentSeries.Visible := (Sender as TcxCheckBox).Checked;
  RefreshCrossValue(ChartTool);
end;

procedure TMain.GridDisplayParamsDBTableViewcolorCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.FillRect(AViewInfo.Bounds, TColor(AViewInfo.Value));
  ADone := True;
end;

procedure TMain.GridDisplayParamsDBTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
  CurSeries: TChartSeries;
  Dimension: TDimensionParam;
begin
  RestoreArchiveLine;

  Dimension := GetArchiveCurrentRightAxis;
  if Assigned(Dimension) then
    ChartTool.Pen.Color := Dimension.Color;

  AdjustArchiveRightAxis(Dimension);

  CurSeries := GetArchiveCurrentSeries;

  ChartDragPointTool.Series := CurSeries;
  //утолщаю активную серию
  if Assigned(CurSeries) then
    TLineSeries(CurSeries).LinePen.Width := 2;
//!!!  ChartTool.Series := CurSeries;

//  TagCrossTime.Font.Color := Dimension.Color;
  RefreshCrossValue(ChartTool);
end;

procedure TMain.cxPageControlChange(Sender: TObject);
begin
  RefreshPlan;
end;

procedure TMain.CreatePlanDiagram(const ID: LongWord);
const
  COL_COUNT = 3;
var
  aSQL, LeftName, TopName: string;
  Query: TZQuery;
  Chart: TChartE;
  ChartID: Longword;
  LeftChart, TopChart, n: Integer;
  WidthSeries, ValueSeries, MaxValueSeries: TBarSeriesE;
  IniFile: TIniFile;
begin
  aSQL := 'SELECT diagram_id,                       ' +
          '   lvalue,                               ' +
          '   hvalue,                               ' +
          '   name,                                 ' +
          '   dimensionname,                        ' +
          '   consumerism_id,                       ' +
          '   anglelable                            ' +
          'FROM diagrams                            ' +
          'WHERE consumerism_id = :id   ' +
          'ORDER BY diagram_id';
  Query :=  UDM.CreateDataSet(aSQL) as TZQuery;
  try
    Query.ParamByName('id').Value := ID;
    Query.Open;
    IniFile := TIniFile.Create(GetConfigIniFile);
    try
      n := 0;
      while not Query.Eof do
      begin
        Chart := TChartE.Create(SpDesignArea);
        with Chart do
        begin
          //Control
          Border.Style := psDot;
          ParentColor := True;
          BorderStyle := bsNone;
          //Class extension
          ID := Query.FieldByName('diagram_id').AsInteger;
          //Series
          AllowPanning := pmNone;
          Legend.Hide;
          AllowZoom := False;
          View3D := False;
          BevelOuter := TBevelCut(0);
          Title.Text.Add(Query.FieldByName('name').AsString + ' (' + Query.FieldByName('dimensionname').AsString + ')');
          Title.Alignment := taCenter;
          //LeftAxis
          LeftAxis.SetMinMax(Query.FieldByName('lvalue').AsFloat, Query.FieldByName('hvalue').AsFloat);
          LeftAxis.Grid.Hide;
          LeftAxis.MinorTicks.Hide;
          LeftAxis.TicksInner.Hide;
          LeftAxis.Axis.Hide;
          LeftAxis.Increment := Query.FieldByName('hvalue').AsFloat / 4;
          LeftAxis.AxisValuesFormat := '#,##0.#';
          LeftAxis.LabelsFont.Name := 'Lucida Console';
          LeftAxis.LabelsFont.Size := 8;
          //BottomAxis
          BottomAxis.Grid.Hide;
          BottomAxis.MinorTickCount := 0;
          BottomAxis.Axis.Hide;
          BottomAxis.LabelsAngle := Query.FieldByName('anglelable').AsInteger;
        end;
        ChartID := Query.FieldByName('diagram_id').AsInteger;

        LeftName := Format(DIAGRAM_POSITION_VAL, [UDM.Host, ChartID, 'Left']);
        TopName := Format(DIAGRAM_POSITION_VAL, [UDM.Host, ChartID, 'Top']);
        Chart.Width := IniFile.ReadInteger(PROPERTY_DIAGRAM_KEY,
          Format(DIAGRAM_POSITION_VAL, [UDM.Host, ChartID, 'Width']), 300);
        Chart.Height := IniFile.ReadInteger(PROPERTY_DIAGRAM_KEY,
          Format(DIAGRAM_POSITION_VAL, [UDM.Host, ChartID, 'Height']), 300);

        LeftChart := (n - (n div COL_COUNT) * COL_COUNT) * Chart.Width;
        TopChart := 80 + n div COL_COUNT * (Chart.Height + 20);

        Chart.Left := IniFile.ReadInteger(PROPERTY_DIAGRAM_KEY, LeftName, LeftChart);
        Chart.Top := IniFile.ReadInteger(PROPERTY_DIAGRAM_KEY, TopName, TopChart);

        Chart.Parent := SpDesignArea;

        WidthSeries := TBarSeriesE.Create(Chart);
        Chart.AddSeries(WidthSeries);
        with WidthSeries do
        begin
          BarWidthPercent := 100;
          SideMargins := False;
          Marks.Hide;
          RefreshSeries;
        end;
        //серия по высоте
        MaxValueSeries := TBarSeriesE.Create(Chart);
        Chart.AddSeries(MaxValueSeries);
        with MaxValueSeries do
        begin
          //cобытие определяющее бар стиль
          OnGetBarStyle := GetBarStyle;
          OnClick := SeriesClick;
          CustomBarWidth := Chart.Width div 10;
          Cursor := crHandPoint;
          BarPen.Color := clSilver;
          BarPen.Style := psDot;
          Marks.Hide;
          RefreshSeries;
        end;
        //серия значений
        ValueSeries := TBarSeriesE.Create(Chart);
        Chart.AddSeries(ValueSeries);
        with ValueSeries do
        begin
          OnClick := SeriesClick;
          CustomBarWidth := Chart.Width div 20;
          Marks.Style := smsValue;
          Marks.ShapeStyle := fosRoundRectangle;
          Marks.Callout.Hide;
          Marks.Callout.Length := 5;
          Marks.Callout.Arrow.SmallDots := True;
          Marks.Show;
          Marks.Clip := True;
          Marks.Arrow.Color := clBlack;
          AutoMarkPosition := True;
          CalcVisiblePoints := False;
          MultiBar := TMultiBar(mbNone);
          RefreshSeries;
        end;
        Inc(n);
        Query.Next;
      end;
      Query.Close;
      SpDesignArea.Refresh;
    finally
      IniFile.Free;
    end;
  finally
    Query.Free;
  end;
end;

procedure TMain.DisplayValuesBeforeDrawButton(Sender: TObject; Index: Integer;
  Canvas: TCanvas; Rect: TRect; State: TButtonDrawState);
begin
  if Index = 3 then
    Canvas.Brush.Color := clRed;
  if Index = 2 then
    Canvas.Font.Color := clRed;
end;

function TMain.ReportDesign(const ReportID: LongWord; const ReportName: string): LongWord;
begin
  Result := FReport.DesignReport(ReportID, ReportName);
end;

procedure TMain.PlanTimerTimer(Sender: TObject);
begin
  RefreshPlan;
end;

function TBarSeriesE.AddBar(const aValue: Double; const aLabel: string;
  const aColor: TColor; DimensionParam: TDimensionParam): Integer;
begin
  Result := inherited AddBar(AValue, ALabel, AColor);
  FBarsList.Add(DimensionParam);
end;

constructor TBarSeriesE.Create(AOwner: TComponent);
begin
  inherited;
  FBarsList := TObjectList.Create(True);
end;

destructor TBarSeriesE.Destroy;
begin
  FBarsList.Clear;
  FBarsList.Free;
  inherited Destroy;
end;

function TBarSeriesE.IndexOf(const aId: LongWord): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FBarsList.Count - 1 do
    if TDimensionParam(FBarsList[i]).ID = aId then
    begin
      Result := i;
      Break;
    end;
end;

function TBarSeriesE.GetBar(Index: Integer): TDimensionParam;
begin
  Result := TDimensionParam(FBarsList[Index]);
end;

procedure TBarSeriesE.SetBar(Index: Integer; const Value: TDimensionParam);
begin
  FBarsList[Index] := Value;
end;

constructor TPlanNodeClass.Create(const aID: LongWord;
  const aTreeElement: TPlanTreeElement);
begin
  FId := aID;
  FTreeElement := aTreeElement;
end;

constructor TReportNodeClass.Create(const aID: LongWord;
  const aTreeElement: TReportTreeElement);
begin
  FId := aID;
  FTreeElement := aTreeElement;
end;

constructor TDimensionParam.Create;
begin
  History := TObjectList.Create;
end;

destructor TDimensionParam.Destroy;
begin
  History.Free;
end;

{ TChartE }

procedure TChartE.ClearSelection;
var
  i: Integer;
begin
  for i := 0 to ValueSeries.FBarsList.Count - 1 do
    ValueSeries.Bars[i].Selected := False;    
end;

function TChartE.GetSelected(Index: Integer): Boolean;
begin
  Result := ValueSeries.Bars[Index].Selected;
end;

function TChartE.GetSelectedCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to ValueSeries.FBarsList.Count - 1 do
   if Selected[i] then
     Inc(Result);
end;

function TChartE.MaxValueSeries: TBarSeriesE;
begin
  Result := TBarSeriesE(SeriesList[1]);
end;

procedure TChartE.SetSelected(Index: Integer; const Value: Boolean);
begin
  ValueSeries.Bars[Index].Selected := Value;
end;

function TChartE.ValueSeries: TBarSeriesE;
begin
  Result := TBarSeriesE(SeriesList[2]);
end;

end.
