{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit TablesSynchronization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFTablesSynchronization = class(TForm)
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    BtnHelp: TBitBtn;
    GroupBox1: TGroupBox;
    CBTypeMeters: TCheckBox;
    CBHeaderList: TCheckBox;
    CBUnitHandBook: TCheckBox;
    CBListOfString: TCheckBox;
    CBMeters: TCheckBox;
    GroupBox2: TGroupBox;
    CBUpdate: TCheckBox;
  private
    function GetStateHeaderList: Boolean;
    function GetStateTypeMeters: Boolean;
    function GetStateListOfString: Boolean;
    function GetStateMeters: Boolean;
    function GetStateUnitHandBook: Boolean;
    function GetStateUpdate: Boolean;
    { Private declarations }
  public
    property bOnTypeMeters : Boolean read GetStateTypeMeters;
    property bOnHeaderList : Boolean read GetStateHeaderList;
    property bOnUnitHandBook : Boolean read GetStateUnitHandBook;
    property bOnListOfString : Boolean read GetStateListOfString;
    property bOnMeters : Boolean read GetStateMeters;
    property bOnUpdate : Boolean read GetStateUpdate;
    function Execute : Boolean;
  end;

var
  FTablesSynchronization: TFTablesSynchronization;

implementation

{$R *.dfm}

{ TFTablesSynchronization }

function TFTablesSynchronization.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

function TFTablesSynchronization.GetStateHeaderList: Boolean;
begin
  Result := CBHeaderList.Checked;
end;

function TFTablesSynchronization.GetStateListOfString: Boolean;
begin
  Result := CBListOfString.Checked;
end;

function TFTablesSynchronization.GetStateMeters: Boolean;
begin
  Result := CBMeters.Checked;
end;

function TFTablesSynchronization.GetStateTypeMeters: Boolean;
begin
  Result := CBTypeMeters.Checked;
end;

function TFTablesSynchronization.GetStateUnitHandBook: Boolean;
begin
  Result := CBUnitHandBook.Checked;
end;

function TFTablesSynchronization.GetStateUpdate: Boolean;
begin
  Result := CBUpdate.Checked;
end;

end.
