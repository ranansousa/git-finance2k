unit uFrmManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Generics.Collections,
  System.Classes, Vcl.Graphics, udmConexao,System.DateUtils,System.Math, uTituloPagarCentroCustoDAO,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  uUTil, Data.DB,uConstantes,
  FireDAC.Stan.Param,  uFrmAlteraTituloPagar,
  FireDAC.Comp.DataSet, uTituloPagarDAO, uTituloPagarModel,
  FireDAC.Comp.Client, Vcl.DBGrids, uFrameOrganizacoes,
  uTPBaixaModel, uTPBaixaDAO,

  uFrameBDTables, uFrameProgressBar, uFramePeriodo, Vcl.ExtCtrls, EMsgDlg,
  cxGraphics, cxControls,
  dxStatusBar, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids;

type
  TfrmManutencao = class(TForm)
    pgcAjustes: TPageControl;
    tbsTP: TTabSheet;
    tbsTR: TTabSheet;
    btnDeletarExcluidos: TBitBtn;
    dbgrdMain: TDBGrid;
    dsPreencheGrid: TDataSource;
    tsTabelas: TTabSheet;
    frameOrgs: TframeOrg;
    frameBDTables: TfrmBDTables;
    btn1: TButton;
    lbl1: TLabel;
    qryQtdRegistros: TFDQuery;
    dbgrd2: TDBGrid;
    lbl2: TLabel;
    ds2: TDataSource;
    btnAjustaDataEmissaoTP: TButton;
    qryTodosTP: TFDQuery;
    qryAjustaDataEmissao: TFDQuery;
    qryDeletaTP: TFDQuery;
    FDSDeletaTP: TFDStoredProc;
    qryObterFilhosTP: TFDQuery;
    qryRemoveFilhoTP: TFDQuery;
    qryObterRateioHistorico: TFDQuery;
    qryAjustaHistorico: TFDQuery;
    lblQryRecordCount: TLabel;
    qryObterRateioCC: TFDQuery;
    tsAjustaRateios: TTabSheet;
    frmPeriodo1: TfrmPeriodo;
    qryObterTodosTPPeriodo: TFDQuery;
    dbgrd1: TDBGrid;
    dsRateio: TDataSource;
    lbl3: TLabel;
    dbgrd3: TDBGrid;
    dsGridTR: TDataSource;
    qryObterTodosTRPeriodo: TFDQuery;
    pnlAjustaTP: TPanel;
    pnlAjustaTR: TPanel;
    qryAjustaRateioCC: TFDQuery;
    qryInsereHistorico: TFDQuery;
    qryObterBaixaBCO: TFDQuery;
    qryAjustaData: TFDQuery;
    btnAjustaDATAPAGTOTP: TButton;
    lbl4: TLabel;
    tsCedente: TTabSheet;
    btnLimparEnd: TBitBtn;
    qryObterEnderecos: TFDQuery;
    qryObterCedentePorEndereco: TFDQuery;
    qryDeletaEndereco: TFDQuery;
    qryObterSacadoPorEndereco: TFDQuery;
    framePB1: TframePB;
    qryObterFuncionarioPorEndereco: TFDQuery;
    btnFechar: TBitBtn;
    ts1: TTabSheet;
    tsMovimentoDiario: TTabSheet;
    btnLimpaMovDiario: TBitBtn;
    frmPeriodo2: TfrmPeriodo;
    qryObterTPPVazio: TFDQuery;
    btnAjustaRegistroProvisao: TButton;
    qryAjustaRP: TFDQuery;
    btnAjustaValorBaixa: TButton;
    btnAlteraNumeroDoc: TButton;
    PempecMsg: TEvMsgDlg;
    dxStatusBar: TdxStatusBar;
    tbsCentroCusto: TTabSheet;
    framePeriodoCC: TfrmPeriodo;
    dbgTPB: TDBGrid;
    dbgCC: TDBGrid;
    dsTPB: TDataSource;
    btnTodosTPB: TBitBtn;
    qryObterTodosTPB: TFDQuery;
    dsTPBCC: TDataSource;
    btnAjustaTPBCC: TBitBtn;
    procedure btnDeletarExcluidosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterNumDocClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure tsTabelasShow(Sender: TObject);
    procedure frameBDTablesds1DataChange(Sender: TObject; Field: TField);
    procedure btnAjustaDataEmissaoTPClick(Sender: TObject);
    procedure btnAjustaRateiosClick(Sender: TObject);
    procedure pnlAjustaTPClick(Sender: TObject);
    procedure pnlAjustaTRClick(Sender: TObject);
    procedure btnAjustaDATAPAGTOTPClick(Sender: TObject);
    procedure btnLimparEndClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimpaMovDiarioClick(Sender: TObject);
    procedure btnAjustaRegistroProvisaoClick(Sender: TObject);
    procedure btnAjustaValorBaixaClick(Sender: TObject);
    procedure btnAlteraNumeroDocClick(Sender: TObject);
    procedure btnTodosTPBClick(Sender: TObject);
    procedure dsTPBDataChange(Sender: TObject; Field: TField);
    procedure btnAjustaTPBCCClick(Sender: TObject);

  private
    { Private declarations }
    idOrganizacao: String;
    procedure inicializarDM(Sender: TObject);
    procedure ObterQtdRegistro(pTable : string);
    function ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
    function obterFilhosPorTP(pIdOrganizacao,pIdTP :string): boolean;
    function removeFilhosTP(pIdOrganizacao,pIdTPFilho :string): boolean;

    function AjustarDataEmissaoTP(query :TFDQuery):boolean;
    function AjustarValorPagoTP(query :TFDQuery):boolean;

    function AjustaDataPagamentoTitulo(pTable :string; query :TFDQuery):boolean;

    function obterRateioHistorico(pIdOrganizacao,pIdTP, pTable :string): Integer;
    function obterRateioCC(pIdOrganizacao, pIdTP, pTable: string): Integer;
    function obterBaixaBanco(pIdOrganizacao,pIdTP, pTable :string): Boolean;

    function deletaTP(pIdOrganizacao,pID :string) :boolean;

    function ObterTodosTitulosPagarPeriodo(pIdOrganizacao: string; pDataInicio,   pDataFinal: Tdate): Boolean;
    function ObterTodosTitulosReceberPeriodo(pIdOrganizacao: string; pDataInicio,   pDataFinal: Tdate): Boolean;

    function AjustarValorRateioTP(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
    function AjustarValorRateioTR(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
    function insereHistorico(pIdOrganizacao, pIdTP, pIdHistorico,  pTable: string ; pValor :Currency): Boolean;

   ///LIMPAR TABELA ENDERECO
    function obterEndereco (pOrganizacao :string) : Boolean;
    function obterCedentePorEndereco(pOrganizacao, pEndereco: string): Integer;
    function obterSacadoPorEndereco(pOrganizacao, pEndereco: string): Integer;
    function obterFuncionarioPorEndereco(pOrganizacao, pEndereco: string): Integer;
    procedure limparTabelaEndereco;
    function AjustaRegistroProvisao(pTable: string; query: TFDQuery): boolean;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    function calculaTempoRestante(pQtd, pRecno: Integer): Integer;
    function obterSomaPorCampo(pCampo: string; var pQuery: TFDQuery): Currency;



  public
    { Public declarations }
  end;

var
  frmManutencao: TfrmManutencao;

implementation

{$R *.dfm}
{ TfrmManutencao }

function TfrmManutencao.AjustarValorRateioTR(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
var
 pBarra, qtdCC, qtdHistorico :Integer;
sqlAjusta, labelMSG,  idTR, idHistorico :string;
pValorHist, pValorCC,  pValor :Currency;
alterarCC, alterarHistorico :Boolean;
begin
    qtdHistorico:=0;
    qtdCC :=0;
    pValor := 0;
    pValorCC :=0;
    framePB1.Visible :=True;
    alterarCC :=False;
    alterarHistorico := False;

    if not (ObterTodosTitulosReceberPeriodo(pIdOrganizacao, pDataInicio, pDataFinal)) then begin

       ShowMessage('Não existem  titulos para o período informado');

    end;

    framePB1.progressBar(0,Trunc(qryObterTodosTRPeriodo.RecordCount));
    lblQryRecordCount.Caption       := 'Existem ' + IntToStr(qryObterTodosTRPeriodo.RecordCount) + ' a serem ajustados ' ;
    framePB1.lblProgressBar.Caption := 'Existem ' + IntToStr(qryObterTodosTRPeriodo.RecordCount) + ' a serem ajustados ' ;


      try
         qryObterTodosTRPeriodo.Open();
         qryObterTodosTRPeriodo.Last;
         qryObterTodosTRPeriodo.First;
        while not (qryObterTodosTRPeriodo.Eof) do begin

          msgStatusBar(2, 'TIT. RECEBER');
          msgStatusBar(3, ' Tempo aproximado : ' + IntToStr(calculaTempoRestante(qryObterTodosTRPeriodo.RecordCount, qryObterTodosTRPeriodo.RecNo)) + ' minuto(s).');

          qtdHistorico :=0;
          qtdCC :=0;
          idTR := qryObterTodosTRPeriodo.FieldByName('ID_TITULO_RECEBER').AsString;


          qtdHistorico := obterRateioHistorico(idOrganizacao, idTR, 'TITULO_RECEBER');
          qtdCC        := obterRateioCC(idOrganizacao, idTR, 'TITULO_RECEBER');
          pValor       := qryObterTodosTRPeriodo.FieldByName('VALOR_NOMINAL').AsCurrency;
          idHistorico  := qryObterTodosTRPeriodo.FieldByName('ID_HISTORICO').AsString;

          lbl4.Caption := 'Registro atual Nº ' + IntToStr(qryObterTodosTRPeriodo.RecNo) + '  DOC ' +  qryObterTodosTRPeriodo.FieldByName('NUMERO_DOCUMENTO').AsString;
          Application.ProcessMessages;

             // PARTE DO AJUSTE DO RATEIO DE HISTORICOS

              if qtdHistorico = 0 then begin
               //inserir o historico principal
                try
                insereHistorico(idOrganizacao,idTR,idHistorico,'TITULO_RECEBER', pValor ) ;

                except
                    raise Exception.Create('Não foi possível ajustar o histórico do TR ' + idTR );
                end;

              end;


              if qtdHistorico >0 then begin
                 try

                  while not qryObterRateioHistorico.Eof do begin

                    if (qtdHistorico = 1) then begin

                        pValorHist := qryObterRateioHistorico.FieldByName('VALOR').AsCurrency;
                        if pValorHist <> pValor then
                        begin
                          alterarHistorico := True;
                        end;
                    end;

                     if (alterarHistorico)  then begin
                      sqlAjusta := ' UPDATE titulo_receber_historico TPH ' +
                                   ' SET TPH.valor = :PVALOR ' +
                                   ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPH.ID_TITULO_RECEBER = :PIDTR) ' ;


                       qryAjustaHistorico.Close;
                       qryAjustaHistorico.Connection := dmConexao.conn;
                       qryAjustaHistorico.SQL.Clear;
                       qryAjustaHistorico.SQL.Add(sqlAjusta);
                       qryAjustaHistorico.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaHistorico.ParamByName('PIDTR').AsString := idTR;
                       qryAjustaHistorico.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdHistorico);

                       qryAjustaHistorico.ExecSQL;
                       qryAjustaHistorico.Connection.CommitRetaining;

                     end;

                       qryObterRateioHistorico.Next;

                  end;

                 except
                  qryAjustaHistorico.Connection.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o histórico do TP  ' + idTR );

                 end;
              end;


               // PARTE DO AJUSTE DO RATEIO DE CENTRO DE CUSTOS


              if qtdCC > 0 then begin
                 try

                  while not qryObterRateioCC.Eof do begin

                    if (qtdCC = 1) then begin

                        pValorCC := qryObterRateioCC.FieldByName('VALOR').AsCurrency;
                        if pValorCC <> pValor then
                        begin
                          alterarCC := True;
                        end;
                    end;


                     if (alterarCC)  then begin

                      sqlAjusta := ' UPDATE titulo_receber_rateio_cc TPC ' +
                                   ' SET TPC.valor = :PVALOR ' +
                                   ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPC.ID_TITULO_RECEBER = :PIDTP)';

                       qryAjustaRateioCC.Close;
                       qryAjustaRateioCC.Connection := dmConexao.conn;
                       qryAjustaRateioCC.SQL.Clear;
                       qryAjustaRateioCC.SQL.Add(sqlAjusta);
                       qryAjustaRateioCC.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaRateioCC.ParamByName('PIDTP').AsString := idTR;
                       qryAjustaRateioCC.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdCC);
                       qryAjustaRateioCC.ExecSQL;
                       qryAjustaRateioCC.Connection.CommitRetaining;


                     end;


                       qryObterRateioCC.Next;

                  end;

                 except
                  dmConexao.conn.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o histórico do TP  ' + idTR );

                 end;
              end;

           qryObterTodosTRPeriodo.Next;

           pBarra := qryObterTodosTRPeriodo.RecNo;
          //parte da barra de progresso
          labelMSG := 'Processando os valores dos rateios  do registro ' + IntToStr(pBarra) + ' de ' + IntToStr(qryObterTodosTRPeriodo.RecordCount);
          framePB1.progressBar(1, Trunc(qryObterTodosTRPeriodo.RecordCount ) );
          framePB1.lblProgressBar.Caption := labelMSG;
          Application.ProcessMessages;

        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;

       dmConexao.Conn.CommitRetaining;


    Result :=System.True;

end;



function TfrmManutencao.AjustarValorPagoTP(query: TFDQuery): boolean;
var
  qtd :Integer;
  tituloUP : TTituloPagarModel;
  baixa : TTPBaixaModel;
begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(1, query.RecordCount);
    Application.ProcessMessages;
     PempecMsg.MsgWarning('Rotina em análise...');
     //rever ossp
     // a data de emissao nao pode ser sempre a data de registro
     { suspenso em 12/06 8h. o valor nominal do titulo nao pode ser igual ao valor pago pq dos AC e DE

      try

        query.Open();
        dbgrdMain.DataSource.DataSet := query;
        query.Last;
        query.First;


        while not (query.Eof) do begin
                  qtd :=qtd + 1;

                  tituloUP                := TTituloPagarModel.Create;
                  tituloUP.FIDorganizacao := query.FieldByName('ID_ORGANIZACAO').AsString;
                  tituloUP.FID            := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  tituloUP                := TTituloPagarDAO.obterPorID(tituloUP);


                  if not uutil.Empty(tituloUP.FID) then
                  begin
                     baixa := TTPBaixaModel.Create;
                     baixa.FIDorganizacao := tituloUP.FIDorganizacao;
                     baixa.FIDtituloPagar := tituloUP.FID;
                     baixa.FTituloPagar   := tituloUP;


                     baixa := TTPBaixaDAO.obterPorTP(baixa);

                      if baixa <> nil then
                      begin

                        if not uUTil.Empty(baixa.FID) then
                        begin

                          if tituloUP.FvalorNominal <> baixa.FvalorPago then
                          begin
                            tituloUP.FvalorNominal := baixa.FvalorPago;

                            TTituloPagarDAO.Update(tituloUP);

                          end;

                        end;

                      end;
                    end;

                  query.Next;

            framePB1.progressBar(1, query.RecordCount);
            if(qtd mod 2 = 0) then begin
              Application.ProcessMessages;
            end;
        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar valor dos Titulos ');

      end;

       dmConexao.Conn.CommitRetaining;
       ShowMessage('Processo concluído...');  }

    Result :=System.True;

end;

function TfrmManutencao.calculaTempoRestante(pQtd, pRecno :Integer) : Integer;
var
tempo : Integer;
begin
 tempo := Round((pQtd - pRecno) / 300);

 tempo := tempo +1;

 Result := tempo;

end;



function TfrmManutencao.AjustarValorRateioTP(pIdOrganizacao: string; pDataInicio, pDataFinal: Tdate): Boolean;
var
tempo, pBarraPercent, pBarra, qtdCC, qtdHistorico :Integer;
idHistorico, sqlAjusta, labelMSG,  idTP :string;
pValorHist, pValorCC,  pValor :Currency;
alterarCC, alterarHistorico :Boolean;
begin
    qtdHistorico:=0;
    tempo :=0;
    qtdCC :=0;
    pValor := 0;
    pValorCC :=0;
    framePB1.Visible :=True;
    framePB1.progressBar(0,0);
    alterarCC :=False;
    alterarHistorico := False;
  if not (ObterTodosTitulosPagarPeriodo(pIdOrganizacao, pDataInicio, pDataFinal)) then
  begin

    raise Exception.Create('Erro ao tentar obter os titulos por periodo');

  end;

  limpaStatusBar;

    lblQryRecordCount.Caption := 'Existem ' + IntToStr(qryObterTodosTPPeriodo.RecordCount) + ' a serem ajustados. ' ;
    framePB1.lblProgressBar.Caption := 'Existem ' + IntToStr(qryObterTodosTPPeriodo.RecordCount) + ' a serem ajustados. ';


      try
         qryObterTodosTPPeriodo.Open;
         qryObterTodosTPPeriodo.Last;
         qryObterTodosTPPeriodo.First;
        while not (qryObterTodosTPPeriodo.Eof) do begin
          msgStatusBar(2, 'TIT. PAGAR');
          msgStatusBar(3, ' Tempo aproximado : ' + IntToStr(calculaTempoRestante(qryObterTodosTPPeriodo.RecordCount, qryObterTodosTPPeriodo.RecNo)) + ' minuto(s).');

          qtdHistorico :=0;
          qtdCC :=0;
          idTP := qryObterTodosTPPeriodo.FieldByName('ID_TITULO_PAGAR').AsString;




          qtdHistorico := obterRateioHistorico(idOrganizacao, idTP, 'TITULO_PAGAR');
          qtdCC        := obterRateioCC(idOrganizacao, idTP, 'TITULO_PAGAR');
          pValor       := qryObterTodosTPPeriodo.FieldByName('VALOR_NOMINAL').AsCurrency;
          idHistorico := qryObterTodosTPPeriodo.FieldByName('ID_HISTORICO').AsString;

          lbl4.Caption := 'Registro atual Nº ' + IntToStr(qryObterTodosTPPeriodo.RecNo) + '  DOC ' +  qryObterTodosTPPeriodo.FieldByName('NUMERO_DOCUMENTO').AsString;
          Application.ProcessMessages;

             // PARTE DO AJUSTE DO RATEIO DE HISTORICOS



              if qtdHistorico = 0 then begin
               //inserir o historico principal
                try
                   insereHistorico(idOrganizacao,idTP,idHistorico,'TITULO_PAGAR', pValor ) ;
                except
                   raise Exception.Create('Não foi possível ajustar o histórico do TP ' + idTP );

                end;

              end;


              if qtdHistorico >0 then begin
                 try

                  while not qryObterRateioHistorico.Eof do begin

                    if (qtdHistorico = 1) then begin

                        pValorHist := qryObterRateioHistorico.FieldByName('VALOR').AsCurrency;
                        if pValorHist <> pValor then
                        begin
                          alterarHistorico := True;
                        end;
                    end;

                     if (alterarHistorico)  then begin

                      sqlAjusta := ' UPDATE titulo_pagar_historico TPH ' +
                                   ' SET TPH.valor = :PVALOR ' +
                                   ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPH.ID_TITULO_PAGAR = :PIDTP) ' ;


                       qryAjustaHistorico.Close;
                       qryAjustaHistorico.Connection := dmConexao.conn;
                       qryAjustaHistorico.SQL.Clear;
                       qryAjustaHistorico.SQL.Add(sqlAjusta);
                       qryAjustaHistorico.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaHistorico.ParamByName('PIDTP').AsString := idTP;
                       qryAjustaHistorico.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdHistorico);

                       qryAjustaHistorico.ExecSQL;
                       qryAjustaHistorico.Connection.CommitRetaining;

                     end;

                       qryObterRateioHistorico.Next;

                  end;

                 except
                  qryAjustaHistorico.Connection.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o histórico do TP  ' + idTP );

                 end;
              end;


               // PARTE DO AJUSTE DO RATEIO DE CENTRO DE CUSTOS


              if qtdCC > 0 then begin
                 try

                  while not qryObterRateioCC.Eof do begin

                    if (qtdCC = 1) then begin

                        pValorCC := qryObterRateioCC.FieldByName('VALOR').AsCurrency;
                        if pValorCC <> pValor then
                        begin
                          alterarCC := True;
                        end;
                    end;

                     if (alterarCC)  then begin

                      sqlAjusta := ' UPDATE titulo_pagar_rateio_cc TPC ' +
                                   ' SET TPC.valor = :PVALOR ' +
                                   ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                                   ' AND (TPC.ID_TITULO_PAGAr = :PIDTP)';

                       qryAjustaRateioCC.Close;
                       qryAjustaRateioCC.Connection := dmConexao.conn;
                       qryAjustaRateioCC.SQL.Clear;
                       qryAjustaRateioCC.SQL.Add(sqlAjusta);
                       qryAjustaRateioCC.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
                       qryAjustaRateioCC.ParamByName('PIDTP').AsString := idTP;
                       qryAjustaRateioCC.ParamByName('PVALOR').AsCurrency :=(pValor  / qtdCC);
                       qryAjustaRateioCC.ExecSQL;
                       qryAjustaRateioCC.Connection.CommitRetaining;
                     end;

                       qryObterRateioCC.Next;

                  end;

                 except
                  qryAjustaRateioCC.Connection.RollbackRetaining;
                  raise Exception.Create('Erro ao tentar ajustar o histórico do TP  ' + idTP );

                 end;
              end;

           qryObterTodosTPPeriodo.Next;
           pBarra := qryObterTodosTPPeriodo.RecNo;
          //parte da barra de progresso
          labelMSG := 'Processando os valores dos rateios  do registro ' + IntToStr(pBarra) + ' de ' + IntToStr(qryObterTodosTPPeriodo.RecordCount);
          framePB1.progressBar(1, Trunc(qryObterTodosTPPeriodo.RecordCount) );
          framePB1.lblProgressBar.Caption := labelMSG;
          Application.ProcessMessages;


        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;

      limpaStatusBar;

       dmConexao.Conn.CommitRetaining;

    Result :=System.True;

end;



procedure TfrmManutencao.btn1Click(Sender: TObject);
begin
frameBDTables.obterTabelas;
frameBDTables.dbgrd1.SelectedIndex :=1;
frameBDTables.dbgrd1.SetFocus;
end;

procedure TfrmManutencao.btnAjustaDataEmissaoTPClick(Sender: TObject);
begin
   btnAjustaDataEmissaoTP.Caption := 'Carregando...';
   btnAjustaDataEmissaoTP.Enabled := False;


   if( AjustarDataEmissaoTP(ObterTodosTitulosPagar(TOrgAtual.getId))) then begin
    framePB1.lblProgressBar.Visible :=True;
    framePB1.lblProgressBar.Caption := 'Processo concluído...';
   end;

   btnAjustaDataEmissaoTP.Caption := 'Ajusta TP DATA EMISSÃO';
   btnAjustaDataEmissaoTP.Enabled := True;

  end;


procedure TfrmManutencao.btnAjustaDATAPAGTOTPClick(Sender: TObject);
begin

   dmConexao.conectarBanco;
   framePB1.progressBar(0,0);
   framePB1.Visible :=True;

   lbl4.Caption := 'Ajustando datas';

  if AjustaDataPagamentoTitulo('TITULO_PAGAR', ObterTodosTitulosPagar(idOrganizacao)) then begin
    PempecMsg.MsgInformation(' Processo concluído ');
   end;


end;

procedure TfrmManutencao.btnAjustaRateiosClick(Sender: TObject);
begin
//ajusta os valores dos rateios de historico e de centro de custos
  dmConexao.conectarBanco;
  framePB1.progressBar(0,0);
    framePB1.Visible :=True;
  AjustarValorRateioTR(idOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);

end;

procedure TfrmManutencao.btnAjustaRegistroProvisaoClick(Sender: TObject);
begin

   dmConexao.conectarBanco;
   framePB1.progressBar(0,0);
   framePB1.Visible :=True;

   lbl4.Caption := 'Ajustando registros ';

   qryObterTPPVazio.Close;
   qryObterTPPVazio.Connection := dmConexao.conn;
   qryObterTPPVazio.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTPPVazio.Open;

  if AjustaRegistroProvisao('TITULO_PAGAR', qryObterTPPVazio ) then begin

    ShowMessage('Processo concluído');

   end;

end;

procedure TfrmManutencao.btnAjustaTPBCCClick(Sender: TObject);
var
titulo : TTituloPagarModel;
aux :string;
 I : Integer;
valorSalvo, valorPago,percentRateio :Currency;
sucesso : Boolean;
begin

   sucesso := False;

  framePB1.lblProgressBar.Visible :=True;


 sucesso :=  PempecMsg.MsgConfirmation('ATENÇÃO. Tem certeza que desejar alterar os registos? Não será possível reverter a operação. Faça Backup antes. ')= 6;

  aux :='';


  if sucesso  then begin


  if qryObterTodosTPB.RecordCount >0  then begin
   framePB1.lblProgressBar.Caption := 'Existem ' + IntToStr(qryObterTodosTPB.RecordCount) + ' a serem ajustados. ';
   qryObterTodosTPB.First;

    while not qryObterTodosTPB.Eof do begin
      valorPago := 0;
      valorSalvo := 0;
      titulo := TTituloPagarModel.Create;
      titulo.FIDorganizacao := uutil.TOrgAtual.getId;
      titulo.FID      := qryObterTodosTPB.FieldByName('ID').AsString;

      titulo := TTituloPagarDAO.obterPorID(titulo);


      if titulo <> nil then begin
        valorPago := qryObterTodosTPB.FieldByName('VALOR_PAGO').AsCurrency;

        if titulo.listaCustos.Count > 0 then
        begin

          for I := 0 to titulo.listaCustos.Count - 1 do
          begin
            percentRateio := RoundTo((titulo.listaCustos[I].Fvalor / titulo.FvalorNominal), -2);

            titulo.listaCustos[I].Fvalor := RoundTo( (percentRateio *  valorPago),-2);

            if I = (titulo.listaCustos.Count - 1) then
            begin

              titulo.listaCustos[I].Fvalor := valorPago - valorSalvo;

            end;

            sucesso := TTituloPagarCentroCustoDAO.Update(titulo.listaCustos[I]);

            valorSalvo := valorSalvo + titulo.listaCustos[I].Fvalor;

          end;

        end;


      end;


     qryObterTodosTPB.Next;
     msgStatusBar(3,'Processando os valores dos rateios  do registro ' + IntToStr(qryObterTodosTPB.RecNo) + ' de ' + IntToStr(qryObterTodosTPB.RecordCount));
     framePB1.progressBar(1, Trunc(qryObterTodosTPB.RecordCount) );
     framePB1.lblProgressBar.Caption := dxStatusBar.Panels[3].Text;
     Application.ProcessMessages;

    end;

  end;
  end;



end;

procedure TfrmManutencao.btnAjustaValorBaixaClick(Sender: TObject);
var
titulo : TTituloPagarModel;
begin

titulo := TTituloPagarModel.Create;
titulo.FIDorganizacao :=  idOrganizacao;
titulo.FIDTipoStatus  := 'QUITADO';

 if( AjustarValorPagoTP(TTituloPagarDAO.obterTodosPorStatus(titulo))) then begin
    framePB1.lblProgressBar.Visible :=True;
    framePB1.lblProgressBar.Caption := 'Processo concluído...';
   end;


end;


procedure TfrmManutencao.btnAlteraNumeroDocClick(Sender: TObject);
begin
 try
    frmAlteraNumDocTP := TfrmAlteraNumDocTP.Create(Self);
    frmAlteraNumDocTP.ShowModal;
    FreeAndNil(frmAlteraNumDocTP);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte.');
  end;

end;

procedure TfrmManutencao.btnAlterNumDocClick(Sender: TObject);
begin
// abre uma tela com dados do titulo a ser alterado

end;

procedure TfrmManutencao.btnDeletarExcluidosClick(Sender: TObject);
var
 gerador, idTP, tipoStatus: String;
I, aux, qtd :Integer;
listaExcluidos :TStringList;
 titulo : TTituloPagarModel;
listaTP : TObjectList<TTituloPagarModel>;
tpBaixa : TTPBaixaModel;

  {
tpBaixaDE : TTPBaixaDEModel;
tpBaixaAC :TTPBaixaACModel;
tpBaixaWWW : TTPBaixaInternetModel;
tpBaixaCheque : TTPBaixaChequeModel;
tpBaixaFP : TTPBaixaFPModel;
      }


begin

  idOrganizacao := TOrgAtual.getId;
  tipoStatus := 'EXCLUIDO';
  framePB1.Visible :=True;
  framePB1.progressBar(0,0);

  listaTP := TObjectList<TTituloPagarModel>.Create;
  listaTP.Clear;
  qtd :=0;

     TFDQuery(dbgrdMain.DataSource.DataSet).Close;
     titulo := TTituloPagarModel.Create;
             titulo.FIDorganizacao := uutil.TOrgAtual.getId;
             titulo.FIDTipoStatus :=  tipoStatus;

    dbgrdMain.DataSource.DataSet := TTituloPagarDAO.obterTodosPorStatus(titulo);

    qtd := TFDQuery(dbgrdMain.DataSource.DataSet).RecordCount;

   TFDQuery(dbgrdMain.DataSource.DataSet).Last;
   TFDQuery(dbgrdMain.DataSource.DataSet).First;

   if qtd > 0 then begin

      while not TFDQuery(dbgrdMain.DataSource.DataSet).Eof do begin
             titulo := TTituloPagarModel.Create;
             titulo.FIDorganizacao := TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_ORGANIZACAO').AsString;
             titulo.FID            := TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString;

           if not TTituloPagarDAO.existFilhos(titulo) then begin

              listaTP.Add(titulo);

           end;

           TFDQuery(dbgrdMain.DataSource.DataSet).Next;

      end;

   end;

    if listaTP.Count > 0 then begin

      for I := 0 to listaTP.Count -1  do begin
        try
           tpBaixa := TTPBaixaModel.Create;
           tpBaixa.FIDorganizacao := idOrganizacao;
           tpBaixa.FIDtituloPagar := listaTP[I].FID;
           tpBaixa :=  TTPBaixaDAO.obterPorTP(tpBaixa);

          if uutil.Empty(tpBaixa.FID) then
          begin
             //  TTPBaixaInternetDAO.Delete()
             // TTPBaixaDAO.Delete(tpBaixa);
            TTituloPagarDAO.Delete(listaTP[I]);

          end
          else
          begin

            titulo := TTituloPagarDAO.obterPorID(listaTP[I]);
            titulo.Fobservacao := ' EXISTE BAIXA NO TP.  ';
            titulo.Fdescricao := (titulo.Fdescricao + ' OBS: QUIT/EXC asdadsaasdasaas ').Substring(0,79);

            try
              TTituloPagarDAO.Update(titulo);
            except
              raise Exception.Create('Erro ao tentar alterar TP EXCLUIDO com BAIXA');

            end;

          end;

        except
          on e: Exception do
            ShowMessage(e.Message + sLineBreak + 'Contate o administrador! '  );
        end;
          framePB1.progressBar(1,listaTP.Count);
          Application.ProcessMessages;
      end

    end;

    dbgrdMain.DataSource.DataSet.Open;
    dbgrdMain.Refresh;

end;

procedure TfrmManutencao.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
   Application.ProcessMessages;
end;

procedure TfrmManutencao.btnLimpaMovDiarioClick(Sender: TObject);
var
qryLimpaMD : TFDQuery;
 cmd :string;
 I :Integer;
begin
  dmConexao.conectarBanco;
  framePB1.Visible :=True;
  framePB1.Visible :=True;
  framePB1.pb1.Visible :=True;
  framePB1.lblProgressBar.Visible :=True;
  framePB1.lblProgressBar.Caption := 'Processo sendo iniciado... por favor, aguarde...';
  Application.ProcessMessages;
  framePB1.progressBar(0,0);
  Sleep(5000);



  try
    cmd := ' DELETE FROM MOVIMENTO_DIARIO MV WHERE MV.DATA_REGISTRO BETWEEN :PDTINICIO AND :PDTFINAL ';
    qryLimpaMD := TFDQuery.Create(Self);
    qryLimpaMD.Close;
    qryLimpaMD.Connection := dmConexao.conn;
    qryLimpaMD.SQL.Clear;
    qryLimpaMD.SQL.Add(cmd);

    qryLimpaMD.ParamByName('PDTINICIO').AsDate := frmPeriodo2.getDataInicial;
    qryLimpaMD.ParamByName('PDTFINAL').AsDate := frmPeriodo2.getDataFinal;
    qryLimpaMD.ExecSQL;
    dmConexao.Conn.CommitRetaining;

      for I := 0 to 100 do
      begin
       framePB1.lblProgressBar.Caption := 'Excluindo registros... por favor, aguarde.';
        framePB1.progressBar(I, 100);
        Application.ProcessMessages;
      end;
    framePB1.lblProgressBar.Caption := 'Processo finalizado...';


  except
    dmConexao.Conn.RollbackRetaining;

    raise Exception.Create('Erro ao tentar limpar o movimento diário');

  end;

end;

procedure TfrmManutencao.btnLimparEndClick(Sender: TObject);
var
qryLimpaMD : TFDQuery;
 cmd :string;
 I :Integer;
begin
  dmConexao.conectarBanco;
    limparTabelaEndereco;

end;

procedure TfrmManutencao.btnTodosTPBClick(Sender: TObject);
begin
  dbgTPB.DataSource.DataSet.Close;

  if framePeriodoCC.validarPeriodo then begin

      qryObterTodosTPB.Close;
      qryObterTodosTPB.Connection := dmConexao.conn;
      qryObterTodosTPB.ParamByName('PIDORGANIZACAO').AsString := uutil.TOrgAtual.getId;
      qryObterTodosTPB.ParamByName('DTI').AsDateTime   :=  framePeriodoCC.getDataInicial;
      qryObterTodosTPB.ParamByName('DTF').AsDateTime   :=  framePeriodoCC.getDataFinal;
      qryObterTodosTPB.Open;

      dbgTPB.DataSource.DataSet.First;


  end;


  framePB1.lblProgressBar.Visible :=True;

end;

function TfrmManutencao.deletaTP(pIdOrganizacao, pID: string): boolean;
begin
  dmConexao.conectarBanco;

     try
         FDSDeletaTP.StoredProcName :='sp_del_tp';
         FDSDeletaTP.Prepare;
         FDSDeletaTP.ParamByName('ID_ORGANIZACAO').AsString := pIdOrganizacao;
         FDSDeletaTP.ParamByName('ID_TITULO_PAGAR').AsString := pID;
         FDSDeletaTP.ExecProc;

         dmConexao.Conn.CommitRetaining;

     except
          dmConexao.Conn.RollbackRetaining;
          raise Exception.Create('Erro ao tentar Deletar Titulos (SP_DEL_TP)');

     end;

   Result := System.True;
end;

procedure TfrmManutencao.dsTPBDataChange(Sender: TObject; Field: TField);
var
pIDTP :string;
begin
    pIDTP := qryObterTodosTPB.FieldByName('ID').AsString;
    obterRateioCC(uutil.TOrgAtual.getId,pIDTP,'TITULO_PAGAR');
    dbgCC.DataSource.DataSet := qryObterRateioCC;
    dbgCC.Refresh;

   // msgStatusBar(2, CurrToStr(obterSomaPorCampo('VALOR',qryObterRateioCC)));


end;

procedure TfrmManutencao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmManutencao.FormCreate(Sender: TObject);
begin
inicializarDM(Self);

framePB1.Visible := False;
framePB1.lblProgressBar.Visible :=False;
idOrganizacao := TOrgAtual.getId;
//ObterTodosTitulosPagar(idOrganizacao); mudei. 2/02/20 deixa tela pesada e parece nao ser preciso
pgcAjustes.ActivePageIndex := 0;

limpaStatusBar;

end;

procedure TfrmManutencao.frameBDTablesds1DataChange(Sender: TObject;
  Field: TField);
  var
  table: string;

begin
table := frameBDTables.dbgrd1.DataSource.DataSet.FieldByName('TABELA').AsString;

ObterQtdRegistro(table);

end;

procedure TfrmManutencao.inicializarDM(Sender: TObject);
begin
//nada
   framePeriodoCC.inicializa(IncMonth(Now, -1), Now); //tela de ajuste centro de custos
   frmPeriodo1.inicializa(IncMonth(Now, -1), Now);
   frmPeriodo2.inicializa(IncMonth(Now, -120), IncMonth(Now, -3)); // periodo do movimento diário


end;


function TfrmManutencao.obterBaixaBanco(pIdOrganizacao, pIdTP, pTable: string): Boolean;
var
 cmdSql :string;
begin
 dmConexao.conectarBanco;

      cmdSql := ' SELECT CBD.id_conta_bancaria_debito, CBD.id_titulo_pagar, CBD.data_movimento AS DATA ' +
                ' FROM conta_bancaria_debito CBD ' +
                ' WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CBD.ID_TITULO_PAGAR = :PIDTP) ';



      if pTable.Equals('TITULO_RECEBER') then begin

           cmdSql := ' SELECT CBC.id_conta_bancaria_CREDITO, CBC.id_titulo_RECEBER, CBC.data_movimento AS DATA ' +
                ' FROM conta_bancaria_CREDITO CBC ' +
                ' WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (CBC.ID_TITULO_RECEBER = :PIDTP) ';

      end;

  try

    qryObterBaixaBCO.Close;
    qryObterBaixaBCO.Connection := dmConexao.Conn;
    qryObterBaixaBCO.SQL.Clear;
    qryObterBaixaBCO.SQL.Add(cmdSql);
    qryObterBaixaBCO.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterBaixaBCO.ParamByName('PIDTP').AsString := pIdTP;
    qryObterBaixaBCO.Open;

  except
   raise Exception.Create('Erro ao obter a baixa por ' + pTable);


  end;

    Result := not qryObterBaixaBCO.IsEmpty;

end;


function TfrmManutencao.obterEndereco(pOrganizacao: string): Boolean;
begin
// :PIDORGANIZACAO)
  try
    qryObterEnderecos.Close;
    qryObterEnderecos.Connection := dmConexao.Conn;
    qryObterEnderecos.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterEnderecos.Open;

  except
    raise Exception.Create('Erro ao tentar Obter enderecos ');

  end;

      Result := not qryObterEnderecos.IsEmpty;

end;

function TfrmManutencao.obterSacadoPorEndereco(pOrganizacao, pEndereco: string): Integer;
begin
// :PIDORGANIZACAO)
Result :=0;
  try
    qryObterSacadoPorEndereco.Close;
    qryObterSacadoPorEndereco.Connection := dmConexao.Conn;
    qryObterSacadoPorEndereco.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterSacadoPorEndereco.ParamByName('PIDENDERECO').AsString := pEndereco;
    qryObterSacadoPorEndereco.Open;

  except
    raise Exception.Create('Erro ao tentar obter sacado por enderecos ');

  end;

      Result := qryObterSacadoPorEndereco.RecordCount;

end;



function TfrmManutencao.obterCedentePorEndereco(pOrganizacao, pEndereco: string): Integer;
begin
// :PIDORGANIZACAO)
Result :=0;
  try
    qryObterCedentePorEndereco.Close;
    qryObterCedentePorEndereco.Connection := dmConexao.Conn;
    qryObterCedentePorEndereco.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterCedentePorEndereco.ParamByName('PIDENDERECO').AsString := pEndereco;
    qryObterCedentePorEndereco.Open;

  except
    raise Exception.Create('Erro ao tentar obter cedentes por enderecos ');

  end;

      Result := qryObterCedentePorEndereco.RecordCount;

end;


function TfrmManutencao.obterFilhosPorTP(pIdOrganizacao,  pIdTP: string): boolean;
begin

     try
           qryObterFilhosTP.Close;
           qryObterFilhosTP.Connection := dmConexao.Conn;
           qryObterFilhosTP.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
           qryObterFilhosTP.ParamByName('PIDGERADOR').AsString     :=pIdTP;
           qryObterFilhosTP.Open();

     except
      raise Exception.Create('Erro ao tentar obter Filhos por TP');

     end;


      Result := not qryObterFilhosTP.IsEmpty; //se encotrar filhos retorna true
//fim
end;

function TfrmManutencao.obterFuncionarioPorEndereco(pOrganizacao,
  pEndereco: string): Integer;
begin
  // :PIDORGANIZACAO)
Result :=0;
  try
    qryObterFuncionarioPorEndereco.Close;
    qryObterFuncionarioPorEndereco.Connection := dmConexao.Conn;
    qryObterFuncionarioPorEndereco.ParamByName('PIDORGANIZACAO').AsString := pOrganizacao;
    qryObterFuncionarioPorEndereco.ParamByName('PIDENDERECO').AsString := pEndereco;
    qryObterFuncionarioPorEndereco.Open;

  except
    raise Exception.Create('Erro ao tentar Obter funcionario por enderecos ');

  end;

      Result := qryObterFuncionarioPorEndereco.RecordCount;




end;

procedure TfrmManutencao.tsTabelasShow(Sender: TObject);
begin
frameOrgs.listar(Self);

end;

function TfrmManutencao.AjustaRegistroProvisao(pTable: string; query: TFDQuery): boolean;
var
  qtd: Integer;
  sql, pID: string;
  tituloUP: TTituloPagarModel;

begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(0, 0);
    Application.ProcessMessages;

   try
        query.Open();
        query.Last;
        query.First;

    if pTable.Equals('TITULO_PAGAR') then
    begin

      while not (query.Eof) do
      begin
        qtd := qtd + 1;
        pID := query.FieldByName('ID_TITULO_PAGAR').AsString;
        lbl4.Caption := 'Registro atual Nº ' + IntToStr(query.RecNo) + '  DOC ' + query.FieldByName('NUMERO_DOCUMENTO').AsString;
        Application.ProcessMessages;

        tituloUP := TTituloPagarModel.Create;
        tituloUP.FIDorganizacao := idOrganizacao;
        tituloUP.FID := pID;

        tituloUP := TTituloPagarDAO.obterPorID(tituloUP);

        if not uutil.Empty(tituloUP.FID) then begin
           TTituloPagarDAO.Update(tituloUP);
        end;


        {
        try
          qryAjustaRP := TFDQuery.Create(Self);
          qryAjustaRP.Close;
          qryAjustaRP.Connection := dmConexao.conn;
          qryAjustaRP.SQL.Clear;
          qryAjustaRP.SQL.Add('UPDATE TITULO_PAGAR SET REGISTRO_PROVISAO = :PREGISTRO WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND (ID_TITULO_PAGAR = :PID) ');
          qryAjustaRP.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
          qryAjustaRP.ParamByName('PID').AsString := pID;
          qryAjustaRP.ParamByName('PREGISTRO').Value := null;
          qryAjustaRP.ExecSQL;

          dmConexao.conn.CommitRetaining;

        except
          raise Exception.Create('Erro ao tentar ajustar registro provisão no TP ' );
        end;   }

        query.Next;
        framePB1.progressBar(1, query.RecordCount);
        Application.ProcessMessages;
      end;

    end;

        // refazer
        if pTable.Equals('TITULO_RECEBER') then begin

           while not (query.Eof) do begin
                  qtd :=qtd + 1;

                  pID := query.FieldByName('ID_TITULO_RECEBER').AsString;

               if obterBaixaBanco(idOrganizacao, pID, 'TITULO_RECEBER') then begin



                     sql := ' UPDATE TITULO_RECEBER TR SET TR.DATA_PAGAMENTO = :PDATA ' +
                          ' WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO ) ' +
                          ' AND (TR.ID_TITULO_RECEBER = :PIDTR ) ' ;

                    try

                        qryAjustaData.Close;
                        qryAjustaData.Connection := dmConexao.Conn;
                        qryAjustaData.SQL.Clear;
                        qryAjustaData.SQL.Add(sql);
                        qryAjustaData.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                        qryAjustaData.ParamByName('PIDTR').AsString := pID;

                        qryAjustaData.ExecSQL;
                        dmConexao.Conn.CommitRetaining;
                    except
                      dmConexao.Conn.RollbackRetaining;
                      raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

                    end;

               end;

           query.Next;
           framePB1.progressBar(1, query.RecordCount);
           Application.ProcessMessages;
           end;

       end;


      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');
   end;

    Result :=System.True;

end;



function TfrmManutencao.AjustaDataPagamentoTitulo(pTable: string; query: TFDQuery): boolean;
var
  qtd :Integer;
 sql, pID :string;
pDataTitulo,  pDataBaixa : TDateTime;
begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(0, 0);
    Application.ProcessMessages;

   try
        query.Open();
        query.Last;
        query.First;

        dbgrdMain.DataSource.DataSet := query;


       if pTable.Equals('TITULO_PAGAR') then begin

          while not (query.Eof) do begin
                  qtd :=qtd + 1;

                  pID := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  pDataTitulo := query.FieldByName('DATA_PAGAMENTO').AsDateTime;

                   lbl4.Caption := 'Registro atual Nº ' + IntToStr(query.RecNo) + '  DOC ' +  query.FieldByName('NUMERO_DOCUMENTO').AsString;
                   Application.ProcessMessages;

                 if obterBaixaBanco(idOrganizacao, pID, 'TITULO_PAGAR') then begin

                    pDataBaixa := qryObterBaixaBCO.FieldByName('DATA').AsDateTime;
                     sql := ' UPDATE TITULO_PAGAR TP SET TP.DATA_PAGAMENTO = :PDATA ' +
                            ' WHERE ( TP.ID_ORGANIZACAO = :PIDORGANIZACAO ) ' +
                            ' AND (TP.ID_TITULO_PAGAR = :PIDTP )' ;

                   if (DaysBetween(pDataTitulo, pDataBaixa) <> 0) then begin

                          try

                              qryAjustaData.Close;
                              qryAjustaData.Connection := dmConexao.Conn;
                              qryAjustaData.SQL.Clear;
                              qryAjustaData.SQL.Add(sql);
                              qryAjustaData.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                              qryAjustaData.ParamByName('PIDTP').AsString := pID;
                              qryAjustaData.ParamByName('PDATA').AsDate := pDataBaixa;
                              qryAjustaData.ExecSQL;
                              dmConexao.Conn.CommitRetaining;
                          except
                            dmConexao.Conn.RollbackRetaining;
                            raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

                          end;

                   end;
               end;
                query.Next;
                framePB1.progressBar(1, query.RecordCount);
                Application.ProcessMessages;
               end;


        end;


        if pTable.Equals('TITULO_RECEBER') then begin

           while not (query.Eof) do begin
                  qtd :=qtd + 1;

                  pID := query.FieldByName('ID_TITULO_RECEBER').AsString;

               if obterBaixaBanco(idOrganizacao, pID, 'TITULO_RECEBER') then begin

                    pDataBaixa := qryObterBaixaBCO.FieldByName('DATA').AsDateTime;

                     sql := ' UPDATE TITULO_RECEBER TR SET TR.DATA_PAGAMENTO = :PDATA ' +
                          ' WHERE ( TR.ID_ORGANIZACAO = :PIDORGANIZACAO ) ' +
                          ' AND (TR.ID_TITULO_RECEBER = :PIDTR ) ' ;

                    try

                        qryAjustaData.Close;
                        qryAjustaData.Connection := dmConexao.Conn;
                        qryAjustaData.SQL.Clear;
                        qryAjustaData.SQL.Add(sql);
                        qryAjustaData.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                        qryAjustaData.ParamByName('PIDTR').AsString := pID;
                        qryAjustaData.ParamByName('PDATA').AsDate := pDataBaixa;
                        qryAjustaData.ExecSQL;
                        dmConexao.Conn.CommitRetaining;
                    except
                      dmConexao.Conn.RollbackRetaining;
                      raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

                    end;

               end;

           query.Next;
           framePB1.progressBar(1, query.RecordCount);
           Application.ProcessMessages;
           end;

       end;


      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');
   end;

       dmConexao.Conn.CommitRetaining;
       ShowMessage('Processo concluído...');

    Result :=System.True;

end;


function TfrmManutencao.AjustarDataEmissaoTP(query :TFDQuery):boolean;
  var
  qtd :Integer;
  tituloUP : TTituloPagarModel;
begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(1, query.RecordCount);
    Application.ProcessMessages;

     //rever ossp
     // a data de emissao nao pode ser sempre a data de registro

      try

        query.Open();
        dbgrdMain.DataSource.DataSet := query;
        query.Last;
        query.First;


        while not (query.Eof) do begin
                  qtd :=qtd + 1;

               {   qryAjustaDataEmissao.Close;
                  qryAjustaDataEmissao.Connection := dmConexao.Conn;
                  qryAjustaDataEmissao.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                  qryAjustaDataEmissao.ParamByName('PIDTP').AsString := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  qryAjustaDataEmissao.ParamByName('PDATA').AsDate := query.FieldByName('DATA_REGISTRO').AsDateTime;

                  qryAjustaDataEmissao.ExecSQL;     }



                  tituloUP                := TTituloPagarModel.Create;
                  tituloUP.FIDorganizacao := query.FieldByName('ID_ORGANIZACAO').AsString;
                  tituloUP.FID            := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  tituloUP                := TTituloPagarDAO.obterPorID(tituloUP);

                  if not uutil.Empty(tituloUP.FID) then
                  begin
                    TTituloPagarDAO.Update(tituloUP);
                  end;

                  query.Next;

            framePB1.progressBar(1, query.RecordCount);
            if(qtd mod 2 = 0) then begin
              Application.ProcessMessages;
            end;
        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;

       dmConexao.Conn.CommitRetaining;
       ShowMessage('Processo concluído...');

    Result :=System.True;

end;



function TfrmManutencao.ObterTodosTitulosPagarPeriodo(pIdOrganizacao :string; pDataInicio, pDataFinal :Tdate ): Boolean;
begin
    qryObterTodosTPPeriodo.Close;
    qryObterTodosTPPeriodo.Connection := dmConexao.Conn;
    qryObterTodosTPPeriodo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryObterTodosTPPeriodo.ParamByName('pDataInicial').AsDate := pDataInicio;
    qryObterTodosTPPeriodo.ParamByName('pDataFinal').AsDate := pDataFinal;
    qryObterTodosTPPeriodo.Open;
    qryObterTodosTPPeriodo.Last;

    Result := not qryObterTodosTPPeriodo.IsEmpty;
end;



function TfrmManutencao.ObterTodosTitulosReceberPeriodo(pIdOrganizacao: string;
  pDataInicio, pDataFinal: Tdate): Boolean;
begin
  dmConexao.conectarBanco;

  try

    qryObterTodosTRPeriodo.Close;
    qryObterTodosTRPeriodo.Connection := dmConexao.Conn;
    qryObterTodosTRPeriodo.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryObterTodosTRPeriodo.ParamByName('pDataInicial').AsDate := pDataInicio;
    qryObterTodosTRPeriodo.ParamByName('pDataFinal').AsDate := pDataFinal;
    qryObterTodosTRPeriodo.Open;
    qryObterTodosTRPeriodo.Last;

    Result := not qryObterTodosTRPeriodo.IsEmpty;

  except
   raise Exception.Create('Erro ao obter titulos à receber..');

  end;


end;

procedure TfrmManutencao.pnlAjustaTPClick(Sender: TObject);
begin

  framePB1.lblProgressBar.Visible :=True;
  AjustarValorRateioTP(idOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);

end;

procedure TfrmManutencao.pnlAjustaTRClick(Sender: TObject);
begin
  framePB1.lblProgressBar.Visible :=True;
  AjustarValorRateioTR(idOrganizacao, frmPeriodo1.getDataInicial, frmPeriodo1.getDataFinal);
end;

function TfrmManutencao.ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
var
titulo : TTituloPagarModel;
begin
 {
  try
    qryTodosTP.Close;
    qryTodosTP.Connection := dmConexao.Conn;
    qryTodosTP.SQL.Clear;
    qryTodosTP.SQL.Add(' SELECT * FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO )' +
                        ' AND (TP.ID_LOTE_CONTABIL IS NULL)   AND (TP.ID_TIPO_STATUS  <> ''EXCLUIDO'' ) ORDER BY TP.DATA_REGISTRO DESC ' ) ;
    qryTodosTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryTodosTP.Open;

    qryTodosTP.RecordCount;
  except

    raise Exception.Create('Erro ao obter todos TP');

  end;   }


  titulo := TTituloPagarModel.Create;
  titulo.FIDorganizacao := pIdOrganizacao;
  titulo.FIDTipoStatus := 'QUITADO';
  qryTodosTP.Close;
  qryTodosTP := TTituloPagarDAO.obterTodosPorStatus(titulo);

  Result := qryTodosTP;


end;



function TfrmManutencao.removeFilhosTP(pIdOrganizacao, pIdTPFilho: string): boolean;
begin
   try
      qryRemoveFilhoTP.Close;
      qryRemoveFilhoTP.Connection := dmConexao.Conn;
      qryRemoveFilhoTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
      qryRemoveFilhoTP.ParamByName('PIDTPFILHO').AsString := pIdTPFilho; //campo id do titulo a ser alterador

      qryRemoveFilhoTP.ExecSQL;

      dmConexao.Conn.CommitRetaining;
   except
    raise Exception.Create('Erro ao obter filhos TP');

   end;

  Result := System.True;

end;

procedure TfrmManutencao.ObterQtdRegistro(pTable :string);
var
cmd : String;
begin
   cmd :=' SELECT count(*) as REGISTROS '+
        '  FROM  ' +  pTable +
        '  WHERE 1=1 ;' ;

    qryQtdRegistros.Close;
    qryQtdRegistros.Connection := dmConexao.Conn;
    qryQtdRegistros.SQL.Clear;
    qryQtdRegistros.SQL.Add(cmd);
    qryQtdRegistros.Open;

end;


function TfrmManutencao.obterRateioCC(pIdOrganizacao, pIdTP, pTable: string): Integer;
 var
 cmdSql :string;
begin
 dmConexao.conectarBanco;
     { substituido em 12/06/20 ranan
      cmdSql :=   ' SELECT TPC.id_titulo_pagar_rateio_cc, TPC.id_titulo_pagar, TPC.valor '+
                  ' FROM titulo_pagar_rateio_cc TPC '+
                  ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                  ' AND (TPC.ID_TITULO_PAGAR = :PIDTP) ';  }

       cmdSql := ' SELECT TPC.ID_TITULO_PAGAR_RATEIO_CC, TPC.ID_TITULO_PAGAR_RATEIO_CC AS ID_TPC, '+
                 ' TPC.ID_TITULO_PAGAR, '+
                 ' TPC.VALOR, '+
                 ' TPC.ID_CENTRO_CUSTO,'+
                 ' CC.DESCRICAO '+
                 ' FROM TITULO_PAGAR_RATEIO_CC TPC '+
                 ' LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID_CENTRO_CUSTO AND CC.ID_ORGANIZACAO = TPC.ID_ORGANIZACAO) '+
                 ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
                 ' AND (TPC.ID_TITULO_PAGAR = :PIDTP) ';


      if pTable.Equals('TITULO_RECEBER') then begin

        cmdSql := ' SELECT TPC.id_titulo_RECEBER_rateio_cc, TPC.id_titulo_receber, TPC.valor '+
                  ' FROM titulo_receber_rateio_cc TPC '+
                  ' WHERE (TPC.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                  ' AND (TPC.ID_TITULO_RECEBER = :PIDTP) ';

      end;



  try

    qryObterRateioCC.Close;
    qryObterRateioCC.Connection := dmConexao.Conn;
    qryObterRateioCC.SQL.Clear;
    qryObterRateioCC.SQL.Add(cmdSql);
    qryObterRateioCC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterRateioCC.ParamByName('PIDTP').AsString := pIdTP;
    qryObterRateioCC.Open;

  except
   raise Exception.Create('Erro ao obter o rateio de centro de custos..');


  end;

    Result := qryObterRateioCC.RecordCount;

end;



function TfrmManutencao.obterSomaPorCampo( pCampo :string; var pQuery :TFDQuery) : Currency;
var
total :Currency;
begin

  total := 0;
  pQuery.First;
  while not pQuery.Eof do
  begin

    try
      total := total + pQuery.FieldByName(pCampo).AsCurrency;
    except
      total := 0;

    end;

  end;
  Result := total;

end;



function TfrmManutencao.obterRateioHistorico(pIdOrganizacao, pIdTP, pTable: string): Integer;
 var
 cmdSql :string;
begin
 dmConexao.conectarBanco;

      cmdSql := ' SELECT TPH.id_titulo_pagar_historico, TPH.valor, TPH.id_titulo_pagar ' +
                ' FROM titulo_pagar_historico TPH ' +
                ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                ' AND (TPH.ID_TITULO_PAGAR = :PIDTP) ' ;

      if pTable.Equals('TITULO_RECEBER') then begin

          cmdSql := ' SELECT TPH.id_titulo_receber_historico, TPH.valor, TPH.id_titulo_receber ' +
                    ' FROM titulo_receber_historico TPH ' +
                    ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                    ' AND (TPH.ID_TITULO_RECEBER = :PIDTP) ' ;

      end;

  try

    qryObterRateioHistorico.Close;
    qryObterRateioHistorico.Connection := dmConexao.Conn;
    qryObterRateioHistorico.SQL.Clear;
    qryObterRateioHistorico.SQL.Add(cmdSql);
    qryObterRateioHistorico.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterRateioHistorico.ParamByName('PIDTP').AsString := pIdTP;
    qryObterRateioHistorico.Open;

  except
   raise Exception.Create('Erro ao obter o rateio de histórico..');


  end;

    Result := qryObterRateioHistorico.RecordCount;

end;


function TfrmManutencao.insereHistorico(pIdOrganizacao, pIdTP, pIdHistorico,  pTable: string ; pValor :Currency): Boolean;
var
 sqlCmdInsere,   pIdTituloHistorico :string;

begin

  dmConexao.conectarBanco;


  try

    pIdTituloHistorico := dmConexao.obterNewID;

    sqlCmdInsere := ' INSERT INTO TITULO_PAGAR_HISTORICO (ID_TITULO_PAGAR_HISTORICO, ID_ORGANIZACAO, ID_HISTORICO, ID_TITULO_PAGAR, VALOR )'+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDHISTORICO, :PIDTP, :PVALOR ) ' ;


   if pTable.Equals('TITULO_RECEBER') then begin

    sqlCmdInsere := ' INSERT INTO TITULO_RECEBER_HISTORICO (ID_TITULO_RECEBER_HISTORICO, ID_ORGANIZACAO, ID_HISTORICO, ID_TITULO_RECEBER, VALOR )'+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDHISTORICO, :PIDTP, :PVALOR ) ' ;

   end;

     qryInsereHistorico.Close;
     qryInsereHistorico.Connection := dmConexao.conn;
     qryInsereHistorico.SQL.Clear;
     qryInsereHistorico.SQL.Add(sqlCmdInsere);
     qryInsereHistorico.ParamByName('PID').AsString := pIdTituloHistorico;
     qryInsereHistorico.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryInsereHistorico.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
     qryInsereHistorico.ParamByName('PIDTP').AsString := pIdTP;
     qryInsereHistorico.ParamByName('PVALOR').AsCurrency    := pValor;

     qryInsereHistorico.ExecSQL;
     qryInsereHistorico.Connection.CommitRetaining;


  except
          qryInsereHistorico.Connection.RollbackRetaining;
  raise Exception.Create('Erro ao tentar inserir histórico ' + pIdTP );

  end;

  Result := System.True;
end;


procedure TfrmManutencao.limparTabelaEndereco;
var
eliminados, qtdRegistros, liberaDel :Integer;
  pIdEndereco :string;

begin
 dmConexao.conectarBanco;
 liberaDel := 0;
  eliminados := 0;

  try

     if obterEndereco(idOrganizacao) then
      begin
          framePB1.Visible := True;
          framePB1.lblProgressBar.Visible := True;
          framePB1.progressBar(0,0);
          framePB1.lblProgressBar.Caption :=' Progresso da manutenção ';

        qryObterEnderecos.Last;
        qryObterEnderecos.First;
        qtdRegistros:= qryObterEnderecos.RecordCount;
        while not qryObterEnderecos.Eof do
        begin
         pIdEndereco := qryObterEnderecos.FieldByName('ID_ENDERECO').AsString;
         liberaDel :=0;
          liberaDel := liberaDel + obterCedentePorEndereco(idOrganizacao,pIdEndereco );
          liberaDel := liberaDel + obterSacadoPorEndereco(idOrganizacao, pIdEndereco) ;
          liberaDel := liberaDel + obterFuncionarioPorEndereco(idOrganizacao, pIdEndereco) ;

          if liberaDel = 0 then
          begin

            qryDeletaEndereco.Close;
            qryDeletaEndereco.Connection := dmConexao.conn;
            qryDeletaEndereco.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
            qryDeletaEndereco.ParamByName('PIDENDERECO').AsString := qryObterEnderecos.FieldByName('ID_ENDERECO').AsString;
            qryDeletaEndereco.ExecSQL;
            inc(eliminados);

            dmConexao.conn.CommitRetaining;
          end;

          qryObterEnderecos.Next;
          framePB1.progressBar(1, Trunc(qtdRegistros));
          framePB1.lblProgressBar.Caption :=' Analisando o registro ' +  IntToStr(Trunc(qryObterEnderecos.RecNo)) +  '  /  ' + IntToStr(Trunc(qtdRegistros));
          Application.ProcessMessages;

        end;
      end;

      framePB1.lblProgressBar.Caption :=' Foram eliminados  ' + IntToStr(eliminados) + ' registros. ';

  except
  raise Exception.Create('Erro ao tentar limpar endereços.');
  end;
end;

procedure TfrmManutencao.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

//dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfrmManutencao.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;




end.
