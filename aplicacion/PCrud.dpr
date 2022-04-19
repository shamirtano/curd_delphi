program PCrud;

uses
  Vcl.Forms,
  UMenu in '..\unidades\UMenu.pas' {FMenu},
  UModulo in '..\unidades\UModulo.pas' {Modulo: TDataModule},
  UClientes in '..\unidades\UClientes.pas' {FClientes},
  UProductos in '..\unidades\UProductos.pas' {FProductos},
  ULClientes in '..\unidades\ULClientes.pas' {FLClientes},
  ULProductos in '..\unidades\ULProductos.pas' {FLProductos},
  UVenta in '..\unidades\UVenta.pas' {FVenta};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TModulo, Modulo);
  Application.CreateForm(TFClientes, FClientes);
  Application.CreateForm(TFProductos, FProductos);
  Application.CreateForm(TFLClientes, FLClientes);
  Application.CreateForm(TFLProductos, FLProductos);
  Application.CreateForm(TFVenta, FVenta);
  Application.Run;
end.
