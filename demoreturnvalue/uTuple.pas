unit uTuple;

interface

type
  TTuple<T, R> = record
  strict private
    FA : T;
    FB : R;
  public
    class function SendBack(a: T; b: R):TTuple<T, R>; static;
    constructor Create(a: T; b: R);
    procedure Returns(var left:T; var right:R);
  end;

implementation

constructor TTuple<T, R>.Create(a: T; b: R);
begin
  FA := a;
  FB := b;
end;

class function TTuple<T, R>.SendBack(a: T; b: R): TTuple<T, R>;
begin
  Result := TTuple<T, R>.Create(a, b);
end;

procedure TTuple<T, R>.Returns(var left: T; var right: R);
begin
  left := FA;
  right := FB;
end;

end.
