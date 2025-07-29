object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Code-128 Barcode Generator'
  ClientHeight = 273
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LabelInput: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 372
    Height = 15
    Align = alTop
    ExplicitWidth = 3
  end
  object ImageOutput: TImage
    AlignWithMargins = True
    Left = 3
    Top = 53
    Width = 372
    Height = 92
    Align = alTop
  end
  object EditInput: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 24
    Width = 372
    Height = 23
    Align = alTop
    TabOrder = 0
    OnChange = EditInputChange
    ExplicitWidth = 362
  end
end
