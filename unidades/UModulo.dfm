object Modulo: TModulo
  OldCreateOrder = False
  Height = 354
  Width = 525
  object Conn: TMyConnection
    Database = 'crud_delphi'
    Username = 'root'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object QClientes: TMyQuery
    Connection = Conn
    SQL.Strings = (
      'Select * From Clientes')
    Left = 24
    Top = 88
  end
  object QProductos: TMyQuery
    Connection = Conn
    Left = 24
    Top = 160
  end
  object QCabeza_Factura: TMyQuery
    Connection = Conn
    SQL.Strings = (
      'Select * From Clientes')
    Left = 120
    Top = 88
  end
  object QDetalle_Factura: TMyQuery
    Connection = Conn
    SQL.Strings = (
      'Select * From Clientes')
    Left = 120
    Top = 160
  end
end
