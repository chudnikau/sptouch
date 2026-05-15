{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginContainer;

interface

uses
  Controls, Classes, Contnrs, SysUtils, StrUtils, TypInfo, ObjectInspector, Graphics;

type
  IProperty = interface
    ['{2553751F-195E-4478-A44D-1823452CFB4B}']
    function  GetPropValue: Variant;
    procedure SetPropValue(const Value: Variant);
    property PropValue: Variant read GetPropValue write SetPropValue;
  end;

  TPluginContainer = class
  private
    FCategoryIndex: Integer;
    FGlyph: TBitmap;
    FHeight: Integer;
    FHelpText: string;
    FPlugin: TControl;
    FPreviewFileName: string;
    FPropClass: TObjectInspectorClass;
    FTitle: string;
    FWidth: Integer;
  published
    procedure PreviewGlyph(const FileName: string; Glyph: TBitmap);
  public
    destructor Destroy; override;
    property CategoryIndex: Integer read FCategoryIndex write FCategoryIndex;
    property HelpText: string read FHelpText write FHelpText;
    property Plugin: TControl read FPlugin write FPlugin;
    property PreviewFileName: string read FPreviewFileName write FPreviewFileName;
    property PropClass: TObjectInspectorClass read FPropClass write FPropClass;
    property Title: string read FTitle write FTitle;
  end;

implementation

destructor TPluginContainer.Destroy;
begin
  if Assigned(FPlugin) then FPlugin.Free;
  inherited Destroy;
end;

procedure TPluginContainer.PreviewGlyph(const FileName: string; Glyph: TBitmap);
begin
  if Assigned(Glyph) and FileExists(FileName) then Glyph.LoadFromFile(FileName);
end;

end.
