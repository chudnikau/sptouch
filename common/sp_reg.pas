unit sp_reg;

interface

uses
  SysUtils, Classes, ColorComboEdit, SpDesignPanel;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('SpTouchVCL', [TSpDesignPanel]);
  RegisterComponents('Samples', [TColorComboEdit]);
end;

end.
