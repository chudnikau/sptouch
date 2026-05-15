{*********************************************************}
{                                                         }
{        Originally written by Siarhei Chudnikau          }
{                                                         }
{*********************************************************}

unit globalclasses;

interface

type
  TBlockAnlData = packed record
    ParamQId : LongWord;
    DateTime : TDateTime;
    Value : Single;
  end;

implementation

end.
