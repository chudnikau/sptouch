unit fPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FlexBase, FlexUtils;

type
  TfmPreview = class(TForm)
    Flex: TFlexPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPreview: TfmPreview;

implementation

{$R *.DFM}

procedure TfmPreview.FormShow(Sender: TObject);
begin
 try
  Flex.ClientWidth := ScaleValue(Flex.DocWidth, 100);
  Flex.ClientHeight := ScaleValue(Flex.DocHeight, 100);
  ClientWidth := Flex.Width;
  ClientHeight := Flex.Height;
  Flex.Align := alClient;
  Flex.HorzScrollBar.Visible := True;
  Flex.VertScrollBar.Visible := True;
  if Flex.HorzScrollBar.IsScrollBarVisible or
     Flex.VertScrollBar.IsScrollBarVisible then
   WindowState := wsMaximized
  else begin
   Left := (Screen.Width - Width) div 2;
   Top := (Screen.Height - Height) div 2;
  end;
  Flex.ActiveScheme := Flex.DefaultScheme;
 except
 end;
end;

end.
