{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit Log;

interface

uses Classes, SysUtils, Windows, DateUtils;

function GetLogFilePath : string;
procedure WriteToLog(const ALogStr: string); overload;
procedure WriteToLog(const ALogStr, aLogFilePath: string); overload;

implementation

uses dm_general, Forms, globalvars, DBdata;

procedure WriteToLog(const ALogStr, aLogFilePath: string);
var
  S, aLogFile : string;
  fs : TFileStream;
begin
  if FileExists(aLogFilePath) then
     fs := TFileStream.Create(aLogFilePath, fmOpenWrite)
  else
     fs := TFileStream.Create(aLogFilePath, fmCreate);
  fs.Seek(0, soFromEnd);
  try
    S := '[' + DateTimeToStr(Now) + ']' + #9 + ALogStr + #13#10;
    fs.WriteBuffer(Pointer(S)^, Length(S));
  finally
    fs.Free;
  end;
end;

procedure WriteToLog(const ALogStr: string);
var
  S, aLogFile : string;
  fs : TFileStream;
begin
  if FileExists(GetLogFilePath) then
     fs := TFileStream.Create(GetLogFilePath, fmOpenWrite)
  else
     fs := TFileStream.Create(GetLogFilePath, fmCreate);
  try
    fs.Seek(0, soFromEnd);
    S := '[' + DateTimeToStr(Now) + ']' + #9 + ALogStr + #13#10;
    fs.WriteBuffer(Pointer(S)^, Length(S));
  finally
    fs.Free;
  end;
end;

function GetLogFilePath : string;
var
  aWeekNr, aDayOfWeek : Word;
  aLogPath, aDateStr : string;
  aServerDateTime : TDateTime;
begin
  Result := EmptyStr;
  //если не могу получить серверное время, беру локальное время компьютера
  if UDBData <> nil then
    aServerDateTime := UDBData.GetServerDateTime
  else
    aServerDateTime := Now();
  aWeekNr := WeekOfTheMonth(aServerDateTime);
  aDayOfWeek := DayOfTheWeek(aServerDateTime);
  aLogPath := ExtractFilePath(Application.ExeName) + 'log';
  if not ForceDirectories(aLogPath) then
    raise Exception.Create(Concat('Не могу создать дирректорию. ', aLogPath));
  aDateStr := Format('%d_%d', [aWeekNr, aDayOfWeek]);
  Result := Concat(IncludeTrailingPathDelimiter(aLogPath), aDateStr, '.log');
end;

end.
