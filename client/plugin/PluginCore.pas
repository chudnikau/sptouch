{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginCore;

interface

uses
  Windows, Classes, SysUtils, Forms, PluginContainer;

type
  TProcPluginCount = function: Integer; stdcall;
  TProcCategoryList = function: TStringList; stdcall;
  TProcPluginContainer = function: TPluginContainer; stdcall;
  TProcPluginVersion = function: Integer; stdcall;

procedure CheckPlugin;

implementation

uses
  GlobalVars, FileUtils;

procedure CheckPlugin;
var
  Lib: THandle;
  List: TStringList;
  i: Integer;
begin
  //провер€ю плагины
  List := TStringList.Create;
  try
    FileList('.\plugins\*.plg', List);
    for i := 0 to List.Count - 1 do
    begin
      Lib := LoadLibrary(PChar('.\plugins\' + List[i]));
      try
        ASSERT(Assigned(GetProcAddress(Lib, 'PluginVersion')));
        ASSERT(Assigned(GetProcAddress(Lib, 'PluginObject')));
      finally
        FreeLibrary(Lib);
      end;
    end;
  finally
    List.Free;
  end;
  //провер€ю библиотеку категорий плагинов
  ASSERT(FileExists('.\plugins\' + PLUGIN_CAT));
  Lib := LoadLibrary('.\plugins\' + PLUGIN_CAT);
  try
    ASSERT(Assigned(GetProcAddress(Lib, 'CategoryList')));
  finally
    FreeLibrary(Lib);
  end;
  //провер€ю наличие ini файла содерж информацию о загрузке плагинов в прилож
  ASSERT(FileExists(ChangeFileExt(Application.ExeName, '.INI')));
end;

end.
