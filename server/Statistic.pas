{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Statistic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dm_general;

type
  TFStatistic = class(TForm)
    Panel1: TPanel;
    dtsStatus: TDataSource;
    dtbStatus: TZQuery;
    GroupBox1: TGroupBox;
    dxDBGrid1: TdxDBGrid;
    dtbStatusId: TLargeintField;
    dtbStatusUser: TStringField;
    dtbStatusHost: TStringField;
    dtbStatusdb: TStringField;
    dtbStatusCommand: TStringField;
    dtbStatusTime: TLargeintField;
    dtbStatusState: TStringField;
    dtbStatusInfo: TStringField;
    dxDBGrid1Id: TdxDBGridColumn;
    dxDBGrid1User: TdxDBGridMaskColumn;
    dxDBGrid1Host: TdxDBGridMaskColumn;
    dxDBGrid1db: TdxDBGridMaskColumn;
    dxDBGrid1Command: TdxDBGridMaskColumn;
    dxDBGrid1Time: TdxDBGridColumn;
    dxDBGrid1State: TdxDBGridMaskColumn;
    dxDBGrid1Info: TdxDBGridMaskColumn;
    BtnRefresh: TBitBtn;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    L1: TLabel;
    L2: TLabel;
    L3: TLabel;
    L4: TLabel;
    Label1: TLabel;
    ServerTime: TLabel;
    LockPassword: TLabel;
    CountRequestParams: TLabel;
    DBSize: TLabel;
    Connection: TLabel;
    procedure BtnRefreshClick(Sender: TObject);
  private
    FIniConfig: TIniConfig;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FStatistic: TFStatistic;

implementation

uses globalvars, DBdata, globalmethods;

{$R *.dfm}

{ TFStatistic }

procedure TFStatistic.BtnRefreshClick(Sender: TObject);
begin
  dtbStatus.Close;
  dtbStatus.Open;
end;

constructor TFStatistic.Create(AOwner: TComponent);
var
  aDbName : string;
  dbSizeByte : LongWord;
begin
  inherited Create(AOwner);
  FIniConfig := TIniConfig.Create(GetConfigIniFile);
  dtbStatus.Connection := UDM.MySQLConnection;
  Connection.Caption := Format('Host=%s HostDes=%s User=%s', [UDM.Host, UDM.HostDes, UDM.User]);
  aDbName := FIniConfig.GetIniStr(DB_UNIT_KEY, DB_NAME_VAL, EmptyStr);
  dbSizeByte := UDBData.GetVariantVal('SELECT SUM(DATA_LENGTH) AS DATA_LENGTH FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = :table_schema ', [aDbName], 'DATA_LENGTH');
  DBSize.Caption := Format('%f Ìב', [dbSizeByte / 1024 / 1024]);
  CountRequestParams.Caption := IntToStr(UDBData.GetVariantVal('SELECT COUNT(*) as count FROM paramsqueries WHERE enabled > 0', [], 'count'));
  LockPassword.Caption := Format('"%s"', [FIniConfig.GetIniStr(SETTING_KEY, LOCK_SECRET_VAL, EmptyStr)]);
  ServerTime.Caption := DateTimeToStr(UDBData.GetServerDateTime);
  dtbStatus.Open;
end;

destructor TFStatistic.Destroy;
begin
  FIniConfig.Free;
  dtbStatus.Close;
  inherited Destroy;
end;

end.
