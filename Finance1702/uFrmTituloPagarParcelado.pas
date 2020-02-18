unit uFrmTituloPagarParcelado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, Data.DB, uTituloPagarModel, System.Generics.Collections,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, udmConexao, uUtil,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons;

type
  TfrmTituloPagarParcelado = class(TForm)
    edtQtdParcelas: TEdit;
    Label1: TLabel;
    edtValorDespesa: TEvNumEdit;
    Label2: TLabel;
    dsTP: TDataSource;
    gridTP: TDBGrid;
    fdmTPParcelado: TFDMemTable;
    edtValorTP: TEvNumEdit;
    edtFornecedor: TEdit;
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
    tituloMain : TTituloPagarModel;
    pIDorganizacao :string;
    collTitulos : TObjectList<TTituloPagarModel>;

    procedure createTable;
    procedure limparTable;
    function obterTotalParcelado :Currency;
    procedure liberaBtnProvisao;
  public
    { Public declarations }

    constructor Create (AOwner :TComponent; pTitulo :TTituloPagarModel);


  end;

var
  frmTituloPagarParcelado: TfrmTituloPagarParcelado;

implementation

{$R *.dfm}

{ TfrmTituloPagarParcelado }

procedure TfrmTituloPagarParcelado.btnConfirmarClick(Sender: TObject);
var
  I: Integer;
  aux : string;
begin
 //criar a colecao de TP com base nas infs do DBGRID
    collTitulos := TObjectList<TTituloPagarModel>.Create;
    collTitulos.Clear;

 fdmTPParcelado.Open;
 fdmTPParcelado.First;

   while not fdmTPParcelado.Eof do    begin

      tituloMain.FvalorNominal   := fdmTPParcelado.FieldByName('VALOR').AsCurrency;
      tituloMain.Fparcela        := fdmTPParcelado.FieldByName('PARC').AsString;
      tituloMain.FdataVencimento := fdmTPParcelado.FieldByName('DATA_VENCIMENTO').AsDateTime;
      tituloMain.FID             := fdmTPParcelado.FieldByName('ID').AsString;

      collTitulos.Add(tituloMain);

      fdmTPParcelado.Next;


    end;



  if collTitulos.Count >0  then begin

   //enviar para TPDAO.
   aux := '';
    for I := 0 to collTitulos.Count -1 do begin

      aux :=  TTituloPagarModel(collTitulos[I]).FnumeroDocumento;
      aux := TTituloPagarModel(collTitulos[I]).Fparcela;
      aux := CurrToStr( TTituloPagarModel(collTitulos[I]).FvalorNominal);

    end;



  end else begin ShowMessage('N�o foi poss�vel salvar provis�o. A lista est� vazia.');

end;

end;


procedure TfrmTituloPagarParcelado.liberaBtnProvisao;
begin
  btnConfirmar.Enabled := False;

  if edtValorDespesa.Value >0 then begin

  if edtValorDespesa.Value = obterTotalParcelado then begin
     btnConfirmar.Enabled := True;
  end;
  end;



end;
procedure TfrmTituloPagarParcelado.btnGerarParcsClick(Sender: TObject);
var
titulo : TTituloPagarModel;
 nDoc, I: Integer;
doc,  parc :string;
begin
 dmConexao.conectarBanco;
 //montar uma colecao de X TP
  limparTable;
  parc := '1 / '+intTostr(parcela);

  fdmTPParcelado.Open;
  fdmTPParcelado.InsertRecord([tituloMain.FnumeroDocumento,(edtValorDespesa.Value / parcela), parc, tituloMain.FID, uUtil.TFormat.proximoDiaUtil(tituloMain.FdataVencimento)]);

  for I := 2 to parcela do begin

     parc := intTostr(I) + ' / ' +intTostr(parcela);
     doc := edtDocPrincipal.Text + '0' + intTostr(I);

    //nDoc := StrToInt(tituloMain.FnumeroDocumento);

     titulo := TTituloPagarModel.Create;
     titulo.FID := dmConexao.obterNewID;
     titulo.FnumeroDocumento := doc;
     titulo.FIDHistorico := tituloMain.FIDHistorico;
     titulo.Fdescricao := tituloMain.Fdescricao;
     titulo.FIDTituloPagarAnterior := tituloMain.FID;
     titulo.FTituloPagar := tituloMain;
     titulo.FvalorNominal := (edtValorDespesa.Value / parcela);
     titulo.FdataVencimento := uUtil.TFormat.proximoDiaUtil(IncMonth(tituloMain.FdataVencimento, (I-1)));

     fdmTPParcelado.Open;
     fdmTPParcelado.InsertRecord([titulo.FnumeroDocumento,(edtValorDespesa.Value / parcela), parc, titulo.FID, titulo.FdataVencimento]);

  end;


  edtTotalParcelado.Value := obterTotalParcelado;
  liberaBtnProvisao;



end;

procedure TfrmTituloPagarParcelado.btnLimparClick(Sender: TObject);
begin
limparTable;
  edtTotalParcelado.Value := obterTotalParcelado;
end;

procedure TfrmTituloPagarParcelado.btnSairClick(Sender: TObject);
begin
 limparTable;
  edtTotalParcelado.Value := obterTotalParcelado;
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;


constructor TfrmTituloPagarParcelado.Create(AOwner: TComponent;  pTitulo: TTituloPagarModel);
begin
  inherited Create(AOwner);
  pIDorganizacao := uUtil.TOrgAtual.getId;
  // createTable;
   limparTable;

   parcela                      := StrToInt(pTitulo.Fparcela);
   edtQtdParcelas.Text          := pTitulo.Fparcela;
   edtValorTP.Value             := pTitulo.FvalorNominal;
   edtValorDespesa.Value        := (parcela * pTitulo.FvalorNominal);
   edtFornecedor.Text           := pTitulo.FCedente.Fnome;
   edtDescricao.Text            := pTitulo.FHistorico.FDescricao + ' ' + pTitulo.Fdescricao;
   edtDocPrincipal.Text         := pTitulo.FnumeroDocumento;


   fdmTPParcelado.Open;
   fdmTPParcelado.InsertRecord([pTitulo.FnumeroDocumento,pTitulo.FvalorNominal, pTitulo.Fparcela, pTitulo.FID, pTitulo.FdataVencimento ]);

   tituloMain := pTitulo;


end;

procedure TfrmTituloPagarParcelado.createTable;
begin

    fdmTPParcelado.FieldDefs.Add('NUMERO_DOCUMENTO', ftString, 50, false);
    fdmTPParcelado.FieldDefs.Add('VALOR_NOMINAL', ftCurrency, 0, false);
    fdmTPParcelado.FieldDefs.Add('PARCELA', ftString, 20, false);
    fdmTPParcelado.FieldDefs.Add('ID_TITULO_PAGAR', ftString, 36, false);
    fdmTPParcelado.FieldDefs.Add('DATA_VENCIMENTO', ftDate, 0, false);


    fdmTPParcelado.CreateDataSet;



end;

procedure TfrmTituloPagarParcelado.edtQtdParcelasChange(Sender: TObject);
begin
  parcela := StrToInt(edtQtdParcelas.Text);

if parcela > 0  then begin

  edtValorDespesa.Value := edtValorTP.Value * parcela;

end else begin ShowMessage('A parcela n�o pode ser menor que 1'); edtQtdParcelas.Text := '1';  end;
end;

procedure TfrmTituloPagarParcelado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmTituloPagarParcelado.FormCreate(Sender: TObject);
begin

  if not Assigned(dmConexao) then begin
     dmConexao := TdmConexao.Create(Self);
  end;

  dmConexao.conectarBanco;
 btnConfirmar.Enabled := False;
end;



procedure TfrmTituloPagarParcelado.gridTPCellClick(Column: TColumn);
begin
  edtTotalParcelado.Value := obterTotalParcelado;
  liberaBtnProvisao;
end;

procedure TfrmTituloPagarParcelado.limparTable;
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

end;

function TfrmTituloPagarParcelado.obterTotalParcelado: Currency;
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
