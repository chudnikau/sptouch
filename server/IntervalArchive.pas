{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit IntervalArchive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib,
  Buttons, DB, ZAbstractRODataset, ZDataset;

type
  TFIntervalArchive = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    ZReadOnlyQuery: TZReadOnlyQuery;
    DataSource: TDataSource;
  private
    { Private declarations }
  public
    function Execute : Boolean;
  end;

var
  FIntervalArchive: TFIntervalArchive;

implementation

{$R *.dfm}

{ TFIntervalArchive }

function TFIntervalArchive.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

end.
