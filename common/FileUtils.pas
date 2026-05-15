unit FileUtils;

interface

uses
  Classes, SysUtils;

procedure FileList(const Path: string; List: TStringList);

implementation

procedure FileList(const Path: string; List: TStringList);
var
  SearchRec: TSearchRec;
begin
  if FindFirst(Path, faAnyFile, SearchRec) = 0 then
  repeat
    List.Add(SearchRec.Name);
  until FindNext(SearchRec) <> 0;
end;

end.
