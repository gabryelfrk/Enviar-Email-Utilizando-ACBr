object FrmEnviar: TFrmEnviar
  Left = 0
  Top = 0
  Caption = 'Enviar Email'
  ClientHeight = 303
  ClientWidth = 511
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  StyleElements = [seFont, seBorder]
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Do Nome:'
  end
  object Label2: TLabel
    Left = 240
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Para E-mail:'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 43
    Height = 13
    Caption = 'Assunto:'
  end
  object MemoEmail: TMemo
    Left = 8
    Top = 114
    Width = 489
    Height = 145
    Lines.Strings = (
      'Texto que ser'#225' enviado para o e-mail.')
    TabOrder = 0
  end
  object BtnEnviar: TButton
    Left = 8
    Top = 267
    Width = 75
    Height = 25
    Caption = 'Enviar'
    TabOrder = 1
    OnClick = BtnEnviarClick
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 201
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 240
    Top = 27
    Width = 201
    Height = 21
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 8
    Top = 75
    Width = 489
    Height = 21
    TabOrder = 4
  end
end
