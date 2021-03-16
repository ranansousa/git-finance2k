unit uCBCreditoModel;

interface


uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TCedenteModel = class(TObject)
  private
    FFID: string;
    FFCodigo :string;
    FFStatus :string;
    FFIDtipoCedente: string;
    FFIDorganizacao :string;
    FFIDendereco: string;
    FFIDcontato: string;
    FFnome: string;
    FFcpfCnpj: string;
    FFinscricaoEstadual: string;
    FFinscricaoMunicipal: string;
    FFcga: string;
    FFpersonalidade: string;
    FFconta: string;
    FFagencia: string;
    FFIDbanco: string;
    FFIDcontaContabil: string;
    FFIDcartaoCreditoModel: string;
    FFDataRegistro: TDateTime;
    FFDataUltimaAtualizacao: TDateTime;
    FFOrganizacao :TOrganizacaoModel;


    function getFFOrganizacao : TOrganizacaoModel;
    function getFFIDtipoCedente: string;
    function getFFID: string;
    function getFFCodigo: string;
    function getFFStatus: string;

    function getFFIDendereco: string;
    function getFFIDcontato: string;
    function getFFnome: string;
    function getFFcpfCnpj: string;
    function getFFinscricaoEstadual: string;
    function getFFinscricaoMunicipal: string;
    function getFFcga: string;
    function getFFpersonalidade: string;
    function getFFconta: string;
    function getFFagencia: string;
    function getFFIDbanco: string;
    function getFFIDcontaContabil: string;
    function getFFIDcartaoCreditoModel: string;
    function getFFIDorganizacao: string;
    function getFFDataRegistro :TDateTime;
    function getFFDataUltimaAtualizacao :TDateTime;

    procedure SetFagencia(const Value: string);
    procedure SetFcga(const Value: string);
    procedure SetFconta(const Value: string);
    procedure SetFcpfCnpj(const Value: string);
    procedure SetFIDbanco(const Value: string);
    procedure SetFIDcartaoCreditoModel(const Value: string);
    procedure SetFIDcontaContabil(const Value: string);
    procedure SetFIDcontato(const Value: string);
    procedure SetFIDendereco(const Value: string);
    procedure SetFIDtipoCedente(const Value: string);
    procedure SetFinscricaoEstadual(const Value: string);
    procedure SetFinscricaoMunicipal(const Value: string);
    procedure SetFnome(const Value: string);
    procedure SetFpersonalidade(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFID(const Value: string);
    procedure SetFCodigo(const Value: string);
    procedure SetFStatus(const Value: string);
    procedure SetFDataRegistro(const Value: TDateTime);
    procedure SetFDataUltimaAtualizacao(const Value: TDateTime);

  public

    property FDataRegistro: TDateTime read getFFDataRegistro write SetFDataRegistro;
    property FDataUltimaAtualizacao: TDateTime read getFFDataUltimaAtualizacao write SetFDataUltimaAtualizacao;

    property FIDtipoCedente: string read getFFIDtipoCedente write SetFIDtipoCedente;
    property FCodigo: string read getFFCodigo write SetFCodigo;
    property FStatus: string read getFFStatus write SetFStatus;

    property  FID: string read getFFID write SetFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;

    property FIDendereco: string read getFFIDendereco write SetFIDendereco;
    property FIDcontato: string read getFFIDcontato write SetFIDcontato;
    property Fnome: string read getFFnome write SetFnome;
    property FcpfCnpj: string read getFFcpfCnpj write SetFcpfCnpj;
    property FinscricaoEstadual: string read getFFinscricaoEstadual write SetFinscricaoEstadual;
    property FinscricaoMunicipal: string read getFFinscricaoMunicipal write SetFinscricaoMunicipal;
    property Fcga: string read getFFcga write SetFcga;
    property Fpersonalidade: string read getFFpersonalidade write SetFpersonalidade;
    property Fconta: string read getFFconta write SetFconta;
    property Fagencia: string read getFFagencia write SetFagencia;
    property FIDbanco: string read getFFIDbanco write SetFIDbanco;
    property FIDcontaContabil: string read getFFIDcontaContabil write SetFIDcontaContabil;
    property FIDcartaoCreditoModel: string read getFFIDcartaoCreditoModel write SetFIDcartaoCreditoModel;

      Constructor Create;

  end;

implementation

end.
