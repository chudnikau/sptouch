{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit DialogsEx;

interface

uses
  Windows, Messages, SysUtils, CommDlg,
  Printers, Classes, Graphics, Controls, Forms, StdCtrls, DateUtils, ExtCtrls,
  Mask, MdExtCtrls;

function _InputBox(const ACaption, APrompt, ADefault: string): string;
function _InputBoxPassword(const ACaption, APrompt, ADefault: string): string;
function _InputQuery(const ACaption, APrompt: string; var Value: string): Boolean;
function _InputQueryPassword(const ACaption, APrompt: string; var Value: string): Boolean;
function _MessageBoxTimeOut(lpText, lpCaption: string; uType: Longword; const aTimeOut : Integer): Integer;
function _MessageBox(hWnd: HWND; lpText, lpCaption: PChar; uType: UINT): Integer;

implementation

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function _InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TMdBitBtn.Create(Form) do
      begin
        Parent := Form;
        Caption := 'ОК';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TMdBitBtn.Create(Form) do
      begin
        Parent := Form;
        Caption := 'Отмена';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function _InputQueryPassword(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        PasswordChar := '*';
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'ОК';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'Отмена';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function _InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  _InputQuery(ACaption, APrompt, Result);
end;

function _InputBoxPassword(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  _InputQueryPassword(ACaption, APrompt, Result);
end;

function _MessageBoxTimeOut(lpText, lpCaption: string; uType: Longword; const aTimeOut : Integer): Integer;
var Form: TForm;
    DialogUnits: TPoint;
    aShowingStart, aShowing : TTime;
    ButtonFirst, ButtonSecond, ButtonThird : TButton;
    aShowingBetween, aGeneralBtnWidth, aDefOneBtnWidth, P, P1, P2, P3 : Integer;
    fIcon : HIcon;
    aFirstLeft, aSecondLeft, aThirdLeft : Integer;
    S : string;
 begin
  Form := TForm.Create(Application);
  with Form do
  try
    Caption := lpCaption;
    Canvas.Font := Font;
    BorderStyle := bsDialog;
    FormStyle := fsStayOnTop;
    ClientWidth := Canvas.TextWidth(lpText) + 70;
    Position := poScreenCenter;
    ButtonFirst := nil;
    ButtonSecond := nil;
    ButtonThird := nil;
    with TLabel.Create(Form) do
    begin
      Parent := Form;
      Caption := lpText;
      Left := 60;
      Top := 25;
    end;
    if uType mod $00000010 = MB_OKCANCEL then
    begin
      ButtonFirst := TButton.Create(Form);
      ButtonFirst.Caption := 'OK';
      ButtonFirst.ModalResult := mrOk;
      ButtonSecond := TButton.Create(Form);
      ButtonSecond.Caption := 'Отмена';
      ButtonSecond.ModalResult := mrCancel;
    end else
    if uType mod $00000010 = MB_ABORTRETRYIGNORE then
    begin
      ButtonFirst := TButton.Create(Form);
      ButtonFirst.Caption := 'Прервать';
      ButtonFirst.ModalResult := mrAbort;
      ButtonSecond := TButton.Create(Form);
      ButtonSecond.Caption := 'Игнорировать';
      ButtonSecond.ModalResult := mrIgnore;
    end else
    if uType mod $00000010 = MB_YESNOCANCEL then
    begin
      ButtonFirst := TButton.Create(Form);
      ButtonFirst.Caption := 'Да';
      ButtonFirst.ModalResult := mrYes;
      ButtonSecond := TButton.Create(Form);
      ButtonSecond.Caption := 'Нет';
      ButtonSecond.ModalResult := mrNo;
      ButtonThird := TButton.Create(Form);
      ButtonThird.Caption := 'Отмена';
      ButtonThird.ModalResult := mrCancel;
    end else
    if uType mod $00000010 = MB_YESNO then
    begin
      ButtonFirst := TButton.Create(Form);
      ButtonFirst.Caption := 'Да';
      ButtonFirst.ModalResult := mrYes;
      ButtonSecond := TButton.Create(Form);
      ButtonSecond.Caption := 'Нет';
      ButtonSecond.ModalResult := mrNo;
    end else
    if uType mod $00000010 = MB_RETRYCANCEL then
    begin
      ButtonFirst := TButton.Create(Form);
      ButtonFirst.Caption := 'Повторить';
      ButtonFirst.ModalResult := mrRetry;
      ButtonSecond := TButton.Create(Form);
      ButtonSecond.Caption := 'Отмена';
      ButtonSecond.ModalResult := mrCancel;
    end else
    begin
      //MB_OK
      ButtonFirst := TButton.Create(Form);
      ButtonFirst.Caption := 'OK';
      ButtonFirst.ModalResult := mrOk;
    end;
    aDefOneBtnWidth := 75;
    aGeneralBtnWidth := 0;
    if ButtonFirst <> nil then
    with ButtonFirst do
    begin
      Parent := Form;
      Top := 60;
      Width := 25;
      Width := aDefOneBtnWidth;
      Inc(aGeneralBtnWidth, aDefOneBtnWidth);
    end;
    if ButtonSecond <> nil then
    with ButtonSecond do
    begin
      Parent := Form;
      Top := 60;
      Width := 25;
      Width := aDefOneBtnWidth;
      Inc(aGeneralBtnWidth, aDefOneBtnWidth);
    end;
    if ButtonThird <> nil then
    with ButtonThird do
    begin
      Parent := Form;
      Top := 60;
      Width := 25;
      Width := aDefOneBtnWidth;
      Inc(aGeneralBtnWidth, aDefOneBtnWidth);
    end;
    P := (Form.ClientWidth - aGeneralBtnWidth) div 2;
    P1 := P;
    P2 := P1 + aDefOneBtnWidth + 5;
    P3 := P2 + aDefOneBtnWidth + 5;
    if ButtonFirst <> nil then ButtonFirst.Left := P1;
    if ButtonSecond <> nil then ButtonSecond.Left := P2;
    if ButtonThird <> nil then ButtonThird.Left := P3;
    ClientHeight := 60 + 25 + 15;
    if uType div $00000010 * $00000010 = MB_ICONQUESTION then
       fIcon := LoadIcon(0, IDI_QUESTION)
    else
    if uType div $00000010 * $00000010 = MB_ICONWARNING then
       fIcon := LoadIcon(0, IDI_WARNING)
    else
    if uType div $00000010 * $00000010 = MB_ICONERROR then
       fIcon := LoadIcon(0, IDI_ERROR);
    with TImage.Create(Form) do
    begin
      Name := 'Image';
      Parent := Form;
      Picture.Icon.Handle := fIcon;
      SetBounds(10, 17, 32, 32);
    end;
    Show;
    try
      SendMessage(Handle, CM_ACTIVATE, 0, 0);
      ModalResult := mrNone;
      aShowingStart := Time;
      S := ButtonFirst.Caption;
      repeat
        aShowingBetween := MilliSecondsBetween(aShowingStart, Time);
        ButtonFirst.Caption := S + ' (' + IntToStr((aTimeOut - aShowingBetween) div 1000) + ')';
        Application.ProcessMessages;
      until (aShowingBetween >= aTimeOut) or (ModalResult <> 0);
      if ModalResult = mrNone then ModalResult := ButtonFirst.ModalResult;
      Result := ModalResult;
      SendMessage(Handle, CM_DEACTIVATE, 0, 0);
    finally
      Hide;
    end;
  finally
    Form.Free;
  end;
end;

function _MessageBox(hWnd: HWND; lpText, lpCaption: PChar; uType: UINT): Integer;
begin
  case uType div $00000010 * $00000010  of
    MB_ICONHAND          : MessageBeep(MB_ICONHAND);
    //MB_ICONQUESTION не работает, заменил на MB_ICONEXCLAMATION
    MB_ICONQUESTION      : MessageBeep(MB_ICONEXCLAMATION);
    MB_ICONEXCLAMATION   : MessageBeep(MB_ICONEXCLAMATION);
    MB_ICONASTERISK      : MessageBeep(MB_ICONASTERISK);
  else
    MessageBeep(MB_OK);
  end;
  Result := Windows.MessageBox(hWnd, lpText, lpCaption, uType);
end;

end.
