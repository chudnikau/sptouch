{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit SPTForm;

interface

uses Forms, Classes;

type
  TSPTForm = class(TForm)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSPTDialogForm = class(TSPTForm)
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  FSPTForm: TSPTForm = nil;  

implementation

{ TSPTForm }

constructor TSPTForm.Create(AOwner: TComponent);
begin
  inherited;
  Position := poScreenCenter;
end;

{ TSPTDialogForm }

constructor TSPTDialogForm.Create(AOwner: TComponent);
begin
  inherited;
  BorderStyle := bsDialog;
end;

end.
