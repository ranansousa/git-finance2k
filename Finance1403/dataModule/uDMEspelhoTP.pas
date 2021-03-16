unit uDMEspelhoTP;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,Vcl.Forms,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uUtil,UVarGlobais,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uDMOrganizacao,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, frxExportImage,
  frxExportRTF, frxExportCSV, frxExportPDF, frxExportBaseDialog, frxExportMail,
  frxExportDOCX;

type
  TdmEspelhoTP = class(TDataModule)
    frxDBTitulos: TfrxDBDataset;
    frxTPROVDB: TfrxDBDataset;
    frxTPPROVCR: TfrxDBDataset;
    qryTPPROVCR: TFDQuery;
    qryTPPROVDB: TFDQuery;
    dsDetalhesTP: TDataSource;
    frxDBTPQuitados: TfrxDBDataset;
    frxDBTPBCaixa: TfrxDBDataset;
    frxTPBAcrescimo: TfrxDBDataset;
    frxTPBDeducao: TfrxDBDataset;
    frxDBTPB: TfrxDBDataset;
    frxTPBCheque: TfrxDBDataset;
    qryTPQuitados: TFDQuery;
    qryObterTPBaixaPorTitulo: TFDQuery;
    qryBaixaTPCaixa: TFDQuery;
    qryBaixaTPCheque: TFDQuery;
    qryTPBAcrescimos: TFDQuery;
    qryTPBDeducao: TFDQuery;
    qryTPBHistorico: TFDQuery;
    frxTPBHistorico: TfrxDBDataset;
    frxEspelhoTP: TfrxReport;
    qryObterTPBBanco: TFDQuery;
    qryCedente: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    frxCedente: TfrxDBDataset;
    qryRateioCentroCustos: TFDQuery;
    frxCentroCustos: TfrxDBDataset;
    qryLotePagamento: TFDQuery;
    frxLotePagamento: TfrxDBDataset;
    frxTPBBanco: TfrxDBDataset;
    fdmTPPrinter: TFDMemTable;
    procedure dsDetalhesTPDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }

   dtInicial, dtFinal : TDate;
    procedure closeAll;

  public
    { Public declarations }
    procedure inicializarDM(Sender: TObject);
    function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure exibirRelatorio(pDataInicial, pDataFinal: TDate);

    //TP PRovisionado
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTPProvCR(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
    function obterTPProvDB(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
    function obterRateioCentroCusto(pIdOrganizacao,pIdTituloPagar : string ): Boolean;

    //TP BAIXA
    function obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterTPBaixaPorTitulo(pIdOrganizacao, pIdtituloPagar: String): Boolean;
    function obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
    function obterTPBDE(pIdOrganizacao, pIdTPB : String): Boolean;

    function obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
    function obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
    function obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;

    function obterTPBHistorico(pIdorganizacao, tituloPagarQuitado : string): Boolean;
    function obterCdentePorID(pIdorganizacao, idCedente : string): Boolean;
    function obterLotePagamento(pIdorganizacao, idLote : string): Boolean;

  end;

var
  dmEspelhoTP: TdmEspelhoTP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function TdmEspelhoTP.retornarCaminhoRelatorio: string;
begin
   Result := uutil.TPathRelatorio.getContasPagarEspelho;
//    Result := ExtractFilePath(Application.ExeName) + '\relEspelhoTituloPagar.fr3';
end;

procedure  TdmEspelhoTP.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end ;

end;

procedure TdmEspelhoTP.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with   frxEspelhoTP.Variables do
  begin

    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));



    // Variables['strTipo'] := QuotedStr(tipo); // muda a depender do lancamento

  end;

end;


procedure TdmEspelhoTP.dsDetalhesTPDataChange(Sender: TObject; Field: TField);
var
pIdOrganizacao, pIdCedente, pIdTituloPagar,pIdLote, pIdTPB :string;
begin



//pegar os dados dos detalhe
{
 pIdTPB :='';
 pIdOrganizacao := qryObterPorNumeroDocumento.FieldByName('ID_ORGANIZACAO').AsString;
 pIdCedente     := qryObterPorNumeroDocumento.FieldByName('ID_CEDENTE').AsString;
 pIdTituloPagar := qryObterPorNumeroDocumento.FieldByName('ID_TITULO_PAGAR').AsString;
 dtInicial := qryObterPorNumeroDocumento.FieldByName('DATA_EMISSAO').AsDateTime;
 dtFinal   := dtInicial;

                }
 //FDM

 pIdTPB :='';
 pIdOrganizacao := fdmTPPrinter.FieldByName('ID_ORGANIZACAO').AsString;
 pIdCedente     := fdmTPPrinter.FieldByName('ID_CEDENTE').AsString;
 pIdTituloPagar := fdmTPPrinter.FieldByName('ID_TITULO_PAGAR').AsString;
 dtInicial      := fdmTPPrinter.FieldByName('DATA_EMISSAO').AsDateTime;
 dtFinal        := dtInicial;


  obterTPProvDB(pIdOrganizacao, pIdTituloPagar);
  obterCdentePorID(pIdOrganizacao, pIdCedente);
  obterRateioCentroCusto(pIdOrganizacao, pIdTituloPagar);
  qryObterTPBaixaPorTitulo.Close;
  qryBaixaTPCaixa.Close;
  qryBaixaTPCheque.Close;
  qryObterTPBBanco.Close;


  if obterTPBaixaPorTitulo(pIdOrganizacao,pIdTituloPagar) then begin


      pIdTPB  := qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      pIdLote := qryObterTPBaixaPorTitulo.FieldByName('ID_LOTE_PAGAMENTO').AsString;

      obterTPBAC(pIdOrganizacao,pIdTPB);
      obterTPBDE(pIdOrganizacao,pIdTPB);

      obterLotePagamento(pIdOrganizacao,pIdLote);

      obterTPBCaixa(pIdOrganizacao,pIdTPB);
      obterTPBCheque(pIdOrganizacao,pIdTPB);
      obterTPBBanco(pIdOrganizacao,pIdTPB);

  end ;

  { else begin

    obterTPBAC(pIdOrganizacao, '0000');
    obterTPBDE(pIdOrganizacao, '0000');

    obterLotePagamento(pIdOrganizacao, '00000');

    obterTPBCaixa(pIdOrganizacao, '0000');
    obterTPBCheque(pIdOrganizacao, '0000');
    obterTPBBanco(pIdOrganizacao, '0000');


  end; }




  //analisar e testar com outros details
  //Desabilitar

  qryTPBDeducao.Filtered := False;
  qryTPBAcrescimos.Filtered := False;
  qryBaixaTPCaixa.Filtered := False;
  qryBaixaTPCheque.Filtered := False;
  qryObterTPBBanco.Filtered := False;
  qryLotePagamento.Filtered := False;


  //filtros



  qryTPBDeducao.Filter    := 'ID_ORGANIZACAO =  ' + QuotedStr(pIdOrganizacao ) + ' AND ID_TITULO_PAGAR_BAIXA = ' +  QuotedStr(qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString  ) ;

  qryTPBAcrescimos.Filter := 'ID_ORGANIZACAO =  ' + QuotedStr(pIdOrganizacao ) + ' AND ID_TITULO_PAGAR_BAIXA = ' +  QuotedStr(qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString  ) ;

  qryBaixaTPCaixa.Filter  := 'ID_ORGANIZACAO =  ' + QuotedStr(pIdOrganizacao ) + ' AND  ID_TITULO_PAGAR_BAIXA = ' +  QuotedStr(qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString  ) ;

  qryBaixaTPCheque.Filter := 'ID_ORGANIZACAO =  ' + QuotedStr(pIdOrganizacao ) + ' AND  ID_TITULO_PAGAR_BAIXA = ' +  QuotedStr(qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString  ) ;

  qryObterTPBBanco.Filter := 'ID_ORGANIZACAO =  ' + QuotedStr(pIdOrganizacao ) + ' AND  ID_TITULO_PAGAR_BAIXA = ' +  QuotedStr(qryObterTPBaixaPorTitulo.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString  ) ;

  qryLotePagamento.Filter := 'ID_ORGANIZACAO =  ' + QuotedStr(pIdOrganizacao ) + ' AND  ID_LOTE_PAGAMENTO = ' +  QuotedStr(qryObterTPBaixaPorTitulo.FieldByName('ID_LOTE_PAGAMENTO').AsString  ) ;


  //habilita
  qryTPBDeducao.Filtered := True;
  qryTPBAcrescimos.Filtered := True;
  qryBaixaTPCaixa.Filtered := True;
  qryBaixaTPCheque.Filtered := True;
  qryObterTPBBanco.Filtered := True;
  qryLotePagamento.Filtered := True;



end;

Procedure TdmEspelhoTP.exibirRelatorio(pDataInicial, pDataFinal: TDate);
begin
         frxEspelhoTP.Clear;
  if not(frxEspelhoTP.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
    ///dasa
  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal); //verficar essa data

    {frxMail.Login := uVarGlobais.rHost.Conta;
    frxMail.Password :=uVarGlobais.rHost.Senha;
    frxMail.SmtpHost := uVarGlobais.rHost.host;
    frxMail.SmtpPort := StrToInt(uVarGlobais.rHost.porta);
    frxMail.Subject := 'Espelho do TP ' ;
    frxMail.MailBcc := 'ranansousa@gmail.com' ;}

//    Autentica := uVarGlobais.rHost.Autentica;




    frxEspelhoTP.OldStyleProgress := True;
    frxEspelhoTP.ShowProgress := True;
    frxEspelhoTP.ShowReport;

    end;

  closeAll; //fechar todos os componentes TFDQUERY

end;

procedure TdmEspelhoTP.closeAll;
var
i : Integer;
begin

   dmEspelhoTP.fdmTPPrinter.Close;

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TFDQuery then
    begin
      (Self.Components[i] as TFDQuery).Close;
    end;

  end;

end;

function  TdmEspelhoTP.obterTPProvCR(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
begin
  Result := false;
  try

    qryTPPROVCR.Close;
    qryTPPROVCR.Connection := dmConexao.Conn;
    qryTPPROVCR.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTPPROVCR.ParamByName('PIDTITULOPAGAR').AsString := pIdTituloPagar;
    qryTPPROVCR.Open;

  except
    raise(Exception).Create('Erro ao tentar consultar PROVCR ');
  end;

  Result := not qryTPPROVCR.IsEmpty;

end;



function TdmEspelhoTP.obterTPProvDB(pIdOrganizacao,pIdTituloPagar : string ): Boolean;
begin
  Result := false;

  try
    qryTPPROVDB.Close;
    qryTPPROVDB.Connection := dmConexao.Conn;
    qryTPPROVDB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTPPROVDB.ParamByName('PIDTITULOPAGAR').AsString := pIdTituloPagar;
    qryTPPROVDB.Open;

  except
    raise(Exception).Create('Erro ao tentar consultar PROVDB ');
  end;

  Result := not qryTPPROVDB.IsEmpty;

end;



function TdmEspelhoTP.obterTPQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
var auxSql :string;
begin
  Result := false;

  try

    qryTPQuitados.Close;
    qryTPQuitados.Connection := dmConexao.Conn;
    qryTPQuitados.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryTPQuitados.ParamByName('pIdStatus').AsString := pIdStatus;
    qryTPQuitados.ParamByName('pDataInicial').AsDate := pDataInicial;
    qryTPQuitados.ParamByName('pDataFinal').AsDate := pDataFinal;
//  auxSql := QuotedStr(qry1.SQL.Text); S� PARA TESTE
    qryTPQuitados.Open;

  except
    raise(Exception).Create('Erro ao tentar consultar t�tulos quitados. ');
  end;

  Result := not qryTPQuitados.IsEmpty;

end;

function TdmEspelhoTP.obterTPBCaixa(pIdOrganizacao, pIdTPB: String): Boolean;
begin
  Result := false;
  //obtem os TP pago pela tesouraria
  try
    qryBaixaTPCaixa.Close;
    qryBaixaTPCaixa.Connection := dmConexao.Conn;
    qryBaixaTPCaixa.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
    qryBaixaTPCaixa.ParamByName('PIDTPB').AsString := pIdTPB;
    qryBaixaTPCaixa.Open;
  except
  raise(Exception).Create('Erro ao tentar consultar baixa tesouraria ' );
  end;

  Result := not qryBaixaTPCaixa.IsEmpty;

end;

function TdmEspelhoTP.obterTPBCheque(pIdOrganizacao, pIdTPB  : String): Boolean;
begin

  Result := false;
  try
    qryBaixaTPCheque.Close;
    qryBaixaTPCheque.Connection := dmConexao.Conn;
    qryBaixaTPCheque.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryBaixaTPCheque.ParamByName('PIDTPB').AsString :=pIdTPB;
    qryBaixaTPCheque.Open;
  except
  raise(Exception).Create('Erro ao tentar consultar pagamento do cheque ' );
  end;

  Result := not qryBaixaTPCheque.IsEmpty;
end;

function TdmEspelhoTP.obterTPBBanco(pIdOrganizacao, pIdTPB  : String): Boolean;

begin
  Result := false;

  TRY
    qryObterTPBBanco.Close;
    qryObterTPBBanco.Connection := dmConexao.Conn;
    qryObterTPBBanco.ParamByName('PIDORGANIZACAO').AsString :=   pIdOrganizacao;
    qryObterTPBBanco.ParamByName('PIDTPB').AsString := pIdTPB;
    qryObterTPBBanco.Open;
  except
  raise(Exception).Create('Erro ao tentar consultar o pagamento por banco  ' );
  end;


  Result := not qryObterTPBBanco.IsEmpty;

end;

function TdmEspelhoTP.obterCdentePorID(pIdorganizacao,
  idCedente: string): Boolean;
begin
try

      qryCedente.Close;
      qryCedente.Connection := dmConexao.Conn;
      qryCedente.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCedente.ParamByName('PIDCEDENTE').AsString := idCedente;

      qryCedente.Open;

  except
  raise(Exception).Create('Erro ao tentar consultar o Fornecedor ' );
  end;

  Result := not qryCedente.IsEmpty;
end;

function TdmEspelhoTP.obterLotePagamento(pIdorganizacao,
  idLote: string): Boolean;
begin

 try
      qryLotePagamento.Close;
      qryLotePagamento.Connection := dmConexao.Conn;
      qryLotePagamento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryLotePagamento.ParamByName('PIDLOTE').AsString := idLote;

      qryLotePagamento.Open;

 except

  raise(Exception).Create('Erro ao tentar consultar Lote Pagamento ' );

 end;

  Result := not qryLotePagamento.IsEmpty;


end;

function TdmEspelhoTP.obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
begin

  try
    qryObterPorNumeroDocumento.Close;
    qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
    qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

    qryObterPorNumeroDocumento.Open;

    if qryObterPorNumeroDocumento.RecordCount >0  then begin
     fdmTPPrinter.Close;

     fdmTPPrinter.AppendData(qryObterPorNumeroDocumento.Data,False);

    end;



  except

    raise(Exception).Create('Erro ao tentar consultar o TP DOC ' + pNumDoc);

  end;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;

function TdmEspelhoTP.obterRateioCentroCusto(pIdOrganizacao,
  pIdTituloPagar: string): Boolean;
begin
 try

      qryRateioCentroCustos.Close;
      qryRateioCentroCustos.Connection := dmConexao.Conn;
      qryRateioCentroCustos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryRateioCentroCustos.ParamByName('PIDTITULOPAGAR').AsString := pIdTituloPagar;

      qryRateioCentroCustos.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o rateio de custos ....');


  end;

  Result := not qryRateioCentroCustos.IsEmpty;
end;

function TdmEspelhoTP.obterTPBAC(pIdOrganizacao, pIdTPB : String): Boolean;
begin

  Result := false;
  try
      qryTPBAcrescimos.Close;
      qryTPBAcrescimos.Connection := dmConexao.Conn;
      qryTPBAcrescimos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTPBAcrescimos.ParamByName('PIDTPB').AsString := pIdTPB;
      qryTPBAcrescimos.Open;


  except

  raise(Exception).Create('Erro ao tentar obter os acr�scimos ....');


  end;
  Result := not qryTPBAcrescimos.IsEmpty;
end;




function TdmEspelhoTP.obterTPBaixaPorTitulo(pIdOrganizacao, pIdtituloPagar: String): Boolean;
begin
 Result := false;

 try
      qryObterTPBaixaPorTitulo.Close;
      qryObterTPBaixaPorTitulo.Connection := dmConexao.Conn;
      qryObterTPBaixaPorTitulo.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
      qryObterTPBaixaPorTitulo.ParamByName('PIDTITULOPAGAR').AsString :=  pIdtituloPagar;
      qryObterTPBaixaPorTitulo.Open;
 except

  raise(Exception).Create('Erro ao tentar obter baixa de titulos  ....');

 end;

  Result := not qryObterTPBaixaPorTitulo.IsEmpty;

end;


function TdmEspelhoTP.obterTPBDE(pIdOrganizacao, pIdTPB
  : String): Boolean;
begin

  Result := false;
  try
      qryTPBDeducao.Close;
      qryTPBDeducao.Connection := dmConexao.Conn;
      qryTPBDeducao.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTPBDeducao.ParamByName('PIDTPB').AsString :=         pIdTPB;
      qryTPBDeducao.Open;
  except

  raise(Exception).Create('Erro ao tentar obter dedu��es  ....');

 end;

  Result := not qryTPBDeducao.IsEmpty;
end;


function TdmEspelhoTP.obterTPBHistorico(pIdorganizacao, tituloPagarQuitado :string): Boolean;
begin
  Result := false;

  if not qryTPBHistorico.Connection.Connected then
  begin
    qryTPBHistorico.Connection := dmConexao.Conn;
  end;

  qryTPBHistorico.Close;
  qryTPBHistorico.ParamByName('PIDTP').AsString := tituloPagarQuitado;
  qryTPBHistorico.ParamByName('pIdOrganizacao').AsString := pIdorganizacao;

  qryTPBHistorico.Open();

  Result := not qryTPBHistorico.IsEmpty;

end;



end.
