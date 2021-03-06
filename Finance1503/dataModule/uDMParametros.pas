unit uDMParametros;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmParametros = class(TDataModule)
    qryObterTodos: TFDQuery;
    qryObterStatusTela: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function obterTodos():Boolean;
    function obterStatusTela (pCodigo :string) : Integer;


  end;

var
  dmParametros: TdmParametros;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmParametros }

function TdmParametros.obterStatusTela(pCodigo: string): Integer;
begin
dmConexao.conectarBanco;
  try
     qryObterStatusTela.Close;
     qryObterStatusTela.Connection := dmConexao.conn;
     qryObterStatusTela.ParamByName('PCODIGO').AsString :=pCodigo;
     qryObterStatusTela.Open;


  except
  raise Exception.Create('Erro ao obter o status da tela.');

  end;

     Result := qryObterStatusTela.FieldByName('STATUS').AsInteger;
end;


function TdmParametros.obterTodos: Boolean;
begin
  dmConexao.conectarBanco;
  try
     qryObterTodos.Close;
     qryObterTodos.Connection := dmConexao.conn;
     qryObterTodos.Open;
     qryObterTodos.Last;
     qryObterTodos.First;

  except
  raise Exception.Create('Erro ao carregar lista de parāmetros..');

  end;

     Result := not qryObterTodos.IsEmpty;
end;

end.
