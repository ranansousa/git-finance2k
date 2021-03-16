unit uDMExportaFinanceManter;

interface
uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmExdportFinanceManter = class(TDataModule)
    qryGravarLote: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function gravaLoteContabil(pId, pIdOrganizacao, pLote, pStatus, pIdUsuario: string; pDataInicial, pDataFinal: TDateTime): Boolean;
  end;

var
  dmExdportFinanceManter: TdmExdportFinanceManter;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule3 }

procedure TdmExdportFinanceManter.freeAndNilDM(Sender: TObject);
begin
  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

  dmConexao.conectarBanco;

end;

function TdmExdportFinanceManter.gravaLoteContabil(pId, pIdOrganizacao, pLote, pStatus, pIdUsuario: string; pDataInicial, pDataFinal: TDateTime): Boolean;
var
  comando: string;
begin
//

{     ver como fazer... se vai fazer

        QTD_TIT_PAG       NUMERIC(5,0),
        QTD_TIT_REC       NUMERIC(5,0),
        QTD_TIT_PAG_BX    NUMERIC(5,0),
        QTD_TIT_REC_BX    NUMERIC(5,0),
        QTD_TES_CRED      NUMERIC(5,0),
        QTD_CTA_DEB       NUMERIC(5,0),
        QTD_CTA_TRA       NUMERIC(5,0),
        QTD_CTA_CRE       NUMERIC(5,0),
        QTD_TES_DEB       NUMERIC(5,0),

}
{
   ID_LOTE_CONTABIL  VARCHAR(36) NOT NULL, //trigger faz isso
        ID_ORGANIZACAO    VARCHAR(36) NOT NULL,
        LOTE              VARCHAR(30),
        STATUS            VARCHAR(30),
        ID_USUARIO        NUMERIC(5,0),
        DATA_REGISTRO     DATE,
        DATA_ATUALIZACAO  DATE NOT NULL,
        PERIODO_INICIAL   DATE,
        PERIODO_FINAL     DATE }


  comando := ' INSERT INTO LOTE_CONTABIL (ID_LOTE_CONTABIL, ID_ORGANIZACAO, LOTE, STATUS, ID_USUARIO, DATA_REGISTRO,DATA_ATUALIZACAO,PERIODO_INICIAL, PERIODO_FINAL) ' +
             ' VALUES (:pId, :pIdOrganizacao, :pLote, :pStatus, :pIdUsuario, :pDataRegistro, :pDataAtualizacao, :pDataInicial,:pDataFinal)';

  try

    qryGravarLote.Close;
    qryGravarLote.Connection := dmConexao.Conn;
    qryGravarLote.SQL.Clear;
    qryGravarLote.SQL.Add(comando);
    qryGravarLote.ParamByName('pId').AsString := pId;
    qryGravarLote.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryGravarLote.ParamByName('pLote').AsString := pLote;
    qryGravarLote.ParamByName('pStatus').AsString := UpperCase(pStatus);
    qryGravarLote.ParamByName('pIdUsuario').AsString := '1'; // pIdUsuario;
    qryGravarLote.ParamByName('pDataRegistro').AsString := FormatDateTime('mm/dd/yyyy', Now);
    qryGravarLote.ParamByName('pDataAtualizacao').AsString := FormatDateTime('mm/dd/yyyy', Now);
    qryGravarLote.ParamByName('pDataInicial').AsDateTime := pDataInicial;
    qryGravarLote.ParamByName('pDataFinal').AsDateTime := pDataFinal;

    qryGravarLote.ExecSQL;

    dmConexao.Conn.Commit;

    Result := System.True;

  except
    raise;
  end;

end;

procedure TdmExdportFinanceManter.inicializarDM(Sender: TObject);
begin

end;

end.


