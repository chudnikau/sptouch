{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit SPServer;

interface

uses Windows, Messages, SysUtils, Classes, Registry, ShellApi, dm_general, Dialogs;

type
  ESPServer = class (Exception);

function StartSPServer : Boolean;
function SPServerIsRunning : Boolean;
function SPServerInstall : Boolean;
function GetSPServerPath : string;

implementation

uses globalvars, globalmethods;

function GetSPServerPath : string;
var Reg : TRegistry;
begin
  Result := EmptyStr;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Spnet95.exe', False) then
    begin
       Result := Reg.ReadString('Path');
       Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

function SPServerIsRunning : Boolean;
begin
  Result := ProcessIsRunning('Spdemo.exe') or ProcessIsRunning('Spserver.exe');
end;

function StartSPServer : Boolean;
var SPPath, SPExe, OldCurrentDir : string;
  InstHnd : HINST;
begin
  Result := False;
  if not SPServerIsRunning then
  begin
    SPExe := EmptyStr;
    SPPath := IncludeTrailingPathDelimiter(GetSPServerPath);// IncludeTrailingBackslash(GetSPServerPath);
    if ParamStr(1) = 'uspdemo' then
    begin
       SPExe := SPPath + 'spdemo.exe'
    end else
        SPExe := SPPath + 'spserver.exe';
    if FileExists(SPExe) then
    begin
      OldCurrentDir := GetCurrentDir;
      if not SetCurrentDir(PChar(SPPath)) then
        raise Exception.Create(
           'Ќе удалось задать текущий путь дл€ запуска sp сервера. ' +
            '¬озможно отсутствует каталог.'
        );
      InstHnd := Shellexecute(0, 'open', PChar(SPExe), nil, nil, SW_SHOWMINNOACTIVE);
      Result := InstHnd > 32;
      if Result then Sleep(5000);
      if DirectoryExists(OldCurrentDir) then SetCurrentDir(PChar(OldCurrentDir));
    end;
  end;
  Result := Result;
end;

function SPServerInstall: Boolean;
var Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Result := Reg.KeyExists('SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Spnet95.exe');
    Result := True;
  finally
    Reg.Free;
  end;
end;

end.
