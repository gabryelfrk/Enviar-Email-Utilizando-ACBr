object FrmConexao: TFrmConexao
  Left = 0
  Top = 0
  Caption = 'FrmConexao'
  ClientHeight = 206
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ADOConPrimario: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 41
    Top = 31
  end
end
