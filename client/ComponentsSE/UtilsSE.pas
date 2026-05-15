unit UtilsSE;

interface

uses
  Classes, Controls, ColorBoxSE, SpinSE;

function  CreateColorBox(const AName: string = ''; ControlSite: TControl = Nil;
  HideColorNone: Boolean = False): TColorBoxSE;
function  CreateSpinEdit(const AName: string = ''; ControlSite: TControl = Nil;
  const MinValue: extended = 0; const MaxValue: extended = 0;
  const Increment: extended = 1; const Decimal: integer = 3): TSpinEditSE;

procedure ReplaceControl(ControlSite, Control: TControl);

implementation

type
  TControlFriend = class(TControl);

function  CreateColorBox(const AName: string = ''; ControlSite: TControl = Nil;
  HideColorNone: Boolean = False): TColorBoxSE;
var Owner: TComponent;
begin
  if Assigned(ControlSite)
    then Owner := ControlSite.Owner
    else Owner := Nil;
  Result := TColorBoxSE.Create(Owner);
  Result.Name := AName;
  if Assigned(ControlSite) then
    ReplaceControl(ControlSite, Result);
  if HideColorNone and Assigned(Result.Parent) then
    Result.Style := Result.Style - [ fcbNoneColor ];
end;

function  CreateSpinEdit(const AName: string = ''; ControlSite: TControl = Nil;
  const MinValue: extended = 0; const MaxValue: extended = 0;
  const Increment: extended = 1; const Decimal: integer = 3): TSpinEditSE;
var Owner: TComponent;
begin
  if Assigned(ControlSite)
    then Owner := ControlSite.Owner
    else Owner := Nil;
  Result := TSpinEditSE.Create(Owner);
  Result.Name := AName;
  if Assigned(ControlSite) then
    ReplaceControl(ControlSite, Result);
  Result.MaxValue := MaxValue;
  Result.MinValue := MinValue;
  Result.Increment := Increment;
  Result.Decimal := Decimal;
end;

procedure ReplaceControl(ControlSite, Control: TControl);
begin
 if not Assigned(ControlSite) or not Assigned(Control) then exit;
 with ControlSite do begin
  Control.Parent := Parent;
  Control.SetBounds(Left, Top, Width, Height);
  Control.Align := Align;
  Control.Anchors := Anchors;
  Control.Constraints.Assign(Constraints);
  Control.Enabled := Enabled;
  Control.Hint := Hint;
  Control.ShowHint := ShowHint;
  Control.Visible := Visible;
 end;
 if (ControlSite is TWinControl) and (Control is TWinControl) then
  with TWinControl(ControlSite) do begin
   TWinControl(Control).TabOrder := TabOrder;
   TWinControl(Control).TabStop := True;
  end;
 ControlSite.Free;
end;

end.
