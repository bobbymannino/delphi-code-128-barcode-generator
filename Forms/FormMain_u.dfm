object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Code-128 Barcode Generator'
  ClientHeight = 273
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MinWidth = 400
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
    Width = 378
    Height = 15
    Align = alTop
    Caption = 'Input'
    ExplicitWidth = 28
  end
  object ImageOutput: TImage
    AlignWithMargins = True
    Left = 3
    Top = 53
    Width = 378
    Height = 92
    Align = alTop
    ExplicitWidth = 372
  end
  object EditInput: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 24
    Width = 378
    Height = 23
    Align = alTop
    TabOrder = 0
    OnChange = EditInputChange
    ExplicitWidth = 372
  end
end
