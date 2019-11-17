unit uFrmRelatorioPagamentosHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uUtil,  udmConexao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uDmRelTPHistorico, udmOrganizacao, frxClass,
  EFrmLab, frxDBSet, frxExportCSV, frxExportPDF, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCTPHistorico = class(TForm)
    cbxComboFornecedor: TComboBox;
    Label2: TLabel;
    dtDataInicial: TDateTimePicker;
    Label3: TLabel;
    dtDataFinal: TDateTimePicker;
    Label7: TLabel;
    cbxOrdem: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnConsultar: TButton;
    btnImprimir: TBitBtn;
    dbgTitulos: TDBGrid;
    lblTotalDeb: TEvFrameLabel;
    lblTotalPago: TEvFrameLabel;
    lblSaldo: TEvFrameLabel;
    frxDBCedente: TfrxDBDataset;
    frxRelTitulosPorCedente: TfrxReport;
    frxDBTitulosPorCedente: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    qryTitulosPorFornecedor: TFDQuery;
    dsPreencheGrid: TDataSource;
    lbl1: TLabel;
    qryObterCedentePorID: TFDQuery;
    qryComboFornecedor: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbxComboFornecedorChange(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);


  private
    { Private declarations }
    FsListaIdFornecedor: TStringList;
    FsListaIdCedente: TStringList;

    idOrganizacao,  idCedente: String;
    pDataInicial, pDataFinal: TDate;

    codigoErro :string;

    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    function retornarCaminhoRelatorio(tipo: Integer): string;
    function retornarCampoOrdenacao: string;
    function validarFormulario: boolean;
    procedure carregaComboCedente;
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
    function obterCedentePorId(pIdOrganizacao, pIdCedente: String): Boolean;
    function preencheComboFornecedor(pIdOrganizacao: String): Boolean;

  public
    { Public declarations }
  end;

var
  frmCTPHistorico: TfrmCTPHistorico;

implementation

{$R *.dfm}

function TfrmCTPHistorico.preencheComboFornecedor(pIdOrganizacao: String): Boolean;

begin
  codigoErro := 'REL_PG_HST - COMBO CEDENTE ';
  Result := false;
 { cmd := 'SELECT C.NOME,C.ID_CEDENTE FROM CEDENTE C ' +
    ' WHERE ( C.ID_ORGANIZACAO = :pIdOrganizacao ) ' + ' ORDER BY C.NOME;';    }


   try
    qryComboFornecedor.Close;
    qryComboFornecedor.Connection := dmConexao.Conn;
    qryComboFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryComboFornecedor.Open;
    Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ' + codigoErro );
  end;

  Result := not qryComboFornecedor.IsEmpty;

end;



function TfrmCTPHistorico.obterCedentePorId(pIdOrganizacao,  pIdCedente: String): Boolean;
var
cmd :string;
begin
  codigoErro := 'REL_PG_HST - CEDENTE ';
  Result := false;
  cmd := ' SELECT * FROM CEDENTE C ' +
         ' WHERE (C.ID_ORGANIZACAO = :pIdOrganizacao) ' + ' AND ' +
         ' (C.ID_CEDENTE = :pIdCedente)';

    try
        qryObterCedentePorID.Close;
        qryObterCedentePorID.Connection := dmConexao.Conn;
        qryObterCedentePorID.SQL.Clear;
        qryObterCedentePorID.SQL.Add(cmd);
        qryObterCedentePorID.ParamByName('pIdOrganizacao').AsString :=  pIdOrganizacao;
        qryObterCedentePorID.ParamByName('pIdCedente').AsString := pIdCedente;
        qryObterCedentePorID.Open;

    Except

    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : ' + codigoErro );
  end;
    Result := not qryObterCedentePorID.IsEmpty;
  end;


procedure TfrmCTPHistorico.btnConsultarClick(Sender: TObject);
var
  valorDebito, valorCredito: Currency;
begin

     pDataInicial :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataInicial.Date));
     pDataFinal :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataFinal.Date));

  inicializarDM(Self);
  if (cbxComboFornecedor.ItemIndex > (-1)) then
  begin
    if validarFormulario then
    begin
      valorDebito := dmRelTPHistorico.obterTotalPorFornecedor(idOrganizacao,idCedente,pDataInicial,pDataFinal);
      lblTotalDeb.Caption := FormatCurr('#,,0.00', valorDebito);

      valorCredito := dmRelTPHistorico.obterTotalQuitadoPorFornecedor(idOrganizacao, idCedente,pDataInicial,pDataFinal);
      lblTotalPago.Caption := FormatCurr('#,,0.00', valorCredito);

      lblSaldo.Caption := FormatCurr('#,,0.00', (valorDebito - valorCredito));

      if obterTitulosPorFornecedor(idOrganizacao, idCedente,
        retornarCampoOrdenacao, pDataInicial,pDataFinal)
      then
      begin
         dsPreencheGrid.DataSet :=qryTitulosPorFornecedor;
         dbgTitulos.DataSource := dsPreencheGrid;

      end;

    end;
  end;
end;

procedure TfrmCTPHistorico.btnImprimirClick(Sender: TObject);
begin

  if validarFormulario then
  begin

    dmOrganizacao.carregarDadosEmpresa(idOrganizacao);

    if obterCedentePorId(idOrganizacao,idCedente) then
    begin
      if obterTitulosPorFornecedor(idOrganizacao, idCedente,
        retornarCampoOrdenacao,pDataInicial,pDataFinal)
      then
      begin
              dsPreencheGrid.DataSet := qryTitulosPorFornecedor;
        if not(dmRelTPHistorico.dataSourceIsEmpty(dsPreencheGrid))
        then
        begin
          //tipo 1 = relTitulosPorCedenteDetalhado.fr3
          exibirRelatorio(1); //
        end;
      end;
    end;
  end;
end;

procedure TfrmCTPHistorico.carregaComboCedente;
begin

  FsListaIdFornecedor := TStringList.Create;
  FsListaIdFornecedor.Clear;
  FsListaIdFornecedor.Add('Sem ID');
  cbxComboFornecedor.Clear;
  cbxComboFornecedor.Items.Add('<<< Selecione  >>>');

  if preencheComboFornecedor(idOrganizacao) then begin
      qryComboFornecedor.First;

      while not qryComboFornecedor.Eof do
      begin
        cbxComboFornecedor.Items.Add(qryComboFornecedor.FieldByName('NOME').AsString);
        FsListaIdFornecedor.Add(qryComboFornecedor.FieldByName('ID_CEDENTE').AsString);
        qryComboFornecedor.Next;
      end;

      cbxComboFornecedor.ItemIndex := 0;
  end;

end;

procedure TfrmCTPHistorico.cbxComboFornecedorChange(Sender: TObject);
begin
  inicializarDM(Self);

  if cbxComboFornecedor.ItemIndex < 0 then
  begin
    cbxComboFornecedor.Text := '';
  end;

  if validarFormulario then
  begin
    if cbxComboFornecedor.ItemIndex > (-1) then
      idCedente := FsListaIdFornecedor[cbxComboFornecedor.ItemIndex];
    begin
      obterCedentePorId(idOrganizacao, idCedente);

    end;
  end;

end;

function TfrmCTPHistorico.retornarCampoOrdenacao: string;
begin
  case cbxOrdem.ItemIndex of
    0:
      Result := 'TP.VALOR_NOMINAL';
    1:
      Result := 'TP.DATA_VENCIMENTO';
    2:
      Result := 'TP.DATA_PAGAMENTO';

  end;
end;

procedure TfrmCTPHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freeAndNilDM(Self);
  Action := caFree;
end;

procedure TfrmCTPHistorico.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
  carregaComboCedente;
  cbxOrdem.ItemIndex := 0;
  dtDataInicial.DateTime := now;
  dtDataFinal.DateTime := now;

end;

procedure TfrmCTPHistorico.freeAndNilDM(Sender: TObject);
begin
     dmConexao.conectarBanco;

  if (Assigned(dmRelTPHistorico)) then
  begin
    FreeAndNil(dmRelTPHistorico);
  end;

  if (Assigned(dmOrganizacao)) then
  begin
    FreeAndNil(dmOrganizacao);
  end;

end;

procedure TfrmCTPHistorico.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not(Assigned(dmRelTPHistorico)) then
  begin
    dmRelTPHistorico := TdmRelTPHistorico.Create(Self);
  end;

  idOrganizacao := TOrgAtual.getId;

end;

function TfrmCTPHistorico.retornarCaminhoRelatorio(tipo: Integer): string;
begin

  case tipo of

    0:  Result := uUtil.TPathRelatorio.getPagtoCedenteDetalhado;
    1:  Result := uUtil.TPathRelatorio.getPagtoCedenteDetalhado;

  end;

end;

function TfrmCTPHistorico.validarFormulario: boolean;
var
  valido: boolean;
begin
  valido := false;

  if not(idOrganizacao = '') then
  begin
    valido := true;
  end;

  Result := valido;
end;


procedure TfrmCTPHistorico.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxRelTitulosPorCedente.Variables do
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
    Variables['strUF'] :=    QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  até  ' + DateToStr(dtFinal));
    Variables['strTipoStatus'] := 'TODOS';

  end;
end;

function TfrmCTPHistorico.obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente,
  campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
  var cmd :string;
begin
cmd := ' SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.VALOR_NOMINAL, TP.NUMERO_DOCUMENTO, TP.DATA_EMISSAO, '+
       ' TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DESCRICAO, TP.PARCELA, TP.ID_TIPO_STATUS, H.descricao AS HISTORICO, CC.descricao AS CENTRO_C ' +
       ' FROM  TITULO_PAGAR TP ' +
       ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.id_organizacao = TP.id_organizacao) ' +
       ' LEFT OUTER JOIN centro_custo CC ON (CC.ID_CENTRO_CUSTO = TP.id_centro_custo) AND ( CC.id_organizacao = TP.id_organizacao) ' +
       ' WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' +
       ' (TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' +
       ' (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
       ' (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' +
       ' ORDER BY ' + campoOrdem;

 try
    qryTitulosPorFornecedor.Close;
    qryTitulosPorFornecedor.Connection := dmConexao.Conn;
    qryTitulosPorFornecedor.SQL.Clear;
    qryTitulosPorFornecedor.SQL.Add(cmd);
    qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString     := pIdCedente;
    qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsDate    :=   pDataInicial;
    qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsDate      :=   pDataFinal;
    qryTitulosPorFornecedor.Open;
  except
   raise Exception.Create('Erro ao tentar Obter TPFornecedor ');

     end;



  Result := not qryTitulosPorFornecedor.IsEmpty;
end;

procedure TfrmCTPHistorico.exibirRelatorio(tipo: Integer);
begin
  frxRelTitulosPorCedente.Clear;
  if not(frxRelTitulosPorCedente.LoadFromFile(retornarCaminhoRelatorio(tipo)))
  then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(pDataInicial, pDataFinal);
    frxRelTitulosPorCedente.OldStyleProgress := true;
    frxRelTitulosPorCedente.ShowProgress := true;
    frxRelTitulosPorCedente.ShowReport;

  end;
end;

end.
