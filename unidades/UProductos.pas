unit UProductos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFProductos = class(TForm)
    LECodigo: TLabeledEdit;
    LENombre: TLabeledEdit;
    LEPrecio: TLabeledEdit;
    BtnGuardar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnEliminar: TBitBtn;
    BtnCerrar: TBitBtn;
    procedure BtnCerrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function insertarProducto(producto, nombre_producto, valor : String): boolean;
    function editarProducto(producto, nombre_producto, valor : String): boolean;
    function eliminarProducto(producto : String): boolean;
  end;

var
  FProductos: TFProductos;

implementation

{$R *.dfm}

uses UMenu, UModulo;

procedure TFProductos.BtnCerrarClick(Sender: TObject);
begin
  FMenu.limpiarLEdit(FProductos);
  LECodigo.SetFocus;
  Close;
end;

procedure TFProductos.BtnGuardarClick(Sender: TObject);
var
  producto, nombre_producto, valor : String;
begin
  if not FMenu.esVacio([LECodigo.Text, LENombre.Text, LEPrecio.Text]) then begin
    showMessage('Hay campos vacios y son obligatorios');
  end
  else begin
    producto        := quotedstr(LECodigo.Text);
    nombre_producto := quotedstr(LENombre.Text);
    valor           := quotedstr(LEPrecio.Text);
    insertarProducto(producto, nombre_producto, valor);
  end;
end;

function TFProductos.editarProducto(producto, nombre_producto, valor: String): boolean;
begin
  result := false;
  With Modulo.QProductos do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'UPDATE Productos SET Nombre_Producto = :a, Valor = :b WHERE Producto = :c';
    Params[0].AsString := LECodigo.Text;
    Params[1].AsString := LENombre.Text;
    Params[2].AsString := LEPrecio.Text;
    ShowMessage(sql.Text);
    ExecSql;
  end;
  ShowMessage('Registro actualizado exitosamente');
  FMenu.limpiarLEdit(FProductos);
  LECodigo.SetFocus;
  Close;
end;

function TFProductos.eliminarProducto(producto: String): boolean;
begin
  result := false;
  With Modulo.QProductos do
  begin
    active := false;
    Sql.Clear;
    Sql.Text := 'DELETE FROM Productos WHERE producto = :a';
    Params[0].AsString := producto;
    ExecSql;
  end;
  ShowMessage('Registro eliminado exitosamente');
end;

function TFProductos.insertarProducto(producto, nombre_producto, valor: String): boolean;
begin
  result := false;
  With Modulo.QProductos do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'INSERT INTO Productos (Producto, Nombre_Producto, Valor) ' +
      'VALUES('+producto+', '+nombre_producto+', '+valor+')';
    ShowMessage(sql.Text);
    ExecSql;
  end;
  ShowMessage('Registro agregado exitosamente');
  FMenu.limpiarLEdit(FProductos);
  LECodigo.SetFocus;
end;

procedure TFProductos.FormShow(Sender: TObject);
begin
  if (self.Caption = 'Información del Producto - Agregar') then
  begin
    LECodigo.ReadOnly := false;
    FMenu.limpiarLEdit(FProductos);
    BtnGuardar.Enabled  := true;
    BtnEditar.Enabled   := false;
    BtnEliminar.Enabled := false;
    LECodigo.SetFocus;
  end
  else
  if (self.Caption = 'Información del Producto - Actualizar') then
  begin
    With Modulo.QClientes do
    begin
      active := false;
      sql.Clear;
      Sql.Text := 'SELECT * FROM Productos WHERE producto = :a';
      Params[0].AsString := self.Hint;
      active := true;
      LECodigo.Text := FieldByName('producto').AsString;
      LENombre.Text := FieldByName('nombre_producto').AsString;
      LEPrecio.Text := FieldByName('valor').AsString;
    end;
    LECodigo.ReadOnly := true;
    BtnGuardar.Enabled  := false;
    BtnEditar.Enabled   := true;
    BtnEliminar.Enabled := false;
    LENombre.SetFocus;
  end;
end;



end.
