unit uFrmDeletaLoteContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,udmConexao,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uUtil,uDMDeletaLoteContabil,
  FireDAC.Comp.Client, EGauge, Vcl.Mask, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinsDefaultPainters, dxStatusBar, dxRibbonSkins,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, EMsgDlg;

type
  TfrmDeletaLoteContabil = class(TForm)
    qryObterLoteID: TFDQuery;
    edtIdLote: TEdit;
    edtDataRegistro: TEdit;
    medtValorDB: TMaskEdit;
    edtTabela: TEdit;
    qryGeneric: TFDQuery;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    medtValorCR: TMaskEdit;
    qryAlteraGeneric: TFDQuery;
    qryAlteraLote: TFDQuery;
    qryObterTPPROV: TFDQuery;
    qryDeletaLote: TFDQuery;
    edtTipoLancamento: TEdit;
    qryObterLotePorAno: TFDQuery;
    dbgrd1: TDBGrid;
    dsMega: TDataSource;
    qryObterLoteFNC: TFDQuery;
    dbgrd2: TDBGrid;
    dsFinance: TDataSource;
    dxStatusBar: TdxStatusBar;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarcbbAno: TdxBarCombo;
    dxBarcbbLoteContabil: TdxBarCombo;
    dxBarManager1Bar2: TdxBar;
    dxBarCustom: TdxBar;
    dxBarManager1Bar5: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    dxBarBtnLimpar: TdxBarLargeButton;
    dxBarBtnDeletarLote: TdxBarLargeButton;
    dxBarSincronizaLotes: TdxBarLargeButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure btnSincronizaLotesClick(Sender: TObject);

    procedure dxBarcbbAnoChange(Sender: TObject);
    procedure dxBarcbbLoteContabilChange(Sender: TObject);
    procedure dxBarBtnSairClick(Sender: TObject);
    procedure dxBarBtnLimparClick(Sender: TObject);
    procedure dxBarBtnDeletarLoteClick(Sender: TObject);
    procedure dxBarSincronizaLotesClick(Sender: TObject);

  private
    { Private declarations }

    pid: string;
  indiceCbbAno,  qtd, indice: Integer;
   pAno,  pIdOrganizacao : string;

    FsListaIdLotes: TStringList;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
    procedure obterLotePorAnoMega(pidEmpresa :Integer; pAno :string);
    procedure obterLotePorAnoFinance(pIdOrganizacao :string; pDataInicial, pDataFinal :TDate);
    function obterLoteID(pId, pIdOrganizacao :string):Boolean;
    function preencheAba(pId, pIdOrganizacao :string) :Boolean;
    procedure limpaCampos;
    function obterLancamentosPorLote(pIdLote, pIdOrganizacao, pTable :string):Boolean;
    function deletarLoteContabil() :Boolean;
    function alteraLancamentos(pIdLancamento, idOrganizacao, pTable,pTipo, pIdLote :string ) : Boolean;
    function alteraLoteContabil(idLote, idOrganizacao :string ) : Boolean;
    function obterTituloPagarProvisao(pId, pIdOrganizacao :string): Boolean ;
    function deletaLoteContabil(idLote, idOrganizacao: string): Boolean;
    function compararLotes(pAnoFNC, pLoteFNC: string; pDebitoFNC: Currency;
      pAnoSC, pLoteSC: string; pTotalSC: Currency): Boolean;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure preencheComboAno(pIdOrganizacao :string);
    function isSincroniza:Boolean;



  public
    { Public declarations }
  end;

var
  frmDeletaLoteContabil: TfrmDeletaLoteContabil;

implementation

{$R *.dfm}

{ TfrmDeletaLoteContabil }

function TfrmDeletaLoteContabil.alteraLancamentos(pIdLancamento, idOrganizacao, pTable, pTipo, pIdLote :string ) : Boolean;
var
cmd :string;
begin

dmConexao.conectarBanco;
  //somente retira a FK vinculada ao LOTE CONTABIL

      cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_CONTABIL = :PSTATUS  ' +
             ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
             ' AND  ID_'+ pTable +' = :PID ';

   if pTable.Equals('TITULO_PAGAR') then begin

      if ( obterTituloPagarProvisao(pIdLancamento, pIdOrganizacao) ) then begin

          if (qryObterTPPROV.FieldByName('ID_LOTE_TPB').AsString).Equals(pIdLote) then begin

          cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_TPB = :PSTATUS ' +
                    ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
                    ' AND  ID_'+ pTable +' = :PID ';
          end ;

      end;

   end;


   if pTable.Equals('TITULO_RECEBER') then begin

      if ( obterTituloPagarProvisao(pIdLancamento, pIdOrganizacao) ) then begin

          if (qryObterTPPROV.FieldByName('ID_LOTE_TRB').AsString).Equals(pIdLote) then begin

          cmd := ' UPDATE ' + pTable  + ' SET ID_LOTE_TRB = :PSTATUS ' +
                    ' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
                    ' AND  ID_'+ pTable +' = :PID ';
          end ;

      end;

   end;


   try
        qryAlteraGeneric.Close;
        qryAlteraGeneric.Connection := dmConexao.Conn;
        qryAlteraGeneric.SQL.Clear;
        qryAlteraGeneric.SQL.Add(cmd);
        qryAlteraGeneric.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
        qryAlteraGeneric.ParamByName('PID').AsString :=pIdLancamento;
        qryAlteraGeneric.ParamByName('PSTATUS').Value := NULL;

        qryAlteraGeneric.ExecSQL;
        dmConexao.Conn.CommitRetaining;

   except
       dmConexao.Conn.RollbackRetaining;
       raise(Exception).Create('Problemas ao tentar alterar lançamento contábil ');

   end;

    Result := System.True;
end;



function TfrmDeletaLoteContabil.alteraLoteContabil(idLote,  idOrganizacao: string): Boolean;
var
cmd :string;
begin

 cmd := ' UPDATE LOTE_CONTABIL  SET STATUS = :PSTATUS  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO AND  ID_LOTE_CONTABIL = :PIDLOTE ';

    try
    qryAlteraLote.Close;
    qryAlteraLote.Connection := dmConexao.Conn;
    qryAlteraLote.SQL.Clear;
    qryAlteraLote.SQL.Add(cmd);
    qryAlteraLote.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryAlteraLote.ParamByName('PIDLOTE').AsString :=idLote;
    qryAlteraLote.ParamByName('PSTATUS').AsString :='EXCLUIDO';


    qryAlteraLote.ExecSQL;
    dmConexao.conn.CommitRetaining;
    except
  dmConexao.Conn.RollbackRetaining;
    raise(Exception).Create('Problemas ao deletar lote contabil ');

  end;

end;


function TfrmDeletaLoteContabil.compararLotes(pAnoFNC,pLoteFNC :string; pDebitoFNC: Currency; pAnoSC,pLoteSC :string; pTotalSC : Currency) :Boolean;
var
loteIgual :Boolean;
begin
loteIgual := False;
  if not uutil.Empty(pAnoFNC) then
  begin

    if not uutil.Empty(pLoteFNC) then
    begin

      if pDebitoFNC > 0 then
      begin

        if pAnoFNC.Equals(pAnoSC) then begin

          if pLoteFNC.Equals(pLoteSC) then begin

            if pDebitoFNC = pTotalSC then begin

               loteIgual :=True;

            end;
          end;
        end;


      end;

    end;

  end;


Result := loteIgual;

end;



procedure TfrmDeletaLoteContabil.btnSincronizaLotesClick(Sender: TObject);
var
msgFinal, pTipoTable, pIdLoteFNC, pAnoSC, pLoteSC,pAnoFNC, pLoteFNC :string;
pTotalSC, pDebitoFNC :Currency;
resultado, loteExist :Boolean;
lotesExc : TStringList;
  I: Integer;
begin
pAnoSC   :='';
pLoteSC  :='';
pAnoFNC  :='';
pLoteFNC :='';
pTotalSC   :=0;
pDebitoFNC :=0;
loteExist :=False;
resultado :=False;
lotesExc := TStringList.Create;
 msgStatusBar(1,' Serão deletados apenas os lotes que existem no Finance 2K e não constam no sistema contábil.');
 Sleep(5000);
 msgStatusBar(1,'Obtendo dados dos sistemas...');
 Sleep(2000);


  qryObterLoteFNC.First;
  while not qryObterLoteFNC.Eof do begin

     pAnoFNC    := qryObterLoteFNC.FieldByName('ANO').AsString;
     pAno :=  pAnoFNC;
     pLoteFNC   := qryObterLoteFNC.FieldByName('LOTE').AsString;
     pDebitoFNC := qryObterLoteFNC.FieldByName('TOTAL').AsCurrency;
     pIdLoteFNC := qryObterLoteFNC.FieldByName('ID_LOTE_CONTABIL').AsString;
     pTipoTable := qryObterLoteFNC.FieldByName('TABELA').AsString;

     //buscar o lote no mega
      qryObterLotePorAno.First;
     while not qryObterLotePorAno.Eof do begin
       msgStatusBar(1,'Analisando o lote de número ' + pLoteFNC);
       pAnoSC    := qryObterLotePorAno.FieldByName('ANO').AsString;
       pLoteSC   := qryObterLotePorAno.FieldByName('LOTE').AsString;
       pTotalSC  := qryObterLotePorAno.FieldByName('TOTAL').AsCurrency;

       loteExist := compararLotes(pAnoFNC,pLoteFNC,pDebitoFNC,pAnoSC,pLoteSC,pTotalSC);
       if loteExist then begin
        qryObterLotePorAno.Last;
       end;
       qryObterLotePorAno.Next;

     end;

    if not loteExist then
    begin
      msgStatusBar(1,' O lote de número ' + pLoteFNC + ' não foi encontrado no sistema contábil ou os registros estão diferentes.');
     if  preencheAba(pIdLoteFNC, pIdOrganizacao) then begin

      if (obterLancamentosPorLote(pIdLoteFNC, pIdOrganizacao, pTipoTable)) then
      begin

        try

          try
            resultado := deletarLoteContabil;
          except
            on e: Exception do
              ShowMessage(e.Message + sLineBreak + ' deletando lote contábil!');
          end;

          if resultado then
          begin
           lotesExc.Add(pLoteFNC);
            msgStatusBar(1,'O lote de número ' + pLoteFNC + ' foi deletado com sucesso.' );
          end;

        except
          on e: Exception do
            ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
        end;
      end;


    end;

    end;

     qryObterLoteFNC.Next;

  end;

   limpaCampos;
   dxBarcbbAno.ItemIndex := indiceCbbAno;

  for I := 0 to lotesExc.Count - 1 do
  begin

    msgFinal := msgFinal + ' [  ' + lotesExc[I] + ' ]';

  end;

  if lotesExc.Count > 0 then
  begin
    msgStatusBar(1, 'Lotes excluídos : ' + msgFinal);
  end
  else
  begin
    msgStatusBar(1, ' Nenhum lote a ser excluído ');
  end;

end;

{
procedure TfrmDeletaLoteContabil.cbbAnoChange(Sender: TObject);
var
ano :string;
idSistemaContabil :Integer;
pDataInicial, pDataFinal, dataServer :TDateTime;

begin

 if dxBarcbbAno.ItemIndex > 0 then begin
    cbbLoteContabil.Clear;
    indiceCbbAno := dxBarcbbAno.ItemIndex;
    ano := dxBarcbbAno.Items[indiceCbbAno];
    idSistemaContabil := StrToInt(uutil.TOrgAtual.getIDSistemaContabil);
    pAno :=ano;

    //mostrar os lotes do sistema cont´´abil
    obterLotePorAnoMega(idSistemaContabil,ano);
    //mostrar os lotes do Financeiro
     pDataInicial := StrToDateTime('01/01/'+ano);
     pDataFinal := StrToDateTime('31/12/'+ano);
     obterLotePorAnoFinance(pIdOrganizacao,pDataInicial,pDataFinal);
     msgStatusBar(1,'Obtendo dados dos sistemas...');
     if qryObterLotePorAno.RecordCount >0 then begin
        btnSincronizaLotes.Enabled := True;
     end else begin       btnSincronizaLotes.Enabled := False; end;


  if dmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao, ano) then
    begin
      cbbLoteContabil.Enabled := True;
      dmDeletaLoteContabil.listaLoteContabil(cbbLoteContabil, FsListaIdLotes);
      msgStatusBar(1,' Sistema pronto pra exclusão de lotes. Selecione um lote ou clique em sincronizar.');

    end;

    dxBarcbbAno.ItemIndex := indiceCbbAno;

 end;


end;


} {
procedure TfrmDeletaLoteContabil.cbbLoteContabilSelect(Sender: TObject);
begin
    pid:='';
    indice:=0;

if (cbbLoteContabil.ItemIndex > 0 ) then
  begin
    indice := (cbbLoteContabil.ItemIndex );
    pid := FsListaIdLotes[indice];

         msgStatusBar(1,'Obtendo dados dos sistemas...');
  end;

 if  preencheAba(pid, pIdOrganizacao) then begin

      msgStatusBar(1,'Preenchendo a tela com os dados...');

  if (obterLancamentosPorLote(pid,pIdOrganizacao, edtTabela.Text)) then begin
         msgStatusBar(1,'Obtendo os lançamentos dos lotes. ');
//     if qtd> 0 then begin
     if 1=1 then begin
        btnDeletarLote.Enabled := true;
        btnSincronizaLotes.Enabled := True;
         msgStatusBar(1,'Botão para deletar lotes está ativo...');

      end;

      try
          obterLoteID(pid,pIdOrganizacao);

      except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
      end;
  end;

 end;




end;
 }
function TfrmDeletaLoteContabil.deletarLoteContabil: Boolean;
var
tipo, tabela, idLote  :string;
aux : Integer ;

begin
     tabela := edtTabela.Text;
     idLote  :=  edtIdLote.Text;
     tipo := edtTipoLancamento.Text;

    // obterLancamentosPorLote(idLote,pIdOrganizacao, tabela);

     // a qry é preenchida no evento OnSelect de cbbLoteContabil
    qryGeneric.First;
    aux :=0;

   qryGeneric.RecordCount;

    while not qryGeneric.Eof do begin
          try
               alteraLancamentos(qryGeneric.FieldByName('ID_'+tabela).AsString,
                          qryGeneric.FieldByName('ID_ORGANIZACAO').AsString,
                          tabela,tipo, idLote);
                          Inc(aux);
              qryGeneric.Next;
          except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' alteraLancamentos!');

          end;
    end;

    try
          alteraLoteContabil(idLote, pIdOrganizacao);
          deletaLoteContabil(idLote, pIdOrganizacao);

          //atualizar o combo
          if dmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao,pAno) then
           begin
            dmDeletaLoteContabil.listaLoteContabilTDX(dxBarcbbLoteContabil, FsListaIdLotes);
          end;

        dxBarBtnDeletarLote.Enabled := False;

    except
          on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' alteraLoteContabil!');

    end;



  Result := System.True;

end;

procedure TfrmDeletaLoteContabil.dxBarBtnDeletarLoteClick(Sender: TObject);
var
resultado : Boolean;
begin
   resultado := False;


  try
    msgStatusBar(1, ' Processando a sua solicitação. Por favor, aguarde.');

    resultado := deletarLoteContabil;
  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + ' deletando lote contábil!');
  end;

  if resultado then
  begin
    msgStatusBar(1, 'Solicitação concluída com sucesso.');
    PempecMsg.MsgInformation('Lote cancelado com sucesso...! ATENÇÃO: Os lançamentos ainda constam no sistema contábil...');
  end;

  limpaCampos;

end;


procedure TfrmDeletaLoteContabil.dxBarBtnLimparClick(Sender: TObject);
begin
 limpaCampos;
  dxBarcbbAno.ItemIndex := indiceCbbAno;
end;

procedure TfrmDeletaLoteContabil.dxBarBtnSairClick(Sender: TObject);
begin
PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmDeletaLoteContabil.dxBarcbbAnoChange(Sender: TObject);
var
ano :string;
idSistemaContabil :Integer;
pDataInicial, pDataFinal, dataServer :TDateTime;

begin

 if dxBarcbbAno.ItemIndex > 0 then begin
    dxBarcbbLoteContabil.Items.Clear;
    indiceCbbAno := dxBarcbbAno.ItemIndex;
    ano := dxBarcbbAno.Items[indiceCbbAno];
    idSistemaContabil := StrToInt(uutil.TOrgAtual.getIDSistemaContabil);
    pAno :=ano;

    //mostrar os lotes do sistema cont´´abil
    obterLotePorAnoMega(idSistemaContabil,ano);
    //mostrar os lotes do Financeiro
     pDataInicial := StrToDateTime('01/01/'+ano);
     pDataFinal := StrToDateTime('31/12/'+ano);
     obterLotePorAnoFinance(pIdOrganizacao,pDataInicial,pDataFinal);
     msgStatusBar(1,'Obtendo dados dos sistemas...');
     if qryObterLotePorAno.RecordCount >0 then begin
        dxBarSincronizaLotes.Enabled := True;
     end else begin       dxBarSincronizaLotes.Enabled := False; end;


  if dmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao, ano) then
    begin
      dxBarcbbLoteContabil.Enabled := True;
      dmDeletaLoteContabil.listaLoteContabilTDX(dxBarcbbLoteContabil, FsListaIdLotes);
      msgStatusBar(1,' Sistema pronto pra exclusão de lotes. Selecione um lote ou clique em sincronizar.');

    end;

    dxBarcbbAno.ItemIndex := indiceCbbAno;

 end;


end;

procedure TfrmDeletaLoteContabil.dxBarcbbLoteContabilChange(Sender: TObject);
begin
  pid := '';
  indice := 0;
  dxBarBtnDeletarLote.Enabled := False;
  dxBarSincronizaLotes.Enabled:= False;

  if (dxBarcbbLoteContabil.ItemIndex > 0) then
  begin
    indice := (dxBarcbbLoteContabil.ItemIndex);
    pid := FsListaIdLotes[indice];

    msgStatusBar(1, 'Obtendo dados dos sistemas...');
  end;

  if preencheAba(pid, pIdOrganizacao) then
  begin

    msgStatusBar(1, 'Preenchendo a tela com os dados...');

    if (obterLancamentosPorLote(pid, pIdOrganizacao, edtTabela.Text)) then
    begin
      msgStatusBar(1, 'Obtendo os lançamentos dos lotes. ');
//     if qtd> 0 then begin
      if 1 = 1 then
      begin
        dxBarBtnDeletarLote.Enabled := true;
        dxBarSincronizaLotes.Enabled := True;
        msgStatusBar(1, 'Botão para deletar lotes está ativo...');

      end;

      try
        obterLoteID(pid, pIdOrganizacao);

      except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
      end;
    end;

  end;

end;

procedure TfrmDeletaLoteContabil.dxBarSincronizaLotesClick(Sender: TObject);
var
msgFinal, pTipoTable, pIdLoteFNC, pAnoSC, pLoteSC,pAnoFNC, pLoteFNC :string;
pTotalSC, pDebitoFNC :Currency;
resultado, loteExist :Boolean;
lotesExc : TStringList;
  I: Integer;
begin
pAnoSC   :='';
pLoteSC  :='';
pAnoFNC  :='';
pLoteFNC :='';
pTotalSC   :=0;
pDebitoFNC :=0;
loteExist :=False;
resultado :=False;
lotesExc := TStringList.Create;
 msgStatusBar(1,' Serão deletados apenas os lotes que existem no Finance 2K e não constam no sistema contábil.');
 Sleep(5000);
 msgStatusBar(1,'Obtendo dados dos sistemas...');
 Sleep(2000);

  if isSincroniza then
  begin

    qryObterLoteFNC.First;
    while not qryObterLoteFNC.Eof do
    begin

      pAnoFNC := qryObterLoteFNC.FieldByName('ANO').AsString;
      pAno := pAnoFNC;
      pLoteFNC := qryObterLoteFNC.FieldByName('LOTE').AsString;
      pDebitoFNC := qryObterLoteFNC.FieldByName('TOTAL').AsCurrency;
      pIdLoteFNC := qryObterLoteFNC.FieldByName('ID_LOTE_CONTABIL').AsString;
      pTipoTable := qryObterLoteFNC.FieldByName('TABELA').AsString;

     //buscar o lote no mega
      qryObterLotePorAno.First;
      while not qryObterLotePorAno.Eof do
      begin
        msgStatusBar(1, 'Analisando o lote de número ' + pLoteFNC);
        pAnoSC := qryObterLotePorAno.FieldByName('ANO').AsString;
        pLoteSC := qryObterLotePorAno.FieldByName('LOTE').AsString;
        pTotalSC := qryObterLotePorAno.FieldByName('TOTAL').AsCurrency;

        loteExist := compararLotes(pAnoFNC, pLoteFNC, pDebitoFNC, pAnoSC, pLoteSC, pTotalSC);
        if loteExist then
        begin
          qryObterLotePorAno.Last;
        end;
        qryObterLotePorAno.Next;

      end;

      if not loteExist then
      begin
        msgStatusBar(1, ' O lote de número ' + pLoteFNC + ' não foi encontrado no sistema contábil ou os registros estão diferentes.');
        if preencheAba(pIdLoteFNC, pIdOrganizacao) then
        begin

          if (obterLancamentosPorLote(pIdLoteFNC, pIdOrganizacao, pTipoTable)) then
          begin

            try

              try
                resultado := deletarLoteContabil;
              except
                on e: Exception do
                  ShowMessage(e.Message + sLineBreak + ' deletando lote contábil!');
              end;

              if resultado then
              begin
                lotesExc.Add(pLoteFNC);
                msgStatusBar(1, 'O lote de número ' + pLoteFNC + ' foi deletado com sucesso.');
              end;

            except
              on e: Exception do
                ShowMessage(e.Message + sLineBreak + ' obterLoteID!');
            end;
          end;

        end;

      end;

      qryObterLoteFNC.Next;

    end;

    limpaCampos;
    dxBarcbbAno.ItemIndex := indiceCbbAno;

    for I := 0 to lotesExc.Count - 1 do
    begin

      msgFinal := msgFinal + ' [  ' + lotesExc[I] + ' ]';

    end;

    if lotesExc.Count > 0 then
    begin
      msgStatusBar(1, 'Lotes excluídos : ' + msgFinal);
    end
    else
    begin
      msgStatusBar(1, ' Nenhum lote a ser excluído ');
    end;

  end
  else
  begin
    PempecMsg.MsgError('Não foi possível sincronizar.' + #13 + ' Verifique os dados do sistema contábil. ');
  end;

end;

procedure TfrmDeletaLoteContabil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 freeAndNilDM();
 Action := caFree;
end;

procedure TfrmDeletaLoteContabil.FormCreate(Sender: TObject);
var
  I: Integer;
begin
 pIdOrganizacao := uutil.TOrgAtual.getId;


    dxBarBtnDeletarLote.Enabled := False;
    dxBarcbbLoteContabil.Enabled := False;
    dxBarcbbAno.ItemIndex :=0;
    limpaCampos;
    limpaStatusBar;
    inicializarDM(Self);
    dxBarSincronizaLotes.Enabled := False;

end;


procedure TfrmDeletaLoteContabil.freeAndNilDM;
begin
 //ver
   //existe
  if (Assigned(dmDeletaLoteContabil)) then
  begin
       FreeAndNil(dmDeletaLoteContabil);
  end;

end;

procedure TfrmDeletaLoteContabil.inicializarDM(Sender: TObject);
begin
  try
       dmConexao.conectarBanco;

  except on E: Exception do
      ShowMessage(' '+ e.Message);
  end;


   if not Assigned(dmDeletaLoteContabil) then begin
     dmDeletaLoteContabil := TdmDeletaLoteContabil.Create(Self);
   end;

   //carrega o combo
    pIdOrganizacao := Uutil.TOrgAtual.getId;
    dxBarBtnDeletarLote.Enabled := False;
    dxBarcbbAno.ItemIndex := indiceCbbAno;

end;

function TfrmDeletaLoteContabil.isSincroniza: Boolean;
var
sucesso : Boolean;
begin
  sucesso := False;

  if  (dbgrd1.DataSource.DataSet as TFDQuery).RecordCount > 0 then
  begin
    if (dbgrd2.DataSource.DataSet as TFDQuery).RecordCount > 0 then
    begin
      sucesso := True;
    end;

  end;



 Result := sucesso;


end;

procedure TfrmDeletaLoteContabil.limpaCampos;
var x: Integer;
begin
 limpaStatusBar;
for x := 0 to (ComponentCount) - 1 do
  begin

     if (TComponent(Components[x]).Tag<>100) then
       begin
         if (Components[x] is TCustomEdit) then
            (Components[x] as TCustomEdit).Clear;
         if (Components[x] is TComboBox) then
           Begin
             (Components[x] as TComboBox).ItemIndex:= 0;
             (Components[x] as TComboBox).Text:=EmptyStr;
           End;
         if (Components[x] is TCheckBox) then
           (Components[x] as TCheckBox).Checked := False;
       end;
  end;

     dxBarSincronizaLotes.Enabled := false;
     preencheComboAno(pIdOrganizacao);


end;



function TfrmDeletaLoteContabil.obterLancamentosPorLote(pIdLote, pIdOrganizacao, pTable : string): Boolean;
var
cmd :string;

begin
 pIdOrganizacao := Uutil.TOrgAtual.getId;
  Result := false;
  qtd :=0;
   //pegar todos os lancamentos do tipo que veio e preenhcer a query
     cmd := ' SELECT  *  FROM ' + pTable  +  ' TB ' +
            ' WHERE   (TB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
            ' (TB.ID_LOTE_CONTABIL = :PIDLOTE ) ' ;



  if (pTable = 'TITULO_PAGAR') then begin //se for titulo pagar provisionado sem baixa
      cmd := ' SELECT  *  FROM ' + pTable  +  ' TB ' +
             ' WHERE   (TB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
             ' ((TB.ID_LOTE_CONTABIL = :PIDLOTE ) OR (TB.ID_LOTE_TPB = :PIDLOTE )) ' ;
  end;


  if (pTable = 'TITULO_RECEBER') then begin

     cmd := ' SELECT  *  FROM ' + pTable  +  ' TB ' +
             ' WHERE   (TB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
             ' ((TB.ID_LOTE_CONTABIL = :PIDLOTE ) OR (TB.ID_LOTE_TRB = :PIDLOTE )) ' ;
  end;




  if not qryGeneric.Connection.Connected then
  begin
    qryGeneric.Connection := dmConexao.Conn;
  end;
  qryGeneric.Close;
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add(cmd);
  qryGeneric.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryGeneric.ParamByName('PIDLOTE').AsString := pIdLote;
  qryGeneric.Open;

  qtd := qryGeneric.RecordCount;

  Result := not qryGeneric.IsEmpty;


end;

function TfrmDeletaLoteContabil.obterLoteID(pId,
  pIdOrganizacao: string): Boolean;
begin
 pIdOrganizacao := Uutil.TOrgAtual.getId;

  Result := false;
  try
        qryObterLoteID.Close;
        qryObterLoteID.Connection := dmConexao.Conn;
        qryObterLoteID.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterLoteID.ParamByName('PIDLOTE').AsString := pId;
        qryObterLoteID.Open;
  except

  raise Exception.Create('Erro ao obter lote por ID ');

  end;

  Result := not qryObterLoteID.IsEmpty;

end;



procedure TfrmDeletaLoteContabil.obterLotePorAnoFinance(pIdOrganizacao: string;  pDataInicial, pDataFinal: TDate);
var
ano, cmd :string;

begin

  dmConexao.conectarBanco;

  try
    qryObterLoteFNC.Close;

    qryObterLoteFNC.Connection := dmConexao.conn;
    qryObterLoteFNC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterLoteFNC.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
    qryObterLoteFNC.ParamByName('DTDATAFINAL').AsDate := pDataFinal;

    qryObterLoteFNC.Open;
    qryObterLoteFNC.Last;
    qryObterLoteFNC.First;

  except
  raise Exception.Create('Erro ao obter lotes no FNC');

  end;


end;

procedure TfrmDeletaLoteContabil.obterLotePorAnoMega(pidEmpresa: Integer;
  pAno: string);
begin
  dmConexao.conectarMega;
  //obter todos os lotes do ano que estejam no sistema contábil

  try

    qryObterLotePorAno.Close;
    qryObterLotePorAno.Connection :=dmConexao.ConnMega;
    qryObterLotePorAno.ParamByName('PIDEMPRESA').AsInteger := pidEmpresa;
    qryObterLotePorAno.ParamByName('PANO').AsString := pAno;
    qryObterLotePorAno.Open;
    qryObterLotePorAno.Last;
    qryObterLotePorAno.First;

  except
  raise Exception.Create('Erro ao obter a lista de lotes do Sistema Contábil');

  end;

end;

function TfrmDeletaLoteContabil.preencheAba(pId, pIdOrganizacao :string) :Boolean;
var
abaPreenchida :Boolean;
begin
      abaPreenchida := False;

      if obterLoteID(pid,pIdOrganizacao) then begin

       edtIdLote.Text         := qryObterLoteID.FieldByName('ID_LOTE_CONTABIL').AsString;
       edtDataRegistro.Text   := qryObterLoteID.FieldByName('DATA_REGISTRO').AsString;
       edtTabela.Text         := qryObterLoteID.FieldByName('TIPO_TABLE').AsString ;
       edtTipoLancamento.Text := qryObterLoteID.FieldByName('TIPO_LANCAMENTO').AsString ;
       medtValorDB.Text       := (FormatFloat('R$ ###,###,##0.00',qryObterLoteID.FieldByName('VALOR_DB').AsCurrency));
       medtValorCR.Text       := (FormatFloat('R$ ###,###,##0.00',qryObterLoteID.FieldByName('VALOR_CR').AsCurrency));

        if uutil.Empty(qryObterLoteID.FieldByName('TIPO_TABLE').AsString) then
        begin
          edtTabela.Text := 'NC';
          edtTipoLancamento.Text := 'NC';

          medtValorDB.Text := (FormatFloat('R$ ###,###,##0.00', 0));
          medtValorCR.Text := (FormatFloat('R$ ###,###,##0.00', 0));

          dxBarBtnDeletarLote.Enabled := False;
        end else begin       abaPreenchida := True;
        dxBarBtnDeletarLote.Enabled := True; end;


      end;

   Result :=  abaPreenchida;
end;

procedure TfrmDeletaLoteContabil.preencheComboAno(pIdOrganizacao: string);
var
cmdCbb : string;
qryComboAno :TFDQuery;

begin
 dmConexao.conectarBanco;
 try
  { select distinct cast( extract  (year from data_registro ) as varchar(5)) as anos
  from lote_contabil lc where lc.id_organizacao = :pidorganizacao  order by lc.data_registro desc
   }


   cmdCbb := ' SELECT DISTINCT CAST(EXTRACT(YEAR FROM LC.DATA_REGISTRO) AS VARCHAR(4)) AS ANO ' +
             ' FROM LOTE_CONTABIL LC WHERE LC.ID_ORGANIZACAO = :PIDORGANIZACAO AND LC.STATUS <> ''REMOVIDO'' ' +
             ' ORDER BY LC.DATA_REGISTRO DESC ';

     qryComboAno := TFDQuery.Create(SELF);
     qryComboAno.Close;
     qryComboAno.Connection := dmConexao.conn;
     qryComboAno.SQL.Clear;
     qryComboAno.SQL.Add(cmdCbb);
     qryComboAno.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryComboAno.Open;

     dxBarcbbAno.Items.Clear;
     dxBarcbbAno.Items.Add('<<< ANO  >>>');

    if qryComboAno.RecordCount > 0 then
    begin
      qryComboAno.First;
      while not qryComboAno.Eof do
      begin

        dxBarcbbAno.Items.Add(qryComboAno.FieldByName('ANO').AsString);

        qryComboAno.Next;
      end;

    end;


 except
 raise Exception.Create('Erro ao tentar preencher o combo ano.');

 end;
 dxBarcbbAno.ItemIndex :=0;

end;

function TfrmDeletaLoteContabil.obterTituloPagarProvisao(pId, pIdOrganizacao :string): Boolean;
var
cmd :string;

begin

      cmd := ' SELECT  *  FROM TITULO_PAGAR  TP ' +
             ' WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
             ' (TP.ID_TITULO_PAGAR = :PID ) AND ' +
             ' (TP.REGISTRO_PROVISAO IS NOT NULL) ' ;

       try
            qryObterTPPROV.Close;
            qryObterTPPROV.Connection := dmConexao.Conn;
            qryObterTPPROV.SQL.Clear;
            qryObterTPPROV.SQL.Add(cmd);
            qryObterTPPROV.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
            qryObterTPPROV.ParamByName('PID').AsString :=pId;
            qryObterTPPROV.Open();

       except
         raise Exception.Create('Não foi possível consultar o TP PROV');

       end;

       Result := not qryObterTPPROV.IsEmpty;
end;


function TfrmDeletaLoteContabil.deletaLoteContabil(idLote,  idOrganizacao: string): Boolean;
 var
cmd :string;

begin

 cmd := ' DELETE FROM LOTE_CONTABIL   WHERE ID_ORGANIZACAO = :PIDORGANIZACAO AND  ID_LOTE_CONTABIL = :PIDLOTE ';
    try
    qryAlteraLote.Close;
    qryAlteraLote.Connection := dmConexao.Conn;
    qryAlteraLote.SQL.Clear;
    qryAlteraLote.SQL.Add(cmd);
    qryAlteraLote.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    qryAlteraLote.ParamByName('PIDLOTE').AsString :=idLote;

    qryAlteraLote.ExecSQL;
    dmConexao.conn.CommitRetaining;
    except
  dmConexao.Conn.RollbackRetaining;
    raise(Exception).Create('Problemas ao deletar lote contábil ');

  end;

end;

procedure TfrmDeletaLoteContabil.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Deleta um ou todos os lotes exportação existentes no sistema. ';
end;


procedure TfrmDeletaLoteContabil.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;





end.
