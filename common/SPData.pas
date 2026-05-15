{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit SPData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, SPADO,
  SPQuery;

type
  ERSPT961Exception = class(Exception);

  TParamsQ = array of Integer;

  TDesParam = record
    Id : LongWord;                 //id - paramquery_id
    ParamID : LongWord;            //id - param_id
    Code : string[2];              //признак массива
    Value : Single;                //значение параметра
  end;

  TDesParams = array of TDesParam;

  TSPData = class
  private
    FSPQuery : TSPQuery;
    function GetConnected: Boolean;
  public
    constructor Create(const ATopic : string); reintroduce;
    destructor Destroy; override;
    procedure ReConnectDde;
    function Active : Boolean;
    function GetParams(const AMeterId : Word; const ARequestParams : TDesParams) : TDesParams;
    function GetArray(const AMeterId : Word;  const ARequestParam : TDesParam;
      const AFilter : string; const aTryN : Integer) : TDesParams;
    function GetTable(const AMeterId : Word; const ARequestParams : TDesParams) : TDesParams;
    property Connected : Boolean read GetConnected;
  end;

implementation

uses Log, dm_general, globalvars;

function TSPData.Active: Boolean;
begin
  Result := FSPQuery.Connected;
end;

constructor TSPData.Create(const ATopic : string);
begin
  inherited Create;
  FSPQuery := TSPQuery.Create(ATopic);
  //FSPADO := TSPADO.Create(nil);
end;

destructor TSPData.Destroy;
begin
  //FSPADO.Free;
  FSPQuery.Free;
  inherited Destroy;
end;

function TSPData.GetConnected: Boolean;
begin
  Result := FSPQuery.Connected;
end;

(*
возвращает массив ответов
если размеры массивов не совпадают request и response, то
произошла ошибка при чтении одного из параметров массива request
*)
function TSPData.GetParams(const AMeterId: Word;
  const ARequestParams : TDesParams): TDesParams;
const
  TRY_COUNT = 2;
var
  DataString, ResponseStr, PatternRequest, Decimal : string;
  FirstValue : Double;
  i : Integer;
  ParamId : LongWord;
  Buffer : PChar;
  tryI : Byte;
begin
  SetLength(Result, 0);
  if Length(ARequestParams) = 0 then Exit;  
  PatternRequest := EmptyStr;
  for i := Low(ARequestParams) to High(ARequestParams) do
     PatternRequest := Concat(PatternRequest, Format('(%d,%d)',
        [AMeterId, ARequestParams[i].ParamID]));
  PatternRequest := 'R' + PatternRequest;
  tryI := 0;
  WriteToLog('--> ' + PatternRequest);
  ResponseStr := FSPQuery.GetData(PatternRequest);
  WriteToLog('<-- ' + ResponseStr);
  while ((ResponseStr = EmptyStr) or (ResponseStr[1] = 'E')) and (tryI < TRY_COUNT) do
  begin
    WriteToLog('--> ' + PatternRequest);
    ResponseStr := FSPQuery.GetData(PatternRequest);
    WriteToLog('<-- ' + ResponseStr);
    Inc(tryI);
  end;
  if (ResponseStr = EmptyStr) or (ResponseStr[1] = 'E') then Exit;
  GetMem(Buffer, 1);
  try
    GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, Buffer, 1);
    SetString(Decimal, Buffer, 1);
  finally
    FreeMem(Buffer);
  end;
  //сопоставление мантисы ответа СП-Сервера и Windows
  if Decimal <> '.' then
     ResponseStr := StringReplace(ResponseStr, '.', Decimal, [rfReplaceAll]);
  (*
  for testing
  ResponseStr := 'D(18,16187)'#$C#$C'(18,16188)'#$C#$C'(18,16189)'#$C#$C;
  ResponseStr := 'D(18,16187)'#$C#9'1.0614'#9'МПа'#$C'(18,16188)'#$C#9'111.98'#9'C'#$C'(18,16189)'#$C#9'2772'#9'т/ч'#$C;
  ResponseStr := 'D(4,16219)'#$C#9'Канал?'#$C'(4,16187)'#$C#9'0.7964'#9'МПа'#$C;
  *)
  while ResponseStr <> EmptyStr do
  begin
    Delete(ResponseStr, 1, Pos(',', ResponseStr));
    ParamId := StrToIntDef(Copy(ResponseStr, 1, Pos(')', ResponseStr) - 1), 0);
    Delete(ResponseStr, 1, Pos(#$C, ResponseStr));
    DataString := EmptyStr;
    if (ResponseStr <> EmptyStr) and (ResponseStr[1] = #9) then
    begin
      DataString := Copy(ResponseStr, 2, Pos(#$C, ResponseStr) - 1);
      if Pos(#9, DataString) > 0 then
         DataString := Copy(DataString, 1, Pos(#9, DataString) - 1)
      else
         DataString := Copy(DataString, 1, Pos(#$C, DataString) - 1);
      FirstValue := StrToFloatDef(DataString, 99999999);
      if FirstValue = 99999999 then Continue; //не получается преобразовать
      SetLength(Result, Length(Result) + 1);
      for i := 0 to Length(ARequestParams) - 1 do
      begin
        if ARequestParams[i].ParamID = ParamId then
        begin
          Result[High(Result)].Id := ARequestParams[i].id;
          Break;
        end;
      end;
      Result[High(Result)].ParamID := ParamId;
      Result[High(Result)].value := FirstValue;
    end;
    Delete(ResponseStr, 1, Pos(#$C, ResponseStr));
  end;
end;

function TSPData.GetArray(const AMeterId: Word;
  const ARequestParam: TDesParam; const AFilter : string; const aTryN : Integer): TDesParams;
var
  DataString, ResponseStr : string;
  PatternRequest, Decimal : string;
  tryI : Byte;
  Buffer : PChar;
  FirstValue : Double;
begin
  SetLength(Result, 0);
  PatternRequest := Format('R(%d, %d, %s)', [AMeterId, ARequestParam.ParamID, AFilter]);
  WriteToLog('--> ' + PatternRequest);
  ResponseStr := FSPQuery.GetData(PatternRequest);
  WriteToLog('<-- ' + ResponseStr);
  tryI := 0;
  while ((ResponseStr = EmptyStr) or (ResponseStr[1] = 'E')) and (tryI < aTryN) do
  begin
    WriteToLog('--> ' + PatternRequest);
    ResponseStr := FSPQuery.GetData(PatternRequest);
    WriteToLog('<-- ' + ResponseStr);
    Inc(tryI);
  end;
  if (ResponseStr = EmptyStr) or (ResponseStr[1] = 'E') then Exit;
  //получаю разделитель дроби windows
  GetMem(Buffer, 1);
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SDECIMAL, Buffer, 1);
  SetString(Decimal, Buffer, 1);
  FreeMem(Buffer);
  //сопоставление мантисы ответа СП-Сервера и Windows
  if Decimal <> '.' then
     ResponseStr := StringReplace(ResponseStr, '.', Decimal, [rfReplaceAll]);
  while ResponseStr <> EmptyStr do
  begin
    Delete(ResponseStr, 1, Pos(#$C, ResponseStr));
    DataString := EmptyStr;
    if (ResponseStr <> EmptyStr) and (ResponseStr[1] = #9) then
    begin
      DataString := Copy(ResponseStr, 2, Pos(#$C, ResponseStr) - 1);
      if Pos(#9, DataString) > 0 then
         FirstValue := StrToFloatDef(Copy(DataString, 1, Pos(#9, DataString) - 1), 0)
      else
         FirstValue := StrToFloatDef(Copy(DataString, 1, Pos(#$C, DataString) - 1), 0);
      //создаю массив-ответ
      SetLength(Result, Length(Result) + 1);
      //заполняю информацию о параметре
      Result[High(Result)].Id := ARequestParam.Id;
      Result[High(Result)].ParamID := ARequestParam.ParamID;
      Result[High(Result)].Value := FirstValue;
    end;
    Delete(ResponseStr, 1, Pos(#$C, ResponseStr));
  end;
end;

function TSPData.GetTable(const AMeterId : Word;
      const ARequestParams : TDesParams): TDesParams;
begin
  raise ERSPT961Exception.Create('Exception GetTableFromDdeServer() not support.');
end;

procedure TSPData.ReConnectDde;
begin
  FSPQuery.ReConnectDde;
end;

end.
