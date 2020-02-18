unit uFrameNotaFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmNotafiscal = class(TFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


{ campos da tabela NOTA_FISCAL_ENTRADA


ID_NOTA_FISCAL_ENTRADA
ID_ORGANIZACAO
ID_TIPO_NOTA_FISCAL
ID_USUARIO

NUMERO
DESCRICAO
ID_RESPONSAVEL
DATA_REGISTRO
DATA_EMISSAO
DATA_PROTOCOLO
VALOR
OBSERVACAO
SERIE
SUB_SERIE
VALOR_ISS
BASE_CALCULO_ISS
ALIQUOTA_ISS
DATA_RETENCAO_ISS




CREATE TABLE NOTA_FISCAL_ENTRADA (
    ID_NOTA_FISCAL_ENTRADA  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO          VARCHAR(36) NOT NULL,
    NUMERO                  VARCHAR(20),
    DESCRICAO               VARCHAR(150),
    ID_RESPONSAVEL          VARCHAR(36),
    DATA_REGISTRO           DATE,
    DATA_EMISSAO            DATE,
    DATA_PROTOCOLO          DATE,
    VALOR                   NUMERIC(10,2),
    OBSERVACAO              VARCHAR(200),
    SERIE                   VARCHAR(2),
    SUB_SERIE               VARCHAR(2),
    VALOR_ISS               NUMERIC(10,2),
    BASE_CALCULO_ISS        NUMERIC(10,2),
    ALIQUOTA_ISS            VARCHAR(5),
    DATA_RETENCAO_ISS       DATE,
    ID_TIPO_NOTA_FISCAL     VARCHAR(36),
    ID_USUARIO              NUMERIC(5,0)
);





  }


end.
