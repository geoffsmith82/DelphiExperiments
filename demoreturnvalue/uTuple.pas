unit uTuple;

interface

type
  TTuple<T, R, S> = record
  strict private
    FA : T;
    FB : R;
    FC : S;
  public
    class function SendBack(a: T; b: R; c: S):TTuple<T, R, S>; static;
    constructor Create(a: T; b: R; c: S);
    procedure Returns(var left:T; var right:R; var third:S);
  end;


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

{ TTuple<T, R, S> }

constructor TTuple<T, R, S>.Create(a: T; b: R; c: S);
begin
  FA := a;
  FB := b;
  FC := c;
end;

procedure TTuple<T, R, S>.Returns(var left: T; var right: R; var third: S);
begin
  left := FA;
  right := FB;
  third := FC;
end;

class function TTuple<T, R, S>.SendBack(a: T; b: R; c: S): TTuple<T, R, S>;
begin
  Result := TTuple<T, R, S>.Create(a, b, c);
end;

end.
