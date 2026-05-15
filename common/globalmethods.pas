{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit globalmethods;

interface

uses Windows, SysUtils, Registry, Classes, Graphics;

  //определ€ет tmp папку в Windows
  function GetWindowsTempPath: string;
  //определе€ет папку C:\Documents and Settings\Admin\Application Data
  function GetCurrentUserPath: string;
  function KillProcess(const aExeFileName: string): Integer;
  function ProcessIsRunning(const aExeFileName: string): Boolean;
  function GetHDDInfo(Disk : Char;var VolumeName, FileSystemName: string;
    var VolumeSerialNo, MaxComponentLength, FileSystemFlags:LongWord): Boolean;
  function GetConfigIniFile: string;
  function Lighter(Color: TColor; Percent:Byte): TColor;
  function Darker(Color: TColor; Percent:Byte): TColor;
  function GetVerInfo(const aFileName, KeyVal: string): string;

implementation

uses globalvars, Forms, Wcrypt2;

  function CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD): THandle;
    stdcall; external 'KERNEL32.DLL';

  function Process32First(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL;
    stdcall; external 'KERNEL32.DLL' name 'Process32FirstW';

  function Process32Next(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL;
    stdcall; external 'KERNEL32.DLL' name 'Process32NextW';

function GetWindowsTempPath : string;
var Buffer: array[0..MAX_PATH] of Char;
begin
  SetString(Result, Buffer, GetTempPath(SizeOf(Buffer), Buffer));
  Result := IncludeTrailingPathDelimiter(Result);
end;

function GetCurrentUserPath: string;
var Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('Volatile Environment', False);
    Result := IncludeTrailingPathDelimiter(Registry.ReadString('APPDATA'));
  finally
    Registry.Free;
  end;
end;

function ProcessIsRunning(const aExeFileName : string) : Boolean;
const
  TH32CS_SNAPPROCESS  = $00000002;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
       if UpperCase(FProcessEntry32.szExeFile) = UpperCase(aExeFileName) then
       begin
         Result := True;
         Break;
       end;
       ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
  finally
    CloseHandle(FSnapshotHandle);
  end;
end;

function KillProcess(const aExeFileName: string): Integer;
const
  TH32CS_SNAPPROCESS  = $00000002;
  PROCESS_TERMINATE = $0001; 
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle; 
  FProcessEntry32: TProcessEntry32;
begin 
  Result := 0; 
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32); 
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32); 
  while Integer(ContinueLoop) <> 0 do  begin 
    if ( 
         (UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(aExeFileName)) or
         (UpperCase(FProcessEntry32.szExeFile) = UpperCase(aExeFileName))
        ) then 
      Result := 
        Integer( 
          TerminateProcess( 
            OpenProcess( 
              PROCESS_TERMINATE, 
              BOOL(0), 
              FProcessEntry32.th32ProcessID 
            ), 
            0 
          ) 
        ); 
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32); 
  end; 
  CloseHandle(FSnapshotHandle); 
end;

function GetHDDInfo(Disk : Char;var VolumeName, FileSystemName : string;
  var VolumeSerialNo, MaxComponentLength, FileSystemFlags:LongWord) : Boolean;
var
 _VolumeName,_FileSystemName:array [0..MAX_PATH-1] of Char;
 _VolumeSerialNo,_MaxComponentLength,_FileSystemFlags:LongWord;
begin
  if GetVolumeInformation(PChar(Disk + ':\'), _VolumeName, MAX_PATH, @_VolumeSerialNo,
     _MaxComponentLength, _FileSystemFlags, _FileSystemName, MAX_PATH) then
  begin
    VolumeName := _VolumeName;
    VolumeSerialNo := _VolumeSerialNo;
    MaxComponentLength := _MaxComponentLength;
    FileSystemFlags := _FileSystemFlags;
    FileSystemName := _FileSystemName;
    Result := True;
  end else
    Result := False;
end;

function Lighter(Color: TColor; Percent:Byte): TColor;
var
  r, g, b: Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r + muldiv(255 - r, Percent, 100); //процент% увеличени€ €ркости
  g := g + muldiv(255 - g, Percent, 100);
  b := b + muldiv(255 - b, Percent, 100);
  Result := RGB(r, g, b);
end;

function Darker(Color: TColor; Percent:Byte): TColor;
var  
  r, g, b: Byte;
begin  
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r - muldiv(r, Percent, 100);  //процент% уменьшени€ €ркости
  g := g - muldiv(g, Percent, 100);
  b := b - muldiv(b, Percent, 100);
  Result := RGB(r,g,b);
end;

function GetConfigIniFile: string;
var
  aFileName: string;
begin
  aFileName := ExtractFileName(Application.ExeName);
  aFileName := ChangeFileExt(aFileName, '.INI');
  Result := IncludeTrailingPathDelimiter(GetCurrentUserPath + SPTOUCH_STR) + aFileName;
end;

function GetVerInfo(const aFileName, KeyVal: string): string;
var
  aSize: DWORD;
  aBuf: pointer;
  aInfo: pointer;
  aStub: cardinal;
  aTrans: string;
  aKey: string;
begin
  aInfo := nil;
  aSize := GetFileVersionInfoSize(PChar(aFileName), aStub);
  if aSize > 0 then
  try
    aInfo := AllocMem(aSize);
    Win32Check(GetFileVersionInfo(PChar(aFileName), aStub, aSize, aInfo));

    aKey := '\VarFileInfo\Translation';
    Win32Check(VerQueryValue(aInfo, PChar(aKey), aBuf, aSize));
    aTrans := IntToHex(MakeLong(HiWord(Longint(aBuf^)), LoWord(Longint(aBuf^))), 8);

    aKey := Format('\StringFileInfo\%s\%s', [aTrans, KeyVal]);
    Win32Check(VerQueryValue(aInfo, PChar(aKey), aBuf, aSize));

    SetLength(Result, aSize - 1);
    Move(PChar(aBuf)^, PChar(Result)^, aSize - 1);
  finally
    ReallocMem(aInfo, 0);
  end;
end;

end.
