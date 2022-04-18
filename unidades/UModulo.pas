unit UModulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DBXMySQL, Data.SqlExpr,
  Data.FMTBcd, FireDAC.Phys.MySQLDef, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQL,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, MemDS, DBAccess, MyAccess;

type
  TModulo = class(TDataModule)
    Conn: TMyConnection;
    QClientes: TMyQuery;
    QProductos: TMyQuery;
    QCabeza_Factura: TMyQuery;
    QDetalle_Factura: TMyQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    {function insertarCliente(cliente, nombre_cliente, direccion: String): boolean;
    function editarCliente(cliente, nombre_cliente, direccion: String): boolean;
    function eliminarCliente(cliente: String): boolean;}
  end;

var
  Modulo: TModulo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{function TModulo.editarCliente(cliente, nombre_cliente, direccion: String): Boolean;
var
  sql : String;
begin

end;

function TModulo.eliminarCliente(cliente: String): Boolean;
var
  sql : String;
begin

end;

function TModulo.insertarCliente(cliente, nombre_cliente, direccion: String): Boolean;
var
  sql : String;
begin
  result := false;
  sql := 'INSERT INTO (CLIENTE, NOMBRE_CLIENTE, DIRECCION) VALUES('''+cliente+''', '''+nombre_cliente+''', '''+direccion+''')';
  try
    FDConnection.ExecSQL(sql, []);
    result := true;
  except on e: Exception do

  end;
end;   }

end.
