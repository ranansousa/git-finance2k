unit uDMContasPagarDTS;

interface

uses
  System.SysUtils, System.Classes, Data.DB,uDMContasPagar;

type
  TdmContasPagarDTS = class(TDataModule)
    dtsTituloReceber: TDataSource;
    dtsTituloPagar: TDataSource;
    dtsCentroCusto: TDataSource;
    dtsHistoricoTR: TDataSource;
    dtsCentroCustoTR: TDataSource;
    dtsHistorico: TDataSource;
    dtsTituloPagarExcel: TDataSource;
  private
    { Private declarations }
        procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
  end;

var
  dmContasPagarDTS: TdmContasPagarDTS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



{ TdmContasPagarDTS }

procedure TdmContasPagarDTS.inicializarDM(Sender: TObject);
begin

   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end ;



end;

end.
