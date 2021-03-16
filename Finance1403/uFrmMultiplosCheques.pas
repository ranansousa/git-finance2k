unit uFrmMultiplosCheques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  uFrameContaBancaria,uContaContabilModel,udmConexao,uUtil,MDDAO, uContaBancariaChequeDAO, uContaBancariaChequeModel,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uContaBancariaDBModel,uContaBancariaDebitoDAO,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, ELab3D, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxStatusBar, EMsgDlg;

type
  TfrmMultiplosCheques = class(TForm)
    lbl1: TLabel;
    edtContaContabil: TEdit;
    lbl2: TLabel;
    edtDescricaoCC: TEdit;
    frmContaBancaria1: TfrmContaBancaria;
    lbl8: TLabel;
    dtpCompensa: TDateTimePicker;
    btnCompensar: TButton;
    qryObterCheque: TFDQuery;
    qryListaChequesPorCB: TFDQuery;
    qryTPBBAIXA: TFDQuery;
    qryInsereCBD: TFDQuery;
    qryCheckIdent: TFDQuery;
    qryUpdateCheque: TFDQuery;
    lblIDCONTAbANCARIA: TLabel;
    lblRESPONSAVEL: TLabel;
    lblIDUSER: TLabel;
    gridMain: TStringGrid;
    btnFechar: TBitBtn;
    PempecMsg: TEvMsgDlg;
    dxStatusBar: TdxStatusBar;
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCompensarClick(Sender: TObject);
    procedure gridMainSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure gridMainDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);

  private
     iDOrganizacao :string;
        FsListaIdContas : TStringList;
        FsListaIdCheques : TStringList;
        idLocalContaBancaria : string;
        indice :Integer;

        procedure inicializarDM(Sender: TObject);
        procedure freeAndNilDM();
        function obterChequesEmtidos (pIdOrganizacao, pIdContaBancaria : string) :Boolean;
        function obterChequePorId(pIdOrganizacao, pIdCheque : string) :Boolean;
        function obterDadosBaixaTP(pIdOrganizacao, pIdCheque : string) :Boolean;
        function compensarCheque(pIdOrganizacao, pIdCheque, pIdContaBancaria, pIdTipoOPeracao, pIdResponsavel, pIdTP, pDescricaoTP : string; pValor :Currency; pDataMovimento : TDate) :Boolean;
    function updateChequeEmitido(pIdCheque: string;
      pDataCompensado: TDateTime): Boolean;
    procedure limparPanel;
    procedure preencheGrid;
    procedure AdicionarLinhasComCheckBoxes(qryCheques: TFDQuery);
    procedure Limpabuffer;
    procedure AlinhaCheck;
    procedure AutoSizeCol(Grid: TStringGrid; Coluna: integer);
    procedure AutoSizeCols(Grid: TStringGrid; ColunaInicial, ColunaFinal: integer);
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
    procedure msgStatusBar(pPosicao: Integer; msg: string);


 public
    { Public declarations }
    function gerarIdentificador(pDate: TDate) : string;
    function verificaSeExistIdentificador(pIdent: string): Integer;
  end;

var
  frmMultiplosCheques: TfrmMultiplosCheques;

implementation

{$R *.dfm}

function TfrmMultiplosCheques.compensarCheque(pIdOrganizacao, pIdCheque,
  pIdContaBancaria, pIdTipoOPeracao, pIdResponsavel, pIdTP,
  pDescricaoTP: string; pValor: Currency; pDataMovimento: TDate): Boolean;
var
comando,  tipoLancamento, chequeDescricao, idCBD, userId, idTipoStatus, identificacao : string;
  pDataRegistro : TDateTime;

  sucesso : Boolean;
  cheque : TContaBancariaChequeModel;
    contaBancoDB: TContaBancariaDBModel;
begin
  sucesso := False;

  userId := IntToStr(uutil.TUserAtual.getUserId);
  idCBD  := dmConexao.obterNewID;
  idTipoStatus  :='COMPENSADO';
  identificacao := gerarIdentificador(Now);
  chequeDescricao := ' Documento ' +  pDescricaoTP;
  pDataRegistro := Now;
  tipoLancamento := 'D';

   dmConexao.conectarBanco;

  if not dmConexao.conn.InTransaction then
         dmConexao.conn.StartTransaction;
   try
  //altera o status do cheque
 //   if (updateChequeEmitido(pIdCheque, pDataMovimento)) then begin
        cheque := TContaBancariaChequeModel.Create;
        cheque.FIDorganizacao := pIdOrganizacao;
        cheque.FID := pIdCheque;
        cheque := TContaBancariaChequeDAO.obterPorID(cheque);
        cheque.FIDtipoStatus := idTipoStatus;
        cheque.FdataCompensacao := pDataMovimento;
        cheque.FIDusuario := IntToStr(uutil.TUserAtual.getUserId);

        sucesso := TContaBancariaChequeDAO.compensar(cheque);

  if sucesso then begin

      {

    comando :=' INSERT INTO CONTA_BANCARIA_DEBITO (ID_CONTA_BANCARIA_DEBITO, ID_ORGANIZACAO, ID_CONTA_BANCARIA, ' +
              ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_TITULO_PAGAR, ID_CONTA_BANCARIA_CHEQUE, ' +
              ' TIPO_LANCAMENTO, DESCRICAO, VALOR, DATA_REGISTRO, DATA_MOVIMENTO, IDENTIFICACAO, ID_USUARIO) ' +
              ' VALUES (:PID, :PIDORGANIZACAO, :PIDCONTABANCARIA, :PIDTOB, :PIDRESPONSAVEL, :PIDTP, :PIDCHEQUE, ' +
              ' :PLANCAMENTO, :PDESC, :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO, :PIDENTIFICACAO, :PIDUSER )' ;


        // insere lancamento em CBD

         qryInsereCBD.Close;
         qryInsereCBD.Connection := dmConexao.Conn;
         qryInsereCBD.SQL.Clear;
         qryInsereCBD.SQL.Add(comando);

         qryInsereCBD.ParamByName('PID').AsString := idCBD;
         qryInsereCBD.ParamByName('PIDORGANIZACAO').AsString := iDOrganizacao;
         qryInsereCBD.ParamByName('PIDCONTABANCARIA').AsString := pIdContaBancaria;
         qryInsereCBD.ParamByName('PIDTOB').AsString := pIdTipoOPeracao;
         qryInsereCBD.ParamByName('PIDRESPONSAVEL').AsString := pIdResponsavel;
         qryInsereCBD.ParamByName('PIDTP').AsString := pIdTP;
         qryInsereCBD.ParamByName('PIDCHEQUE').AsString := pIdCheque;
         qryInsereCBD.ParamByName('PLANCAMENTO').AsString := tipoLancamento;
         qryInsereCBD.ParamByName('PDESC').AsString := pDescricaoTP;
         qryInsereCBD.ParamByName('PVALOR').AsCurrency := pValor;
         qryInsereCBD.ParamByName('PDTREGISTRO').AsDate := pDataRegistro;
         qryInsereCBD.ParamByName('PDTMOVIMENTO').AsDate:= pDataMovimento;
         qryInsereCBD.ParamByName('PIDENTIFICACAO').AsString := identificacao;
         qryInsereCBD.ParamByName('PIDUSER').AsString := userId;

          qryInsereCBD.ExecSQL;    }


           //CBD
               contaBancoDB                   := TContaBancariaDBModel.Create;
               contaBancoDB.FIDorganizacao    := iDOrganizacao;
               contaBancoDB.FID               := idCBD;
               contaBancoDB.Fidentificacao    := dmConexao.obterIdentificador('',iDOrganizacao,'CBD');
               contaBancoDB.FIDusuario        := uutil.TUserAtual.userID;
               contaBancoDB.FIDResponsavel    := pIdResponsavel;
               contaBancoDB.FIDTOB            := pIdTipoOPeracao;
               contaBancoDB.FIDTP             := pIdTP;
               contaBancoDB.FtipoLancamento   := tipoLancamento;
               contaBancoDB.Fdescricao        := pDescricaoTP + '- CH  ' + cheque.FNumero;
               contaBancoDB.FIDcontaBancaria  := pIdContaBancaria;
               contaBancoDB.Fvalor            := pValor;
               contaBancoDB.FdataMovimento    := pDataMovimento;
               contaBancoDB.FdataRegistro     := Now;

                sucesso:= TContaBancariaDebitoDAO.Insert(contaBancoDB);

                if sucesso then
                begin
                  registraMovimentacao(pIdOrganizacao, 'CHEQUE', 'COMPENSAR M', uutil.TUserAtual.getNameUser + ' compensou cheque  ' + cheque.FNumero + ' da conta ' + cheque.FcontaBancaria.Fconta, 'COMP');

                  if dmConexao.conn.InTransaction then
                    dmConexao.conn.CommitRetaining;
                end;

                Result := sucesso;
    end;

   except
        if dmConexao.conn.InTransaction then
        dmConexao.conn.RollbackRetaining;
        raise Exception.Create('Problemas ao tentar inserir CBD');
   end;

end;

procedure TfrmMultiplosCheques.FormClose(Sender: TObject;
  var Action: TCloseAction);

begin
 freeAndNilDM();
 Action := caFree;
end;


procedure TfrmMultiplosCheques.FormCreate(Sender: TObject);
begin
inicializarDM(Self);
end;

procedure TfrmMultiplosCheques.freeAndNilDM;
begin
 //ver


end;

procedure TfrmMultiplosCheques.frmContaBancaria1cbbContaChange(Sender: TObject);
var
contaContabil : TContaContabilModel;
iDContaBancaria :string;
begin
   indice :=0;
   contaContabil := TContaContabilModel.Create;
   indice :=frmContaBancaria1.cbbConta.ItemIndex;
   iDContaBancaria := FsListaIdContas[indice];
   dtpCompensa.DateTime := Now;


  if indice > 0 then begin
      //pegar a conta contabil
     contaContabil := frmContaBancaria1.getContaContabil(iDOrganizacao, iDContaBancaria);
     if not (uutil.Empty(contaContabil.FConta)) then begin
        edtContaContabil.Text := contaContabil.FConta;
        edtDescricaoCC.Text   := contaContabil.FDescricao;
     end;

      //pegar a lista de cheques que estao emitidos   e preencher o combo cheque
     if not uUtil.Empty(iDContaBancaria) then begin
       idLocalContaBancaria :=  iDContaBancaria;
       lblIDCONTAbANCARIA.Caption := idLocalContaBancaria;

      if (obterChequesEmtidos(iDOrganizacao,iDContaBancaria)) then begin
          gridMain.Visible := True;
          btnCompensar.Enabled := True;
          preencheGrid;
          AutoSizeCols(gridMain,1,gridMain.ColCount -1);
          gridMain.FixedRows := 1;
      end else begin

          gridMain.Visible := False;
          btnCompensar.Enabled := False;

      end;



     end;



  end;


end;



function TfrmMultiplosCheques.gerarIdentificador(pDate: TDate): string;
var
 dia,mes,ano, ident :string;
 identAux : Integer;
begin
      // gera e verifica se existe esse identificador na table CBD

   dia := formatdatetime('dd', pDate);
   mes := formatdatetime('mm', pDate);
   ano := formatdatetime('yy', pDate);

   ident := dia  + mes + ano + '0'+'1';
   identAux := StrToInt(ident);

   while (verificaSeExistIdentificador(ident)) > 0 do begin
          Inc(identAux);
          ident := IntToStr(identAux);
   end;


 Result := ident;

end;


procedure TfrmMultiplosCheques.gridMainDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
 var
strTemp: string;
w: integer;
liForLinha : integer;
  s : string;
  LDelta : integer;

begin

  if not (gdFixed in State) then begin
     AlinhaCheck;
  end;

  if ((gdSelected in State) or (ARow = 0)) then begin  //destacar celula/linha
    {Caso a propriedade goRowSelect seja true, as configurações abaixo irão ocorrer em todas as
    celulas da linha selecionada, caso seja false, será aplicada somente na celula selecionada }
    gridMain.Canvas.Font.Style := gridMain.Canvas.Font.Style + [fsBold]; //Aplicando negrito
    gridMain.Canvas.Font.Color := clNavy; //Fonte azul
    gridMain.Canvas.Brush.Color := $00FFEFDF; //Fundo azulado (cor de linha selecionada)
  end;

  {Aplicar estilo zebrado}
  if (ARow > 0) then begin// testa se não é a primeira linha (fixa)
    if not (odd(ARow)) then begin // verifica se é par
      gridMain.Canvas.Font.Color  := clNavy;  //Fonte azul
      gridMain.Canvas.Brush.Color := $00EFEFEF; //Fundo cinza claro
    end;
  end;

     if (ACol = 2 ) and (ARow>0) then
      begin
        s     := gridMain.Cells[ACol, ARow];
        LDelta := gridMain.ColWidths[ACol] - gridMain.Canvas.TextWidth(s);
        gridMain.Canvas.TextRect(Rect, Rect.Left+LDelta, Rect.Top+2, s);
      end else
        gridMain.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, gridMain.Cells[ACol, ARow]);

end;



procedure TfrmMultiplosCheques.gridMainSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

  if ACol = 0 then begin
    gridMain.Options := gridMain.Options + [goEditing] - [goRangeSelect];
  end else begin
    gridMain.Options := gridMain.Options - [goEditing] + [goRangeSelect];
  end;


end;

procedure TfrmMultiplosCheques.inicializarDM(Sender: TObject);
begin
 FsListaIdContas := TStringList.Create;
 gridMain.Visible :=False;
 lblIDUSER.Caption := IntToStr(uutil.TUserAtual.getUserId);

  btnCompensar.Enabled := False;

  dmConexao.conectarBanco;

  if not uUtil.Empty(TOrgAtual.getId) then begin

        iDOrganizacao := TOrgAtual.getId;
  end;


  frmContaBancaria1.obterTodos(iDOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas)




end;

procedure TfrmMultiplosCheques.limparPanel;
var
liForLinha :Integer;
begin

             frmContaBancaria1.obterTodos(iDOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas);
             frmContaBancaria1.cbbConta.ItemIndex := 0 ;
             btnCompensar.Enabled := False;

             edtContaContabil.Text :='';
             edtDescricaoCC.Text := '';


             lblRESPONSAVEL.Caption      := '';
             lblIDCONTAbANCARIA.Caption  := '';
             lblIDUSER.Caption           := '';

             dtpCompensa.DateTime := Now;

             gridMain.Visible :=False;
             btnCompensar.Enabled := False;


  for liForLinha := 1 to (gridMain.RowCount - 1) do begin
   (gridMain.Objects[0,liForLinha] as TCheckBox).Visible :=False;
  end;

 msgStatusBar(1,'Ativo ');
               msgStatusBar(0,'Status');



end;

function TfrmMultiplosCheques.obterChequePorId(pIdOrganizacao,
  pIdCheque: string): Boolean;
begin
dmConexao.conectarBanco;
     try
      qryObterCheque.Close;
      qryObterCheque.Connection :=dmConexao.conn;
      qryObterCheque.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterCheque.ParamByName('PIDCHEQUE').AsString := pIdCheque;
      qryObterCheque.Open;
     except
       raise Exception.Create('Erro ao tentar obter o cheque...');


     end;

  Result := not qryObterCheque.IsEmpty;
end;


function TfrmMultiplosCheques.obterChequesEmtidos(pIdOrganizacao, pIdContaBancaria: string) :Boolean;
begin
 dmConexao.conectarBanco;

   //preenche o combo de cheques
     try
      qryListaChequesPorCB.Close;
      qryListaChequesPorCB.Connection :=dmConexao.conn;
      qryListaChequesPorCB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryListaChequesPorCB.ParamByName('PIDCONTABANCARIA').AsString := pIdContaBancaria;
      qryListaChequesPorCB.Open;

      except
     raise Exception.Create('Erro ao obter lista de cheques por conta bancária...');
      end;

 Result := not qryListaChequesPorCB.IsEmpty;

end;

function TfrmMultiplosCheques.obterDadosBaixaTP(pIdOrganizacao,
  pIdCheque: string): Boolean;
begin
   dmConexao.conectarBanco;
  //obtem dados do TP em que o cheque foi usado
    try
      qryTPBBAIXA.Close;
      qryTPBBAIXA.Connection :=dmConexao.conn;
      qryTPBBAIXA.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTPBBAIXA.ParamByName('PIDCHEQUE').AsString := pIdCheque;
      qryTPBBAIXA.Open;
    except
    raise Exception.Create('Erro ao tentr obter dados da baixa relacionado ao cheque. ');

     end;


  Result := not qryTPBBAIXA.IsEmpty;

end;

function TfrmMultiplosCheques.updateChequeEmitido(pIdCheque: string;
  pDataCompensado: TDateTime): Boolean;

begin




   dmConexao.conectarBanco;
  try
    qryUpdateCheque.Close;
    qryUpdateCheque.Connection := dmConexao.conn;
    qryUpdateCheque.ParamByName('PIDORGANIZACAO').AsString := iDOrganizacao;
    qryUpdateCheque.ParamByName('PIDCHEQUE').AsString      := pIdCheque;
    qryUpdateCheque.ParamByName('PDATACOMPENSADO').AsDate  := pDataCompensado;
    qryUpdateCheque.ParamByName('PSTATUS').AsString  := 'COMPENSADO';


    qryUpdateCheque.ExecSQL;



  except

   dmConexao.conn.RollbackRetaining;
   raise Exception.Create('Não foi possível compensar o cheque.' + 'updateChequeEmitido' );

  end;
     Result :=System.True;

end;

function TfrmMultiplosCheques.verificaSeExistIdentificador(
  pIdent: string): Integer;
begin
 dmConexao.conectarBanco;
  try
   qryCheckIdent.Close;
   qryCheckIdent.Connection := dmConexao.conn;
   qryCheckIdent.ParamByName('PIDENT').AsString := pIdent;
   qryCheckIdent.Open;
  except
  raise Exception.Create('Erro ao obter identificador para CBD');

  end;


 Result := qryCheckIdent.FieldByName('QTD').AsInteger;



end;


procedure TfrmMultiplosCheques.preencheGrid();
begin

  gridMain.Cells[0,0] := 'MARCAR';
  gridMain.Cells[1,0] := 'CHEQUE';
  gridMain.Cells[2,0] := 'VALOR';
  gridMain.Cells[3,0] := 'DOCUMENTO';
  gridMain.Cells[4,0] := 'HISTÓRICO';
  gridMain.Cells[5,0] := 'PORTADOR';
  gridMain.Cells[6,0] := 'PAGTO';
  gridMain.Cells[7,0] := ''; //ID



  if qryListaChequesPorCB.RecordCount >0 then begin
    AdicionarLinhasComCheckBoxes ( qryListaChequesPorCB );
  end;

end;


procedure TfrmMultiplosCheques.AdicionarLinhasComCheckBoxes( qryCheques :TFDQuery  );
var
  liForLinha: Integer;
  loCheckBox: TCheckBox;
begin
  limpaBuffer; {É bom não esquecer de limpar controles não utilizados}
  qryCheques.First;
  if not qryCheques.Eof then begin


      for liForLinha := 1 to qryCheques.RecordCount do begin

        {Criando os checkbox em tempo de execução}
        loCheckBox         := TCheckBox.Create(Application);
        loCheckBox.Width   := 0;
        loCheckBox.Visible := false;
        loCheckBox.Caption := ' ';
        loCheckBox.Color   := clWindow;
        loCheckBox.Tag     := liForLinha;
        //Associar o evento OnClick de todos os checkbox criados a um único evento,
        //que chamei de OnClick, mas poderia ser qualquer nome, contanto que a
        //parte da asinatura dos parametros sejam do mesmo tipo,
        //para o caso de desejar capturar o evento para executar alguma ação
        loCheckBox.OnClick := OnClick;
       // loCheckBox.Parent  := Panel1;
        loCheckBox.Parent  := gridMain.Parent;

        {StringGrid1.Objects[Coluna,Linha]}
        gridMain.Objects[0,liForLinha] := loCheckBox;
        gridMain.Cells  [1,liForLinha] := qryCheques.FieldByName('CHEQUE').AsString;
        gridMain.Cells  [2,liForLinha] := (FormatFloat('###,##0.00', qryCheques.FieldByName('VALOR').AsCurrency));
        gridMain.Cells  [3,liForLinha] := qryCheques.FieldByName('DOCUMENTO').AsString;
        gridMain.Cells  [4,liForLinha] := qryCheques.FieldByName('HISTORICO').AsString;
        gridMain.Cells  [5,liForLinha] := qryCheques.FieldByName('PORTADOR').AsString;
        gridMain.Cells  [6,liForLinha] := DateToStr( qryCheques.FieldByName('PAGTO').AsDateTime);
        gridMain.Cells  [7,liForLinha] := qryCheques.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;


        //gridMain.RowCount := liForLinha;
        qryCheques.Next;
      end;

       gridMain.RowCount := liForLinha;

  end;

  AlinhaCheck; // Alinhar o check na celula e exibí-lo

end;


Procedure TfrmMultiplosCheques.Limpabuffer;
var
  loCheckBoxTemp: TCheckBox;
  liForLinha: Integer;
  lsRow :string;
begin
  for liForLinha := 1 to gridMain.RowCount do begin
    loCheckBoxTemp := (gridMain.Objects[0,liForLinha] as TCheckBox);

    if (loCheckBoxTemp <> nil) then begin // o objeto deve existir para poder ser destruído
      loCheckBoxTemp.Visible   := false;
      gridMain.Objects[0,liForLinha] := nil;
    end;
  end;
end;


Procedure TfrmMultiplosCheques.AlinhaCheck;
var
  loCheckBoxTemp: TCheckBox;
  loRect: TRect;
  liForLinha: Integer;
begin
  for liForLinha := 1 to gridMain.RowCount do begin
    loCheckBoxTemp := (gridMain.Objects[0,liForLinha] as TCheckBox);
    if (loCheckBoxTemp <> nil) then begin
      loRect := gridMain.CellRect(0,liForLinha); // Pegando a celula para alinharmos o check

      loCheckBoxTemp.Left    := gridMain.Left + loRect.Left+2;
      loCheckBoxTemp.Top     := gridMain.Top  + loRect.Top+2;
      loCheckBoxTemp.Width   := loRect.Right     - loRect.Left;
      loCheckBoxTemp.Height  := loRect.Bottom    - loRect.Top;
      loCheckBoxTemp.Visible := True;
    end;
  end;
end;

procedure TfrmMultiplosCheques.AutoSizeCol(Grid: TStringGrid; Coluna: integer);
var
  liForColuna, liTamanhoAtual, liTamanhoMaximo: integer;
begin
  liTamanhoMaximo := 0;
  for liForColuna := 0 to (Grid.RowCount - 1) do begin
    liTamanhoAtual := Grid.Canvas.TextWidth(Grid.Cells[Coluna, liForColuna]);
    if liTamanhoAtual > liTamanhoMaximo then begin
      liTamanhoMaximo := liTamanhoAtual;
    end;
  end;
  Grid.ColWidths[Coluna] := liTamanhoMaximo + 25;  //era 40
end;

procedure TfrmMultiplosCheques.AutoSizeCols(Grid: TStringGrid; ColunaInicial,
  ColunaFinal: integer);
var
  liForColuna: Integer;
begin
  for liForColuna := ColunaInicial to ColunaFinal do begin
    AutoSizeCol(Grid,liForColuna);
  end;
end;

procedure TfrmMultiplosCheques.btnCompensarClick(Sender: TObject);
var
 I,aux,  liForLinha : integer;
pDescTP, idTP,idResp, idCHeque, contabancaria, pTOB :string;
valorCheque :Currency;
pDataMovimento : TDateTime;
begin
  FsListaIdCheques  := TStringList.Create;
  FsListaIdCheques.Clear;
  aux :=0;
  pDataMovimento := dtpCompensa.Date;

  for liForLinha := 1 to (gridMain.RowCount - 1) do begin

    if (gridMain.Objects[0,liForLinha] as TCheckBox).Checked then begin

       idCHeque := gridMain.Cells[7,liForLinha];

        if obterChequePorId(iDOrganizacao,idCHeque) then begin

           contabancaria := qryObterCheque.FieldByName('ID_CONTA_BANCARIA').AsString;
           valorCheque   := qryObterCheque.FieldByName('VALOR').AsCurrency;

          if obterDadosBaixaTP(iDOrganizacao,idCheque)  then begin

             idResp    := qryTPBBAIXA.FieldByName('ID_RESPONSAVEL').AsString;
             pTOB      := qryTPBBAIXA.FieldByName('TOB').AsString;
             idTP      := qryTPBBAIXA.FieldByName('ID_TITULO_PAGAR').AsString;
             pDescTP   := qryTPBBAIXA.FieldByName('DESCRICAO_TP').AsString + ' N DOC ' + qryTPBBAIXA.FieldByName('NUMERO_DOCUMENTO').AsString;

               try
                msgStatusBar(1,'Cheque sendo compensando. Aguarde...');
                 btnCompensar.Enabled := False;

                      compensarCheque(iDOrganizacao, idCHeque,
                                        contabancaria, pTOB,
                                        idResp, idTP,
                                        pDescTP, valorCheque,
                                        pDataMovimento ) ;

               except
                    on e: Exception do
                      ShowMessage(e.Message + sLineBreak + 'Erro ao tentar compensar  múltiplos cheque ');
               end;
          end;
        end;
    end;

  end;
        limparPanel;
        PempecMsg.MsgInformation('Processo concluído...');

end;


procedure TfrmMultiplosCheques.btnFecharClick(Sender: TObject);
begin
     PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;



procedure TfrmMultiplosCheques.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;


procedure TfrmMultiplosCheques.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;






end.
