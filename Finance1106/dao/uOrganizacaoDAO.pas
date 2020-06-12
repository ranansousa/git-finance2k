unit uOrganizacaoDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,System.DateUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  uEstadoModel, uCidadeModel, uBairroModel, uEstadoDAO, uCidadeDAO, uBairroDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uOrganizacaoModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'ORGANIZACAO';

type
 TOrganizacaoDAO = class
  private
    class function getModel (query :TFDQuery) : TOrganizacaoModel;
    class function carregarDadosOrganizacao(
      value: TOrganizacaoModel): TOrganizacaoModel; static;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TOrganizacaoModel): Boolean;
    class function obterPorID(value :TOrganizacaoModel): TOrganizacaoModel;
    class function obterPorCNPJ(value :TOrganizacaoModel): TOrganizacaoModel;

    class function Update(value :TOrganizacaoModel): Boolean;
    class function Delete(value :TOrganizacaoModel): Boolean;
    class function ajustarVersaoBD(value :TOrganizacaoModel) :Boolean;
    class function obterFID(pFID :string) :string;


  end;

implementation

class function TOrganizacaoDAO.ajustarVersaoBD(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso : Boolean;
begin
 sucesso := False;
 //ver uFrmRegistro e uFrmPrincipal

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;
  try
    try
      cmdSql := ' UPDATE ORGANIZACAO ORG SET ORG.DATA_ATUALIZACAO =:PDATA, ORG.VERSAO2K = :PVERSAO WHERE ORG.ID_ORGANIZACAO = :PID';

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString := value.FID;
      qry.ParamByName('PVERSAO').AsString := value.FVersao;
      qry.ParamByName('PDATA').AsDate := IncDay(Now,7); //data da proxima atualizacao
      qry.ExecSQL;

      if dmConexao.conn.InTransaction then
        dmConexao.conn.CommitRetaining;

      if qry.RowsAffected > 0 then      begin
        sucesso := True;
        uUtil.TOrgAtual.setOrganizacao(value);

      end;

    except

      if dmConexao.conn.InTransaction then
        dmConexao.conn.RollbackRetaining;
       sucesso := False;
    end;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

  Result := sucesso;

end;

class function TOrganizacaoDAO.Delete(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
 sucesso : Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;

  qry := TFDQuery.Create(nil);

  try
      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM ' + pTable);
      qry.SQL.Add('WHERE ID_' + pTable + ' = :PID ');

      qry.ParamByName('PID').AsString := value.FID;

      qry.ExecSQL;

      if qry.RowsAffected >0 then begin
        sucesso := True;

      end;

    Result := sucesso;


  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TOrganizacaoDAO.getModel(query: TFDQuery): TOrganizacaoModel;
var model :TOrganizacaoModel;
 estado :TEstadoModel;
 cidade :TCidadeModel;
 bairro :TBairroModel;


begin
  model := TOrganizacaoModel.Create;
  estado :=TEstadoModel.Create;
  cidade :=TCidadeModel.Create;
  bairro :=TBairroModel.Create;



  if not query.IsEmpty then   begin
      model.FID                   := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FSN1                  := query.FieldByName('SN1').AsString;
      model.FSN2                  := query.FieldByName('SN2').AsString;
      model.FSN3                  := query.FieldByName('SN3').AsString;
      model.FVersao               := query.FieldByName('VERSAO2K').AsString;
      model.FHOST_IP              := query.FieldByName('HOST_IP').AsString;
      model.FHOST_NAME            := query.FieldByName('HOST_NAME').AsString;
      model.FCODINOME             := query.FieldByName('CODINOME').AsString;
      model.FCODIGO_WEB           := query.FieldByName('CODIGO_WEB').AsString;
      model.FSOCKET_WEB           := query.FieldByName('SOCKET_WEB').AsString;
      model.FLICENCA              := query.FieldByName('LICENCA').AsString;
      model.FSERIAL_CLIENTE       := query.FieldByName('SERIAL_CLIENTE').AsString;
      model.FSERIAL_HD            := query.FieldByName('SERIAL_HD').AsString;
      model.FSISTEMA_CONTABIL     := query.FieldByName('SISTEMA_CONTABIL').AsString;
      model.FIPSERVERBD           := query.FieldByName('IPSERVERBD').AsString;
      model.FNAMESERVERBD         := query.FieldByName('NAMESERVERBD').AsString;
      model.FIDBAIRRO             := query.FieldByName('ID_BAIRRO').AsString;
      model.FIDCIDADE             := query.FieldByName('ID_CIDADE').AsString;
      model.FIDESTADO             := query.FieldByName('ID_ESTADO').AsString;
      model.FCEP                  := query.FieldByName('CEP').AsString;
      model.FNUMERO               := query.FieldByName('NUMERO').AsString;
      model.FCOMPLEMENTO          := query.FieldByName('COMPLEMENTO').AsString;
      model.FLOGRADOURO           := query.FieldByName('LOGRADOURO').AsString;
      model.FINSCRICAO_ESTADUAL   := query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      model.FINSCRICAO_MUNICIPAL  := query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      model.FCNPJ                 := query.FieldByName('CNPJ').AsString;
      model.FFantasia             := query.FieldByName('FANTASIA').AsString;
      model.FSigla                := query.FieldByName('SIGLA').AsString;
      model.FRazaoSocial          := query.FieldByName('RAZAO_SOCIAL').AsString;
      model.FFLAG_HST             := query.FieldByName('FLAG_HST').AsInteger;
      model.FATIVA                := query.FieldByName('ATIVA').AsInteger;
      model.FDATA_ATUALIZACAO     := query.FieldByName('DATA_ATUALIZACAO').AsDateTime;
      model.Fnovo                 := False;
      model.Fvinculada            := True;

      estado.FID := model.FIDESTADO;
      model.FEstado := TEstadoDAO.obterPorID(estado);

      cidade.FID := model.FIDCIDADE;
      model.FCidade := TCidadeDAO.obterPorID(cidade);

      estado.FID := model.FIDESTADO;
      model.FEstado := TEstadoDAO.obterPorID(estado);

      bairro.FID := model.FIDBAIRRO;
      model.FBairro := TBairroDAO.obterPorID(bairro);


  end;


   Result := model;

end;

class function TOrganizacaoDAO.Insert(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso : Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
     cmdSql := ' INSERT INTO ORGANIZACAO '+
               ' (ID_ORGANIZACAO, RAZAO_SOCIAL, SIGLA, '+
               ' FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, '+
               ' LOGRADOURO, COMPLEMENTO, NUMERO, CEP, '+
               ' ID_ESTADO, ID_CIDADE, ID_BAIRRO, '+
               ' NAMESERVERBD, IPSERVERBD, SISTEMA_CONTABIL, '+
               ' SERIAL_HD, SERIAL_CLIENTE, LICENCA, SOCKET_WEB, CODIGO_WEB, '+
               ' CODINOME, HOST_NAME, HOST_IP, VERSAO2K, DATA_ATUALIZACAO, '+
               ' FLAG_HST, SN1, SN2, SN3, ATIVA) '+
               ' VALUES (:PID, :PIDRAZAO_SOCIAL, :PSIGLA, '+
               ' :PFANTASIA, :PCNPJ, :PINSCRICAO_ESTADUAL, :PINSCRICAO_MUNICIPAL, '+
               ' :PLOGRADOURO, :PCOMPLEMENTO, :PNUMERO, :PCEP, '+
               ' :PID_ESTADO, :PID_CIDADE, :PID_BAIRRO, '+
               ' :PNAMESERVERBD, :PIPSERVERBD, :PSISTEMA_CONTABIL, '+
               ' :PSERIAL_HD, :PSERIAL_CLIENTE, :PLICENCA, :PSOCKET_WEB, :PCODIGO_WEB, '+
               ' :PCODINOME, :PHOST_NAME, :PHOST_IP, :PVERSAO, :PDATA_ATUALIZACAO, '+
               ' :PFLAG_HST, :PSN1, :PSN2, :PSN3, :PATIVA) ';

    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    //OBR
    qry.ParamByName('PID').AsString                   := LowerCase(obterFID(LowerCase(value.FSigla)));
    qry.ParamByName('PIDRAZAO_SOCIAL').AsString       := value.FRazaoSocial;
    qry.ParamByName('PSIGLA').AsString                := value.FSigla;
    qry.ParamByName('PCNPJ').AsString                 := value.FCNPJ;
    qry.ParamByName('PINSCRICAO_ESTADUAL').AsString   := value.FINSCRICAO_ESTADUAL;
    qry.ParamByName('PINSCRICAO_MUNICIPAL').AsString  := value.FINSCRICAO_MUNICIPAL;
    qry.ParamByName('PNAMESERVERBD').AsString         := uutil.GetComputerNetName;
    qry.ParamByName('PIPSERVERBD').AsString            := uutil.GetIp;

    //NOBR
    qry.ParamByName('PFANTASIA').AsString             := value.FFantasia;
    qry.ParamByName('PLOGRADOURO').AsString           := value.FLOGRADOURO;
    qry.ParamByName('PCOMPLEMENTO').AsString          := value.FCOMPLEMENTO;
    qry.ParamByName('PNUMERO').AsString               := value.FNUMERO;
    qry.ParamByName('PCEP').AsString                  := value.FCEP;
    qry.ParamByName('PID_ESTADO').AsString            := value.FIDESTADO;
    qry.ParamByName('PID_CIDADE').AsString            := value.FIDCIDADE;
    qry.ParamByName('PID_BAIRRO').AsString            := value.FIDBAIRRO;
    qry.ParamByName('PSISTEMA_CONTABIL').AsString     := value.FSISTEMA_CONTABIL;
    qry.ParamByName('PSERIAL_HD').AsString            := value.FSERIAL_HD;
    qry.ParamByName('PSERIAL_CLIENTE').AsString       := value.FSERIAL_CLIENTE;
    qry.ParamByName('PLICENCA').AsString              := value.FLICENCA;
    qry.ParamByName('PSOCKET_WEB').AsString           := value.FSOCKET_WEB;
    qry.ParamByName('PCODIGO_WEB').AsString           := value.FCODIGO_WEB;
    qry.ParamByName('PCODINOME').AsString             := value.FCODINOME;
    qry.ParamByName('PHOST_NAME').AsString            := value.FHOST_NAME;
    qry.ParamByName('PHOST_IP').AsString              := value.FHOST_IP;
    qry.ParamByName('PVERSAO').AsString               := value.FVersao;
    qry.ParamByName('PFLAG_HST').AsInteger            := 0;
    qry.ParamByName('PSN1').AsString                  := value.FSN1;
    qry.ParamByName('PSN2').AsString                  := value.FSN2;
    qry.ParamByName('PSN3').AsString                  := value.FSN3;
    qry.ParamByName('PATIVA').AsInteger               := 1;
    qry.ParamByName('PDATA_ATUALIZACAO').AsDate       := IncMonth(Now, 6);

    if uutil.Empty(value.FINSCRICAO_ESTADUAL) then begin
    qry.ParamByName('PINSCRICAO_ESTADUAL').AsString   := '0000';
    end;

    if uutil.Empty(value.FINSCRICAO_MUNICIPAL) then begin
     qry.ParamByName('PINSCRICAO_MUNICIPAL').AsString   := '0000';
    end;
    if uUtil.Empty(value.FIDESTADO) then
    begin
      qry.ParamByName('PID_ESTADO').value := null;
    end;

    if uUtil.Empty(value.FIDCIDADE) then
    begin
      qry.ParamByName('PID_CIDADE').value := null;
    end;

    if uUtil.Empty(value.FIDBAIRRO) then
    begin
      qry.ParamByName('PID_BAIRRO').value := null;
    end;


    qry.ExecSQL;
    if qry.RowsAffected >0 then begin sucesso := True; dmConexao.conn.Commit; end;

   Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

class function TOrganizacaoDAO.obterFID(pFID: string): string;
var
 fid, cmdSql:string;
 model: TOrganizacaoModel;
 aux :Integer;

begin
 aux:=1;
 dmConexao.conectarBanco;
  model := TOrganizacaoModel.Create;

  try

   fid := Trim(LowerCase(pFID));

    while aux > 0 do
    begin
      model.FID := fid;
      model := obterPorID(model);

      if not uUtil.Empty(model.FID) then
      begin
        Inc(aux);
        fid := Trim(LowerCase(pFID)) + '0' + IntToStr(aux);
      end
      else
      begin
        aux := 0;
      end;
    end;


    Result := fid;

  finally
    if Assigned(model) then
    begin
      FreeAndNil(model);
    end;
  end;

end;


class function TOrganizacaoDAO.obterPorCNPJ(
  value: TOrganizacaoModel): TOrganizacaoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TOrganizacaoModel;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
 model := TOrganizacaoModel.Create;
  try

    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add('SELECT * ');
    qryPesquisa.SQL.Add('FROM ' + pTable);
    qryPesquisa.SQL.Add('WHERE CNPJ = :PCNPJ ');

    qryPesquisa.ParamByName('PCNPJ').AsString := value.FCNPJ;
    qryPesquisa.Open;

    if not qryPesquisa.IsEmpty then
    begin
      model := getModel(qryPesquisa);
    end;

    Result := model;

  finally
    if Assigned(qryPesquisa) then
    begin
      FreeAndNil(qryPesquisa);
    end;
  end;

end;

class function TOrganizacaoDAO.obterPorID( value: TOrganizacaoModel): TOrganizacaoModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TOrganizacaoModel;
begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
 model := TOrganizacaoModel.Create;
  try

    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add('SELECT * ');
    qryPesquisa.SQL.Add('FROM ' + pTable);
    qryPesquisa.SQL.Add('WHERE ID_' + pTable + ' = :PID ');

    qryPesquisa.ParamByName('PID').AsString := value.FID;
    qryPesquisa.Open;

    if not qryPesquisa.IsEmpty then
    begin
      model := getModel(qryPesquisa);
    end;

    Result := model;

  finally
    if Assigned(qryPesquisa) then
    begin
      FreeAndNil(qryPesquisa);
    end;
  end;

end;


class function TOrganizacaoDAO.Update(value: TOrganizacaoModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
sucesso : Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try


     cmdSql :=  ' UPDATE ORGANIZACAO  '+
                '  SET RAZAO_SOCIAL             = :PIDRAZAO_SOCIAL ,' +
                '      SIGLA                    = :PSIGLA,' +
                '      FANTASIA                 = :PFANTASIA,'+
                '      CNPJ                     = :PCNPJ,'+
                '      INSCRICAO_ESTADUAL       = :PINSCRICAO_ESTADUAL,'+
                '      INSCRICAO_MUNICIPAL      = :PINSCRICAO_MUNICIPAL,'+
                '      LOGRADOURO               = :PLOGRADOURO,'+
                '      COMPLEMENTO              = :PCOMPLEMENTO,'+
                '      NUMERO                   = :PNUMERO,'  +
                '      CEP                      = :PCEP,'+
                '      ID_ESTADO                = :PID_ESTADO,'+
                '      ID_CIDADE                = :PID_CIDADE,'+
                '      ID_BAIRRO                = :PID_BAIRRO,'+
                '      NAMESERVERBD             = :PNAMESERVERBD,'+
                '      IPSERVERBD               = :PIPSERVERBD,'+
                '      SISTEMA_CONTABIL         = :PSISTEMA_CONTABIL,'+
                '      SERIAL_HD                = :PSERIAL_HD,'+
                '      SERIAL_CLIENTE           = :PSERIAL_CLIENTE,'+
                '      LICENCA                  = :PLICENCA,'+
                '      SOCKET_WEB               = :PSOCKET_WEB,'+
                '      CODIGO_WEB               = :PCODIGO_WEB,'+
                '      CODINOME                 = :PCODINOME,'+
                '      HOST_NAME                = :PHOST_NAME,'+
                '      HOST_IP                  = :PHOST_IP,'+
                '      VERSAO2K                 = :PVERSAO,'+
                '      DATA_ATUALIZACAO         = :PDATA_ATUALIZACAO,'+
                '      FLAG_HST                 = :PFLAG_HST,'+
                '      SN1                      = :PPSN1,'+
                '      SN2                      = :PPSN2,'+
                '      SN3                      = :PPSN3,'+
                '      ATIVA                    = :PATIVA'+
                '  WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)' ;


    //OBR
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FID;
    qry.ParamByName('PIDRAZAO_SOCIAL').AsString       := value.FRazaoSocial;
    qry.ParamByName('PSIGLA').AsString                := value.FSigla;
    qry.ParamByName('PCNPJ').AsString                 := value.FCNPJ;
    qry.ParamByName('PINSCRICAO_ESTADUAL').AsString   := value.FINSCRICAO_ESTADUAL;
    qry.ParamByName('PINSCRICAO_MUNICIPAL').AsString  := value.FINSCRICAO_MUNICIPAL;
    qry.ParamByName('PNAMESERVERBD').AsString         := uutil.GetComputerNetName;
    qry.ParamByName('IPSERVERBD').AsString            := uutil.GetIp;

    //NOBR
    qry.ParamByName('PFANTASIA').AsString             := value.FFantasia;
    qry.ParamByName('PLOGRADOURO').AsString           := value.FLOGRADOURO;
    qry.ParamByName('PCOMPLEMENTO').AsString          := value.FCOMPLEMENTO;
    qry.ParamByName('PNUMERO').AsString               := value.FNUMERO;
    qry.ParamByName('PCEP').AsString                  := value.FCEP;
    qry.ParamByName('PID_ESTADO').AsString            := value.FIDESTADO;
    qry.ParamByName('PID_CIDADE').AsString            := value.FIDCIDADE;
    qry.ParamByName('PID_BAIRRO').AsString            := value.FIDBAIRRO;
    qry.ParamByName('PSISTEMA_CONTABIL').AsString     := value.FSISTEMA_CONTABIL;
    qry.ParamByName('PSERIAL_HD').AsString            := value.FSERIAL_HD;
    qry.ParamByName('PSERIAL_CLIENTE').AsString       := value.FSERIAL_CLIENTE;
    qry.ParamByName('PLICENCA').AsString              := value.FLICENCA;
    qry.ParamByName('PSOCKET_WEB').AsString           := value.FSOCKET_WEB;
    qry.ParamByName('PCODIGO_WEB').AsString           := value.FCODIGO_WEB;
    qry.ParamByName('PCODINOME').AsString             := value.FCODINOME;
    qry.ParamByName('PHOST_NAME').AsString            := value.FHOST_NAME;
    qry.ParamByName('PHOST_IP').AsString              := value.FHOST_IP;
    qry.ParamByName('PVERSAO').AsString               := value.FVersao;
    qry.ParamByName('PFLAG_HST').AsInteger            := 0;
    qry.ParamByName('PSN1').AsString                  := value.FSN1;
    qry.ParamByName('PSN2').AsString                  := value.FSN2;
    qry.ParamByName('PSN3').AsString                  := value.FSN3;
    qry.ParamByName('PATIVA').AsInteger               := 1;
    qry.ParamByName('PDATA_ATUALIZACAO').AsDate       := IncMonth(value.FDATA_ATUALIZACAO, 1);

    if uutil.Empty(value.FINSCRICAO_ESTADUAL) then begin
    qry.ParamByName('PINSCRICAO_ESTADUAL').AsString   := '0000';
    end;

    if uutil.Empty(value.FINSCRICAO_MUNICIPAL) then begin
    qry.ParamByName('PINSCRICAO_MUNICIPAL').AsString   := '0000';
    end;

    if value.FDATA_ATUALIZACAO < IncYear(Now, -3) then begin
    qry.ParamByName('PDATA_ATUALIZACAO').AsDate       := IncMonth(Now, 1);
    end;

    qry.ExecSQL;
    if qry.RowsAffected >0 then sucesso := True;

   Result := sucesso;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;


class function TOrganizacaoDAO.carregarDadosOrganizacao(value: TOrganizacaoModel): TOrganizacaoModel;
var
cmd :string;
org : TOrganizacaoModel;
qryDadosEmpresa: TFDQuery;

begin
 dmConexao.conectarBanco;
  org := TOrganizacaoModel.Create;

   //melhor pegar pleo obterID e alterar na aplicacao
   //RSS em 26/02

  try

     cmd := ' SELECT '+
            '    O.RAZAO_SOCIAL,'+
            '    O.FANTASIA,    '+
            '    O.VERSAO2K,       '+
            '    O.CNPJ,            '+
            '    TRIM(O.LOGRADOURO) || '' '' || TRIM(O.NUMERO) || IIF(TRIM(O.COMPLEMENTO)='''','''','' '' ||TRIM(O.COMPLEMENTO)) || '' - '' || TRIM(B.BAIRRO) AS ENDERECO, '+
            '    O.CEP,'+
            '    C.CIDADE,'+
            '    O.ID_ORGANIZACAO,'+
            '    O.CODINOME,        '+
            '    O.LICENCA,           '+
            '    O.SERIAL_CLIENTE,      '+
            '    O.SISTEMA_CONTABIL,      '+
            '    O.CODIGO_WEB,              '+
            '    O.IPSERVERBD,                '+
            '    E.SIGLA AS UF           '+
            '  FROM  ORGANIZACAO O '+
            '    JOIN BAIRRO B ON (O.ID_BAIRRO = B.ID_BAIRRO)'+
            '    JOIN CIDADE C ON (B.ID_CIDADE = C.ID_CIDADE)  '+
            '    JOIN ESTADO E ON (C.ID_ESTADO = E.ID_ESTADO)   '+
            '  WHERE  (O.ID_ORGANIZACAO = :PIDORGANIZACAO) ';

       qryDadosEmpresa.Close;
       qryDadosEmpresa.Connection := dmConexao.Conn;
       qryDadosEmpresa.SQL.Clear;
       qryDadosEmpresa.SQL.Add(cmd);
       qryDadosEmpresa.ParamByName('PIDORGANIZACAO').AsString := value.FID;
       qryDadosEmpresa.Open;


  except
    raise(Exception).Create('Problemas ao carregar dados da organização.. ');
  end;

  Result := org;
end;

end.
