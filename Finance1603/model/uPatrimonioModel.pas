unit uPatrimonioModel;

interface

uses
  Windows, Messages, Classes, SysUtils;

type
  TPatrimonioModel = class(TObject)
  private
    FFIDorganizacao :string;

    FFEMPRESA: Integer;
    FFGRUPO: Integer;
    FFCODIGO: Integer;
    FFDATAAQ: TDate;
    FFVALORAQ: Currency;
    FFTIPO, FFDESCRICAO, FFCTDESTCM, FFCTDESTDP, FFCTPARTCM, FFCTPARTDP: string;
    FFCTDESTCM_LEI11638, FFCTPARTCM_LEI11638, FFCTDESTDP_LEI11638, FFCTPARTDP_LEI11638: string;


    function getFFEMPRESA: Integer;
    function getFFGRUPO: Integer;
    function getFFCODIGO: Integer;
    function getFFIDorganizacao: string;

    procedure SetFCODIGO(const Value: Integer);
    procedure SetFEMPRESA(const Value: Integer);
    procedure SetFGRUPO(const Value: Integer);
    procedure SetFIDorganizacao(const Value: string);


  public

   property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
   property FEMPRESA: Integer read getFFEMPRESA write SetFEMPRESA;
   property FGRUPO: Integer read getFFGRUPO write SetFGRUPO;
   property FCODIGO: Integer read getFFCODIGO write SetFCODIGO;



end;



implementation



{ TPatrimonioModel }

function TPatrimonioModel.getFFCODIGO: Integer;
begin
  Result := FFCODIGO;
end;

function TPatrimonioModel.getFFEMPRESA: Integer;
begin
    Result := FFEMPRESA;
end;

function TPatrimonioModel.getFFGRUPO: Integer;
begin
  Result := FFGRUPO;

end;

function TPatrimonioModel.getFFIDorganizacao: string;
begin
   Result := FFIDorganizacao;
end;



procedure TPatrimonioModel.SetFCODIGO(const Value: Integer);
begin
 FFCODIGO := Value;
end;

procedure TPatrimonioModel.SetFEMPRESA(const Value: Integer);
begin
   FFEMPRESA := Value;
end;

procedure TPatrimonioModel.SetFGRUPO(const Value: Integer);
begin
   FFGRUPO := Value;
end;

procedure TPatrimonioModel.SetFIDorganizacao(const Value: string);
begin
   FFIDorganizacao := Value;
end;

end.

