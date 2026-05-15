{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, bsSkinCtrls, bsSkinBoxCtrls, ExtCtrls, Buttons, ActnList,
  MdExtCtrls, SPTForm;

type
  TLogin = class(TSPTForm)
    Panel1: TPanel;
    ActionList: TActionList;
    OK: TAction;
    Panel2: TPanel;
    Image1: TImage;
    BtnAbout: TSpeedButton;
    Hosts: TListBox;
    MdBitBtn1: TMdBitBtn;
    procedure OKUpdate(Sender: TObject);
    procedure HostsDblClick(Sender: TObject);
    procedure OKExecute(Sender: TObject);
    procedure BtnAboutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetHostIndex: Integer;
  public
    constructor Create(AOwner: TComponent; aHosts : TStringList); reintroduce;
    property HostIndex : Integer read GetHostIndex;
    function Execute : Boolean;
  end;

implementation

uses About;

{$R *.dfm}

procedure TLogin.BtnAboutClick(Sender: TObject);
begin
  TFAbout.ShowFormAbout('MDClient');
end;

constructor TLogin.Create(AOwner: TComponent; aHosts: TStringList);
var i, k : Integer;
    V : string;
begin
  inherited Create(AOwner);
  Hosts.Items.Clear;
  for i := 0 to aHosts.Count - 1 do
  begin
    V := aHosts.ValueFromIndex[i];
    k := Pos('#', V);
    Hosts.Items.Add(Trim(Copy(V, k + 1, Length(V) - k)));
  end;
  Hosts.ItemIndex := 0;  
end;

function TLogin.Execute: Boolean;
begin
  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  Hosts.SetFocus;
end;

function TLogin.GetHostIndex: Integer;
begin
  Result := Hosts.ItemIndex;
end;

procedure TLogin.HostsDblClick(Sender: TObject);
begin
  OK.Execute;
end;

procedure TLogin.OKExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TLogin.OKUpdate(Sender: TObject);
begin
  OK.Enabled := Hosts.Items.Count > 0;
end;

end.
