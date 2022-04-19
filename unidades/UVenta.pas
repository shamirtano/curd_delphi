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
    SpeedButton1: TSpeedButton;
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
    Grilla: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure LEClienteKeyPress(Sender: TObject; var Key: Char);
    procedure LEProductoKeyPress(Sender: TObject; var Key: Char);
    procedure LEProductoExit(Sender: TObject);
    procedure LEClienteExit(Sender: TObject);
    procedure LEProductoEnter(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure GClienteCellClick(Column: TColumn);
    procedure GProductoCellClick(Column: TColumn);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure bajarProducto;
  end;

var
  FVenta: TFVenta;
  articulo: array of String;

implementation

{$R *.dfm}

uses UModulo;

procedure TFVenta.bajarProducto;
begin
  With Modulo.QDetalle_Factura do
  begin
    active := true;
  end;
end;

procedure TFVenta.BitBtn3Click(Sender: TObject);
begin
  LECliente.Clear;
  LEProducto.Clear;
  Close;
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
  articulo[0] := GProducto.Fields[0].AsString;
  articulo[1] := GProducto.Fields[1].AsString;
  articulo[2] := GProducto.Fields[2].AsString;
  LEProducto.Text := articulo[1];
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

procedure TFVenta.SpeedButton1Click(Sender: TObject);
begin
  bajarProducto;
end;

end.
