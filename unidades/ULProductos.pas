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

end.
