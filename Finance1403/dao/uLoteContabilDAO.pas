unit uLoteContabilDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,  System.DateUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uLoteContabilModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uUsuarioDAO, uUsuarioModel;


  const
   pTable : string = 'LOTE_CONTABIL';

type
 TLoteContabilDAO = class
  private

    class function getModel (query :TFDQuery) : TLoteContabilModel;
  public

    class function Insert(value :TLoteContabilModel): Boolean;
    class function obterPorID(value :TLoteContabilModel): TLoteContabilModel;
    class function Update(value :TLoteContabilModel): Boolean;
    class function Delete(value :TLoteContabilModel): Boolean;
    class function obterPorMes(pLote : TLoteContabilModel) : TLoteContabilModel;

  end;


implementation

class function TLoteContabilDAO.Delete(value: TLoteContabilModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM LOTE_CONTABIL  '  );
  qryDelete.SQL.Add('WHERE ( ID_ORGANIZACAO = :PIDORGANIZACAO )  AND  ( ID_LOTE_CONTABIL = :PID ) '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;


 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR ' +pTable);

 end;

  Result := xResp;
end;

class function TLoteContabilDAO.getModel(query: TFDQuery): TLoteContabilModel;
var model :TLoteContabilModel;
usuario :TUsuarioModel;
begin
 model  := TLoteContabilModel.Create;
 usuario := TUsuarioModel.Create;

  if not query.IsEmpty then begin

    try


      model.FID               := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      model.FqtdRegistros     := query.FieldByName('QTD_REGISTROS').AsInteger;
      model.FIDorganizacao    := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.Flote             := query.FieldByName('LOTE').AsString;
      model.Fstatus           := query.FieldByName('STATUS').AsString;
      model.FtipoLancamento   := query.FieldByName('TIPO_LANCAMENTO').AsString;
      model.FtipoTable        := query.FieldByName('TIPO_TABLE').AsString;

      model.FIDusuario        := query.FieldByName('ID_USUARIO').AsInteger;

      model.FdataRegistro     := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.FdataAtualizacao  := query.FieldByName('DATA_ATUALIZACAO').AsDateTime;
      model.FperiodoInicial   := query.FieldByName('PERIODO_INICIAL').AsDateTime;
      model.FperiodoFinal     := query.FieldByName('PERIODO_FINAL').AsDateTime;

      model.FvalorDB          := query.FieldByName('VALOR_DB').AsCurrency ;
      model.FvalorCR          := query.FieldByName('VALOR_CR').AsCurrency ;

      if (model.FIDusuario >0)  then begin


       usuario.FID            := model.FIDusuario;
       usuario.FIDorganizacao := model.FIDorganizacao;
       model.Fusuario         := TUsuarioDAO.obterPorID(usuario);

      end;


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TLoteContabilDAO.Insert(value: TLoteContabilModel): Boolean;
var
  qryGenerica: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' INSERT INTO LOTE_CONTABIL '+
                ' (ID_LOTE_CONTABIL, ID_ORGANIZACAO, LOTE, '+
                ' STATUS, ID_USUARIO, DATA_REGISTRO, DATA_ATUALIZACAO, '+
                ' PERIODO_INICIAL, PERIODO_FINAL, TIPO_TABLE, QTD_REGISTROS, '+
                ' VALOR_DB, VALOR_CR, TIPO_LANCAMENTO) '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PLOTE, '+
                ' :PSTATUS, :PID_USUARIO, :PDATA_REGISTRO, :PDATA_ATUALIZACAO, '+
                ' :PPERIODO_IN, :PPERIODO_FI, :PTABLE, :PQTD, '+
                ' :PDB, :PCR, :PTIPO )' ;

    qryGenerica := TFDQuery.Create(nil);
    qryGenerica.Close;
    qryGenerica.Connection := dmConexao.conn;
    qryGenerica.SQL.Clear;
    qryGenerica.SQL.Add(cmdSql);
    qryGenerica.ParamByName('PID').AsString                 := value.FID;
    qryGenerica.ParamByName('PIDORGANIZACAO').AsString      := value.FIDorganizacao;
    qryGenerica.ParamByName('PLOTE').AsString               := value.Flote;
    qryGenerica.ParamByName('PSTATUS').AsString             := value.Fstatus;
    qryGenerica.ParamByName('PTABLE').AsString              := value.FtipoTable;
    qryGenerica.ParamByName('PTIPO').AsString               := value.FtipoLancamento;
    qryGenerica.ParamByName('PDB').AsCurrency               := value.FvalorDB;
    qryGenerica.ParamByName('PCR').AsCurrency               := value.FvalorCR;
    qryGenerica.ParamByName('PIDUSUARIO').AsInteger         := value.FIDusuario;
    qryGenerica.ParamByName('PQTD').AsInteger               := value.FqtdRegistros;
    qryGenerica.ParamByName('PDATA_REGISTRO').AsDateTime    := value.FdataRegistro;
    qryGenerica.ParamByName('PDATA_ATUALIZACAO').AsDateTime := value.FdataAtualizacao;
    qryGenerica.ParamByName('PINICIAL').AsDateTime          := value.FperiodoInicial;
    qryGenerica.ParamByName('PFINAL').AsDateTime            := value.FperiodoFinal;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' +  pTable);
  end;

  Result := System.True;
end;

class function TLoteContabilDAO.obterPorID( value: TLoteContabilModel): TLoteContabilModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TLoteContabilModel;
begin

dmConexao.conectarBanco;
model := TLoteContabilModel.Create;
qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE ID_'+ pTable + '  = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := getModel(qryPesquisa);
  end;


except
raise Exception.Create('Erro ao tentar obter ' + ptable);

end;

 Result := model;
end;


class function TLoteContabilDAO.obterPorMes(pLote : TLoteContabilModel) : TLoteContabilModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TLoteContabilModel;
 ano, mes : string;
 pTipo, pDataInicial, pDataFinal, pDataAnterior :string;
  dtInicial, dtFinal :TDate;

begin

 pTipo := plote.FtipoLancamento;

 ano := IntToStr( YearOf(pLote.FperiodoInicial));
 mes :=  IntToStr (MonthOf(pLote.FperiodoInicial));

                  pDataInicial  := '01'  + '/'+ mes + '/' + ano;
                  dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                  pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ mes + '/' + Ano;
                  dtInicial := StrToDate(pDataInicial);
                  dtFinal := StrToDate(pDataFinal);

dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE (PERIODO_INICIAL BETWEEN :DATAINICIAL AND :DATAFINAL) AND (TIPO_LANCAMENTO = :PTIPO) '  );

  qryPesquisa.ParamByName('DATAINICIAL').AsDateTime :=  dtInicial;
  qryPesquisa.ParamByName('DATAFINAL').AsDateTime   :=  dtFinal;
  qryPesquisa.ParamByName('PTIPO').AsString     :=  pTipo;


  qryPesquisa.Open;
  model := TLoteContabilModel.Create;

  if not qryPesquisa.IsEmpty then begin

      model := TLoteContabilModel.Create;
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + ptable);

end;

 Result := model;
end;

class function TLoteContabilDAO.Update(value: TLoteContabilModel): Boolean;
var
  qryGenerica: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql := ' UPDATE LOTE_CONTABIL '  +
               '   SET LOTE               = :PLOTE,   '  +
               '       STATUS             = :PSTATUS, '  +
               '       ID_USUARIO         = :PIDUSUARIO,         '  +
               '       DATA_REGISTRO      = :PDATA_REGISTRO, '  +
               '       DATA_ATUALIZACAO   = :PDATA_ATUALIZACAO, '  +
               '       PERIODO_INICIAL    = :PINICIAL,  '  +
               '       PERIODO_FINAL      = :PFINAL,  '+
               '       TIPO_TABLE         = :PTABLE,'  +
               '       QTD_REGISTROS      = :PQTD, '  +
               '       VALOR_DB           = :PDB, '  +
               '       VALOR_CR           = :PCR,  '  +
               '       TIPO_LANCAMENTO    = :PTIPO '  +
               '   WHERE (ID_LOTE_CONTABIL = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


    qryGenerica := TFDQuery.Create(nil);
    qryGenerica.Close;
    qryGenerica.Connection := dmConexao.conn;
    qryGenerica.SQL.Clear;
    qryGenerica.SQL.Add(cmdSql);
    qryGenerica.ParamByName('PID').AsString             := value.FID;
    qryGenerica.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
    qryGenerica.ParamByName('PLOTE').AsString           := value.Flote;
    qryGenerica.ParamByName('PSTATUS').AsString         := value.Fstatus;
    qryGenerica.ParamByName('PTABLE').AsString          := value.FtipoTable;
    qryGenerica.ParamByName('PTIPO').AsString           := value.FtipoLancamento;

    qryGenerica.ParamByName('PDB').AsCurrency          := value.FvalorDB;
    qryGenerica.ParamByName('PCR').AsCurrency          := value.FvalorCR;

    qryGenerica.ParamByName('PIDUSUARIO').AsInteger     := value.FIDusuario;
    qryGenerica.ParamByName('PQTD').AsInteger           := value.FqtdRegistros;

    qryGenerica.ParamByName('PDATA_REGISTRO').AsDateTime    := value.FdataRegistro;
    qryGenerica.ParamByName('PDATA_ATUALIZACAO').AsDateTime := value.FdataAtualizacao;
    qryGenerica.ParamByName('PINICIAL').AsDateTime          := value.FperiodoInicial;
    qryGenerica.ParamByName('PFINAL').AsDateTime            := value.FperiodoFinal;



    qryGenerica.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable  );
  end;

  Result := System.True;
end;
end.
