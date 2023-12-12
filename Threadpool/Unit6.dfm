object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    628
    442)
  TextHeight = 15
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 473
    Height = 409
    Anchors = [akLeft, akTop, akBottom]
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ExplicitHeight = 408
  end
  object btnStartThreads: TButton
    Left = 504
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start Threads'
    TabOrder = 1
    OnClick = btnStartThreadsClick
  end
  object btnEndThreads: TButton
    Left = 504
    Top = 183
    Width = 75
    Height = 25
    Caption = 'End Threads'
    TabOrder = 2
    OnClick = btnEndThreadsClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 423
    Width = 628
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 50
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
    ExplicitTop = 422
    ExplicitWidth = 624
  end
  object btnStartTasks: TButton
    Left = 504
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Start Tasks'
    TabOrder = 4
    OnClick = btnStartTasksClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 504
    Top = 96
  end
end
