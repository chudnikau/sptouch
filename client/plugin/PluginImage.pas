{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginImage;

interface

uses
  Classes, ExtCtrls, Graphics, PluginContainer;

type
  TPluginImage = class(TImage, IProperty)
  public
    constructor Create(AOwner: TComponent); override;
    function GetPropValue: Variant;
    procedure SetPropValue(const Value: Variant);
    procedure SetGlyph(Glyph: TBitmap);
    function GetGlyphFileName: string;
    procedure SetGlyphFileName(const FileName: string);
  end;

implementation

constructor TPluginImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

function TPluginImage.GetGlyphFileName: string;
begin

end;

function TPluginImage.GetPropValue: Variant;
begin

end;

procedure TPluginImage.SetGlyph(Glyph: TBitmap);
begin

end;

procedure TPluginImage.SetGlyphFileName(const FileName: string);
begin

end;

procedure TPluginImage.SetPropValue(const Value: Variant);
begin

end;

end.
