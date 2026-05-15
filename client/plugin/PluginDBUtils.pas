{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit PluginDBUtils;

interface

uses
  Classes, SysUtils, ZDataset;

//stream  
procedure StreamFromDB(const ID: Integer; Stream: TStream);
procedure StreamToDB(const ID: Integer; Stream: TStream);

implementation

uses
  DBdata, dm_general, DB, ZAbstractRODataset;

procedure StreamFromDB(const ID: Integer; Stream: TStream);
var
  SQL: string;
  ZQuery: TZQuery;
begin
  SQL := 'SELECT plugin_data FROM consumerism WHERE consumerism_id = :id';
  ZQuery := UDM.CreateDataSet(SQL) as TZQuery;
  with ZQuery do
  try
    ParamByName('id').AsInteger := ID;
    Open;
    TBlobField(FieldByName('plugin_data')).SaveToStream(Stream);
  finally
    ZQuery.Free;
  end;
end;

procedure StreamToDB(const ID: Integer; Stream: TStream);
var
  SQL: string;
  ZQuery: TZQuery;
begin
  SQL := 'UPDATE consumerism SET plugin_data = :plugin_data ' +
         'WHERE consumerism_id = :id';
  ZQuery := UDM.CreateDataSet(SQL) as TZQuery;
  with ZQuery do
  try
    ParamByName('plugin_data').LoadFromStream(Stream, ftBlob);
    ParamByName('id').AsInteger := ID;
    ExecSQL;
  finally
    ZQuery.Free;
  end;
end;

end.
