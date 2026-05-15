unit SpMiscUtils;

interface

uses
  Classes, SysUtils;

function IntFromStream(aStream: TStream): integer;
function ReadLine(aStream: TStream; var aLine: string; aBufLen: integer = 255): boolean;
function StrFromStream(aStream: TStream): string;
function GetToken(var aSrc: string; const aSep: string): string;
function HexToInt(const aHex: string): integer;
procedure IntToStream(aStream: TStream; aValue: integer);
procedure StrToStream(aStream: TStream; const aValue: string);

implementation

procedure IntToStream(aStream: TStream; aValue: integer);
begin
  aStream.WriteBuffer(aValue, SizeOf(aValue));
end;

function  IntFromStream(aStream: TStream): integer;
begin
  aStream.ReadBuffer(Result, SizeOf(Result));
end;

procedure StrToStream(aStream: TStream; const aValue: string);
var
  aLen: integer;
begin
  aLen := Length(aValue);
  aStream.WriteBuffer(aLen, SizeOf(aLen));
  aStream.WriteBuffer(PChar(aValue)^, aLen);
end;

function  StrFromStream(aStream: TStream): string;
var
  aLen: integer;
begin
  aStream.ReadBuffer(aLen, SizeOf(aLen));
  SetLength(Result, aLen);
  aStream.ReadBuffer(PChar(Result)^, aLen);
end;

function HexToInt(const aHex: string): integer;
var
  i: byte;
  aLen: byte;
  aDig: byte;
  aBase: integer;
begin
  Result := 0;
  aBase := 1;
  aLen := Length(aHex);
  if aLen > 8 then raise EConvertError.CreateFmt('Hex number too long "%s"', [aHex]);
  for i := 0 to aLen - 1 do
  begin
    case aHex[aLen - i] of
      '0': aDig := 0;
      '1': aDig := 1;
      '2': aDig := 2;
      '3': aDig := 3;
      '4': aDig := 4;
      '5': aDig := 5;
      '6': aDig := 6;
      '7': aDig := 7;
      '8': aDig := 8;
      '9': aDig := 9;
      'A', 'a': aDig := 10;
      'B', 'b': aDig := 11;
      'C', 'c': aDig := 12;
      'D', 'd': aDig := 13;
      'E', 'e': aDig := 14;
      'F', 'f': aDig := 15;
    else
      raise EConvertError.CreateFmt('Invalid hex number "%s"', [aHex]);
    end;

    Result := Result + aBase * aDig;
    aBase := aBase shl 4;
  end;
end;

function  ReadLine(aStream: TStream; var aLine: string; aBufLen: integer = 255): boolean;
var
  i: integer;
  aBuf: string;
  aLen: integer;
  aFlag: boolean;
begin
  Result := (aStream.Position < aStream.Size);
  if not Result then Exit;

  aFlag := False;
  aLine := EmptyStr;
  SetLength(aBuf, aBufLen);
  try
    while not aFlag and (aStream.Position < aStream.Size) do
    begin
      aLen := aStream.Read(aBuf[1], aBufLen);
      for i := 1 to aLen do
        if aBuf[i] = #13 then
        begin
          aLine := aLine + Copy(aBuf, 1, i - 1);
          aStream.Position := aStream.Position - aLen + i + 1;
          aFlag := True;
          Break;
        end;
        
      if not aFlag then aLine := aLine + Copy(aBuf, 1, aLen);
    end;
  finally
    SetLength(aBuf, 0);
  end;
end;

function GetToken(var aSrc: string; const aSep: string): string;
var
  p: integer;
begin
  Result := EmptyStr;
  p := Pos(aSep, aSrc);
  if p = 0 then
  begin
    Result := aSrc;
    aSrc := EmptyStr;
  end else begin
    Result := Copy(aSrc, 1, p - 1);
    Delete(aSrc, 1, p + Length(aSep) - 1);
  end;
end;


end.
