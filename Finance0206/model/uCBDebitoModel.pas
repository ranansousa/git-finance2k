unit uCBDebitoModel;

interface


uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TCBDebitoModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao: string;
    FFOrganizacao: TOrganizacaoModel;

    FFIDcontaBancaria: string;
    FFIDTOB: string;
    FFIDTituloPagar: string;
    FFIDResponsavel: string;
    FFIDcontaBancariaCheque: string;
    FFIDusuario: string;
    FFIDloteContabil: string;
    FFIdentificacao: string;
    FFdescricao: string;
    FFobservacao: string;
    FFTipoLancamento: string;
    FFdataRegistro: TDateTime;
    FFdataMovimento: TDateTime;
    FFvalor: Currency;



    function getFFOrganizacao : TOrganizacaoModel;
    function getFFIDorganizacao: string;
    function getFFID: string;

    function getFFIDcontaBancaria: string;
    function getFFIDTOB: string;
    function getFFIDTituloPagar: string;
    function getFFIDcontaBancariaCheque: string;
    function getFFIdentificacao: string;
    function getFFIDResponsavel: string;
    function getFFIDusuario: string;
    function getFFIDloteContabil: string;

    function getFFdescricao: string;
    function getFFobservacao: string;
    function getFFTipoLancamento: string;

    function getFFvalor: Currency;

    function getFFDataRegistro :TDateTime;
    function getFFdataMovimento :TDateTime;


    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFIDcontaBancaria(const Value: string);
    procedure setFFIDTOB(const Value: string);
    procedure setFFIDTituloPagar(const Value: string);
    procedure setFFIDResponsavel(const Value: string);
    procedure setFFIDcontaBancariaCheque(const Value: string);
    procedure setFFIDusuario(const Value: string);
    procedure setFFIDloteContabil(const Value: string);
    procedure setFFIdentificacao(const Value: string);
    procedure setFFdescricao(const Value: string);
    procedure setFFobservacao(const Value: string);
    procedure setFFTipoLancamento(const Value: string);
    procedure setFFdataRegistro(const Value: TDateTime);
    procedure setFFdataMovimento(const Value: TDateTime);
    procedure setFFvalor(const Value: Currency);




  public
           {

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;
    property FIDcontaBancaria: string read getFFIDcontaBancaria write SetFFIDcontaBancaria;
    property FIDTOB: string read getFFIDTOB write SetFFIDTOB;
    property FIDTituloPagar: string read getFFIDTituloPagar write SetFFIDTituloPagar;
    property FIDResponsavel: string read getFFIDResponsavel write SetFFIDResponsavel;
    property FIDcontaBancariaCheque: string read getFFIDcontaBancariaCheque write SetFFIDcontaBancariaCheque;
    property FIDusuario: string read getFFIDusuario write SetFFIDusuario;
    property FIDloteContabil: string read getFFIDloteContabil write SetFFIDloteContabil;
    property FIdentificacao: string read getFFIdentificacao write SetFFIdentificacao;
    property Fdescricao: string read getFFdescricao write SetFFdescricao;
    property Fobservacao: string read getFFobservacao write SetFFobservacao;
    property FTipoLancamento: string read getFFTipoLancamento write SetFFTipoLancamento;
    property FdataRegistro: TDateTime read getFFdataRegistro write setFFdataRegistro;
    property FdataMovimento: TDateTime read getFFdataMovimento write SetFFdataMovimento;
    property Fvalor: Currency read getFFvalor write setFFvalor;
                                                                      }


      Constructor Create;

  end;

implementation

{ TCBDebitoModel }

constructor TCBDebitoModel.Create;
begin
  ///ver
end;

function TCBDebitoModel.getFFdataMovimento: TDateTime;
begin
 Result := FFdataMovimento;
end;

function TCBDebitoModel.getFFDataRegistro: TDateTime;
begin
  Result := FFdataRegistro;
end;

function TCBDebitoModel.getFFdescricao: string;
begin
   Result := FFdescricao;
end;

function TCBDebitoModel.getFFID: string;
begin
    Result := FFID;
end;

function TCBDebitoModel.getFFIDcontaBancaria: string;
begin
     Result := FFIDcontaBancaria;
end;

function TCBDebitoModel.getFFIDcontaBancariaCheque: string;
begin
   Result := FFIDcontaBancariaCheque;
end;

function TCBDebitoModel.getFFIdentificacao: string;
begin
    Result := FFIdentificacao;
end;

function TCBDebitoModel.getFFIDloteContabil: string;
begin
    Result := FFIDloteContabil;
end;

function TCBDebitoModel.getFFIDorganizacao: string;
begin
   Result := FFIDorganizacao;
end;

function TCBDebitoModel.getFFIDResponsavel: string;
begin
    Result := FFIDResponsavel;
end;

function TCBDebitoModel.getFFIDTituloPagar: string;
begin
  Result := FFIDTituloPagar;
end;

function TCBDebitoModel.getFFIDTOB: string;
begin
    Result := FFIDTOB;
end;

function TCBDebitoModel.getFFIDusuario: string;
begin
     Result := FFIDusuario;
end;

function TCBDebitoModel.getFFobservacao: string;
begin
    Result := FFobservacao;
end;

function TCBDebitoModel.getFFOrganizacao: TOrganizacaoModel;
begin
   Result := FFOrganizacao;
end;

function TCBDebitoModel.getFFTipoLancamento: string;
begin
   Result := FFTipoLancamento;
end;

function TCBDebitoModel.getFFvalor: Currency;
begin
     Result := FFvalor;
end;

procedure TCBDebitoModel.setFFdataMovimento(const Value: TDateTime);
begin
   FFdataMovimento := Value;
end;

procedure TCBDebitoModel.setFFdataRegistro(const Value: TDateTime);
begin
      FFdataRegistro := Value;
end;

procedure TCBDebitoModel.setFFdescricao(const Value: string);
begin
      FFdescricao := Value;
end;

procedure TCBDebitoModel.setFFID(const Value: string);
begin
      FFID := Value;
end;

procedure TCBDebitoModel.setFFIDcontaBancaria(const Value: string);
begin
     FFIDcontaBancaria := Value;
end;

procedure TCBDebitoModel.setFFIDcontaBancariaCheque(const Value: string);
begin
     FFIDcontaBancariaCheque := Value;
end;

procedure TCBDebitoModel.setFFIdentificacao(const Value: string);
begin
    FFIdentificacao := Value;
end;

procedure TCBDebitoModel.setFFIDloteContabil(const Value: string);
begin
      FFIDloteContabil := Value;
end;

procedure TCBDebitoModel.setFFIDorganizacao(const Value: string);
begin
      FFIDorganizacao := Value;
end;

procedure TCBDebitoModel.setFFIDResponsavel(const Value: string);
begin
      FFIDResponsavel := Value;
end;

procedure TCBDebitoModel.setFFIDTituloPagar(const Value: string);
begin
    FFIDTituloPagar := Value;
end;

procedure TCBDebitoModel.setFFIDTOB(const Value: string);
begin
      FFIDTOB := Value;
end;

procedure TCBDebitoModel.setFFIDusuario(const Value: string);
begin
     FFIDusuario := Value;
end;

procedure TCBDebitoModel.setFFobservacao(const Value: string);
begin
      FFobservacao := Value;
end;

procedure TCBDebitoModel.SetFForganizacao(const Value: TOrganizacaoModel);
begin
      FFOrganizacao := Value;
end;

procedure TCBDebitoModel.setFFTipoLancamento(const Value: string);
begin
     FFTipoLancamento := Value;
end;

procedure TCBDebitoModel.setFFvalor(const Value: Currency);
begin
 FFvalor := Value;
end;

end.
