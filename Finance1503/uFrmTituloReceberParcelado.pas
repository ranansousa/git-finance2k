unit uFrmTituloReceberParcelado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, Data.DB, uTituloReceberModel, System.Generics.Collections,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, udmConexao, uUtil,uTituloReceberParceladoModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTituloReceberDAO,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons,
  EMsgDlg;

type
  TfrmTituloReceberParcelado = class(TForm)
    edtQtdParcelas: TEdit;
    Label1: TLabel;
    edtValorDespesa: TEvNumEdit;
    Label2: TLabel;
    dsTP: TDataSource;
    gridTP: TDBGrid;
    fdmTPParcelado: TFDMemTable;
    edtValorTR: TEvNumEdit;
    edtCliente: TEdit;
    Label3: TLabel;
    edtDescricao: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    btnGerarParcs: TBitBtn;
    btnLimpar: TBitBtn;
    btnSair: TBitBtn;
    edtTotalParcelado: TEvNumEdit;
    Label6: TLabel;
    btnConfirmar: TBitBtn;
    edtDocPrincipal: TEdit;
    Label7: TLabel;
    PempecMsg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure edtQtdParcelasChange(Sender: TObject);
    procedure btnGerarParcsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure gridTPCellClick(Column: TColumn);
  private
    { Private declarations }
    parcela :Integer;
    tituloMain : TTituloReceberModel;
    msg, pIDorganizacao :string;
      sucesso : Boolean;
    procedure createTable;
    procedure limparTable;
    function obterTotalParcelado :Currency;
    procedure liberaBtnProvisao;
    procedure AdicionarTP(var collTitulos : TObjectList<TTituloReceberParceladoModel>; pParcela: TTituloReceberParceladoModel);
    function clonaParcela(pValor: Currency; pDoc, pParcela: string; pVcto: TDateTime;  var tituloPrincipal :TTituloReceberModel ): TTituloReceberParceladoModel;


  public
    { Public declarations }

    function getSucesso :Boolean;

    constructor Create (AOwner :TComponent; var pTitulo :TTituloReceberModel);


  end;

var
  frmTituloReceberParcelado: TfrmTituloReceberParcelado;

implementation

{$R *.dfm}

{ TfrmTituloReceberParcelado }

procedure TfrmTituloReceberParcelado.AdicionarTP(var collTitulos : TObjectList<TTituloReceberParceladoModel>; pParcela: TTituloReceberParceladoModel);
// TITULO_RECEBER_
 var
 X: Integer;
 aux :string;
 begin
  collTitulos.Add(TTituloReceberParceladoModel.Create);
  X := collTitulos.Count -1;
  collTitulos[X].FTituloReceber  := pParcela.FTituloReceber;
  collTitulos[X].Fparcela      := pParcela.Fparcela;

  aux :='LISTA '+  collTitulos[X].FTituloReceber.Fparcela ;
  aux :=' TR '  +   pParcela.FTituloReceber.Fparcela;

end;

function TfrmTituloReceberParcelado.clonaParcela(pValor :Currency; pDoc, pParcela :string; pVcto :TDateTime; var tituloPrincipal :TTituloReceberModel ) : TTituloReceberParceladoModel;
var
   tituloParcelado : TTituloReceberParceladoModel;
J :Integer;
tituloReceber :TTituloReceberModel;
iDTP :string;
begin
  tituloReceber :=TTituloReceberModel.Create;
  iDTP := dmConexao.obterNewID;

      tituloReceber.FID                     := iDTP;
      tituloReceber.FIDorganizacao          := uUtil.TOrgAtual.getId;
      tituloReceber.FIDusuario              := uutil.TUserAtual.userID;
      tituloReceber.FIDResponsavel          := tituloPrincipal.FIDResponsavel;
      tituloReceber.FIDHistorico            := tituloPrincipal.FIDHistorico;
      tituloReceber.FIDSacado              := tituloPrincipal.FIDSacado;
      tituloReceber.FIDTipoCobranca         := tituloPrincipal.FIDTipoCobranca;
      tituloReceber.FIDLocalPagamento       := tituloPrincipal.FIDLocalPagamento;
      tituloReceber.FIDTipoStatus           := tituloPrincipal.FIDTipoStatus;
      tituloReceber.FIDCentroCusto          := tituloPrincipal.FIDCentroCusto;
     // tituloReceber.FIDNotaFiscalEntrada    := tituloPrincipal.FIDNotaFiscalEntrada;
      tituloReceber.FIDContaContabilDebito  := tituloPrincipal.FIDContaContabilDebito;
      tituloReceber.FIDContaContabilCredito := tituloPrincipal.FIDContaContabilCredito;
      tituloReceber.Fdescricao              := tituloPrincipal.Fdescricao;
      tituloReceber.Fobservacao             := tituloPrincipal.Fobservacao;

      tituloReceber.FdataRegistro           := Now;
      tituloReceber.FdataEmissao            := tituloPrincipal.FdataEmissao;
      tituloReceber.FdataUltimaAtualizacao  := Now;


      tituloReceber.FprevisaoCartorio       := tituloPrincipal.FprevisaoCartorio;
      tituloReceber.FdataProtocolo          := tituloPrincipal.FdataProtocolo;


      tituloReceber.FvalorNominal           := pValor;
      tituloReceber.FdataVencimento         := pVcto;
      tituloReceber.Fparcela                := pParcela;
    //  tituloReceber.FregistroProvisao       //:= //o DAO CUIDAO DISSO
      tituloReceber.FnumeroDocumento        := pDoc;


      tituloReceber.Fcontrato               := tituloPrincipal.Fcontrato;
      tituloReceber.FcodigoBarras           := tituloPrincipal.FcodigoBarras;
      tituloReceber.Fcarteira               := tituloPrincipal.Fcarteira;
      tituloReceber.Fmoeda                  := tituloPrincipal.Fmoeda;

      tituloReceber.listaHistorico          := tituloPrincipal.listaHistorico;
      tituloReceber.listaCustos             := tituloPrincipal.listaCustos;


     tituloParcelado                                := TTituloReceberParceladoModel.Create;
     tituloParcelado.FTituloReceber                   := tituloReceber;




  Result := tituloParcelado;

end;



procedure TfrmTituloReceberParcelado.btnConfirmarClick(Sender: TObject);
var
 J,  I: Integer;
  aux : string;
  tituloParcelado : TTituloReceberParceladoModel;
  titulo : TTituloReceberModel;
  collTitulos : TObjectList<TTituloReceberParceladoModel>;
  pValor :Currency;
 pDoc, pParcela :string;
  pVcto :TDateTime;
begin
I :=0;
 sucesso := False;
 //criar a colecao de TP com base nas infs do DBGRID
    collTitulos := TObjectList<TTituloReceberParceladoModel>.Create;
    collTitulos.Clear;

    fdmTPParcelado.Open;
    fdmTPParcelado.First;

   while not fdmTPParcelado.Eof do    begin

     pValor   := fdmTPParcelado.FieldByName('VALOR').AsCurrency;
     pParcela := fdmTPParcelado.FieldByName('PARC').AsString;
     pVcto    := fdmTPParcelado.FieldByName('DATA_VENCIMENTO').AsDateTime;
     pDoc     := fdmTPParcelado.FieldByName('DOCUMENTO').AsString;

     tituloParcelado := TTituloReceberParceladoModel.Create;
     tituloParcelado := clonaParcela(pValor, pDoc, pParcela, pVcto, tituloMain);


      AdicionarTP(collTitulos, tituloParcelado);
      fdmTPParcelado.Next;

  end;

  if collTitulos.Count > 0 then
  begin

   if TTituloReceberDAO.InsertParcelados(collTitulos) then begin

    sucesso := True;

   end;

  end
  else
  begin
    PempecMsg.MsgInformation('N�o foi poss�vel salvar provis�o. A lista est� vazia.');

end;

 PostMessage(Self.Handle, WM_CLOSE, 0, 0);

end;


procedure TfrmTituloReceberParcelado.liberaBtnProvisao;
begin
  btnConfirmar.Enabled := False;

  if edtValorDespesa.Value >0 then begin

  if edtValorDespesa.Value = obterTotalParcelado then begin
     btnConfirmar.Enabled := True;
  end;
  end;



end;
procedure TfrmTituloReceberParcelado.btnGerarParcsClick(Sender: TObject);
var
titulo : TTituloReceberModel;
 nDoc, I: Integer;
doc,  parc :string;
begin

 dmConexao.conectarBanco;
 //montar uma colecao de X TP
  limparTable;
  parc := '1 / '+intTostr(parcela);
  tituloMain.FnumeroDocumento :=  dmConexao.obterIdentificador((edtDocPrincipal.Text + '0' + '1'), pIDorganizacao, 'TR' );

  fdmTPParcelado.Open;
  fdmTPParcelado.InsertRecord([tituloMain.FnumeroDocumento,(edtValorDespesa.Value / parcela), parc, tituloMain.FID, uUtil.TFormat.proximoDiaUtil(tituloMain.FdataVencimento)]);

  for I := 2 to parcela do begin

     parc := intTostr(I) + ' / ' +intTostr(parcela);
     doc := edtDocPrincipal.Text + '0' + intTostr(I);
    // doc := dmConexao.obterIdentificador(doc, pIDorganizacao, 'TR');

     titulo                         := TTituloReceberModel.Create;
     titulo.FID                     := dmConexao.obterNewID;
     titulo.FnumeroDocumento        := doc;
     titulo.FIDHistorico            := tituloMain.FIDHistorico;
     titulo.Fdescricao              := tituloMain.Fdescricao;
     titulo.FIDTituloReceberAnterior  := tituloMain.FID;
     titulo.FTituloGerador          := tituloMain;
     titulo.FvalorNominal           := (edtValorDespesa.Value / parcela);
     titulo.FdataVencimento         := uUtil.TFormat.proximoDiaUtil(IncMonth(tituloMain.FdataVencimento, (I-1)));

     fdmTPParcelado.Open;
     fdmTPParcelado.InsertRecord([titulo.FnumeroDocumento,(edtValorDespesa.Value / parcela), parc, titulo.FID, titulo.FdataVencimento]);

  end;

  edtTotalParcelado.Value := obterTotalParcelado;
  liberaBtnProvisao;

end;

procedure TfrmTituloReceberParcelado.btnLimparClick(Sender: TObject);
begin
limparTable;
  edtTotalParcelado.Value := obterTotalParcelado;
end;

procedure TfrmTituloReceberParcelado.btnSairClick(Sender: TObject);
begin
 limparTable;
  edtTotalParcelado.Value := obterTotalParcelado;
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;


constructor TfrmTituloReceberParcelado.Create(AOwner: TComponent; var pTitulo: TTituloReceberModel);
begin
  inherited Create(AOwner);
  pIDorganizacao := uUtil.TOrgAtual.getId;
  // createTable;
   limparTable;

   parcela                      := StrToInt(pTitulo.Fparcela);
   edtQtdParcelas.Text          := pTitulo.Fparcela;
   edtValorTR.Value             := pTitulo.FvalorNominal;
   edtValorDespesa.Value        := (parcela * pTitulo.FvalorNominal);
   edtCliente.Text              := pTitulo.FSacado.Fnome;
   edtDescricao.Text            := pTitulo.FDescricao + ' ' + pTitulo.FHistorico.Fdescricao;

   edtDocPrincipal.Text         := pTitulo.FnumeroDocumento;


   fdmTPParcelado.Open;
   fdmTPParcelado.InsertRecord([pTitulo.FnumeroDocumento,pTitulo.FvalorNominal, pTitulo.Fparcela, pTitulo.FID, pTitulo.FdataVencimento ]);

   tituloMain := pTitulo;
   sucesso := False; //s� fica true quando insere a cole��o das parcelas

end;

procedure TfrmTituloReceberParcelado.createTable;
begin

    fdmTPParcelado.FieldDefs.Add('DOCUMENTO', ftString, 50, false);
    fdmTPParcelado.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmTPParcelado.FieldDefs.Add('PARC', ftString, 20, false);
    fdmTPParcelado.FieldDefs.Add('ID', ftString, 36, false);
    fdmTPParcelado.FieldDefs.Add('DATA_VENCIMENTO', ftDate, 0, false);




    fdmTPParcelado.CreateDataSet;



end;


procedure TfrmTituloReceberParcelado.edtQtdParcelasChange(Sender: TObject);
begin
  parcela := StrToInt(edtQtdParcelas.Text);

  if parcela > 0 then
  begin
    edtValorDespesa.Value := edtValorTR.Value * parcela;
  end
  else
  begin
    edtQtdParcelas.Text := '1';
    msg := 'A parcela n�o pode ser menor que 1';
    PempecMsg.MsgInformation(msg);
  end;
end;

procedure TfrmTituloReceberParcelado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmTituloReceberParcelado.FormCreate(Sender: TObject);
begin

  if not Assigned(dmConexao) then begin
     dmConexao := TdmConexao.Create(Self);
  end;
  dmConexao.conectarBanco;
 btnConfirmar.Enabled := False;
end;



function TfrmTituloReceberParcelado.getSucesso: Boolean;
begin
Result := sucesso;
end;

procedure TfrmTituloReceberParcelado.gridTPCellClick(Column: TColumn);
begin
  edtTotalParcelado.Value := obterTotalParcelado;
  liberaBtnProvisao;
end;

procedure TfrmTituloReceberParcelado.limparTable;
begin
  fdmTPParcelado.Open;
  fdmTPParcelado.First;
  while not fdmTPParcelado.Eof do
  begin
    fdmTPParcelado.Delete;
    fdmTPParcelado.Next;
  end;
    gridTP.DataSource.DataSet.Close;
    gridTP.Refresh;
    liberaBtnProvisao;
    msg := '';

end;

function TfrmTituloReceberParcelado.obterTotalParcelado: Currency;
var
  total: Currency;
  I: Integer;
begin
  total := 0;
  fdmTPParcelado.Open;
  fdmTPParcelado.First;
  while not fdmTPParcelado.Eof do  begin

    total := total + fdmTPParcelado.FieldByName('VALOR').AsCurrency;
    fdmTPParcelado.Next;
  end;
  Result := total;
end;

end.
