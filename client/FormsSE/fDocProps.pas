unit fDocProps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, FlexBase, FlexProps, FlexUtils, SpinSE;

type
  TfmDocProps = class(TForm)
    panProps: TPanel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    Label1: TLabel;
    edTitle: TEdit;
    Label2: TLabel;
    mmComment: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    bbUserData: TBitBtn;
    Label5: TLabel;
    edVersion: TEdit;
    Label12: TLabel;
    panWidth: TPanel;
    panHeight: TPanel;
    panConnectorsMinGap: TPanel;
    chSaveAsBinary: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbUserDataClick(Sender: TObject);
  private
    { Private declarations }
    FFlex: TFlexPanel;
    UserProps: TPropList;
    UserData: TUserDataProp;
  public
    { Replaced controls }
    sedWidth: TSpinEditSE;
    sedHeight: TSpinEditSE;
    sedConnectorsMinGap: TSpinEditSE;
    { Public declarations }
  end;

var
  fmDocProps: TfmDocProps;

implementation

{$R *.DFM}

uses
  UtilsSE;

procedure TfmDocProps.FormCreate(Sender: TObject);
begin
 sedWidth := CreateSpinEdit('sedWidth', panWidth, 1, 99999);
 sedHeight := CreateSpinEdit('sedHeight', panHeight, 1, 99999);
 sedConnectorsMinGap :=
   CreateSpinEdit('sedConnectorsMinGap', panConnectorsMinGap, 1, 99999);

 UserProps := TPropList.Create(Nil);
 UserData := TUserDataProp.Create(UserProps, 'User data');
end;

procedure TfmDocProps.FormDestroy(Sender: TObject);
begin
 UserProps.Free;
end;

procedure TfmDocProps.FormShow(Sender: TObject);
var Ver: integer;
begin
 if (Tag <> 0) and (TObject(Tag) is TFlexPanel) then
  FFlex := TFlexPanel(Tag);
 if Assigned(FFlex) then begin
  edTitle.Text := FFlex.Schemes.Name;
  mmComment.Lines.Text := FFlex.Schemes.Hint;
  sedWidth.Value := FFlex.DocWidth / PixelScaleFactor;
  sedHeight.Value := FFlex.DocHeight / PixelScaleFactor;
  UserData.Text := FFlex.Schemes.UserData.Text;
  Ver := FFlex.Schemes.VersionProp.Value;
  edVersion.Text := Format('%d.%d', [Ver div 100, Ver mod 100]);
  sedConnectorsMinGap.Value := FFlex.ConnectorsMinGap / PixelScaleFactor;
  chSaveAsBinary.Checked := FFlex.SaveAsBinary;
 end else begin
  panProps.Enabled := false;
  bbUserData.Enabled := false;
  bbOk.Enabled := false;
 end;
end;

procedure TfmDocProps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (ModalResult = mrOk) and Assigned(FFlex) then begin
  FFlex.Schemes.Name := edTitle.Text;
  FFlex.Schemes.Hint := mmComment.Lines.Text;
  FFlex.Schemes.UserData.Text := UserData.Text;
  FFlex.DocWidth := Round(sedWidth.Value * PixelScaleFactor);
  FFlex.DocHeight := Round(sedHeight.Value * PixelScaleFactor);
  FFlex.ConnectorsMinGap := Round(sedConnectorsMinGap.Value * PixelScaleFactor);
  FFlex.SaveAsBinary := chSaveAsBinary.Checked;
  ModalResult := mrOk;
 end;
 Action := caHide;
end;

procedure TfmDocProps.bbUserDataClick(Sender: TObject);
begin
 UserData.Edit;
end;

end.
