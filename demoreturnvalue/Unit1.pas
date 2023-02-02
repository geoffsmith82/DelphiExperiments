unit Unit1;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  uTuple
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function Test(): TTuple<boolean, string>;
    function Test3(): TTuple<boolean, string, Integer>;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  success : boolean;
  errorMessage : String;
  num : Integer;
begin
  Test().Returns(success, errorMessage);
  ShowMessage(BoolToStr(success, True) + ' ' + errorMessage);

  Test3().Returns(success, errorMessage, num);
  ShowMessage(BoolToStr(success, True) + ' ' + errorMessage  + ' ' + num.ToString);
end;

function TForm1.Test3: TTuple<boolean, string, Integer>;
begin
  Exit(Result.SendBack(true, 'It Works', 32432));
end;

{ TForm1 }

function TForm1.Test: TTuple<boolean, string>;
begin
  Exit(Result.SendBack(true, 'It Works'));
end;



end.
