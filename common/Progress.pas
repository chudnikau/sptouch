{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, ExtCtrls;

type
  TFProgress = class(TForm)
    Panel1: TPanel;
    ProgressSinhronization: TGauge;
    LabelInfo: TLabel;
  private
    function GetProgress: Integer;
    procedure SetProgress(const Value: Integer);
  published
  public
    constructor Create(AOwner: TComponent; const aTitle : string); reintroduce;
    procedure SetMinMaxProgress(const aMin, aMax : Integer);
    procedure UpdateProgressInfo(const aInfoStr : string);
    property Progress : Integer read GetProgress write SetProgress;
  end;

var
  FProgress: TFProgress;

implementation

{$R *.dfm}

{ TFProgress }

constructor TFProgress.Create(AOwner: TComponent; const aTitle : string);
begin
  inherited Create(AOwner);
  Caption := aTitle;
  ProgressSinhronization.Progress := 0;
end;

function TFProgress.GetProgress: Integer;
begin
  Result := ProgressSinhronization.Progress;
end;

procedure TFProgress.SetMinMaxProgress(const aMin, aMax: Integer);
begin
  ProgressSinhronization.MinValue := aMin;
  ProgressSinhronization.MaxValue := aMax;
end;

procedure TFProgress.SetProgress(const Value: Integer);
begin
  ProgressSinhronization.Progress := Value;
  Application.ProcessMessages;
end;

procedure TFProgress.UpdateProgressInfo(const aInfoStr: string);
begin
  LabelInfo.Caption := aInfoStr;
end;

end.
