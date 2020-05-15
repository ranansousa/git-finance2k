unit uContaContabilDAO;
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uContaContabilModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
 TContaContabilDAO = class
  private
    class function getConta (query :TFDQuery) : TContaContabilModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}

    class function Insert(value :TContaContabilModel): Boolean;
    class function obterPorCodigoReduzido(value :TContaContabilModel): TContaContabilModel;
    class function obterPorID (value :TContaContabilModel): TContaContabilModel;
    class function Delete(value :TContaContabilModel): Boolean;
    class function Update(value : TContaContabilModel): Boolean;

  end;




implementation

{ TContaContabilDAO }

class function TContaContabilDAO.Delete(value: TContaContabilModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM CONTA_CONTABIL  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_CONTABIL = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR CONTA_CONTABIL');

 end;

  Result := xResp;
end;

class function TContaContabilDAO.getConta(query: TFDQuery): TContaContabilModel;
var
cContabil :TContaContabilModel;
begin
     cContabil :=TContaContabilModel.Create;
 try
  if not query.IsEmpty then begin

      cContabil.FID               := query.FieldByName('ID_CONTA_CONTABIL').AsString;
      cContabil.FIDorganizacao    := query.FieldByName('ID_ORGANIZACAO').AsString;
      cContabil.Fdescricao        := query.FieldByName('DESCRICAO').AsString;
      cContabil.Fconta            := query.FieldByName('CONTA').AsString;
      cContabil.FdgVer            := query.FieldByName('DGVER').AsString;
      cContabil.FcodigoReduzido   := query.FieldByName('CODREDUZ').AsString;
      cContabil.FdgReduz          := query.FieldByName('DGREDUZ').AsString;
      cContabil.FinscMF           := query.FieldByName('INSCMF').AsString;
      cContabil.Ftipo             := query.FieldByName('TIPO').AsString;
      cContabil.Fgrau             := query.FieldByName('GRAU').AsString;
      cContabil.Frelacionamento   := query.FieldByName('RELACIONAMENTO').AsInteger;
      cContabil.Fnatureza         := query.FieldByName('NATUREZA').AsInteger;
      cContabil.FdataRegistro     := query.FieldByName('DATA_REGISTRO').AsDateTime;
      cContabil.FordemDIPJ        := query.FieldByName('ORDEM_DIPJ').AsInteger;

  end;

 except
 raise Exception.Create('Erro ao converter CONTA_CONTABIL');

 end;
  Result := cContabil

end;

class function TContaContabilDAO.Insert(value: TContaContabilModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
try
 cmdSql :=  ' INSERT INTO CONTA_CONTABIL '+
            ' (ID_CONTA_CONTABIL, ID_ORGANIZACAO, DESCRICAO, '+
            ' CONTA, DGVER, CODREDUZ, DGREDUZ, INSCMF, TIPO, GRAU, '+
            ' ORDEM_DIPJ, RELACIONAMENTO, NATUREZA, DATA_REGISTRO) '+
            ' VALUES (:PID,:PIDORGANIZACAO,:PDESCRICAO, '+
            ' :PCONTA, :PDGVER, :PCODREDUZ, :PDGREDUZ, :PINSCMF, :PTIPO, :PGRAU, '+
            ' :PORDEM_DIPJ, :PRELACIONAMENTO, :PNATUREZA, :PDATA_REGISTRO ) ' ;

    qryInsert := TFDQuery.Create(nil);
    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString               := value.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qryInsert.ParamByName('PCONTA').AsString            := value.FConta;
    qryInsert.ParamByName('PDESCRICAO').AsString        := value.FDescricao;
    qryInsert.ParamByName('PDGVER').AsString            := value.FDgVer;
    qryInsert.ParamByName('PCODREDUZ').AsString         := value.FCodigoReduzido;
    qryInsert.ParamByName('PDGREDUZ').AsString          := value.FDgReduz;

    qryInsert.ParamByName('PINSCMF').AsString           := value.FinscMF;
    qryInsert.ParamByName('PTIPO').AsString             := value.Ftipo;
    qryInsert.ParamByName('PGRAU').AsString             := value.Fgrau;

    qryInsert.ParamByName('PRELACIONAMENTO').AsInteger   := value.Frelacionamento;
    qryInsert.ParamByName('PNATUREZA').AsInteger         := value.Fnatureza;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime  := value.FdataRegistro;
    qryInsert.ParamByName('PORDEM_DIPJ').AsInteger      := value.FordemDIPJ;


    qryInsert.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar inserir TITULO_PAGAR_BAIXA_FP');

end;

 Result := System.True;
end;

class function TContaContabilDAO.obterPorCodigoReduzido(value: TContaContabilModel): TContaContabilModel;

var
qryPesquisa : TFDQuery;
cContabilModel :TContaContabilModel;

begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_CONTABIL  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  CODREDUZ = :PCODREDUZ '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PCODREDUZ').AsString := value.FcodigoReduzido;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      cContabilModel := TContaContabilModel.Create;
      cContabilModel := getConta(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter CONTA_CONTABIL POR CODREDUZ');

end;

 Result := cContabilModel;
end;

class function TContaContabilDAO.obterPorID(value: TContaContabilModel): TContaContabilModel;
var
qryPesquisa : TFDQuery;
cContabilModel :TContaContabilModel;

begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CONTA_CONTABIL  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CONTA_CONTABIL = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      cContabilModel := TContaContabilModel.Create;
      cContabilModel := getConta(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter CONTA_CONTABIL POR ID');

end;

 Result := cContabilModel;
end;

class function TContaContabilDAO.Update(value: TContaContabilModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
try

cmdSql := ' UPDATE CONTA_CONTABIL '+
          ' SET DESCRICAO     = :PDESCRICAO, '+
          ' CONTA             = :PCONTA, '+
          ' DGVER             = :PDGVER, '+
          ' CODREDUZ          = :PCODREDUZ, '+
          ' DGREDUZ           = :PDGREDUZ, '+
          ' INSCMF            = :PINSCMF, '+
          ' TIPO              = :PTIPO, '+
          ' GRAU              = :PGRAU, '+
          ' ORDEM_DIPJ        = :PORDEM_DIPJ,' +
          ' RELACIONAMENTO    = :PRELACIONAMENTO,'+
          ' NATUREZA          = :PNATUREZA, '+
          ' DATA_REGISTRO     = :PDATA_REGISTRO '+
          ' WHERE (ID_CONTA_CONTABIL = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ' ;

    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PID').AsString               := value.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;
    qryUpdate.ParamByName('PDESCRICAO').AsString        := value.Fdescricao;
    qryUpdate.ParamByName('PCONTA').AsString            := value.Fconta;
    qryUpdate.ParamByName('PDGVER').AsString            := value.FdgVer;
    qryUpdate.ParamByName('PCODREDUZ').AsString         := value.FcodigoReduzido;
    qryUpdate.ParamByName('PDGREDUZ').AsString          := value.FdgReduz;
    qryUpdate.ParamByName('PINSCMF').AsString           := value.FinscMF;
    qryUpdate.ParamByName('PTIPO').AsString             := value.Ftipo;
    qryUpdate.ParamByName('PGRAU').AsString             := value.Fgrau;
    qryUpdate.ParamByName('PORDEM_DIPJ').AsInteger      := value.FordemDIPJ;
    qryUpdate.ParamByName('PRELACIONAMENTO').AsInteger  := value.Frelacionamento;
    qryUpdate.ParamByName('PNATUREZA').AsInteger        := value.Fnatureza;
    qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime  := value.FdataRegistro;

    qryUpdate.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar alterar CONTA_CONTABIL');

end;

 Result := System.True;
end;

end.
