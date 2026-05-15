{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

library Category;

uses
  ShareMem,
  SysUtils,
  Classes,
  Windows;

{$E ctg}

{$R *.res}

//Описывает категории, которые отображаются на форме

var
  FCategoryList: TStringList;

procedure DLLMain(Reason: Integer);
begin
  if Reason = DLL_PROCESS_DETACH then FCategoryList.Free;
end;

function CategoryList: TStringList; stdcall;
begin
  Result := FCategoryList;
end;

exports
  CategoryList;

begin
  DLLProc := @DLLMain;

  FCategoryList := TStringList.Create;
  FCategoryList.Add('Трубы');
  FCategoryList.Add('Приборы');
  FCategoryList.Add('Здания');

end.
