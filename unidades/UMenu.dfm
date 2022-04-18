object FMenu: TFMenu
  Left = 0
  Top = 0
  Caption = 'Facturaci'#243'n - Prueba T'#233'cnica'
  ClientHeight = 465
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 446
    Width = 966
    Height = 19
    Panels = <
      item
        Text = 'Fecha:'
        Width = 50
      end
      item
        Width = 150
      end
      item
        Text = 'Hora:'
        Width = 50
      end
      item
        Width = 100
      end>
  end
  object Tiempo: TTimer
    OnTimer = TiempoTimer
    Left = 776
    Top = 176
  end
  object MainMenu1: TMainMenu
    Left = 304
    Top = 104
    object Operaciones1: TMenuItem
      Caption = '&Operaciones'
      object NuevaVenta1: TMenuItem
        Caption = '&Nueva Venta'
      end
      object ConsultarVentas1: TMenuItem
        Caption = '&Consultar Ventas'
      end
    end
    object Productos1: TMenuItem
      Caption = '&Productos'
      object Productos2: TMenuItem
        Caption = '&Crear Producto'
        OnClick = Productos2Click
      end
      object ListadeProductos1: TMenuItem
        Caption = '&Lista de Productos'
      end
    end
    object ListadeProductos2: TMenuItem
      Caption = '&Clientes'
      object AgregarCliente1: TMenuItem
        Caption = '&Agregar Cliente'
        OnClick = AgregarCliente1Click
      end
      object AgregarCliente2: TMenuItem
        Caption = '&Lista de Clientes'
        OnClick = AgregarCliente2Click
      end
    end
    object Salir1: TMenuItem
      Caption = '&Salir'
      OnClick = Salir1Click
    end
  end
end
