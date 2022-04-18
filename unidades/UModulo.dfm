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
    SQL.Strings = (
      'SELECT * FROM Productos')
    Left = 24
    Top = 160
  end
  object QCabeza_Factura: TMyQuery
    Connection = Conn
    SQL.Strings = (
      'Select * From Cabeza_Factura')
    Left = 120
    Top = 88
  end
  object QDetalle_Factura: TMyQuery
    Connection = Conn
    SQL.Strings = (
      'Select * From Detalle_Factura')
    Left = 120
    Top = 160
  end
  object QTemp: TMyQuery
    Connection = Conn
    SQL.Strings = (
      'Select * From Clientes')
    Left = 24
    Top = 240
  end
  object TClientes: TMyTable
    TableName = 'clientes'
    Connection = Conn
    Left = 216
    Top = 88
  end
end
