object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnResize = FormResize
  DesignSize = (
    624
    441)
  TextHeight = 15
  object btnCreateDemoData: TButton
    Left = 480
    Top = 8
    Width = 136
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Create Demo Data'
    TabOrder = 0
    OnClick = btnCreateDemoDataClick
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 8
    Width = 457
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnShowCachedChanges: TButton
    Left = 480
    Top = 48
    Width = 136
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Show Cached Changes'
    TabOrder = 2
    OnClick = btnShowCachedChangesClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 231
    Width = 616
    Height = 202
    Anchors = [akLeft, akRight]
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object btnDeleteRecord: TButton
    Left = 480
    Top = 97
    Width = 136
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete Record'
    TabOrder = 4
    OnClick = btnDeleteRecordClick
  end
  object btnAppendRecord: TButton
    Left = 480
    Top = 128
    Width = 136
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Append Record'
    TabOrder = 5
    OnClick = btnAppendRecordClick
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 152
    Top = 72
    object FDMemTable1ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
    end
    object FDMemTable1Number: TStringField
      FieldName = 'Number'
    end
  end
  object FDTableAdapter1: TFDTableAdapter
    Left = 312
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 432
    Top = 88
  end
end
