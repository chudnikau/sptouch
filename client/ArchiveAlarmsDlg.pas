{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ArchiveAlarmsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid, StdCtrls,
  Buttons, DB, ZAbstractRODataset, ZDataset, dxDBTLCl, dxGrClms, HelpPic,
  MdExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, SPTForm;

type

  TAlertArchiveDlg = class(TSPTForm)
    Panel1: TPanel;
    dtbAlertArchive: TZReadOnlyQuery;
    dtsAlertArchive: TDataSource;
    dtbAlertArchivename: TStringField;
    dtbAlertArchivevalue: TFloatField;
    dtbAlertArchivewvalue: TFloatField;
    dtbAlertArchiveavalue: TFloatField;
    dtbAlertArchivedate: TDateTimeField;
    HelpPic1: THelpPic;
    Label1: TLabel;
    Label2: TLabel;
    MdBitBtn1: TMdBitBtn;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1name: TcxGridDBColumn;
    cxGrid1DBTableView1value: TcxGridDBColumn;
    cxGrid1DBTableView1wvalue: TcxGridDBColumn;
    cxGrid1DBTableView1avalue: TcxGridDBColumn;
    cxGrid1DBTableView1date: TcxGridDBColumn;
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FArchiveAlarmsDlg: TAlertArchiveDlg;

implementation

uses dm_general;

{$R *.dfm}

{ TArchiveAlertDlg }

constructor TAlertArchiveDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ASSERT(not dtbAlertArchive.Active);
  dtbAlertArchive.Connection := UDM.MySQLConnection;
  dtbAlertArchive.Open;
end;

procedure TAlertArchiveDlg.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
//var
//  v, wv, av : Double;
begin

//  v := StrToFloatDef(ANode.Strings[1], 0);
//  wv := StrToFloatDef(ANode.Strings[2], 0);
//  av := StrToFloatDef(ANode.Strings[3], 0);
//
//  if (av <> 0) and (v >= av) then ACanvas.Brush.Color := $00A4A4FF
//  else
//  if (wv <> 0) and (v >= wv) then ACanvas.Brush.Color := $0080FFFF;
  
end;

destructor TAlertArchiveDlg.Destroy;
begin
  dtbAlertArchive.Close;
  inherited Destroy;
end;

end.
