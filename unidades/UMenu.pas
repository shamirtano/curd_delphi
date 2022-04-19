unit UMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Menus, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList;

type
  TFMenu = class(TForm)
    StatusBar: TStatusBar;
    Tiempo: TTimer;
    MainMenu1: TMainMenu;
    Operaciones1: TMenuItem;
    NuevaVenta1: TMenuItem;
    ConsultarVentas1: TMenuItem;
    Productos1: TMenuItem;
    Productos2: TMenuItem;
    ListadeProductos1: TMenuItem;
    ListadeProductos2: TMenuItem;
    AgregarCliente1: TMenuItem;
    AgregarCliente2: TMenuItem;
    Salir1: TMenuItem;
    procedure TiempoTimer(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AgregarCliente1Click(Sender: TObject);
    procedure Productos2Click(Sender: TObject);
    procedure AgregarCliente2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListadeProductos1Click(Sender: TObject);
    procedure NuevaVenta1Click(Sender: TObject);
    //procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure limpiarLEdit(Forma: TForm);
    function esVacio(arreglo: array of String): Boolean;
  end;

var
  FMenu: TFMenu;

implementation

{$R *.dfm}

uses UModulo, UClientes, UProductos, ULClientes, ULProductos, UVenta;

//Mensaje de confirmacion al salir
procedure TFMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Application.MessageBox('¿Estás seguro de salir de la aplicación?','Facturación',36) = 6 then
    CanClose := true
  else
    CanClose := false;
end;

procedure TFMenu.FormShow(Sender: TObject);
begin
  //Inicializamos el Query de clientes
  With Modulo.QClientes do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'SELECT * FROM Clientes';
    active := true;
  end;
  //Inicializamos el Query de productos
  With Modulo.QProductos do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'SELECT * FROM Productos';
    active := true;
  end;
  //Inicializamos el Query de Cabeza Facturas
  With Modulo.QCabeza_Factura do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'SELECT * FROM Cabeza_factura';
    active := true;
  end;
  //Inicializamos el Query de Detalle Facturas
  With Modulo.QDetalle_Factura do
  begin
    active := false;
    sql.Clear;
    sql.Text := 'SELECT * FROM Detalle_Factura';
    active := true;
  end;
end;

procedure TFMenu.Salir1Click(Sender: TObject);
begin
  Close;
end;

//Mostras fecha y hora en la barra de tareas
procedure TFMenu.TiempoTimer(Sender: TObject);
begin
  StatusBar.Panels[1].Text := DateToStr(Now);
  StatusBar.Panels[3].Text := TimeToStr(Now);
end;

//Metodo para limpiar los edit en todos los formularios
procedure TFMenu.limpiarLEdit(Forma: TForm);
var
 i : Integer;
begin
 for i := 0 to Forma.ComponentCount-1 do
 begin
   if(Forma.Components[i] is TLabeledEdit) then
   begin
     (Forma.Components[i] as TLabeledEdit).Clear;
   end;
 end;
end;

procedure TFMenu.ListadeProductos1Click(Sender: TObject);
begin
  Modulo.QProductos.Close;
  Modulo.QProductos.Open;
  FLProductos.ShowModal;
end;

procedure TFMenu.NuevaVenta1Click(Sender: TObject);
begin
  FVenta.ShowModal;
end;

//Funcion para comprobar edit vacios
function TFMenu.esVacio(arreglo: array of string): Boolean;
var
  limite, i: integer;
begin
  try
    limite := length(arreglo);
  except
    limite := 0;
  end;
  i := 0;
  result := false; //Cuando están vacíos
  while i < limite do
  begin
    if (Trim(arreglo[i]) = EmptyStr) then
    begin
      result := false; //Uno o más campos están vacios
      i := limite;
    end else
    begin
      result := true;
      i := i + 1;
    end;
  end;
end;

procedure TFMenu.AgregarCliente1Click(Sender: TObject);
begin
  FClientes.ShowModal;
end;

procedure TFMenu.AgregarCliente2Click(Sender: TObject);
begin
  FLClientes.ShowModal;
end;

procedure TFMenu.Productos2Click(Sender: TObject);
begin
  FProductos.ShowModal;
end;

end.
