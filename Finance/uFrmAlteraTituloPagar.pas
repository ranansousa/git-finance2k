unit uFrmAlteraTituloPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,uDMContasPagar,uDMContasPagarManter,uDMContasPagarDTS,
  Vcl.StdCtrls;

type
  TfrmAlteraNumDocTP = class(TForm)
    btnConsulta: TButton;
    dbgrdTP: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmAlteraNumDocTP: TfrmAlteraNumDocTP;

implementation

{$R *.dfm}


procedure TfrmAlteraNumDocTP.btnConsultaClick(Sender: TObject);
begin
dbgrdTP.DataSource.DataSet.Next;
dbgrdTP.Refresh;

ShowMessage('Dados atualizados com sucesso');

end;

procedure TfrmAlteraNumDocTP.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
end;

procedure TfrmAlteraNumDocTP.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmContasPagarManter)) then
  begin
    dmContasPagarManter := TdmContasPagarManter.Create(Self);
  end ;

   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end ;

   if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end  ;

  if not(Assigned(dmContasPagarDTS)) then
  begin
    dmContasPagarDTS := TdmContasPagarDTS.Create(Self);
  end  ;

end;

end.