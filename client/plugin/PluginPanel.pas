{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginPanel;

interface

uses
  Classes, Controls, SysUtils, ExtCtrls, Graphics, PluginContainer;

type
  TPluginPanel = class(TPanel, IProperty)
  private
    FGlyph: TBitmap;
    FViewFileName: string;
    function GetPropValue: Variant;
    procedure SetPropValue(const Value: Variant);
    procedure SetViewFileName(const Value: string);
  protected
    procedure Paint; override;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PropValue: Variant read GetPropValue write SetPropValue;
  published
    property ViewFileName: string read FViewFileName write SetViewFileName stored True;
  end;

implementation

procedure TPluginPanel.AssignTo(Dest: TPersistent);
begin
  if Dest.ClassNameIs(ClassName) then
  begin
    Color := TPluginPanel(Dest).Color;
    Width := TPluginPanel(Dest).Width;
    Height := TPluginPanel(Dest).Height;
    BorderStyle := TPluginPanel(Dest).BorderStyle;
    BevelInner := TPluginPanel(Dest).BevelInner;
    BevelKind := TPluginPanel(Dest).BevelKind;
    BevelOuter := TPluginPanel(Dest).BevelOuter;
    ViewFileName := TPluginPanel(Dest).ViewFileName;
  end;
end;

constructor TPluginPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGlyph := TBitmap.Create;
end;

destructor TPluginPanel.Destroy;
begin
  FGlyph.Free;
  inherited Destroy;
end;

procedure TPluginPanel.Paint;
begin
  inherited Paint;
  if not FGlyph.Empty then Canvas.Draw(0, 0, FGlyph);
end;

function TPluginPanel.GetPropValue: Variant;
begin

end;

procedure TPluginPanel.SetPropValue(const Value: Variant);
begin

end;

procedure TPluginPanel.SetViewFileName(const Value: string);
begin
  FViewFileName := Value;
  if FileExists(FViewFileName) then FGlyph.LoadFromFile(FViewFileName);
end;

end.

