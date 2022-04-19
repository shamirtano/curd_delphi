unit ULProductos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFLProductos = class(TForm)
    Panel1: TPanel;
    Grid: TDBGrid;
    LEBuscar: TLabeledEdit;
    Panel2: TPanel;
    BtnAgregar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnEliminar: TBitBtn;
    BtnCerrar: TBitBtn;
    DSProductos: TDataSource;
    procedure BtnCerrarClick(Sender: TObject);
    procedure BtnAgregarClick(Sender: TObject);
    procedure LEBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnEliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLProductos: TFLProductos;

implementation

{$R *.dfm}

uses UModulo, UMenu, ULClientes, UProductos;

procedure TFLProductos.BtnAgregarClick(Sender: TObject);
begin
  FProductos.Caption := 'Información del Cliente - Agregar';
  FProductos.ShowModal;
  FLClientes.RefreshGrid('Productos');
end;

procedure TFLProductos.BtnCerrarClick(Sender: TObject);
begin
  FMenu.limpiarLEdit(FLProductos);
  LEBuscar.SetFocus;
  Close;
end;

procedure TFLProductos.BtnEditarClick(Sender: TObject);
begin
  FProductos.Caption := 'Información del Producto - Actualizar';
  FProductos.Hint := Grid.Fields[0].Text;
  if Trim(Grid.Fields[0].Text) <> '' then
  begin
    FProductos.ShowModal;
    FLClientes.RefreshGrid('Productos');
  end
  else begin
    ShowMessage('No ha seleccionado ningún registro');
  end;
end;

procedure TFLProductos.BtnEliminarClick(Sender: TObject);
begin
  if Trim(Grid.Fields[0].Text) = '' then
  begin
    MessageDlg('No ha seleccionado ningún registro', mtInformation, [mbOk], 0);
    FLClientes.refreshGrid('Productos');
    exit;
  end
  else begin
    if Application.MessageBox('¿Está seguro que desea eliminar el registro?', 'Eliminar Producto', 36) = 6 then
    begin
       FProductos.eliminarProducto(Grid.Fields[0].Text);
       FLCLientes.refreshGrid('Productos');
    end;
  end;
end;

procedure TFLProductos.LEBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  With Modulo.QProductos do
  begin
    active := false;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Productos WHERE Nombre_producto Like :a or producto Like :b';
    Params[0].AsString := '%' + LEBuscar.Text + '%';
    Params[1].AsString := '%' + LEBuscar.Text + '%';
    active := true;
  end;
end;

end.
