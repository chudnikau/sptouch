unit fLibProps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, FlexLibs;

type
  TfmLibProps = class(TForm)
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edTitle: TEdit;
    Label3: TLabel;
    mmDesc: TMemo;
    edLibFilename: TEdit;
    bbBrowse: TBitBtn;
    od_Browse: TOpenDialog;
    procedure bbBrowseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FFlexLibrary: TFlexLibrary;
    procedure SetFlexLibrary(const Value: TFlexLibrary);
  public
    { Public declarations }
    property  FlexLibrary: TFlexLibrary read FFlexLibrary write SetFlexLibrary;
  end;

var
  fmLibProps: TfmLibProps;

implementation

{$R *.DFM}

procedure TfmLibProps.bbBrowseClick(Sender: TObject);
begin
 if od_Browse.Execute then edLibFilename.Text := od_Browse.Filename;
end;

procedure TfmLibProps.SetFlexLibrary(const Value: TFlexLibrary);
begin
 if Value = FFlexLibrary then exit;
 FFlexLibrary := Value;
 if Assigned(FFlexLibrary) then begin
  edLibFilename.Text := FFlexLibrary.LibFilename;
  edTitle.Text := FFlexLibrary.Name;
  mmDesc.Lines.Text := FFlexLibrary.Hint;
 end;
end;

procedure TfmLibProps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ModalResult = mrOk then begin
  FFlexLibrary.LibFilename := edLibFilename.Text;
  FFlexLibrary.Name := edTitle.Text;
  FFlexLibrary.Hint := mmDesc.Lines.Text;
  FFlexLibrary.Modified := true;
 end;
end;

end.
