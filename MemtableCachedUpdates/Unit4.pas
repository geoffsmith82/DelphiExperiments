unit Unit4;

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
  FireDAC.Comp.DataSet,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls
  ;

type
  TForm4 = class(TForm)
    FDMemTable1: TFDMemTable;
    FDTableAdapter1: TFDTableAdapter;
    FDMemTable1ID: TIntegerField;
    FDMemTable1Number: TStringField;
    btnCreateDemoData: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    btnShowCachedChanges: TButton;
    Memo1: TMemo;
    btnDeleteRecord: TButton;
    btnAppendRecord: TButton;
    procedure btnAppendRecordClick(Sender: TObject);
    procedure btnCreateDemoDataClick(Sender: TObject);
    procedure btnDeleteRecordClick(Sender: TObject);
    procedure btnShowCachedChangesClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.btnAppendRecordClick(Sender: TObject);
begin
  FDMemTable1.Append;
end;

procedure TForm4.btnDeleteRecordClick(Sender: TObject);
begin
  FDMemTable1.Delete;
end;

procedure TForm4.btnCreateDemoDataClick(Sender: TObject);
var
  I: Integer;
begin
  FDMemTable1.Active := True;
  for I := 0 to 100 do
  begin
    FDMemTable1.Append;
    FDMemTable1Number.Value := '# ' + I.ToString;
    FDMemTable1.Post;
  end;
  FDMemTable1.CachedUpdates := True;
end;

procedure TForm4.btnShowCachedChangesClick(Sender: TObject);
var
  Delta: IFDDataSetReference;
  i : Integer;
  ChangeRow: TFDDatSRow;
  OriginalIDValue, CurrentIDValue: Variant;
  OriginalNumberValue, CurrentNumberValue: Variant;
  Operation : string;
begin
  Delta := FDMemTable1.Delta;
  Memo1.Lines.Clear;


  if Delta.DataView.Rows.Count = 0 then
  begin
    Memo1.Lines.Add('There are no Cached changes to the data');
    Exit;
  end;


  Memo1.Lines.Add('Cached Changes shown below');
  Memo1.Lines.Add('--------------------------');
  Memo1.Lines.Add('');
  for i := 0 to Delta.DataView.Rows.Count - 1 do
  begin
    ChangeRow := Delta.DataView.Rows[i];

    // Accessing the original value
    if ChangeRow.RowState in [rsModified, rsDeleted] then
    begin
      OriginalIDValue := ChangeRow.GetData('ID');
      OriginalNumberValue := ChangeRow.GetData('Number');
    end;


    // Accessing the current value
    if ChangeRow.RowState in [rsModified, rsInserted] then
    begin
      CurrentIDValue := ChangeRow.GetData('ID');
      CurrentNumberValue := ChangeRow.GetData('Number');
    end;

    Operation := '';
    case ChangeRow.RowState of
      rsInserted: Operation := 'Inserted'; // Handle inserted record
      rsModified: Operation := 'Modified'; // Handle modified record
      rsDeleted: Operation := 'Deleted'; // Handle deleted record
    end;

   Memo1.Lines.Add(Operation + VarToStr(OriginalIDValue) + ' to ' + VarToStr(CurrentIDValue) + ' Content ' + VarToStr(OriginalNumberValue) + ' ' + VarToStr(CurrentNumberValue));
  end;
end;

procedure TForm4.FormResize(Sender: TObject);
begin
  DBGrid1.Height := ClientHeight div 2 - DBGrid1.Top;
  Memo1.Top := DBGrid1.Top + DBGrid1.Height + 10;
  Memo1.Height := ClientHeight - Memo1.Top - 20;
end;

end.
