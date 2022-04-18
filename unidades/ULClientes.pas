unit ULClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFLClientes = class(TForm)
    Panel1: TPanel;
    Grid: TDBGrid;
    LEBuscar: TLabeledEdit;
    DSClientes: TDataSource;
    Panel2: TPanel;
    BtnAgregar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnEliminar: TBitBtn;
    BtnCerrar: TBitBtn;
    procedure BtnCerrarClick(Sender: TObject);
    procedure LEBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAgregarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnEliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure refreshGrid(tabla: String);
    { Public declarations }
  end;

var
  FLClientes: TFLClientes;

implementation

{$R *.dfm}

uses UMenu, UModulo, UClientes;

//Boton Agregar Cliente
procedure TFLClientes.BtnAgregarClick(Sender: TObject);
begin
  FClientes.Caption := 'Información del Cliente - Agregar';
  FClientes.ShowModal;
  RefreshGrid('Clientes');
end;

//Boton Cerrar
procedure TFLClientes.BtnCerrarClick(Sender: TObject);
begin
  FMenu.limpiarLEdit(FLClientes);
  LEBuscar.SetFocus;
  Close;
end;

//Boton actualizar
procedure TFLClientes.BtnEditarClick(Sender: TObject);
begin
  FClientes.Caption := 'Información del Cliente - Actualizar';
  FClientes.Hint := Grid.Fields[0].Text;
  if Trim(Grid.Fields[0].Text) <> '' then
  begin
    FClientes.ShowModal;
    RefreshGrid('Clientes');
  end
  else begin
    ShowMessage('No ha seleccionado ningún registro');
  end;
end;

//Boton Eliminar cliente
procedure TFLClientes.BtnEliminarClick(Sender: TObject);
begin
  if Trim(Grid.Fields[0].Text) = '' then
  begin
    MessageDlg('No ha seleccionado ningún registro', mtInformation, [mbOk], 0);
    refreshGrid('Clientes');
    exit;
  end
  else begin
    if Application.MessageBox('¿Está seguro que desea eliminar el registro?', 'Eliminar Cliente', 36) = 6 then
    begin
       FClientes.eliminarCliente(Grid.Fields[0].Text);
    end;
  end;
  refreshGrid('Clientes');
end;

//Evento OnShow del form
procedure TFLClientes.FormShow(Sender: TObject);
begin
  FMenu.limpiarLEdit(FLClientes);
  LEBuscar.SetFocus;
  With Modulo.QClientes do
  begin
    Sql.Clear;
    Sql.Text := 'SELECT * FROM CLIENTES';
    active := true;
  end;
end;

//Evento KeyPress del edit buscar
procedure TFLClientes.LEBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  With Modulo.QClientes do
  begin
    active := false;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Clientes WHERE Nombre_Cliente Like :a';
    Params[0].AsString := '%' + LEBuscar.Text + '%';
    active := true;
  end;
end;

//Método para refrescarg el Grid
procedure TFLClientes.refreshGrid(tabla: String);
begin
  With Modulo.QTemp do
  begin
    active := false;
    sql.Text := 'SELECT * FROM ' + tabla;
    active := true;
  end;
  LEBuscar.Clear;
end;

end.
