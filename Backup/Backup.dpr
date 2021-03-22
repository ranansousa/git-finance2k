program Backup;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uBackup in 'uBackup.pas' {FrmBackup},
  uPendentes in 'uPendentes.pas' {FPendentes},
  uRelPagamentos in 'uRelPagamentos.pas' {FRelPagamentos},
  udmConexao in 'udmConexao.pas' {dmConexao: TDataModule},
  uDMContasPagar in 'uDMContasPagar.pas' {DataModule1: TDataModule},
  uDMOrganizacao in 'uDMOrganizacao.pas' {dmOrganizacao: TDataModule},
  uUtil in 'util\uUtil.pas',
  UCriptografia in 'util\UCriptografia.pas',
  uMensagens in 'util\uMensagens.pas',
  UVarGlobais in 'util\UVarGlobais.pas',
  uDMMegaContabil in 'uDMMegaContabil.pas' {dmMegaContabil: TDataModule},
  uDmExportaFinance in 'uDmExportaFinance.pas' {dmExportaFinance: TDataModule},
  uLogin in 'uLogin.pas' {frmLogin},
  USeletor in 'USeletor.pas' {Form1},
  uDMRelatorioExportacaoMega in 'uDMRelatorioExportacaoMega.pas' {dmRelExportacaoMega: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Silver');
  Application.Title := 'Pempec Enterprise Backup ';
  Application.CreateForm(TFrmBackup, FrmBackup);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.