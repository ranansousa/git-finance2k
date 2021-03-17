unit uEnderecoModel;

interface


uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel, uCidadeModel, uEstadoModel, uBairroModel;

type
  TEnderecoModel = class(TObject)
  private
    FFID: string;
    FFLOGRADOURO :string;
    FFCOMPLEMENTO :string;
    FFIDESTADO: string;
    FFIDorganizacao :string;
    FFIDBAIRRO: string;
    FFNUMERO: string;
    FFCEP: string;
    FFIDCIDADE: string;
    FFOrganizacao :TOrganizacaoModel;
    FFcidade : TCidadeModel;
    FFestado : TEstadoModel;
    FFbairro : TBairroModel;

    FFnovo : Boolean;


    function getFFOrganizacao: TOrganizacaoModel;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFCEP: string;
    function getFFCOMPLEMENTO: string;
    function getFFIDBAIRRO: string;
    function getFFIDCIDADE: string;
    function getFFIDESTADO: string;
    function getFFLOGRADOURO: string;
    function getFFNUMERO: string;


    procedure SetFCEP(const Value: string);
    procedure SetFCOMPLEMENTO(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIDBAIRRO(const Value: string);
    procedure SetFIDCIDADE(const Value: string);
    procedure SetFIDESTADO(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFLOGRADOURO(const Value: string);
    procedure SetFNUMERO(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFFbairro(const Value: TBairroModel);
    procedure SetFFcidade(const Value: TCidadeModel);
    procedure SetFFestado(const Value: TEstadoModel);



  public

    property FID: string read getFFID write SetFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property FIDCIDADE: string read getFFIDCIDADE write SetFIDCIDADE;
    property FCEP: string read getFFCEP write SetFCEP;
    property FNUMERO: string read getFFNUMERO write SetFNUMERO;
    property FIDBAIRRO: string read getFFIDBAIRRO write SetFIDBAIRRO;
    property FIDESTADO: string read getFFIDESTADO write SetFIDESTADO;
    property FCOMPLEMENTO: string read getFFCOMPLEMENTO write SetFCOMPLEMENTO;
    property FLOGRADOURO: string read getFFLOGRADOURO write SetFLOGRADOURO;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;
    property Fcidade: TCidadeModel read FFcidade write SetFFcidade;
    property Festado: TEstadoModel read FFestado write SetFFestado;
    property Fbairro: TBairroModel read FFbairro write SetFFbairro;

    property Fnovo :Boolean                         read FFnovo                write FFnovo; //define se � novo ou j� existe.

    Constructor Create;


  end;

implementation

{ TEnderecoModel }

constructor TEnderecoModel.Create;
begin
 FFnovo := True;
end;

function TEnderecoModel.getFFCEP: string;
begin
  Result := FFCEP;
end;


function TEnderecoModel.getFFCOMPLEMENTO: string;
begin
   Result := FFCOMPLEMENTO;
end;


function TEnderecoModel.getFFID: string;
begin
  Result := FFID;
end;

function TEnderecoModel.getFFIDBAIRRO: string;
begin
  Result := FFIDBAIRRO;
end;

function TEnderecoModel.getFFIDCIDADE: string;
begin
  Result := FFIDCIDADE;
end;


function TEnderecoModel.getFFIDESTADO: string;
begin
   Result := FFIDESTADO;
end;

function TEnderecoModel.getFFIDorganizacao: string;
begin
  Result := FFIDorganizacao;
end;

function TEnderecoModel.getFFLOGRADOURO: string;
begin
Result := FFLOGRADOURO;
end;


function TEnderecoModel.getFFNUMERO: string;
begin
 Result := FFNUMERO;
end;

function TEnderecoModel.getFFOrganizacao: TOrganizacaoModel;
begin
  Result := FFOrganizacao;
end;


procedure TEnderecoModel.SetFCEP(const Value: string);
begin
 FFCEP :=Value;
end;

procedure TEnderecoModel.SetFCOMPLEMENTO(const Value: string);
begin
    FFCOMPLEMENTO :=Value;
end;

procedure TEnderecoModel.SetFFbairro(const Value: TBairroModel);
begin
  FFbairro := Value;
end;

procedure TEnderecoModel.SetFFcidade(const Value: TCidadeModel);
begin
  FFcidade := Value;
end;

procedure TEnderecoModel.SetFFestado(const Value: TEstadoModel);
begin
  FFestado := Value;
end;

procedure TEnderecoModel.SetFID(const Value: string);
begin
   FFID :=Value;
end;

procedure TEnderecoModel.SetFIDBAIRRO(const Value: string);
begin
   FFIDBAIRRO :=Value;
end;

procedure TEnderecoModel.SetFIDCIDADE(const Value: string);
begin
   FFIDCIDADE :=Value;
end;

procedure TEnderecoModel.SetFIDESTADO(const Value: string);
begin
  FFIDESTADO :=Value;
end;

procedure TEnderecoModel.SetFIDorganizacao(const Value: string);
begin
   FFIDorganizacao :=Value;
end;

procedure TEnderecoModel.SetFLOGRADOURO(const Value: string);
begin
   FFLOGRADOURO :=Value;
end;

procedure TEnderecoModel.SetFNUMERO(const Value: string);
begin
   FFNUMERO :=Value;
end;

procedure TEnderecoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
   FFOrganizacao :=Value;
end;

end.
