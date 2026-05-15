{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginChart;

interface

uses
  Classes, Chart, Graphics, PluginContainer;

type
  TPluginChart = class(TChart, IProperty)
  public
    constructor Create(AOwner: TComponent); override;
    function GetPropValue: Variant;
    procedure SetPropValue(const Value: Variant);
    procedure SetGlyph(Glyph: TBitmap);
    function GetGlyphFileName: string;
    procedure SetGlyphFileName(const FileName: string);
  end;

implementation

{ TPluginChart }

constructor TPluginChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

function TPluginChart.GetGlyphFileName: string;
begin

end;

function TPluginChart.GetPropValue: Variant;
begin

end;

procedure TPluginChart.SetGlyph(Glyph: TBitmap);
begin

end;

procedure TPluginChart.SetGlyphFileName(const FileName: string);
begin

end;

procedure TPluginChart.SetPropValue(const Value: Variant);
begin

end;

end.
