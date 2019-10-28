unit uDMContaContabil;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmContaContabil = class(TDataModule)
    qryObterPlanoContas: TFDQuery;
    dtsPlanoContas: TDataSource;
    qryIncluirConta: TFDQuery;
    qryObterPorConta: TFDQuery;
    qryAtualizaDescricaoConta: TFDQuery;
    qryObterPorCodigoReduzido: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function obterListaContaContabil(pIdOrganizacao: string): Boolean;
    //function insereContaContabil(ID_ORGANIZACAO,DESCRICAO,CONTA,DGVER,
    //CODREDUZ,DGREDUZ,INSCMF,TIPO,GRAU :String; ORDEM_DIPJ,RELACIONAMENTO,NATUREZA :Integer):Boolean;
    function obterContaPorFiltro(pIdOrganizacao, pFiltro, pCAmpo: string): Boolean;
    function obterContaPorCodigoReduzido(pIdOrganizacao, pFiltro, pCAmpo: string): Boolean;
    function insereContaContabil(ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string): Boolean;
    function atualizaDescricaoContaContabil(ID_CONTA_CONTABIL, ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string): Boolean;
  end;

var
  dmContaContabil: TdmContaContabil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmContaContabil.atualizaDescricaoContaContabil(ID_CONTA_CONTABIL, ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string): Boolean;
begin

  try

    qryAtualizaDescricaoConta.Close;
    qryAtualizaDescricaoConta.Connection := dmConexao.Conn;
    qryAtualizaDescricaoConta.ParamByName('pIDOrganizacao').AsString := ID_ORGANIZACAO;
    qryAtualizaDescricaoConta.ParamByName('pIdContaContabil').AsString := ID_CONTA_CONTABIL;
    qryAtualizaDescricaoConta.ParamByName('PDESCRICAO').AsString := UpperCase(DESCRICAO);
    qryAtualizaDescricaoConta.ParamByName('PCONTA').AsString := UpperCase(CONTA);
    qryAtualizaDescricaoConta.ParamByName('PDGVER').AsString := UpperCase(DGVER);
    qryAtualizaDescricaoConta.ParamByName('PCODREDUZ').AsString := UpperCase(CODREDUZ);
    qryAtualizaDescricaoConta.ParamByName('PDGREDUZ').AsString := UpperCase(DGREDUZ);
    qryAtualizaDescricaoConta.ParamByName('PTIPO').AsString := UpperCase(TIPO);
//    qryAtualizaDescricaoConta.ParamByName('pDataRegistro').AsString := FormatDateTime('mm/dd/yyyy', Now);

    qryAtualizaDescricaoConta.ExecSQL;

    dmConexao.Conn.Commit;
    Result := System.True;

  except
    raise Exception.Create('N�o foi poss�vel atualizar a conta contabil.');
  end;

end;

procedure TdmContaContabil.freeAndNilDM(Sender: TObject);
var
  i: Integer;
begin
           {
  if (Assigned(dmCedenteConsulta)) then
  begin
    FreeAndNil(dmCedenteConsulta);
  end;    }

end;

procedure TdmContaContabil.inicializarDM(Sender: TObject);
begin

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
  end;

end;

function TdmContaContabil.insereContaContabil(ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, CODREDUZ, DGREDUZ, TIPO: string): Boolean;
//function TdmContaContabil.insereContaContabil(ID_ORGANIZACAO,DESCRICAO, CONTA, DGVER,CODREDUZ, DGREDUZ, INSCMF, TIPO, GRAU: String; ORDEM_DIPJ, RELACIONAMENTO, NATUREZA: Integer): Boolean;
var
  comando, ident: string;
begin

  try

    comando := 'INSERT INTO CONTA_CONTABIL (ID_ORGANIZACAO, DESCRICAO, CONTA, DGVER, ' + 'CODREDUZ, DGREDUZ,TIPO,DATA_REGISTRO, NATUREZA,RELACIONAMENTO,ORDEM_DIPJ,GRAU,INSCMF ) ' + 'VALUES (:pIdOrganizacao, :pDescricao,:pConta, :pDgVer, :pCodReduz, :pDgCodReduz,' + ':pTipo, :pDataRegistro,:pNatureza,:pRelacao, :pOrdem,:pGrau,:pInscMf)';

    qryIncluirConta.Close;
    qryIncluirConta.Connection := dmConexao.Conn;
    qryIncluirConta.SQL.Clear;
    qryIncluirConta.SQL.Add(comando);
    qryIncluirConta.ParamByName('pIdOrganizacao').AsString := ID_ORGANIZACAO;
    qryIncluirConta.ParamByName('pDescricao').AsString := UpperCase(DESCRICAO);
    qryIncluirConta.ParamByName('pConta').AsString := CONTA;
    qryIncluirConta.ParamByName('pDgVer').AsString := DGVER;
    qryIncluirConta.ParamByName('pCodReduz').AsString := CODREDUZ;
    qryIncluirConta.ParamByName('pDgCodReduz').AsString := DGREDUZ;
    qryIncluirConta.ParamByName('pTipo').AsString := UpperCase(TIPO);
    qryIncluirConta.ParamByName('pDataRegistro').AsString := FormatDateTime('mm/dd/yyyy', Now);
    qryIncluirConta.ParamByName('pInscMf').AsString := '0';
    qryIncluirConta.ParamByName('pGrau').AsString := '5';
    qryIncluirConta.ParamByName('pOrdem').AsInteger := 0;
    qryIncluirConta.ParamByName('pRelacao').AsInteger := 0;
    qryIncluirConta.ParamByName('pNatureza').AsInteger := 0;

    qryIncluirConta.ExecSQL;

    dmConexao.Conn.Commit;

    Result := System.True;
  except
    raise Exception.Create('N�o foi poss�vel inserir a conta contabil.');
  end;

end;

function TdmContaContabil.obterContaPorFiltro(pIdOrganizacao, pFiltro, pCAmpo: string): Boolean;
var
  teste: string;
begin

  if not (qryObterPorConta.Connection.Connected) then
  begin
    qryObterPorConta.Connection := dmConexao.Conn;
  end;
  qryObterPorConta.Close;
  qryObterPorConta.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPorConta.ParamByName('PCONTA').AsString := pFiltro;

  qryObterPorConta.Open();

  Result := not qryObterPorConta.IsEmpty;
end;

function TdmContaContabil.obterContaPorCodigoReduzido(pIdOrganizacao, pFiltro, pCAmpo: string): Boolean;
var
  teste: string;
begin

  if not (qryObterPorCodigoReduzido.Connection.Connected) then
  begin
    qryObterPorCodigoReduzido.Connection := dmConexao.Conn;
  end;
  qryObterPorCodigoReduzido.Close;
  qryObterPorCodigoReduzido.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;

  qryObterPorCodigoReduzido.ParamByName('PCODREDUZ').AsString := pFiltro;

  qryObterPorCodigoReduzido.Open();

  Result := not qryObterPorCodigoReduzido.IsEmpty;
end;

function TdmContaContabil.obterListaContaContabil(pIdOrganizacao: string): Boolean;
begin
  if not (qryObterPlanoContas.Connection.Connected) then
  begin
    qryObterPlanoContas.Connection := dmConexao.Conn;
  end;

  qryObterPlanoContas.Close;
  qryObterPlanoContas.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterPlanoContas.Open();

  Result := not qryObterPlanoContas.IsEmpty;

end;

end.

