unit uSortJSON;

interface

uses
  System.JSON
  ;

function SortJSONKeys(const JSONStr: string): string;
function SortJSONObject(const JSONObject: TJSONObject): TJSONObject;

implementation

uses
  System.SysUtils, System.Classes, System.Generics.Collections;


function SortJSONObject(const JSONObject: TJSONObject): TJSONObject;
var
  KeyList: TStringList;
  Key: string;
  KeyValue: TJSONPair;
  Value: TJSONValue;
begin
  KeyList := TStringList.Create;
  try
    KeyList.Sorted := True;
    for KeyValue in JSONObject do
      KeyList.Add(KeyValue.JsonString.Value);

    Result := TJSONObject.Create;
    for Key in KeyList do
    begin
      Value := JSONObject.GetValue(Key);
      if Value is TJSONObject then
        Value := SortJSONObject(TJSONObject(Value));
      Result.AddPair(Key, Value);
    end;
  finally
    KeyList.Free;
  end;
end;

function SortJSONKeys(const JSONStr: string): string;
var
  JSONValue: TJSONObject;
begin
  JSONValue := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSONStr), 0) as TJSONObject;
  try
    JSONValue := SortJSONObject(JSONValue as TJSONObject);
    Result := JSONValue.ToJson;
  finally
    FreeAndNil(JSONValue);
  end;
end;

end.
