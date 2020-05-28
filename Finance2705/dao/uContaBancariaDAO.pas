unit uContaBancariaDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uBancoDAO, uBancoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uContaBancariaModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  dxBar, Vcl.ComCtrls,   Vcl.StdCtrls   ;

  const
    pTable : string = 'CONTA_BANCARIA';
    pCampoPesquisa : string = 'CONTA';
    pCampoID : string = 'ID_CONTA_BANCARIA';

type
 TContaBancariaDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getConta (query :TFDQuery) : TContaBancariaModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function combo(var combo: TComboBox; var listaID: TStringList) :Boolean;
    class function comboDxBar(var combo: TdxBarCombo; var listaID: TStringList):Boolean;

    class function Insert(value :TContaBancariaModel): Boolean;
    class function obterPorID(value :TContaBancariaModel): TContaBancariaModel;
    class function Update(value :TContaBancariaModel): Boolean;
    class function Delete(value :TContaBancariaModel): Boolean;
 // fazer   class function saldoAtual(value :TContaBancariaModel): Currency;
 //   class function getContaContabil (tForma :TFormaPagamentoModel): TContaContabilModel;
  end;


implementation

class function TContaBancariaDAO.Delete(value: TContaBancariaModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin
xResp := False;
 dmConexao.conectarBanco;
 try

  qryDelete := TFDQuery.Create(nil);
  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM CONTA_BANCARIA  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR CONTA_BANCARIA');

 end;

  Result := xResp;
end;

class function TContaBancariaDAO.getConta(query: TFDQuery): TContaBancariaModel;
var cConta :TContaBancariaModel;
contaCtb : TContaContabilModel;
begin
 cConta                  := TContaBancariaModel.Create;
 contaCtb                := TContaContabilModel.Create;



  if not query.IsEmpty then begin


      cConta.FID              := query.FieldByName('ID_CONTA_BANCARIA').AsString;
      cConta.FIDorganizacao   := query.FieldByName('ID_ORGANIZACAO').AsString;
      cConta.FIDbanco         := query.FieldByName('ID_BANCO').AsString;
      cConta.FIDusuario       := query.FieldByName('ID_USUARIO').AsString;
      cConta.FIDcontaContabil := query.FieldByName('ID_CONTA_CONTABIL').AsString;
      cConta.Fconta           := query.FieldByName('CONTA').AsString;
      cConta.FcontaInterna    := query.FieldByName('CONTA_INTERNA').AsString;
      cConta.Fagencia         := query.FieldByName('AGENCIA').AsString;
      cConta.Fobservacao      := query.FieldByName('OBSERVACAO').AsString;
      cConta.Ftitular         := query.FieldByName('TITULAR').AsString;
      cConta.Fdependente      := query.FieldByName('DEPENDENTE').AsString;
      cConta.FlimiteCredito   := query.FieldByName('LIMITE_CREDITO').AsCurrency;
      cConta.FsaldoInicial    := query.FieldByName('SALDO_INICIAL').AsCurrency;
      cConta.Fativo           := query.FieldByName('ATIVO').AsInteger;
      cConta.Fnovo := False;



      contaCtb.FID            := cConta.FIDcontaContabil;
      contaCtb.FIDorganizacao := cConta.FIDorganizacao;
      cConta.FcontaContabil   := TContaContabilDAO.obterPorID(contaCtb);

      cConta.Fbanco := TBancoModel.Create;
      cConta.Fbanco.FID := cConta.FIDbanco;
      cConta.Fbanco := TBancoDAO.obterPorID(cConta.Fbanco);



  end;


   Result := cConta;

end;

class function TContaBancariaDAO.Insert(value: TContaBancariaModel): Boolean;
var
  qryUpdate: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  try

    cmdSql := ' INSERT INTO CONTA_BANCARIA ' +
              ' (ID_CONTA_BANCARIA, ID_ORGANIZACAO, ID_BANCO, CONTA_INTERNA,'+
              ' CONTA, AGENCIA, OBSERVACAO, TITULAR, LIMITE_CREDITO, SALDO_INICIAL, '+
              ' ID_USUARIO, ID_CONTA_CONTABIL, ATIVO) '+
              ' VALUES (:PID,:PIDORGANIZACAO,:PID_BANCO,:PCONTA_INTERNA, '+
              ' :PCONTA, :PAGENCIA, :POBS, :PTITULAR, :PLIMITE, :PSALDO, '+
              ' :PID_USUARIO, :PID_CONTA_CONTABIL, :PATIVO  ) ';


    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PID').AsString := value.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryUpdate.ParamByName('PAGENCIA').AsString := value.Fagencia;
    qryUpdate.ParamByName('PCONTA').AsString := value.Fconta;
    qryUpdate.ParamByName('POBS').AsString := value.Fobservacao;
    qryUpdate.ParamByName('PTITULAR').AsString := value.Ftitular;
  //  qryUpdate.ParamByName('PDEPENDENTE').AsString := value.Fdependente;
    qryUpdate.ParamByName('PID_BANCO').AsString := value.FIDbanco;
    qryUpdate.ParamByName('PID_USUARIO').AsString := value.FIDusuario;
    qryUpdate.ParamByName('PID_CONTA_CONTABIL').AsString := value.FIDcontaContabil;
  //  qryUpdate.ParamByName('PCONTA_INTERNA').AsString := value.FcontaInterna;
    qryUpdate.ParamByName('PSALDO').AsCurrency := value.FsaldoInicial;
    qryUpdate.ParamByName('PLIMITE').AsCurrency := value.FlimiteCredito;
    qryUpdate.ParamByName('PATIVO').AsInteger := value.Fativo;


    qryUpdate.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar CONTA_BANCARIA');
  end;

  Result := System.True;
end;
class function TContaBancariaDAO.obterPorID( value: TContaBancariaModel): TContaBancariaModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
conta: TContaBancariaModel;
begin
 dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);
 conta := TContaBancariaModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_BANCARIA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_BANCARIA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin


      conta := getConta(qryPesquisa);

  end;

except
raise Exception.Create('Erro ao tentar obter CONTA BANCARIA ');

end;

 Result := conta;
end;

class function TContaBancariaDAO.Update(value: TContaBancariaModel): Boolean;
var
  qryUpdate: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  try

    cmdSql := ' UPDATE CONTA_BANCARIA ' +
              ' SET ID_BANCO          = :PID_BANCO, ' +
              ' CONTA                 = :PCONTA, ' +
              ' AGENCIA               = :PAGENCIA, ' +
              ' OBSERVACAO            = :POBS, ' +
              ' TITULAR               = :PTITULAR, ' +
              ' LIMITE_CREDITO        = :PLIMITE, ' +
              ' SALDO_INICIAL         = :PSALDO, ' +
              ' DEPENDENTE            = :PDEPENDENTE, ' +
              ' ID_USUARIO            = :PID_USUARIO, ' +
              ' ATIVO                 = :PATIVO, ' +
              ' ID_CONTA_CONTABIL     = :PID_CONTA_CONTABIL, ' +
              ' CONTA_INTERNA         = :PCONTA_INTERNA ' +
              ' WHERE (ID_CONTA_BANCARIA = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';

    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PID').AsString := value.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryUpdate.ParamByName('PAGENCIA').AsString := value.Fagencia;
    qryUpdate.ParamByName('PCONTA').AsString := value.Fconta;
    qryUpdate.ParamByName('POBS').AsString := value.Fobservacao;
    qryUpdate.ParamByName('PTITULAR').AsString := value.Ftitular;
    qryUpdate.ParamByName('PDEPENDENTE').AsString := value.Fdependente;
    qryUpdate.ParamByName('PID_BANCO').AsString := value.FIDbanco;
    qryUpdate.ParamByName('PID_USUARIO').AsString := value.FIDusuario;
    qryUpdate.ParamByName('PID_CONTA_CONTABIL').AsString := value.FIDcontaContabil;
    qryUpdate.ParamByName('PCONTA_INTERNA').AsString := value.FcontaInterna;
    qryUpdate.ParamByName('PSALDO').AsCurrency := value.FsaldoInicial;
    qryUpdate.ParamByName('PLIMITE').AsCurrency := value.FlimiteCredito;
    qryUpdate.ParamByName('PATIVO').AsInteger := value.Fativo;


    qryUpdate.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar CONTA_BANCARIA');
  end;

  Result := System.True;
end;



class function TContaBancariaDAO.comboDxBar(var combo: TdxBarCombo; var listaID: TStringList):Boolean;
var
qry :TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Close;
  qry.Connection := dmConexao.conn;
  qry.SQL.Clear;
  qry.SQL.Add(' SELECT CB.ID_CONTA_BANCARIA,  CB.ID_ORGANIZACAO,  CB.CONTA '+
              ' FROM CONTA_BANCARIA CB '+
              ' WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CB.ATIVO = 1) ' );


  qry.ParamByName('PIDORGANIZACAO').AsString := UUTIL.TOrgAtual.getId;
  qry.Open;
  qry.First;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Items.Clear;
  combo.Items.Add('<<< Selecione  >>>');

  while not qry.Eof do
  begin
    combo.Items.Add(qry.FieldByName('CONTA').AsString);
    listaID.Add(qry.FieldByName('ID_CONTA_BANCARIA').AsString);
    qry.Next;
  end;



  qry.Close;
  combo.ItemIndex := 0;

  Result := not qry.IsEmpty;



end;


class function TContaBancariaDAO.combo(var combo: TComboBox; var listaID: TStringList) :Boolean;
var
qry :TFDQuery;

begin
  qry := TFDQuery.Create(nil);
  qry.Close;
  qry.Connection := dmConexao.conn;
  qry.SQL.Clear;
  qry.SQL.Add('SELECT  C.'+pCampoPesquisa + 'C.'+pCampoID + ' FROM  '+pTable + ' C WHERE C.ID_ORGANIZACAO = :PIDORGANIZACAO ');
  qry.ParamByName('PIDORGANIZACAO').AsString := UUTIL.TOrgAtual.getId;
  qry.Open;
  qry.First;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');


  while not qry.Eof do
  begin
    combo.Items.Add(qry.FieldByName(pCampoPesquisa).AsString);
    listaID.Add(qry.FieldByName(pCampoID).AsString);
    qry.Next;
  end;

  qry.Close;
  combo.ItemIndex := 0;

  Result := not qry.IsEmpty;


end;




end.
