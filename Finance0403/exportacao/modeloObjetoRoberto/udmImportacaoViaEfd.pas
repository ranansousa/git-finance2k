unit udmImportacaoViaEfd;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, udmConexao,
  Data.FMTBcd, Data.SqlExpr, Datasnap.Provider, Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLiteVDataSet;

type
  TdmImportacaoViaEfd = class(TDataModule)
    cdsParticipanteTemp: TClientDataSet;
    cdsParticipanteTempNOME: TStringField;
    cdsParticipanteTempINSCMF: TStringField;
    cdsParticipanteTempTIPO_INSCMF: TIntegerField;
    cdsParticipanteTempIE: TStringField;
    cdsParticipanteTempEND: TStringField;
    cdsParticipanteTempNUMERO: TStringField;
    cdsParticipanteTempCOMPL: TStringField;
    cdsParticipanteTempBAIRRO: TStringField;
    cdsParticipanteTempID_FPARTICIPANTE: TStringField;
    cdsDFETemp: TClientDataSet;
    cdsDFEAnaliticoTemp: TClientDataSet;
    cdsDFSTemp: TClientDataSet;
    cdsDFSAnaliticoTemp: TClientDataSet;
    cdsDFSEcfTemp: TClientDataSet;
    cdsDFSEcfAnaliticoTemp: TClientDataSet;
    cdsParticipanteTempEXISTE: TSmallintField;
    cdsParticipanteTempCOD_PART: TStringField;
    cdsParticipanteTempCOD_PAIS: TStringField;
    cdsParticipanteTempCOD_MUN: TStringField;
    cdsCstPisCofinsSaidas: TClientDataSet;
    cdsCstPisCofinsSaidasCODIGO: TStringField;
    cdsCstPisCofinsSaidasDESCRICAO: TStringField;
    cdsCstPisCofinsEntradas: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    cdsParticipanteTempUF: TStringField;
    cdsParticipanteTempID_CIDADE: TStringField;
    cdsParticipanteTempID_ESTADO: TStringField;
    cdsDFSM2Temp: TClientDataSet;
    cdsDFSM2AnaliticoTemp: TClientDataSet;
    qryCfop: TFDQuery;
    cdsCstIpi: TClientDataSet;
    StringField3: TStringField;
    StringField4: TStringField;
    cdsDFSM2TempCondensado: TClientDataSet;
    cdsDFSM2AnaliticoTempCondensado: TClientDataSet;
    qryDFModelo: TFDQuery;
    qryCidadeEstado: TFDQuery;
    qryPais: TFDQuery;
    qryDFSM2Analitico: TFDQuery;
    qryDFSM2: TFDQuery;
    qryEquipamentoECF: TFDQuery;
    qryPessoaFiscalParametros: TFDQuery;
    qryParticipante: TFDQuery;
    qryDFE: TFDQuery;
    qryDFEAnalitico: TFDQuery;
    qryDFS: TFDQuery;
    qryDFSAnalitico: TFDQuery;
    qryDFSEcf: TFDQuery;
    qryDFSEcfAnalitico: TFDQuery;
    qryVerificaDFE: TFDQuery;
    qryVerificaDFS: TFDQuery;
    qryVerificaDFSM2: TFDQuery;
    qryVerificaDFSEcf: TFDQuery;
    qryNFMod_02_65: TFDQuery;
    cdsNFMod_02_65_Temp: TClientDataSet;
    procedure cdsParticipante1ReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmImportacaoViaEfd: TdmImportacaoViaEfd;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmImportacaoViaEfd.cdsParticipante1ReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  showmessage(IntToStr(E.ErrorCode)+': '+E.Message);
end;

end.
