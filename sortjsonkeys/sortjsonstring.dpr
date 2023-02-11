program sortjsonstring;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSortJSON in 'uSortJSON.pas';

var
  UnSortedJSON : string;
  SortedJSON: string;

begin
  try
    UnSortedJSON := '{"c":3,"a":1, "z": {"a":4, "q":1, "c": 3},"b":2}';
    SortedJSON := SortJSONKeys(UnSortedJSON);
    Writeln(SortedJSON);
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
