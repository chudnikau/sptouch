{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit SPADO;

interface

uses
  Windows, Classes, WinTypes, Messages, SysUtils, StdCtrls, DDEML, Dialogs,
  ADODB, ComCtrls, Lists, Contnrs;

type
  ESPADO = class(Exception);

  TCacheObject = class(TObject)
     ParamNr : string;
     ParamNrForSP : LongInt;
  end;

  TSPADO = class(TObject)
  private
    FADOTablePriborData : TADOTable;
    FCacheObjectList : TObjectList;
  public
    function GetParamID(const APriborId : Integer; const AParamNr : string;
        const ACanalNum: Integer = 0): LongInt;
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;
  end;

implementation

uses dm_general, DB;

constructor TSPADO.Create(AOwner : TComponent);
begin
  inherited Create;
//  FADOTablePriborData := TADOTable.Create(AOwner);
//  FCacheItems := TPointerList.Create;
//  FADOTablePriborData.Connection := DH.ADOConnection;
//  FADOTablePriborData.TableName := 'СписокСтроки';
//  FADOTablePriborData.Open;
//  FADOTablePriborData.Filtered := True;
end;

destructor TSPADO.Destroy;
begin
//  if FADOTablePriborData.Active then
//     FADOTablePriborData.Close;
//  FADOTablePriborData.Free;
//  FCacheItems.Free;
  inherited Destroy;
end;

function TSPADO.GetParamID(const APriborId : Integer; const AParamNr : string;
    const ACanalNum: Integer = 0): LongInt;
var CacheObject : TCacheObject;
    FilterStr : string;
begin
//  Result := 0;
//  FCacheObjectList.IndexOf()
//  CacheObject :=   FCacheItems.IndexOf(APriborId);
//  if CacheItem <> nil then
//  begin
//     if CacheItem.ParamNr = AParamNr then
//     begin
//        Result := CacheItem.ParamNrForSP;
//        Exit;
//     end;
//  end;
//  FilterStr := Format('КодСписка=%d AND НомерПараметра=%s AND НомерКанала=%d',
//    [APriborId, AParamNr, ACanalNum]);
//  FADOTablePriborData.Filter := FilterStr;
//  if FADOTablePriborData.RecordCount <> 1 then
//     ESPADO.Create('Error getting param');
//  //add to cache
//  CacheItem := TCacheItem.Create;
//  CacheItem.ParamNr := AParamNr;
//  CacheItem.ParamNrForSP := FADOTablePriborData.FieldByName('КодСтрокиСписка').AsInteger;
//  FCacheItems.Add(APriborId, CacheItem);
//  Result := TCacheItem(FCacheItems.Items[APriborId]).ParamNrForSP;
end;

end.
