unit UClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFClientes = class(TForm)
    BtnGuardar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnEliminar: TBitBtn;
    BtnCerrar: TBitBtn;
    LEId: TLabeledEdit;
    LENombre: TLabeledEdit;
    LEDireccion: TLabeledEdit;
    procedure BtnCerrarClick(Sender: TObject);
    procedure BtnGuardarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnEliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function insertarCliente(cliente, nombre_cliente, direccion : String): boolean;
    function editarCliente(cliente, nombre_cliente, direccion : String): boolean;
    function eliminarCliente(cliente : String): boolean;
  end;

var
  FClientes: TFClientes;

implementation

{$R *.dfm}

uses UMenu, UModulo, ULClientes;

function TFClientes.insertarCliente(cliente, nombre_cliente, direccion : String): boolean;
var
 error : String;
begin
  result := false;
  With Modulo.QClientes do
  begin
    active := false;
    Sql.Clear;
    sql.Text := 'INSERT INTO Clientes (CLIENTE, NOMBRE_CLIENTE, DIRECCION) ' +
      'VALUES('+cliente+', '+nombre_cliente+', '+direccion+')';
    ExecSql;
    ShowMessage('Registro agregado exitosamente');
    FMenu.limpiarLEdit(FCLientes);
    LEId.SetFocus;
  end;
end;

function TFClientes.editarCliente(cliente, nombre_cliente, direccion : String): boolean;
begin
  result := false;
  With Modulo.QClientes do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'UPDATE Clientes SET Nombre_Cliente = :a, Direccion = :b WHERE Cliente = :c';
    Params[0].AsString := LENombre.Text;
    Params[1].AsString := LEDireccion.Text;
    Params[2].AsString := LEId.Text;
    ExecSql;
  end;
  ShowMessage('Registro actualizado exitosamente');
  FMenu.limpiarLEdit(FCLientes);
  LEId.SetFocus;
  Close;
end;

function TFClientes.eliminarCliente(cliente : String): boolean;
begin
  result := false;
  With Modulo.QClientes do
  begin
    active := false;
    Sql.Clear;
    Sql.Text := 'DELETE FROM Clientes WHERE cliente = :a';
    Params[0].AsString := cliente;
    ExecSql;
  end;
  ShowMessage('Registro eliminado exitosamente');
  FLClientes.refreshGrid('Clientes');
end;

procedure TFClientes.FormShow(Sender: TObject);
begin
  if (self.Caption = 'Información del Cliente - Agregar') then
  begin
    LEId.ReadOnly := false;
    FMenu.limpiarLEdit(FClientes);
    BtnGuardar.Enabled  := true;
    BtnEditar.Enabled   := false;
    BtnEliminar.Enabled := false;
    LEId.SetFocus;
  end
  else
  if (self.Caption = 'Información del Cliente - Actualizar') then
  begin
    With Modulo.QClientes do
    begin
      active := false;
      sql.Clear;
      Sql.Text := 'SELECT * FROM Clientes WHERE Cliente = :a';
      Params[0].AsString := self.Hint;
      active := true;
      LEId.Text         := FieldByName('cliente').AsString;
      LENombre.Text     := FieldByName('nombre_cliente').AsString;
      LEDireccion.Text  := FieldByName('direccion').AsString;
    end;
    LEId.ReadOnly := true;
    BtnGuardar.Enabled  := false;
    BtnEditar.Enabled   := true;
    BtnEliminar.Enabled := false;
    LENombre.SetFocus;
  end;
end;

procedure TFClientes.BtnCerrarClick(Sender: TObject);
begin
  FMenu.limpiarLEdit(FClientes);
  LEId.SetFocus;
  FLClientes.refreshGrid('Clientes');
  Close;
end;

procedure TFClientes.BtnEditarClick(Sender: TObject);
var
  cliente, nombre_cliente, direccion : String;
begin
  if not FMenu.esVacio([LEId.Text, LENombre.Text, LEDireccion.Text]) then begin
    showMessage('Hay campos vacios y son obligatorios');
  end
  else begin
    cliente := quotedstr(LEId.Text);
    nombre_cliente := quotedstr(LENombre.Text);
    direccion := quotedstr(LEDireccion.Text);
    editarCliente(cliente, nombre_cliente, direccion);
  end;
end;

procedure TFClientes.BtnEliminarClick(Sender: TObject);
begin
  if Trim(LEId.Text) = '' then
  begin
    ShowMessage('Debe escribir la identificación del cliente a eliminar');
    LEId.SetFocus;
  end
  else begin
    eliminarCliente(LEId.Text);
  end;
end;

procedure TFClientes.BtnGuardarClick(Sender: TObject);
var
  cliente, nombre_cliente, direccion : String;
begin
  if not FMenu.esVacio([LEId.Text, LENombre.Text, LEDireccion.Text]) then begin
    showMessage('Hay campos vacios y son obligatorios');
  end
  else begin
    cliente         := quotedstr(LEId.Text);
    nombre_cliente  := quotedstr(LENombre.Text);
    direccion       := quotedstr(LEDireccion.Text);
    With Modulo.TClientes do
    begin
      Close;
      Open;
      Edit;
      if findKey([LEId.Text]) then
      begin
        ShowMessage('Error: El registro ya existe');
        LEId.SetFocus;
      end
      else begin
        insertarCliente(cliente, nombre_cliente, direccion);
      end;
    end;
    LEId.SetFocus;
  end;
end;

end.
