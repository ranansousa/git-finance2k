unit uNotaFiscalEntradaModel;

interface

{
CREATE TABLE NOTA_FISCAL_ENTRADA (
    ID_NOTA_FISCAL_ENTRADA  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO          VARCHAR(36) NOT NULL,
    ID_RESPONSAVEL          VARCHAR(36),
    ID_TIPO_NOTA_FISCAL     VARCHAR(36),
    ID_USUARIO              NUMERIC(5,0),
    OBSERVACAO              VARCHAR(200),
    NUMERO                  VARCHAR(20),
    DESCRICAO               VARCHAR(150),
    ALIQUOTA_ISS            VARCHAR(5),
    SERIE                   VARCHAR(2),
    SUB_SERIE               VARCHAR(2),
    DATA_REGISTRO           DATE,
    DATA_EMISSAO            DATE,
    DATA_PROTOCOLO          DATE,
    DATA_RETENCAO_ISS       DATE,
    VALOR                   NUMERIC(10,2),
    VALOR_ISS               NUMERIC(10,2),
    BASE_CALCULO_ISS        NUMERIC(10,2)
);



);
}

uses
  Windows, Messages, Classes, SysUtils, uTipoNotaFiscalModel, uFuncionarioModel, uUsuarioModel, uOrganizacaoModel;

type
  TNotaFiscalEntradaModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDresponsavel :string;
    FFIDtipoNotaFiscal :String;
    FFIDusuario :Integer;
    FFnumero :string;
    FFdescricao :string;
    FFobservacao :string;
    FFserie :string;
    FFsubSerie :string;
    FFaliquotaISS :string;

    FFdataRetenncaoISS :TDate;
    FFdataRegistro :TDate;
    FFdataEmissao :TDate;
    FFdataProtocolo :TDate;

    FFvalor :Currency;
    FFvalorISS :Currency;
    FFbaseCalculoISS :Currency;

    FForganizacao :TOrganizacaoModel;
    FFresponsavel :TFuncionarioModel;
    FFtipoNotaFiscal :TTipoNotaFiscalModel;
    FFusuario :TUsuarioModel;



    procedure SetFFaliquotaISS(const Value: string);
    procedure SetFFbaseCalculoISS(const Value: Currency);
    procedure SetFFdataEmissao(const Value: TDate);
    procedure SetFFdataProtocolo(const Value: TDate);
    procedure SetFFdataRegistro(const Value: TDate);
    procedure SetFFdataRetenncaoISS(const Value: TDate);
    procedure SetFFdescricao(const Value: string);
    procedure SetFFID(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDresponsavel(const Value: string);
    procedure SetFFIDtipoNotaFiscal(const Value: String);
    procedure SetFFIDusuario(const Value: Integer);
    procedure SetFFnumero(const Value: string);
    procedure SetFFobservacao(const Value: string);
    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFresponsavel(const Value: TFuncionarioModel);
    procedure SetFFserie(const Value: string);
    procedure SetFFsubSerie(const Value: string);
    procedure SetFFtipoNotaFiscal(const Value: TTipoNotaFiscalModel);
    procedure SetFFusuario(const Value: TUsuarioModel);
    procedure SetFFvalor(const Value: Currency);
    procedure SetFFvalorISS(const Value: Currency);


    public

    property FID: string                            read FFID                   write SetFFID ;
    property FIDorganizacao: string                 read FFIDorganizacao        write SetFFIDorganizacao      ;
    property FIDresponsavel :string                 read FFIDresponsavel        write SetFFIDresponsavel      ;
    property FIDtipoNotaFiscal :String              read FFIDtipoNotaFiscal     write SetFFIDtipoNotaFiscal      ;
    property FIDusuario :Integer                    read FFIDusuario            write SetFFIDusuario      ;
    property Fnumero :string                        read FFnumero               write SetFFnumero      ;
    property Fdescricao :string                     read FFdescricao            write SetFFdescricao      ;
    property Fobservacao :string                    read FFobservacao           write SetFFobservacao      ;
    property Fserie :string                         read FFserie                write SetFFserie      ;
    property FsubSerie :string                      read FFsubSerie             write SetFFsubSerie      ;
    property FaliquotaISS :string                   read FFaliquotaISS          write SetFFaliquotaISS      ;
    property FdataRetenncaoISS :TDate               read FFdataRetenncaoISS     write SetFFdataRetenncaoISS      ;
    property FdataRegistro :TDate                   read FFdataRegistro         write SetFFdataRegistro      ;
    property FdataEmissao :TDate                    read FFdataEmissao          write SetFFdataEmissao      ;
    property FdataProtocolo :TDate                  read FFdataProtocolo        write SetFFdataProtocolo      ;
    property Fvalor :Currency                       read FFvalor                write SetFFvalor      ;
    property FvalorISS :Currency                    read FFvalorISS             write SetFFvalorISS      ;
    property FbaseCalculoISS :Currency              read FFbaseCalculoISS       write SetFFbaseCalculoISS      ;
    property Forganizacao :TOrganizacaoModel        read FForganizacao          write SetFForganizacao      ;
    property Fresponsavel :TFuncionarioModel        read FFresponsavel          write SetFFresponsavel      ;
    property FtipoNotaFiscal :TTipoNotaFiscalModel  read FFtipoNotaFiscal       write SetFFtipoNotaFiscal      ;
    property Fusuario :TUsuarioModel                read FFusuario              write SetFFusuario      ;


   constructor Create;




  end;


implementation

{ TNotaFiscalEntradaModel }

constructor TNotaFiscalEntradaModel.Create;
begin

end;

procedure TNotaFiscalEntradaModel.SetFFaliquotaISS(const Value: string);
begin
  FFaliquotaISS := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFbaseCalculoISS(const Value: Currency);
begin
  FFbaseCalculoISS := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFdataEmissao(const Value: TDate);
begin
  FFdataEmissao := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFdataProtocolo(const Value: TDate);
begin
  FFdataProtocolo := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFdataRegistro(const Value: TDate);
begin
  FFdataRegistro := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFdataRetenncaoISS(const Value: TDate);
begin
  FFdataRetenncaoISS := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFdescricao(const Value: string);
begin
  FFdescricao := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFIDresponsavel(const Value: string);
begin
  FFIDresponsavel := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFIDtipoNotaFiscal(const Value: String);
begin
  FFIDtipoNotaFiscal := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFIDusuario(const Value: Integer);
begin
  FFIDusuario := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFnumero(const Value: string);
begin
  FFnumero := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TNotaFiscalEntradaModel.SetFForganizacao(
  const Value: TOrganizacaoModel);
begin
  FForganizacao := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFresponsavel(
  const Value: TFuncionarioModel);
begin
  FFresponsavel := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFserie(const Value: string);
begin
  FFserie := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFsubSerie(const Value: string);
begin
  FFsubSerie := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFtipoNotaFiscal(
  const Value: TTipoNotaFiscalModel);
begin
  FFtipoNotaFiscal := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFusuario(const Value: TUsuarioModel);
begin
  FFusuario := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

procedure TNotaFiscalEntradaModel.SetFFvalorISS(const Value: Currency);
begin
  FFvalorISS := Value;
end;

end.
