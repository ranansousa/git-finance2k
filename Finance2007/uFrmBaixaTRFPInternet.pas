unit uFrmBaixaTRFPInternet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, udmConexao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameContaBancaria, uUtil, uSacadoModel, uSacadoDAO, uTituloReceberModel, uTituloReceberDAO,
  Vcl.StdCtrls, ENumEd, uTRBaixaInternetModel, System.DateUtils, uTipoOperacaoBancariaModel, uTipoOperacaoBancariaDAO, Vcl.ComCtrls,
  uFrameBanco;

type
  TfrmBaixaTRFPInternet = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    edtValor: TEvNumEdit;
    lbl1: TLabel;
    dtpEmissao: TDateTimePicker;
    lbl2: TLabel;
    btnConfirmaCh: TButton;
    btnCancelar: TButton;
    edtDetalhamento: TEdit;
    lbl8: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure btnConfirmaChClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);


  private
    { Private declarations }

    FSListaIDConta :TStringList;
    idTRB,  idTOB, iDConta,  pIdOrganizcacao : string;
    pValor :Currency;
    baixaWWWAux : TTRBaixaInternetModel;
  public
    { Public declarations }
    function getBaixaWWW: TTRBaixaInternetModel;
    constructor Create(AOwner: TComponent; var baixaWWW: TTRBaixaInternetModel );

  end;

var
  frmBaixaTRFPInternet: TfrmBaixaTRFPInternet;

implementation

{$R *.dfm}

{ TfrmBaixaFPCheque }

function TfrmBaixaTRFPInternet.getBaixaWWW: TTRBaixaInternetModel;
begin
  Result := baixaWWWAux;
end;


procedure TfrmBaixaTRFPInternet.btnCancelarClick(Sender: TObject);
begin
  baixaWWWAux := TTRBaixaInternetModel.Create;
  baixaWWWAux.FID :='';
  baixaWWWAux.Fvalor :=0;
  baixaWWWAux.FIDTRB := '';

 idTOB :='';
 iDConta := '';
 LimpaTela(Self);
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmBaixaTRFPInternet.btnConfirmaChClick(Sender: TObject);
begin


       baixaWWWAux := TTRBaixaInternetModel.Create;
       baixaWWWAux.FIDTOB                   := idTOB;
       baixaWWWAux.FIDorganizacao           := pIdOrganizcacao;
       baixaWWWAux.Fvalor                   := edtValor.Value;
       baixaWWWAux.Fdetalhamento            := edtDetalhamento.Text;
       baixaWWWAux.FdataOperacao            := dtpEmissao.DateTime;
       baixaWWWAux.FIDcontaBancaria         := iDConta;
       baixaWWWAux.FID                      := dmConexao.obterNewID;
       baixaWWWAux.FIDTRB                   := idTRB;



 PostMessage(Self.Handle, WM_CLOSE, 0, 0);

end;


constructor TfrmBaixaTRFPInternet.Create(AOwner: TComponent; var baixaWWW: TTRBaixaInternetModel );
var
tipoTOB : TTipoOperacaoBancariaModel;
 indiceBanco : Integer;
begin
  inherited Create(AOwner);

    idTRB := baixaWWW.FIDTRB;
    baixaWWWAux := baixaWWW;

    pValor                := baixaWWW.Fvalor;
    pIdOrganizcacao       := baixaWWW.FIDorganizacao;
    edtDetalhamento.Text  := baixaWWW.Fdetalhamento;
    edtValor.Value        := pValor;

    FSListaIDConta        := TStringList.Create;

    FSListaIDConta        := TStringList.Create;

     idTOB := 'PAGTO VIA BANK-LINE';
     tipoTOB := TTipoOperacaoBancariaModel.Create;
     tipoTOB.FIDorganizacao := pIdOrganizcacao;
     tipoTOB.FID := idTOB;
     tipoTOB := TTipoOperacaoBancariaDAO.obterPorID(tipoTOB);
     dtpEmissao.DateTime := baixaWWW.FdataOperacao;
     dtpEmissao.Enabled := False;


    frmContaBancaria1.obterTodos(pIdOrganizcacao, frmContaBancaria1.cbbConta,FSListaIDConta );
    btnConfirmaCh.Enabled := False;

   // Self.Close;

end;

procedure TfrmBaixaTRFPInternet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;


procedure TfrmBaixaTRFPInternet.FormCreate(Sender: TObject);
begin
btnConfirmaCh.Enabled := False;
 idTOB := 'PAGTO VIA BANK-LINE';


end;

procedure TfrmBaixaTRFPInternet.frmContaBancaria1cbbContaChange(Sender: TObject);
begin

 if frmContaBancaria1.cbbConta.ItemIndex > 0 then
  begin
      iDConta := FslistaIdConta[frmContaBancaria1.cbbConta.ItemIndex];
      btnConfirmaCh.Enabled := True;
  end else   begin    btnConfirmaCh.Enabled := False; end ;

end;


end.


