unit uTuple;

interface

type
  TTuple<T,R> = record
  private type
    TA = ^T;
    TB = ^R;
  private
    FA : T;
    FB : R;
  public
    constructor Create(a: T; b: R);
    procedure Returns(var left:T;var right:R);
  end;

implementation

constructor TTuple<T,R>.Create(a: T; b: R);
begin
  FA := a;
  FB := b;
end;

procedure TTuple<T,R>.Returns(var left:T;var right:R);
begin
  left := FA;
  right := FB;
end;

end.
