{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

//http://msdn.microsoft.com/en-us/library/ff468833(v=VS.85).aspx
//http://msdn.microsoft.com/en-us/library/ms648714(v=VS.85).aspx

unit SPQuery;

interface

uses
  Windows, WinTypes, Messages, SysUtils, Classes, StdCtrls, DDEML, Dialogs;

type
  ESPQuery = class(Exception);

  TSPQuery = class(TObject)
  private
    FConnected : Boolean;
    FDdeInstId : LongInt;
    FServiceHSZ, FTopicHSZ : HSZ;
    hConv : HConv;
    FTopic : string;
    procedure DDECheck(Success: Boolean);
    procedure ConnectDde;
    procedure DisconnectDde;
  public
    procedure ReConnectDde;
    function GetData(const ARequest : string) : string;
    constructor Create(const Atopic : string); reintroduce;
    destructor Destroy; override;
    property Connected : Boolean read FConnected;
  end;

function DdeCallback(CallType, Fmt: Word; Conv: HConv; HSz1, HSz2: HSZ;
    Data: HDDEData; Data1, Data2: Longint): HDDEData; export;

implementation

uses Consts, Log;

procedure TSPQuery.DDECheck(Success: Boolean);
var
  err: Integer;
  ErrStr: string;
begin
  if Success then Exit;
  err := DdeGetLastError(FDdeInstId);
  case err of
    DMLERR_LOW_MEMORY, DMLERR_MEMORY_ERROR:
      ErrStr := Format(SDdeMemErr, [err]);
    DMLERR_NO_CONV_ESTABLISHED:
      ErrStr := Format(SDdeConvErr, [err]);
  else
    ErrStr := Format(SDdeErr, [err]);
  end;
  raise ESPQuery.Create(ErrStr);
end;

function DdeCallback(CallType,
  Fmt: Word;        // Clipboard data format.
  Conv: HConv;      // Handle to the conversation.
  HSz1,             // Handle to a string.
  HSz2: HSZ;        // Handle to a string.
  Data: HDDEData;   // Handle to a global memory object.
  Data1,            // Transaction-specific data.
  Data2: Longint    // Transaction-specific data.
  ): HDDEData;
begin
  Result := DDE_FACK;  //транзакции мы не обрабатываем
end;

procedure TSPQuery.ConnectDde;
var CharVal: array[0..255] of Char;
    aLastError : UINT;
begin
  FDdeInstId := 0;
  DDECheck(DdeInitialize(FDdeInstId, @DdeCallback, APPCLASS_STANDARD, 0) = 0);
  StrPCopy(CharVal, 'spserver');
  FServiceHSZ := DdeCreateStringHandle(FDdeInstId, CharVal, CP_WINANSI);
  StrPCopy(CharVal, FTopic);
  FTopicHSZ := DdeCreateStringHandle(FDdeInstId, CharVal, CP_WINANSI);
  hConv := DdeConnect(FDdeInstId, FServiceHSz, FTopicHSZ, nil);
  aLastError := DdeGetLastError(FDdeInstId);
  if aLastError <> DMLERR_NO_ERROR then
  begin
    case aLastError of
       DMLERR_DLL_NOT_INITIALIZED : WriteToLog('E: DdeOpen: DMLERR_DLL_NOT_INITIALIZED');
       DMLERR_INVALIDPARAMETER : WriteToLog('E: DdeOpen: DMLERR_INVALIDPARAMETER');
       DMLERR_NO_CONV_ESTABLISHED : WriteToLog('E: DdeOpen: DMLERR_NO_CONV_ESTABLISHED');
    end;
    Exit;
  end;
  FConnected := hConv > 0;
end;

constructor TSPQuery.Create(const ATopic : string);
begin
  inherited Create;
  FTopic := ATopic;
  ConnectDde;
end;

destructor TSPQuery.Destroy;
begin
  DisconnectDde;
  inherited Destroy;
end;

procedure TSPQuery.DisconnectDde;
begin
  if hConv <> 0 then DdeDisconnect(hConv);
  if FServiceHSZ <> 0 then DdeFreeStringHandle(FDdeInstId, FServiceHSZ);
  if FTopicHSZ <> 0 then DdeFreeStringHandle(FDdeInstId, FTopicHSZ);
  DdeUninitialize(FDdeInstId);
end;

function TSPQuery.GetData(const ARequest : string): string;
const
  TIME_OUT = 10000;
type
  TRequestArray = array of string;
var
  hItem : HSZ;
  hData : HDDEData;
  pData: Pointer;
  Len: Integer;
  aLastError : UINT;
  ARequestArray : TRequestArray;
  i : Integer;
  pAccessedData : PChar;
  sAccessedData : string;
  buffer : array [1..255] of char;

  procedure CalcInputParams(const aRequestString : string; out aRequestArray : TRequestArray);
  var S, TmpS : string;
      n : Integer;
  begin
    S := aRequestString;
    while S <> '' do
    begin
      if Length(S) <= 255 then
      begin
        TmpS := S;
        if TmpS[1] <> 'R' then TmpS := 'R' + TmpS;
        SetLength(aRequestArray, Length(aRequestArray) + 1);
        aRequestArray[High(aRequestArray)] := TmpS;
        Break;
      end else
      begin
        n := 255;
        while S[n] <> ')' do Dec(n);
        TmpS := Copy(S, 1, n);
        if TmpS[1] <> 'R' then TmpS := 'R' + TmpS;
        SetLength(aRequestArray, Length(aRequestArray) + 1);
        aRequestArray[High(aRequestArray)] := TmpS;
        Delete(S, 1, n);
      end;
    end;
  end;

begin
  CalcInputParams(ARequest, ARequestArray);
  for i := 0 to Length(ARequestArray) - 1 do
  begin
    hItem := DdeCreateStringHandle(FDdeInstId, PChar(ARequestArray[i]), CP_WINANSI);
    try
      aLastError := DdeGetLastError(FDdeInstId);
      if aLastError <> DMLERR_NO_ERROR then
      begin
        case aLastError of
          DMLERR_INVALIDPARAMETER : WriteToLog('E: DdeCreateStringHandle: DMLERR_INVALIDPARAMETER');
          DMLERR_SYS_ERROR : WriteToLog('E: DdeCreateStringHandle: DMLERR_SYS_ERROR');
        end;
        Exit;
      end;
      hData := DdeClientTransaction(nil, 0, hConv, hItem, CF_TEXT, XTYP_REQUEST, TIME_OUT, nil);
      try
        aLastError := DdeGetLastError(FDdeInstId);
        if aLastError <> DMLERR_NO_ERROR then
        begin
          case aLastError of
            DMLERR_ADVACKTIMEOUT : WriteToLog('E: DdeClientTransaction: DMLERR_ADVACKTIMEOUT');
            DMLERR_BUSY : WriteToLog('E: DdeClientTransaction: DMLERR_BUSY');
            DMLERR_DATAACKTIMEOUT : WriteToLog('E: DdeClientTransaction: DMLERR_DATAACKTIMEOUT');
            DMLERR_DLL_NOT_INITIALIZED : WriteToLog('E: DdeClientTransaction: DMLERR_DLL_NOT_INITIALIZED');
            DMLERR_EXECACKTIMEOUT : WriteToLog('E: DdeClientTransaction: DMLERR_EXECACKTIMEOUT');
            DMLERR_INVALIDPARAMETER : WriteToLog('E: DdeClientTransaction: DMLERR_INVALIDPARAMETER');
            DMLERR_MEMORY_ERROR : WriteToLog('E: DdeClientTransaction: DMLERR_MEMORY_ERROR');
            DMLERR_NO_CONV_ESTABLISHED : WriteToLog('E: DdeClientTransaction: DMLERR_NO_CONV_ESTABLISHED');
            DMLERR_NOTPROCESSED : WriteToLog('E: DdeClientTransaction: DMLERR_NOTPROCESSED');
            DMLERR_POKEACKTIMEOUT : WriteToLog('E: DdeClientTransaction: DMLERR_POKEACKTIMEOUT');
            DMLERR_POSTMSG_FAILED : WriteToLog('E: DdeClientTransaction: DMLERR_POSTMSG_FAILED');
            DMLERR_REENTRANCY : WriteToLog('E: DdeClientTransaction: DMLERR_REENTRANCY');
            DMLERR_SERVER_DIED : WriteToLog('E: DdeClientTransaction: DMLERR_SERVER_DIED');
            DMLERR_UNADVACKTIMEOUT : WriteToLog('E: DdeClientTransaction: DMLERR_UNADVACKTIMEOUT');
          end;
          Exit;
        end;
        pData := DdeAccessData(hData, @Len);
        try
          if pData <> nil then
          begin
            pAccessedData := StrAlloc(Len + 1);
            try
              Move(pData^, pAccessedData^, len);
              pAccessedData[len] := #0;
              sAccessedData := pAccessedData;
              if Result = EmptyStr then
                Result := sAccessedData
              else
                Result := Result + Copy(sAccessedData, 2, Length(sAccessedData) - 1);
            finally
              StrDispose(pAccessedData);
            end;
          end;
        finally
          DdeUnaccessData(hData);
        end;
      finally
        DdeFreeDataHandle(hData);
      end;
    finally
      DdeFreeStringHandle(FDdeInstId, hItem);
    end;
  end;
end;

procedure TSPQuery.ReConnectDde;
begin
  DisconnectDde;
  ConnectDde;
end;

end.

