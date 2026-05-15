{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit SQLCreater;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, HelpPic, Edits, MdExtCtrls, SPTForm;

type
  TSQLType = (tSut, tMonth, tYear);

  TFSQLCreater = class(TSPTForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    RBSut: TRadioButton;
    RBMonth: TRadioButton;
    RBYear: TRadioButton;
    HelpPic1: THelpPic;
    EditRowCount: TMdIntEdit;
    MdBitBtn1: TMdBitBtn;
    BtnCancel: TMdBitBtn;
  private
    function GetSQLType: TSQLType;
    function GetRowCount: Integer;
  public
    property RowCount : Integer read GetRowCount;
    property SQLType : TSQLType read GetSQLType;
    function Execute : Boolean;
  end;

var
  FSQLCreater: TFSQLCreater;

implementation

{$R *.dfm}

function TFSQLCreater.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TFSQLCreater.GetRowCount: Integer;
begin
  Result := StrToIntDef(EditRowCount.Text, -1);
end;

function TFSQLCreater.GetSQLType: TSQLType;
begin
  if RBSut.Checked then Result := tSut
  else
  if RBMonth.Checked then Result := tMonth
  else
  if RBYear.Checked then Result := tYear;
end;

end.
