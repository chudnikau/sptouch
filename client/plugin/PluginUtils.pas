{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginUtils;

interface

uses
  Classes, Windows, SysUtils, Messages, Controls, Contnrs;

//stream
procedure PluginFromStream(ParentControl: TWinControl; Stream: TStream);
procedure PluginToStream(Instance: TControl; Stream: TStream);
//ifer
function ClassIsPlugin(Instance: TControl): Boolean;
//функция получения номера версии плагина, которые использует приложение
function GetCurrentPluginVersion: Integer;

implementation

uses
  SpMiscUtils, PluginContainer, Dialogs, IniFiles, Forms;

procedure PluginFromStream(ParentControl: TWinControl; Stream: TStream);
var
  i: Integer;
  Comp: TComponent;
  ObjList: TList;
begin
  if Assigned(ParentControl) then
  begin
    ObjList := TList.Create;
    try
      ParentControl.Perform(WM_SETREDRAW, 0, 0);
      try
        i := IntFromStream(Stream);
        while i > 0 do
        begin
          Comp := Stream.ReadComponent(nil);
          ObjList.Add(Comp);
          ParentControl.InsertComponent(Comp);
          TControl(Comp).Parent := ParentControl;
          Dec(i);
        end;
      finally
        ParentControl.Perform(WM_SETREDRAW, 1, 0);
      end;
      for i := 0 to ObjList.Count - 1 do TControl(ObjList[i]).Invalidate;
    finally
      ObjList.Free;
    end;
  end;
end;

procedure PluginToStream(Instance: TControl; Stream: TStream);
var
  i, n: Integer;
begin
  n := 0;
  IntToStream(Stream, 0);
  for i := 0 to Instance.ComponentCount - 1 do
  begin
    if Assigned(Instance.Components[i].GetInterfaceEntry(IProperty)) then
    begin
      Stream.WriteComponent(Instance.Components[i]);
      Inc(n);
    end;
  end;
  Stream.Seek(0, soFromBeginning);
  IntToStream(Stream, n);
end;

function ClassIsPlugin(Instance: TControl): Boolean;
begin
  Result := Assigned(Instance.GetInterfaceEntry(IProperty));
end;

function GetCurrentPluginVersion: Integer;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI')) do
  try
    Result := ReadInteger('PLUGIN', 'VERSION', 0);
  finally
    Free;
  end;
end;

end.
