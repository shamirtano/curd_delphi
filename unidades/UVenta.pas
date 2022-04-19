unit UVenta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TFVenta = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    LTotal: TLabel;
    Panel4: TPanel;
    DSDetalle: TDataSource;
    DSProducto: TDataSource;
    DSCliente: TDataSource;
    Tiempo: TTimer;
    LEProducto: TLabeledEdit;
    GProducto: TDBGrid;
    GDetalle: TDBGrid;
    LECantidad: TLabeledEdit;
    SBAgregar: TSpeedButton;
    LDocumento: TLabel;
    Label3: TLabel;
    LECliente: TLabeledEdit;
    GCliente: TDBGrid;
    DateTimePicker1: TDateTimePicker;
    LEFacturaNo: TLabeledEdit;
    Label2: TLabel;
    LDireccion: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure LEClienteKeyPress(Sender: TObject; var Key: Char);
    procedure LEProductoKeyPress(Sender: TObject; var Key: Char);
    procedure LEProductoExit(Sender: TObject);
    procedure LEClienteExit(Sender: TObject);
    procedure LEProductoEnter(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure GClienteCellClick(Column: TColumn);
    procedure GProductoCellClick(Column: TColumn);
    procedure SBAgregarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure calcular;
    procedure bajarProducto;
  end;

var
  FVenta: TFVenta;
  codigo, detalle: String;
  vUni, cant, subtotal, total : Double;

implementation

{$R *.dfm}

uses UModulo;

procedure TFVenta.bajarProducto;
var
  cantidad, precio : String;
begin
  cantidad := FloatToStr(cant);
  precio := FloatToStr(vUni);
  With Modulo.QDetalle_Factura do
  begin
    active := false;
    Sql.Clear;
    Sql.Text := 'INSERT INTO detalle_factura(NUMERO, PRODUCTO, CANTIDAD, VALOR) '+
                'VALUES ('+LEFacturaNo.Text+', '+codigo+', '+cantidad+', '+precio+')';
    ExecSql;
    LEProducto.Clear;
    LEProducto.SetFocus;
  end;
  With Modulo.QDetalle_Factura do
  begin
    active := false;
    Sql.Clear;
    Sql.Add('SELECT * FROM detalle_factura df');
    Sql.Add('INNER JOIN Productos p ON p.producto = df.producto');
    Sql.Add('WHERE numero = :a');
    Params[0].AsString := LEFacturaNo.Text;
    Open;
  end;
  GDetalle.Columns[0].Field := Modulo.QDetalle_Factura.FieldByName('producto');
  GDetalle.Columns[1].Field := Modulo.QDetalle_Factura.FieldByName('cantidad');
  LTotal.Caption := FloatToStr(total);
end;

procedure TFVenta.BitBtn3Click(Sender: TObject);
begin
  LECliente.Clear;
  LEProducto.Clear;
  Close;
end;

procedure TFVenta.calcular;
begin
  if Trim(LECantidad.Text) = '' then
  begin
    ShowMessage('Debes ingresar la cantidad a vender');
    LECantidad.SetFocus;
  end
  else
  begin
    cant := StrToFloat(LECantidad.Text);
    subtotal := cant * vUni;
    total := total + subtotal;
    bajarProducto;
  end;
end;

procedure TFVenta.FormShow(Sender: TObject);
var
  n_factura : integer;
begin
  n_factura := 0;
  GProducto.Visible := false;
  GCliente.Visible := false;
  With Modulo.QCabeza_Factura do
  begin
    active := false;
    Sql.Clear;
    Sql.Text := 'SELECT max(numero) + 1 as numero FROM Cabeza_Factura';
    active := true;
    n_Factura := FieldByName('numero').AsInteger;
  end;
  LEFacturaNo.Text := IntToStr(n_factura);
  LECliente.SetFocus;
end;

procedure TFVenta.GClienteCellClick(Column: TColumn);
begin
  LECliente.Text := GCliente.Fields[1].AsString;
  LDocumento.Caption := GCliente.Fields[0].AsString;
  LDireccion.Caption := GCliente.Fields[2].AsString;
end;

procedure TFVenta.GProductoCellClick(Column: TColumn);
begin
  codigo  := GProducto.Fields[0].AsString;
  detalle := GProducto.Fields[1].AsString;
  vUni    := GProducto.Fields[2].AsFloat;
  LEProducto.Text := detalle;
  LECantidad.SetFocus;
end;

procedure TFVenta.LEClienteExit(Sender: TObject);
begin
  GCliente.Visible := false;
  LEProducto.SetFocus;
end;

procedure TFVenta.LEClienteKeyPress(Sender: TObject; var Key: Char);
begin
  GCliente.Left := 8;
  GCliente.Top := 52;
  With Modulo.QClientes do
  begin
    active := false;
    Sql.Clear;
    Sql.Text := 'SELECT * FROM Clientes WHERE nombre_cliente Like :a or cliente Like :b';
    Params[0].AsString := '%'+LECliente.Text+'%';
    Params[1].AsString := '%'+LECliente.Text+'%';
    active := true;
  end;
  GCliente.Columns[2].Visible := false;
  GCliente.Visible := True;
end;

procedure TFVenta.LEProductoEnter(Sender: TObject);
begin
  GProducto.Visible := true;
end;

procedure TFVenta.LEProductoExit(Sender: TObject);
begin
  GProducto.Visible := false;
end;

procedure TFVenta.LEProductoKeyPress(Sender: TObject; var Key: Char);
begin
  With Modulo.QProductos do
  begin
    active := false;
    Sql.Clear;
    Sql.Text := 'SELECT * FROM Productos WHERE nombre_producto Like :a';
    Params[0].AsString := '%'+ LEProducto.Text +'%';
    ExecSql;
  end;
end;

procedure TFVenta.SBAgregarClick(Sender: TObject);
begin
  calcular;
end;

end.
