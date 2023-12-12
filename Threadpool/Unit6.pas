unit Unit6;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Types,
  System.Generics.Collections,
  System.Diagnostics,
  System.Math,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Threading,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Unit1
  ;

type
  TForm6 = class(TForm)
    Memo1: TMemo;
    Timer1: TTimer;
    btnStartThreads: TButton;
    btnEndThreads: TButton;
    StatusBar: TStatusBar;
    btnStartTasks: TButton;
    procedure btnStartThreadsClick(Sender: TObject);
    procedure btnEndThreadsClick(Sender: TObject);
    procedure btnStartTasksClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    maxOpsPerEvent : Int64;
    RunNo : Integer;
    FThreadPool  : TExampleThreadPool;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}




procedure TForm6.btnStartThreadsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to 100 do
  begin
    if Memo1.Lines.Count < i then
      Memo1.Lines.Add(i.ToString);
  end;
  Application.ProcessMessages;
  FThreadPool.StartThreads;

  OutputDebugString(PChar('Threads Started'));
end;

procedure TForm6.btnEndThreadsClick(Sender: TObject);
begin
  FThreadPool.EndThreadpool;
end;

procedure TForm6.btnStartTasksClick(Sender: TObject);
var
  i : Integer;
  task : TTaskObject;
begin
  for i := 0 to 100 do
  begin
    task := TTaskObject.Create;
    task.FRunNo := RunNo;
    FThreadPool.AddWorkItem(task);
    OutputDebugString(PChar('Task Added ' + i.ToString + ' ' + RunNo.ToString));
  end;
  Inc(RunNo);
  Timer1.Enabled := true;
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  FThreadPool.EndThreadpool;
  FreeAndNil(FThreadPool);
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  FThreadPool  := TExampleThreadPool.Create;
  maxOpsPerEvent := 100;
end;

procedure TForm6.Timer1Timer(Sender: TObject);
var
  obj : TOperationObject;
  maxOps : Integer;
  sw : TStopwatch;
  finishedqueuedOperations : Int64;
begin
  sw := TStopwatch.StartNew;
  Memo1.LockDrawing; 
  maxOps := 0; 
  StatusBar.Panels[1].Text := (FThreadPool.UITotalItemsPushed - FThreadPool.UITotalItemsPopped).ToString;
  while FThreadPool.UiPopItem(obj) = wrSignaled do
  begin
    Memo1.Lines[obj.FthreadNo] := obj.FText;
    if maxOps > maxOpsPerEvent then
      break;
    Inc(maxOps);
    FreeAndNil(obj);
  end;
  finishedqueuedOperations := (FThreadPool.UITotalItemsPushed - FThreadPool.UITotalItemsPopped);

  Memo1.UnlockDrawing;
  StatusBar.Panels[0].Text := sw.ElapsedMilliseconds.ToString + ' ms';
  StatusBar.Panels[2].Text := finishedqueuedOperations.ToString;
  StatusBar.Panels[3].Text := maxOpsPerEvent.ToString;

  StatusBar.Panels[4].Text := (FThreadPool.TasksTotalItemsPushed - FThreadPool.TasksTotalItemsPopped).ToString + ' tasks';
end;

end.
