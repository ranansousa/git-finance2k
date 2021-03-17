unit uFrmImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, udmConexao, uFrmPendentes, uUtil, uDMImport,
  uDMContasReceber,uDMContaBancariaCreditoConsulta, uFrameProgressBar, EMsgDlg;

type
  TfrmImportar = class(TForm)
    lblStatusExport: TLabel;
    edtFileExport: TLabeledEdit;
    Memo1: TMemo;
    btnLocateExport: TBitBtn;
    btnCheckExport: TBitBtn;
    btnExportar: TBitBtn;
    btnPendentes: TBitBtn;
    dlgOrigem: TOpenDialog;
    statusBarImporta: TStatusBar;
    lblPrincipal: TLabel;
    btnDeletAll: TBitBtn;
    framePB1: TframePB;
    btnFechar: TBitBtn;
    PempecMsg: TEvMsgDlg;
    procedure btnLocateExportClick(Sender: TObject);
    procedure btnCheckExportClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnPendentesClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeletAllClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);

  private
    { Private declarations }
    arq: TextFile; { declarando a vari�vel "arq" do tipo arquivo texto }
     qtdRegistros : Integer;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }
  end;

var
  frmImportar: TfrmImportar;

implementation

{$R *.dfm}

procedure TfrmImportar.btnCheckExportClick(Sender: TObject);
var
  aux, linha: string;
  indx: integer;

begin
 qtdRegistros :=0;
 framePB1.Visible := True;
  Memo1.Clear;
  lblStatusExport.Visible := True;
  lblStatusExport.Caption := 'Analisando o arquivo selecionado. Aguarde...';

  if edtFileExport.Text = '' then
  begin
    ShowMessage('Sem arquivo para analisar');
  end;

  // [ 1 ] Associa a vari�vel do programa "arq" ao arquivo externo "tabuada.txt"
  // na unidade de disco "d"
  AssignFile(arq, edtFileExport.Text);

{$I-}         // desativa a diretiva de Input
  Reset(arq); // [ 3 ] Abre o arquivo texto para leitura
{$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) // verifica o resultado da opera��o de abertura
  then
    Memo1.Lines.Add('Erro na abertura do arquivo !!!')
  else
  begin
    // [ 11 ] verifica se o ponteiro de arquivo atingiu a marca de final de arquivo
    indx := 0;
    framePB1.Visible :=True;
    lblStatusExport.Caption := 'Arquivo sendo processado';
    statusBarImporta.Panels[1].Text :=
      'Cuidado. Opera��o irrevers�vel. Fa�a backup antes.';
   Memo1.Lines.Add('Contando as linhas existentes');
      Sleep(2000);
    while (not eof(arq)) do
    begin
      readln(arq, linha);
                      if not(linha = 'Committ Work;') then
                      begin
                        if not(linha = '') then
                        begin
                            indx := indx + 1;
                        end;
                      end;
    end;
    qtdRegistros := indx;
    Memo1.Lines.Add('Total de linhas ' + IntToStr(qtdRegistros) );
     Sleep(2000);
   //fim da contagem

   Memo1.Lines.Add('Processo de an�lise iniciado...');

   while (not eof(arq)) do
    begin
      readln(arq, linha);
      indx := 0;
      Memo1.Lines.Add(linha);
      if not(linha = '') then
      begin
        indx := indx + 1;
        if (linha.Length > 0) then
        begin
          aux := linha;
        end;
      end;

      framePB1.progressBar(1, qtdRegistros);
      Application.ProcessMessages;
    end;
    framePB1.lblProgressBar.Visible :=True;
    framePB1.lblProgressBar.Caption := 'Processo conclu�do...';
    CloseFile(arq); // [ 8 ] Fecha o arquivo texto aberto
  end;
  lblStatusExport.Caption := 'Arquivo analisado com sucesso.';
  Memo1.Clear;
  Memo1.Lines.Add('Foram encontradas  ' + indx.ToString +
    '  linhas poss�veis de exporta��o.');

  btnExportar.Enabled := True;

end;

procedure TfrmImportar.btnDeletAllClick(Sender: TObject);
begin
    if MessageDlg('Deseja mesmo DELETAR todos os pendentes?', mtConfirmation,
              [mbYes, mbNo], 0) = mrYes then
begin

  if (dmContasReceber.deletePendentesAll(TOrgAtual.getId)) then
  begin
    ShowMessage('Titulos pendentes deletados com sucesso.');
  end
  else
  begin
    ShowMessage('N�o foi poss�vel deletes os Titulos.');
  end;
end;

end;

procedure TfrmImportar.btnExportarClick(Sender: TObject);
var
  QueryTPS: TFDQuery;
  cmdSql, linha, comando: String;
  indx: integer;

begin

    framePB1.lblProgressBar.Visible :=False;
    btnCheckExport.Enabled := false;
    Memo1.Clear;
    AssignFile(arq, edtFileExport.Text);


    if edtFileExport.Text = '' then
    begin
      PempecMsg.MsgInformation('Sem arquivo para exportar');
    end;



{$I-}         // desativa a diretiva de Input
  Reset(arq); // [ 3 ] Abre o arquivo texto para leitura
{$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) // verifica o resultado da opera��o de abertura
  then
    Memo1.Lines.Add('Erro na abertura do arquivo !!!')
  else
  begin
    indx := 0;      { pegar a qtd de registro do arquivo   }

    lblStatusExport.Caption := 'Arquivo sendo preparado para exporta��o';
    while (not eof(arq)) do
    begin
     //  qtdRegistros := qtdRegistrosFile( arq);
      lblStatusExport.Caption := 'Importa��o iniciada...';
      readln(arq, linha); // [ 6 ] L� uma linha do arquivo
      Memo1.Lines.Add('Importando...');
      try
        if not(linha = 'Committ Work;') then
        begin
          if not(linha = '') then
          begin
            cmdSql := linha;

            if (dmImport.insereTRPorImportacao(cmdSql) = 0) then
                begin

                  framePB1.progressBar(1, qtdRegistros);
                  indx := indx + 1;
                  Memo1.Clear;
                  Memo1.Lines.Add('Processando a solicita��o atual de n�mero  ' + indx.ToString() + ' de ' + IntToStr(qtdRegistros));
                 statusBarImporta.Panels[1].Text := 'Foram exportados  ' + indx.ToString() + ' registros.';


                  Application.ProcessMessages;
            end;
          end;
        end;

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak +
            'Problemas com Importa��o. Erro: 1015');
      end;


    end;

    CloseFile(arq); // [ 8 ] Fecha o arquivo texto aberto
  end;


   framePB1.lblProgressBar.Visible :=True;
   framePB1.lblProgressBar.Caption := 'Processo conclu�do...';

  lblStatusExport.Caption := 'Arquivo analisado com sucesso.';
  // 'Foram encontrados  ' + indx.ToString + '  registros .'   ;
  Memo1.Clear;
  Memo1.Lines.Add('Foram encontradas  ' + indx.ToString +
    '  linhas poss�veis de exporta��o.');
  btnExportar.Enabled := false;
  Memo1.Clear;

  Memo1.Lines.Add('Verificando os rateios  ' );






end;


procedure TfrmImportar.btnFecharClick(Sender: TObject);
begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmImportar.btnLocateExportClick(Sender: TObject);
begin
  if dlgOrigem.Execute then
  begin
    edtFileExport.Text := dlgOrigem.FileName;
    btnCheckExport.Enabled := True;

  end;
end;

procedure TfrmImportar.btnPendentesClick(Sender: TObject);

begin

  try
    if (dmContasReceber.obterTRPendentesImportados(TOrgAtual.getId)) then
    begin


      if not dmContasReceber.dataSourceIsEmpty
        (dmContasReceber.dtsPendentesImportados) then

        btnDeletAll.Enabled := True; // libera possibilidade de deletar todos


      begin

        frmPendentes := TfrmPendentes.Create(Self);
        frmPendentes.ShowModal;
        FreeAndNil(frmPendentes);
      end;

    end
    else
    begin
      ShowMessage('N�o existem titulos pendentes a serem listados.');
    end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak +
        'Contate o administrador! Erro: 1020');
  end;

  { if frmPendentes = nil then
    frmPendentes.ShowModal;
    freeAndNilDM(Self); }

end;

procedure TfrmImportar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freeAndNilDM(Self);
  Action := caFree; // sempre como ultimo comando
end;

procedure TfrmImportar.FormCreate(Sender: TObject);
begin

  inicializarDM(Self);
  LimpaTela(Self);
  btnExportar.Enabled := false;
  btnDeletAll.Enabled := false;
  btnCheckExport.Enabled := false;
  lblPrincipal.Caption := 'IMPORTA��O TITULOS A RECEBER ';

  framePB1.Visible := False;
  framePB1.lblProgressBar.Visible :=False;
  qtdRegistros := 0;
  framePB1.progressBar(1, 100);



end;

procedure TfrmImportar.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

  dmConexao.conectarBanco;

  if not(Assigned(dmImport)) then
  begin
    dmImport := TdmImport.Create(Self);
  end;

  if not(Assigned(dmContasReceber)) then
  begin
    dmContasReceber := TdmContasReceber.Create(Self);
  end;

  if not(Assigned(dmCBCConsulta)) then
  begin
    dmCBCConsulta := TdmCBCConsulta.Create(Self);
  end;



end;

procedure TfrmImportar.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmImport)) then
  begin
    FreeAndNil(dmImport);
  end;

  if (Assigned(dmConexao)) then
  begin
    FreeAndNil(dmConexao);
  end;

  if (Assigned(dmContasReceber)) then
  begin
    FreeAndNil(dmContasReceber);
  end;

  if (Assigned(dmCBCConsulta)) then
  begin
    FreeAndNil(dmCBCConsulta);
  end;

end;




end.
