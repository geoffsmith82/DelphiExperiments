unit uExampleThreadPool;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Diagnostics,
  System.Threading,
  System.Math,
  System.Types,
  Vcl.Forms,
  Winapi.Windows;

type


  TTaskObject = class
    FRunNo : Integer;
    Exit : Boolean;
  end;

  TOperationObject = class
    FThreadNo : Integer;
    FText : String;
  end;

  TExampleThreadPool = class;


  TTExampleThread = class(TThread)
  private
    FText: string;
    FThreadNo : Integer;
    FRunNo : Integer;
    FThreadPool : TExampleThreadPool;
    fwaits : array [0..1000] of Int64;
    procedure UpdateGUI;
  public
    procedure Execute; override;
    constructor Create(threadPool: TExampleThreadPool; threadNo: Integer);
  end;

  TExampleThreadPool = class
  private
    FUiUpdates : TThreadedQueue<TOperationObject>;
    FSchTasks : TThreadedQueue<TTaskObject>;
  public
    Threads : TObjectList<TTExampleThread>;
    constructor Create;
    destructor Destroy; override;
    procedure StartThreads;
    procedure EndThreadpool;
    procedure AddWorkItem(task: TTaskObject);
    function UiTotalItemsPushed: Int64;
    function UiTotalItemsPopped: Int64;
    function TasksTotalItemsPushed: Int64;
    function TasksTotalItemsPopped: Int64;
    function UiPopItem(var obj: TOperationObject): TWaitResult;
    function UiPushItem(obj: TOperationObject): TWaitResult;
  end;

implementation


{ TTExampleThread }

procedure TTExampleThread.UpdateGUI;
var
  obj : TOperationObject;
begin
  obj := TOperationObject.Create;
  obj.FThreadNo := FthreadNo;
  obj.FText := 'Run ('+ FrunNo.ToString + ')'+ FText;
  FThreadPool.UiPushItem(obj);
end;

constructor TTExampleThread.Create(threadPool: TExampleThreadPool; threadNo: Integer);
begin
  inherited Create(True);
  FThreadNo := threadNo;
  FThreadPool := threadPool;
end;

procedure TTExampleThread.Execute;
var
  I : Integer;
  sw : TStopwatch;
  maxwait : Int64;
  obj : TTaskObject;
begin
  inherited;
  obj := nil;
  while FThreadPool.FSchTasks.PopItem(obj) = wrSignaled do
  begin
    try
      maxwait := 0;
      FRunNo := obj.FRunNo;
      OutputDebugString(PChar('Running in Thread - ' + FThreadNo.ToString));
      for I := 1 to 40 do
      begin
        if Terminated or Application.Terminated then
          Exit;
        if not Assigned(obj) then
        begin
          OutputDebugString(PChar(''));
          continue;
        end;
       // Sleep(300);
        Sleep(Random(1000));
        sw := TStopwatch.StartNew;

        begin
            FText := FText + '[' + FThreadNo.ToString + '] updated in thread [' + i.ToString + '] wait ' + maxwait.ToString + ' current ' + fwaits[i - 1].ToString;
            UpdateGUI;
        end;//);
        fwaits[i] := sw.ElapsedMilliseconds;
        FText := '';
        maxwait := max(maxwait, fwaits[i]);
      end;
    finally
      FreeAndNil(obj);
    end;
  end;
end;

{ TExampleThreadPool }

procedure TExampleThreadPool.AddWorkItem(task: TTaskObject);
begin
  FSchTasks.PushItem(task);
end;

constructor TExampleThreadPool.Create;
begin
  Threads := TObjectList<TTExampleThread>.Create;
  FUiUpdates := TThreadedQueue<TOperationObject>.Create(1000, INFINITE, 0);
  FSchTasks := TThreadedQueue<TTaskObject>.Create(10000, INFINITE, INFINITE);
end;

destructor TExampleThreadPool.Destroy;
begin
  FreeAndNil(Threads);
  inherited;
end;

procedure TExampleThreadPool.EndThreadpool;
var
  i: Integer;
  task: TTaskObject;
begin
  for i := 0 to 100 do
  begin
    if Assigned(Threads[i]) then
      Threads[i].Terminate;
    task := TTaskObject.Create;
    task.FRunNo := -1;
    FSchTasks.PushItem(task);
  end;

  for i := 100 downto 0 do
  begin
    if Assigned(Threads[i]) then
    begin
      if Threads[i].Terminated then
      begin
        Threads.Delete(i);
      end;
    end;
  end;

end;

procedure TExampleThreadPool.StartThreads;
var
  i : Integer;
begin
  for i := 0 to 100 do
  begin
    Threads.Add(TTExampleThread.Create(Self, i));
    Application.ProcessMessages;
  end;
  OutputDebugString(PChar('Threads Created'));

  for i := 0 to 100 do
  begin
    Threads[i].Start;
    Application.ProcessMessages;
  end;
end;


function TExampleThreadPool.TasksTotalItemsPopped: Int64;
begin
  Result := FSchTasks.TotalItemsPopped;
end;

function TExampleThreadPool.TasksTotalItemsPushed: Int64;
begin
  Result := FSchTasks.TotalItemsPushed;
end;

function TExampleThreadPool.UiPopItem(var obj: TOperationObject): TWaitResult;
begin
  Result := FUiUpdates.PopItem(obj);
end;

function TExampleThreadPool.UiPushItem(obj: TOperationObject): TWaitResult;
begin
  Result := FUiUpdates.PushItem(obj);
end;

function TExampleThreadPool.UiTotalItemsPopped: Int64;
begin
  Result := FUiUpdates.TotalItemsPopped;
end;

function TExampleThreadPool.UiTotalItemsPushed: Int64;
begin
  Result := FUiUpdates.TotalItemsPushed;
end;

end.
