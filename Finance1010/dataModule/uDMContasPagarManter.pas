unit uDMContasPagarManter;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Forms, udmConexao;

type
  TdmContasPagarManter = class(TDataModule)
    qryDeletaExcluidos: TFDQuery;
    qryAlteraNumDoc: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }

    function deletarTitulosPorTipoStatus(pidOrganizacao,
      status: String): Boolean;

      function alterarNumDocTP(pidOrganizacao,
      pId, pNumero: String): Boolean;


  end;

var
  dmContasPagarManter: TdmContasPagarManter;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmContasPagarManter }

//alterar numero do documento


function TdmContasPagarManter.alterarNumDocTP(pidOrganizacao,
      pId, pNumero: String): Boolean;
      var
  cmd: string;
begin

cmd := 'UPDATE TITULO_PAGAR TP SET TP.NUMERO_DOCUMENTO = :pNumero ' +
       'WHERE (TP.ID_TITULO_PAGAR = :PID) AND ' +
       '(TP.ID_ORGANIZACAO = :PIDORGANIZACAO)' ;
  try
    if not qryAlteraNumDoc.Connection.Connected then
    begin
      qryAlteraNumDoc.Connection := dmConexao.Conn;
    end;
  Except
    raise Exception.Create
      ('Problemas ao tentar conectar com base. Erro : ALTNUMDOCTP-1');
  end;

  qryAlteraNumDoc.Close;
  qryAlteraNumDoc.Connection := dmConexao.Conn;
  qryAlteraNumDoc.SQL.Clear;
  qryAlteraNumDoc.SQL.Add(cmd) ;


  qryAlteraNumDoc.ParamByName('PID').AsString := pId;
  qryAlteraNumDoc.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;
  qryAlteraNumDoc.ParamByName('PNUMERO').AsString := pNumero;
  qryAlteraNumDoc.SQL.SaveToFile(ExtractFilePath(Application.ExeName) + 'ALTNUMDOCTP.log');


  try
    qryAlteraNumDoc.ExecSQL;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ALTNUMDOCTP-2');
  end;

  dmConexao.Conn.Commit;

   Result := System.True;

end;



//deletar todos os TP

function TdmContasPagarManter.deletarTitulosPorTipoStatus(pidOrganizacao,
  status: String): Boolean;
begin

  //pegar os titulos
  //deletar os historicos


 if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
  end ;

  qryDeletaExcluidos.Close;
  qryDeletaExcluidos.Connection := dmConexao.Conn;
  qryDeletaExcluidos.ParamByName('PIDSTATUS').AsString := status;
  qryDeletaExcluidos.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;

  try
    qryDeletaExcluidos.ExecSQL;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : DELTP-2');
  end;

  dmConexao.Conn.Commit;

   Result := System.True;

end;

procedure TdmContasPagarManter.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
  end;
end;

end.
