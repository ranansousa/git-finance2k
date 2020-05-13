unit uFrmSelecionaOrganizacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uFrameOrganizacoes, udmConexao, uDMOrganizacao,uUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uDMParametros,  uOrganizacaoDAO, uOrganizacaoModel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmSelectOrganizacao = class(TForm)
    frameOrg1: TframeOrg;
    btnSelecOrg: TButton;
    qryPreencheCombo: TFDQuery;
    lblBoasVindas: TLabel;
    lbl1: TLabel;
    lblSistemaContabil: TLabel;
    qryDadosEmpresaMega: TFDQuery;
    procedure btnSelecOrgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  orgModel : TOrganizacaoModel;
    procedure freeAndNilDM(Sender: TObject);
    procedure inicializarDM(Sender: TObject);
    procedure listaOrganizacao(var combo: TComboBox; var listaID: TStringList);
    function preencheCombo: Boolean;
    procedure AjustaForm;
    function carregarDadosEmpresaMega(pCnpj: string): Boolean;

    { Private declarations }
  public
    { Public declarations }
        FsListaIdOrganizacoes: TStringList;
        ptela,  pid: string;

        function getOrganizacao: TOrganizacaoModel;



  end;

var
  frmSelectOrganizacao: TfrmSelectOrganizacao;

implementation

{$R *.dfm}


procedure TfrmSelectOrganizacao.inicializarDM(Sender: TObject);

begin
       
  if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);

  end;


   if not (Assigned(dmParametros)) then
  begin
    dmParametros := TdmParametros.Create(Self);
      dmParametros.obterTodos;
  end;




end;



procedure TfrmSelectOrganizacao.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmOrganizacao)) then
  begin
    FreeAndNil(dmOrganizacao);
  end;

  if (Assigned(dmParametros)) then
  begin
    FreeAndNil(dmParametros);   end;

end;

function TfrmSelectOrganizacao.getOrganizacao: TOrganizacaoModel;
begin

 Result := orgModel;

end;

procedure TfrmSelectOrganizacao.btnSelecOrgClick(Sender: TObject);
var
  indice: Integer;
  cnpj, fantasia, razao, contabil : string;
begin
  try
      if ( frameOrg1.cbbOrg.ItemIndex > (-1)) then
      begin
        indice := (frameOrg1.cbbOrg.ItemIndex);
        pid := FsListaIdOrganizacoes[indice];

        if (dmOrganizacao.carregarDadosOrganizacaoFNC(pid)) then begin
            //cnpj := Trim(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
            //setando dados da organizacao selecionada
            cnpj :=Trim(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
            fantasia :=dmOrganizacao.qryDadosEmpresa.FieldByName('FANTASIA').AsString;
            razao :=dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString;
            contabil :=dmOrganizacao.qryDadosEmpresa.FieldByName('SISTEMA_CONTABIL').AsString;

            uUtil.TOrgAtual.setId(pid);
            uUtil.TOrgAtual.setCNPJ(cnpj);
            uUtil.TOrgAtual.setFantasia(fantasia);
            uUtil.TOrgAtual.setRazaoSocial(razao);
            uUtil.TOrgAtual.setSistemaContabil(contabil);
            uUtil.TOrgAtual.setIDSistemaContabil('0'); // 0 = nao tem empresa vinculada

            orgModel      := TOrganizacaoModel.Create;
            orgModel.FID  := pid;
            orgModel      := TOrganizacaoDAO.obterPorID(orgModel);

            if not uutil.Empty( orgModel.FID ) then begin

               cnpj := orgModel.FCNPJ;
            end;



            //tentando pegar o ID da empresa no MEGA e setando na organizacao
            if dmConexao.conectarMega then begin
             if carregarDadosEmpresaMega(cnpj) then begin
               uUtil.TOrgAtual.setIDSistemaContabil(IntToStr(qryDadosEmpresaMega.FieldByName('ID').AsInteger));
             end;
            end;

            if not (uUtil.TOrgAtual.getSistemaContabil = '') then begin
            lblSistemaContabil.Visible :=True;
            lblSistemaContabil.Caption := ' SISTEMA CONTÁBIL   ' + uUtil.TOrgAtual.getSistemaContabil;

            end;

            PostMessage(Self.Handle, WM_CLOSE, 0,0);

        end
        else
        begin
          MessageDlg('Erro ao carregar os dados da organização...', mtWarning, [mbOK], 0);
        end;
      end;


  except
    on e: Exception do
      MessageDlg('Problemas ao selecionar uma empresa...', mtWarning, [mbOK], 0);
  end;




end;

procedure TfrmSelectOrganizacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmSelectOrganizacao.FormCreate(Sender: TObject);
var
msg,nameUser :string;
begin
   lblSistemaContabil.Visible :=false;
   nameUser := uUtil.TUserAtual.getNameUser;
       msg :=' Seja bem vindo(a) Sr(a) ' + nameUser;

   if nameUser =  ''  then begin

      msg :=' Seja bem vindo(a)...  ';

   end;

    if dmOrganizacao.carregarOrganizacoes then
    begin
      listaOrganizacao(frameOrg1.cbbOrg, FsListaIdOrganizacoes);
    end;

    lblBoasVindas.Caption := msg;




end;

procedure TfrmSelectOrganizacao.listaOrganizacao(var combo: TComboBox; var listaID: TStringList);
begin
  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione uma Empresa  >>>');

  if (preencheCombo) then begin
      qryPreencheCombo.First;

      while not qryPreencheCombo.Eof do
       begin

        combo.Items.Add(qryPreencheCombo.FieldByName('RAZAO_SOCIAL').AsString);
        listaID.Add(qryPreencheCombo.FieldByName('ID_ORGANIZACAO').AsString);
        qryPreencheCombo.Next;

       end;
      qryPreencheCombo.Close;
      combo.ItemIndex := 0;
  end;


end;


function TfrmSelectOrganizacao.preencheCombo(): Boolean;
begin

  Result := false;
  try

    qryPreencheCombo.Close;
    qryPreencheCombo.Connection := dmConexao.Conn;
    qryPreencheCombo.Open;
   except
    raise(Exception).Create('Problemas ao carregar organizações.. ');
  end;

    Result := not qryPreencheCombo.IsEmpty;
end;


procedure TfrmSelectOrganizacao.AjustaForm;
Const
nTamOriginal = 680; // Será o 100% da escala
Var
nEscala : Double; // Vai me dar o percentual de Transformação escalar
nPorcento : Integer; // Vai me dar em percentual inteiro o valor
begin
With frmSelectOrganizacao do
begin
      if nTamOriginal <> Screen.Width then
      begin
        nEscala := ((Screen.Width-nTamOriginal)/nTamOriginal);
        nPorcento := Round((nEscala*100) + 100);
        Self.Width := Round(Self.Width * (nEscala+1));
        Self.Height := Round(Self.Height * (nEscala+1));
        Self.ScaleBy(nPorcento,100);
      end;
end;
end;



function TfrmSelectOrganizacao.carregarDadosEmpresaMega(pCnpj: string): Boolean;
var
  x: string;
begin

  dmConexao.conectarMega;

 try
      qryDadosEmpresaMega.Close;
      qryDadosEmpresaMega.Connection := dmConexao.ConnMega;
      qryDadosEmpresaMega.ParamByName('pCnpj').AsString := pCnpj;
      qryDadosEmpresaMega.Open;
 except
    raise(Exception).Create('Erro ao tentar obter dados do MEGA');
 end;

  Result := not qryDadosEmpresaMega.IsEmpty;
end;




end.
