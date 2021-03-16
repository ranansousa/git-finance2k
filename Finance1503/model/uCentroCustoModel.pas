unit uCentroCustoModel;

interface

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

 type
  TCentroCustoModel = class(TObject)

  private

    FFID: string;
    FFIDorganizacao: string;
    FFDescricao: string;
    FFOrganizacao: TOrganizacaoModel;
    FFCodigo :Integer;
    FFSigla :string;
    FFnovo : Boolean;

    function getFFOrganizacao: TOrganizacaoModel;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFDescricao: string;
    function getFFSigla: string;
    function getFFCodigo: Integer;

    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFDescricao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure setFFSigla(const Value: string);
    procedure setFFCodigo(const Value: Integer);


  public

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property FDescricao: string read getFFDescricao write SetFFDescricao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;
    property FSigla: string read getFFSigla write setFFSigla;
    property FCodigo: Integer read getFFCodigo write setFFCodigo;
    property Fnovo :Boolean                         read FFnovo                write FFnovo      ; //define se � novo ou j� existe.




  Constructor Create;


  end;

implementation

{ TCentroCustoModel }

constructor TCentroCustoModel.Create;
begin
  //ver
end;

function TCentroCustoModel.getFFCodigo: Integer;
begin
 Result := FFCodigo;
end;

function TCentroCustoModel.getFFDescricao: string;
begin
  Result := FFDescricao;
end;

function TCentroCustoModel.getFFID: string;
begin
 Result := FFID;

end;

function TCentroCustoModel.getFFIDorganizacao: string;
begin
 Result := FFIDorganizacao;

end;

function TCentroCustoModel.getFFOrganizacao: TOrganizacaoModel;
begin
 Result := FFOrganizacao;

end;

function TCentroCustoModel.getFFSigla: string;
begin
 Result := FFSigla;

end;

procedure TCentroCustoModel.setFFCodigo(const Value: Integer);
begin
   FFCodigo :=Value;
end;

procedure TCentroCustoModel.setFFDescricao(const Value: string);
begin
     FFDescricao :=Value;
end;

procedure TCentroCustoModel.setFFID(const Value: string);
begin
     FFID :=Value;
end;

procedure TCentroCustoModel.setFFIDorganizacao(const Value: string);
begin
     FFIDorganizacao :=Value;
end;

procedure TCentroCustoModel.setFFSigla(const Value: string);
begin
   FFSigla :=Value;
end;

procedure TCentroCustoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
     FFOrganizacao :=Value;
end;

end.

