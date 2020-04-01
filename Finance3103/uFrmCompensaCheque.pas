unit uFrmCompensaCheque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,udmConexao,uUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameContaBancaria,uContaContabilModel, Vcl.StdCtrls,MDDAO, uContaBancariaDBModel,uContaBancariaDebitoDAO,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.Math, uContaBancariaChequeDAO, uContaBancariaChequeModel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  EMsgDlg;

type
  TfrmCompensaCheque = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    edtContaContabil: TEdit;
    lbl1: TLabel;
    edtDescricaoCC: TEdit;
    lbl2: TLabel;
    cbbcheque: TComboBox;
    lbl3: TLabel;
    qryObterCheque: TFDQuery;
    qryListaChequesPorCB: TFDQuery;
    edtPortador: TEdit;
    medtDataEmissao: TMaskEdit;
    lbl4: TLabel;
    medtEstorno: TMaskEdit;
    lbl5: TLabel;
    medtvalor: TMaskEdit;
    lbl6: TLabel;
    lbl7: TLabel;
    qryTPBBAIXA: TFDQuery;
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    qryInsereCBD: TFDQuery;
    qryCheckIdent: TFDQuery;
    qryUpdateCheque: TFDQuery;
    btnCompensar: TButton;
    lblIDTP: TLabel;
    lblIDCONTAbANCARIA: TLabel;
    lblIDCHEQUE: TLabel;
    lblRESPONSAVEL: TLabel;
    lblTOB: TLabel;
    lblIDUSER: TLabel;
    lbl8: TLabel;
    dtpCompensa: TDateTimePicker;
    btnFechar: TBitBtn;
    PempecMsg: TEvMsgDlg;
    procedure FormCreate(Sender: TObject);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure cbbchequeChange(Sender: TObject);
    procedure btnCompensarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
        iDOrganizacao :string;
        FsListaIdContas : TStringList;
        FsListaIdCheques : TStringList;
        indice :Integer;
        
        procedure inicializarDM(Sender: TObject);
        procedure freeAndNilDM();
        procedure obterChequesEmtidos (pIdOrganizacao, pIdContaBancaria : string);
        function obterChequePorId(pIdOrganizacao, pIdCheque : string) :Boolean;
        function obterDadosBaixaTP(pIdOrganizacao, pIdCheque : string) :Boolean;
        function compensarCheque(pIdOrganizacao, pIdCheque, pIdContaBancaria, pIdTipoOPeracao, pIdResponsavel, pIdTP, pDescricaoTP : string; pValor :Currency; pDataMovimento : TDate) :Boolean;
    function updateChequeEmitido(pIdCheque: string;
      pDataCompensado: TDateTime): Boolean;
    procedure limparPanel;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);



  public
    { Public declarations }
    function gerarIdentificador(pDate: TDate) : string;
    function verificaSeExistIdentificador(pIdent: string): Integer;


  end;

var
  frmCompensaCheque: TfrmCompensaCheque;

implementation

{$R *.dfm}

procedure TfrmCompensaCheque.btnCompensarClick(Sender: TObject);
var
pDescTP, idTP,idResp, idCHeque, contabancaria, pTOB :string;
valorCheque :Currency;
begin
 idResp := lblRESPONSAVEL.Caption;
 idCHeque :=lblIDCHEQUE.Caption;
 pTOB := lblTOB.Caption;
 contabancaria := lblIDCONTAbANCARIA.Caption;
 idTP := lblIDTP.Caption;
 pDescTP := qryTPBBAIXA.FieldByName('DESCRICAO_TP').AsString + ' N DOC ' + qryTPBBAIXA.FieldByName('NUMERO_DOCUMENTO').AsString;
 valorCheque := qryObterCheque.FieldByName('VALOR').AsCurrency;

   try
         if  compensarCheque(iDOrganizacao, idCHeque,
                            contabancaria, pTOB,
                            idResp, idTP,
                            pDescTP, valorCheque,
                            dtpCompensa.Date ) then begin

              ShowMessage('Cheque compensado com sucesso');
              limparPanel;

         end;

   except
        on e: Exception do
          ShowMessage(e.Message + sLineBreak + 'Erro ao tentar compensar cheque ');
   end;

end;

procedure TfrmCompensaCheque.btnFecharClick(Sender: TObject);
begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmCompensaCheque.cbbchequeChange(Sender: TObject);
var
indice :Integer;
idCheque :string;
dtEstorno : TDateTime;
begin
 if cbbcheque.ItemIndex >0 then begin

      indice := cbbcheque.ItemIndex;


    if (obterChequePorId(iDOrganizacao, FsListaIdCheques[indice])) then begin

           idCheque := qryObterCheque.FieldByName('IDCHEQUE').AsString ;

           medtDataEmissao.Text := DateToStr(qryObterCheque.FieldByName('DATA_EMISSAO').AsDateTime) ;

           dtEstorno := qryObterCheque.FieldByName('DATA_ESTORNO').AsDateTime;
           medtEstorno.Text     := DateToStr(dtEstorno) ;

           if dtEstorno < qryObterCheque.FieldByName('DATA_EMISSAO').AsDateTime  then begin
               medtEstorno.Text := '';
           end;

           medtvalor.Text       := FormatFloat('R$ ,0.00',qryObterCheque.FieldByName('VALOR').AsCurrency) ;
           edtPortador.Text     := qryObterCheque.FieldByName('PORTADOR').AsString ;

           btnCompensar.Enabled := True;


    end;


    if obterDadosBaixaTP(iDOrganizacao,idCheque)  then begin

       dbgrd1.Enabled := False;

       lblIDTP.Caption             := qryTPBBAIXA.FieldByName('ID_TITULO_PAGAR').AsString;
       lblRESPONSAVEL.Caption      := qryTPBBAIXA.FieldByName('ID_RESPONSAVEL').AsString;
       lblTOB.Caption              := qryTPBBAIXA.FieldByName('TOB').AsString;
       lblIDCHEQUE.Caption         := idCheque;
       lblIDCONTAbANCARIA.Caption  := qryObterCheque.FieldByName('ID_CONTA_BANCARIA').AsString ;
       lblIDUSER.Caption           := TUserAtual.getUserId;


    end;

 end;


end;

function TfrmCompensaCheque.compensarCheque(pIdOrganizacao, pIdCheque,pIdContaBancaria, pIdTipoOPeracao, pIdResponsavel, pIdTP,
  pDescricaoTP: string; pValor: Currency; pDataMovimento: TDate): Boolean;
var
  comando, tipoLancamento, chequeDescricao, idCBD, userId, idTipoStatus, identificacao: string;
  pDataRegistro: TDateTime;
  sucesso: Boolean;
  cheque: TContaBancariaChequeModel;
  contaBancoDB: TContaBancariaDBModel;

begin
  sucesso := False;


  userId := TUserAtual.getUserId;
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

    cheque := TContaBancariaChequeModel.Create;
    cheque.FIDorganizacao := pIdOrganizacao;
    cheque.FID := pIdCheque;
    cheque := TContaBancariaChequeDAO.obterPorID(cheque);
    cheque.FIDtipoStatus := idTipoStatus;
    cheque.FdataCompensacao := pDataMovimento;
    cheque.FIDusuario := uutil.TUserAtual.getUserId;

    sucesso := TContaBancariaChequeDAO.compensar(cheque);

    if sucesso then
    begin

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
                registraMovimentacao(pIdOrganizacao, 'CHEQUE', 'COMPENSAR', uutil.TUserAtual.getNameUser + ' compensou cheque  ' + cheque.FNumero + ' da conta ' + cheque.FcontaBancaria.Fconta, 'COMP');
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

procedure TfrmCompensaCheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 freeAndNilDM();
 Action := caFree; // sempre como ultimo comando

end;

procedure TfrmCompensaCheque.FormCreate(Sender: TObject);
begin
inicializarDM(Self);

end;

procedure TfrmCompensaCheque.freeAndNilDM;
begin
//nada ainda

end;

procedure TfrmCompensaCheque.frmContaBancaria1cbbContaChange(Sender: TObject);
var
contaContabil : TContaContabilModel;
iDContaBancaria :string;
begin
   indice :=0;
   contaContabil := TContaContabilModel.Create;
   indice :=frmContaBancaria1.cbbConta.ItemIndex;
   iDContaBancaria := FsListaIdContas[indice];
   cbbcheque.Enabled := True;
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

      obterChequesEmtidos(iDOrganizacao,iDContaBancaria);
      cbbcheque.Enabled :=True;


     end;
     


  end;


end;


function TfrmCompensaCheque.gerarIdentificador(pDate: TDate): string;
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

procedure TfrmCompensaCheque.inicializarDM(Sender: TObject);
begin
 FsListaIdContas := TStringList.Create;

  cbbcheque.Enabled := False;
  btnCompensar.Enabled := False;
  
  dmConexao.conectarBanco;

  if not uUtil.Empty(TOrgAtual.getId) then begin

        iDOrganizacao := TOrgAtual.getId;
  end;


  frmContaBancaria1.obterTodos(iDOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas)

end;

function TfrmCompensaCheque.obterChequePorId(pIdOrganizacao,
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

procedure TfrmCompensaCheque.obterChequesEmtidos(pIdOrganizacao, pIdContaBancaria: string);
begin
   dmConexao.conectarBanco;
      
   //preenche o combo de cheques
     try
      FsListaIdCheques := TStringList.Create;
      FsListaIdCheques.Clear;
      FsListaIdCheques.Add('Sem ID');
      cbbcheque.Clear;
      cbbcheque.Items.Add('<<< Selecione  >>>');

      qryListaChequesPorCB.Close;
      qryListaChequesPorCB.Connection :=dmConexao.conn;
      qryListaChequesPorCB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryListaChequesPorCB.ParamByName('PIDCONTABANCARIA').AsString := pIdContaBancaria;
      qryListaChequesPorCB.Open;

       if not qryListaChequesPorCB.IsEmpty then begin
          qryListaChequesPorCB.First;

          while not qryListaChequesPorCB.Eof do begin
            cbbcheque.Items.Add(qryListaChequesPorCB.FieldByName('NUMERO_CHEQUE').AsString);
            FsListaIdCheques.Add(qryListaChequesPorCB.FieldByName('IDCHEQUE').AsString);
            qryListaChequesPorCB.Next;
          end;


          cbbcheque.ItemIndex :=0;

       end;
     except
     raise Exception.Create('Erro ao obter lista de cheques por conta banc�ria...');


     end;

end;

function TfrmCompensaCheque.obterDadosBaixaTP(pIdOrganizacao,  pIdCheque: string): Boolean;
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

function TfrmCompensaCheque.verificaSeExistIdentificador(
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

function TfrmCompensaCheque.updateChequeEmitido(pIdCheque :string; pDataCompensado :TDateTime) : Boolean;
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
    Result :=System.True;
  except
   qryUpdateCheque.Connection.RollbackRetaining;
   raise Exception.Create('N�o foi poss�vel compensar o cheque.' + 'updateChequeEmitido' );

  end; 

end;

procedure TfrmCompensaCheque.limparPanel();
begin

             frmContaBancaria1.obterTodos(iDOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas);
             frmContaBancaria1.cbbConta.ItemIndex := indice ;
             cbbcheque.Enabled :=False;             
             cbbcheque.ItemIndex :=0;
             btnCompensar.Enabled := False;
             dbgrd1.DataSource.DataSet.Close;
             edtContaContabil.Text :='';
             edtPortador.Text := '';
             edtDescricaoCC.Text := '';

             medtDataEmissao.Text := '';
             medtEstorno.Text := '';
             medtvalor.Text := '0,00';  
                          
             lblIDTP.Caption             := '';
             lblRESPONSAVEL.Caption      := '';
             lblTOB.Caption              := '';
             lblIDCHEQUE.Caption         := '';
             lblIDCONTAbANCARIA.Caption  := '';
             lblIDUSER.Caption           := '';

             dtpCompensa.DateTime := Now;

end;

procedure TfrmCompensaCheque.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;




end.
