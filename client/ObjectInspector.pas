{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit ObjectInspector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SPTForm, Contnrs, bsSkinCtrls, bsCategoryButtons,
  bsButtonGroup, dxExEdtr, dxCntner, dxInspct, dxOI, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  cxStyles, cxEdit, cxInplaceContainer, cxVGrid, cxOI;

type
  TObjectInspectorForm = class(TSPTForm)
    cxRTTIInspector: TcxRTTIInspector;

  private
    FObjects: TObjectList;
    procedure LoadObjects;
    procedure ShowObjectDescription(const Index: Integer);
    procedure SetDesignControl(const Value: TControl);
    function GetDesignControl: TControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DesignControl: TControl read GetDesignControl write SetDesignControl;
  end;

  TObjectInspector = class(TPersistent)
  private
    FObjectInspector: TObjectInspectorForm;
  public
    procedure Show;
  end;

  TObjectInspectorClass = class of TObjectInspector;

var
  FObjectInspector: TObjectInspectorForm = nil;

implementation

{$R *.dfm}

{ TObjectInspector }

constructor TObjectInspectorForm.Create(AOwner: TComponent);
begin
  inherited;
  FObjects := TObjectList.Create;
end;

destructor TObjectInspectorForm.Destroy;
begin
  FObjects.Free;
  inherited;
end;

function TObjectInspectorForm.GetDesignControl: TControl;
begin
  Result := TControl(cxRTTIInspector.InspectedObject);
end;

procedure TObjectInspectorForm.LoadObjects;
begin

end;

procedure TObjectInspectorForm.SetDesignControl(const Value: TControl);
begin
  cxRTTIInspector.InspectedObject := Value;
//  cxRTTIInspector.RefreshInspectedProperties;
end;

procedure TObjectInspectorForm.ShowObjectDescription(const Index: Integer);
begin

end;

{ TBaseObjectInspector }

procedure TObjectInspector.Show;
begin

end;

initialization
  RegisterClass(TObjectInspector);

end.
