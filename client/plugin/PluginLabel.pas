{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginLabel;

interface

uses
  Classes, StdCtrls, Graphics, PluginContainer;

type
  TPluginLabel = class(TLabel, IProperty)
  public
    constructor Create(AOwner: TComponent); override;
    function GetPropValue: Variant;
    procedure SetPropValue(const Value: Variant);
    procedure SetGlyph(Glyph: TBitmap);
    function GetGlyphFileName: string;
    procedure SetGlyphFileName(const FileName: string);
  end;

implementation

constructor TPluginLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

function TPluginLabel.GetGlyphFileName: string;
begin

end;

function TPluginLabel.GetPropValue: Variant;
begin
  Result := Caption;
end;

procedure TPluginLabel.SetGlyph(Glyph: TBitmap);
begin

end;

procedure TPluginLabel.SetGlyphFileName(const FileName: string);
begin

end;

procedure TPluginLabel.SetPropValue(const Value: Variant);
begin
  Caption := Value;
end;

end.
