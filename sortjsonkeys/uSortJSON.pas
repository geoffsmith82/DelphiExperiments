unit uSortJSON;

interface

uses
  System.JSON
  ;

function SortJSONKeys(const JSONStr: string): string;
function SortJSONObject(const JSONObject: TJSONObject): TJSONObject;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections
  ;

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
    try
      for Key in KeyList do
      begin
        Value := JSONObject.GetValue(Key).Clone as TJSONValue;
        try
          if Value is TJSONObject then
            Value := SortJSONObject(TJSONObject(Value));
          Result.AddPair(Key, Value);
        except
          FreeAndNil(Value);
          raise;
        end;
      end;
    except
      FreeAndNil(Result);
      raise;
    end;
  finally
    FreeAndNil(KeyList);
  end;
end;

function SortJSONKeys(const JSONStr: string): string;
var
  JSONValue: TJSONObject;
  JSONNew: TJSONObject;
begin
  JSONValue := nil;
  JSONNew := nil;
  try
    JSONValue := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSONStr), 0) as TJSONObject;
    JSONNew := SortJSONObject(JSONValue);
    Result := JSONValue.ToJson;
  finally
    FreeAndNil(JSONValue);
    FreeAndNil(JSONNew);
  end;
end;

end.
