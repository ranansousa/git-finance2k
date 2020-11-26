unit uFrmManterHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel,
  uFrameContaContabil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg;

type
  TfrmManterHistorico = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    frmContaContabil1: TfrmContaContabil;
    dbgrd1: TDBGrid;
    dsHistorico: TDataSource;
    edtDescricaoConta: TEdit;
    edtCODREDUZ: TEdit;
    lbl1: TLabel;
    edtContaContabil: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    edtHistorico: TEdit;
    lbl4: TLabel;
    cbbTipo: TComboBox;
    edtCodHistPadrao: TEdit;
    lbl5: TLabel;
    dxBarManager1Bar1: TdxBar;
    dxBtnEditar: TdxBarLargeButton;
    dxBarSalvar: TdxBar;
    dxBtnSalvar: TdxBarLargeButton;
    dxBarManager1Bar2: TdxBar;
    dxBtnNovo: TdxBarLargeButton;
    dxBarManager1Bar3: TdxBar;
    dxBtnFechar: TdxBarLargeButton;
    dxBarManager1Bar4: TdxBar;
    dxBtnDeletar: TdxBarLargeButton;
    dxBarManager1Bar5: TdxBar;
    cxbrdtmPesquisa: TcxBarEditItem;
    qryPreencheGrid: TFDQuery;
    dxBarManager1Bar6: TdxBar;
    dxBtnLimpar: TdxBarLargeButton;
    PempecMsg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsHistoricoDataChange(Sender: TObject; Field: TField);
    procedure frmContaContabil1cbbContaContabilChange(Sender: TObject);
    procedure dxBtnEditarClick(Sender: TObject);
    procedure dxBtnSalvarClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnNovoClick(Sender: TObject);
    procedure dxBtnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
  private
    { Private declarations }
   pIdContaContabil, pIdHistorico,  pIdOrganizacao, pIdUsuario :string;
   FslistaTipo,    FsListaIdContas : TStringList;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    function obterTipoHistorico(pTipo: String): Integer;
    procedure preencheComboTipo;
    function salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil,
      pTipo, pDescricao: string; pCodigo: Integer): Boolean;
    function qtdUso(pIdOrganizacao, pIdHistorico: string): Integer;
    function deletar (pIdOrganizacao, pIdHistorico :string): Boolean;
    function isValidForm: Boolean;


  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao :string);

  end;

var
  frmManterHistorico: TfrmManterHistorico;

implementation

{$R *.dfm}

procedure TfrmManterHistorico.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('DESCRICAO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterHistorico.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

function TfrmManterHistorico.deletar(pIdOrganizacao, pIdHistorico: string): Boolean;
var cmd :string;
qryDel :TFDQuery;
begin

try

      cmd := ' DELETE FROM HISTORICO  WHERE  (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_HISTORICO = :PIDHISTORICO) ';

      qryDel := TFDQuery.Create(Self);
      qryDel.Close;
      qryDel.Connection := dmConexao.conn;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(cmd);
      qryDel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryDel.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryDel.ExecSQL;

  dmConexao.conn.CommitRetaining;

except
  dmConexao.conn.RollbackRetaining;
  Result := System.False;
raise Exception.Create(' Não foi possível deletar o histórico. Inform ao suporte.');

end;
  limparPanel;
  Result := System.True;
end;

procedure TfrmManterHistorico.dsHistoricoDataChange(Sender: TObject;
  Field: TField);
  var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;


begin
    idContaContabil :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTA_CONTABIL').AsString;
    edtHistorico.Text :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('DESCRICAO').AsString;
    cbbTipo.ItemIndex := obterTipoHistorico( (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('TIPO').AsString);
    edtCodHistPadrao.Text :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CODIGO').AsString;
    pIdHistorico :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_HISTORICO').AsString;

    if qtdUso(pIdOrganizacao, pIdHistorico) = 0 then
    begin
      dxBtnDeletar.Enabled := True;
    end
    else
    begin
      dxBtnDeletar.Enabled := False;
    end;

    if not uUtil.Empty(idContaContabil) then
  begin

    for I := 0 to FsListaIdContas.Count -1 do begin
         if FsListaIdContas[I].Equals(idContaContabil) then begin
             frmContaContabil1.cbbContaContabil.ItemIndex := I;
            conta := TContaContabilModel.Create;
            conta := frmContaContabil1.obterPorID(pIdOrganizacao, idContaContabil);

            if not uUtil.Empty(conta.FCodigoReduzido)  then begin

               edtDescricaoConta.Text := conta.FDescricao;
               edtCODREDUZ.Text := conta.FCodigoReduzido;
               edtContaContabil.Text :=conta.FConta;
            end;

         end;
    end;

  end
  else
  begin
    frmContaContabil1.cbbContaContabil.ItemIndex := 0;
    edtDescricaoConta.Clear;
    edtCODREDUZ.Clear;
    edtContaContabil.Clear;
  end;

   dxBtnEditar.Enabled := True;

end;

procedure TfrmManterHistorico.dxBtnDeletarClick(Sender: TObject);
begin

 if deletar(pIdOrganizacao, pIdHistorico) then begin
  ShowMessage('Histórico deletado com sucesso.');
 end;
end;

procedure TfrmManterHistorico.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled :=False;
  frmContaContabil1.cbbContaContabil.Enabled :=True;
  cbbTipo.Enabled :=True;
  edtHistorico.Enabled :=True;
  edtCodHistPadrao.Enabled :=True;
  cxbrdtmPesquisa.Enabled :=False;

  pIdHistorico :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_HISTORICO').AsString;
  pIdContaContabil := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTA_CONTABIL').AsString;
  dxBtnSalvar.Enabled :=true ;
  dxBtnNovo.Enabled :=False;

end;

procedure TfrmManterHistorico.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterHistorico.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
end;

procedure TfrmManterHistorico.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;

  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;

  frmContaContabil1.cbbContaContabil.Enabled :=True;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;

  cbbTipo.Enabled          :=True;
  edtHistorico.Enabled     :=True;
  edtCodHistPadrao.Enabled :=True;
  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;

  pIdHistorico :='';
  cxbrdtmPesquisa.Enabled :=False;




end;

procedure TfrmManterHistorico.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 pDescricao, pTipo :string;
 pCodigo :Integer;
begin

  if isValidForm then
  begin

    if frmContaContabil1.cbbContaContabil.ItemIndex > 0 then
    begin
      conta := TContaContabilModel.Create;
      pIdContaContabil := FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
      conta := TContaContabilModel.Create;
      conta := frmContaContabil1.obterPorID(pIdOrganizacao, pIdContaContabil);
    end;

    if not uUtil.Empty(pIdHistorico) then
    begin
      pIdHistorico := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_HISTORICO').AsString;
    end;

    pDescricao := UpperCase(edtHistorico.Text);
    pCodigo := StrToInt(edtCodHistPadrao.Text);
    pTipo := FslistaTipo[cbbTipo.ItemIndex];

    if salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil, pTipo, pDescricao, pCodigo) then
    begin

      PempecMsg.MsgInformation('Histórico salvo com sucesso.');

    end;

    limparPanel;

  end;

end;

procedure TfrmManterHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterHistorico.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
end;

procedure TfrmManterHistorico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterHistorico.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterHistorico.frmContaContabil1cbbContaContabilChange(
  Sender: TObject);
  var
  conta : TContaContabilModel;
begin
  if frmContaContabil1.cbbContaContabil.ItemIndex > 0 then
  begin
    pIdContaContabil := FsListaIdContas[frmContaContabil1.cbbContaContabil.ItemIndex];
    conta := TContaContabilModel.Create;
    conta := frmContaContabil1.obterPorID(pIdOrganizacao, pIdContaContabil);

    if not uUtil.Empty(conta.FCodigoReduzido) then
    begin

      edtDescricaoConta.Text := conta.FDescricao;
      edtCODREDUZ.Text := conta.FCodigoReduzido;
      edtContaContabil.Text := conta.FConta;
      pIdContaContabil :=conta.FID;
    end;

  end;

end;

procedure TfrmManterHistorico.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;

end;

procedure TfrmManterHistorico.limparPanel();
begin
 limpaStatusBar;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

 frmContaContabil1.obterTodos(pIdOrganizacao, frmContaContabil1.cbbContaContabil,FsListaIdContas);
 preencheComboTipo();

  frmContaContabil1.cbbContaContabil.Enabled :=False;
  preencheGrid(pIdOrganizacao);

 //botao editar muda
  dbgrd1.Enabled :=True;

  cbbTipo.Enabled :=False;
  edtHistorico.Enabled :=False;
  edtCodHistPadrao.Enabled :=False;


  edtDescricaoConta.Clear;
  edtCodHistPadrao.Clear;
  edtDescricaoConta.Clear;
  edtCODREDUZ.Clear;
  edtContaContabil.Clear;
  edtHistorico.Clear;

  dxBtnNovo.Enabled := True;
 dxBtnEditar.Enabled := False;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;
  cxbrdtmPesquisa.Enabled :=True;


  cbbTipo.ItemIndex :=0;
  frmContaContabil1.cbbContaContabil.ItemIndex :=0;


end;

procedure TfrmManterHistorico.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterHistorico.preencheGrid(pIdOrganizacao: string);
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try

    sqlCmd := ' SELECT HST.ID_HISTORICO, '+
              ' HST.ID_ORGANIZACAO, '+
              ' HST.DESCRICAO, '+
              ' HST.TIPO, '+
              ' HST.CODIGO, '+
              ' HST.ID_CONTA_CONTABIL, '+
              ' CC.CONTA, CC.CODREDUZ, '+
              ' HST.DESCRICAO_REDUZIDA '+
              ' FROM HISTORICO HST '+
              ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = HST.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = HST.ID_ORGANIZACAO) '+
              ' WHERE (HST.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
              ' ORDER BY HST.DESCRICAO ' ;
    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;

 except
 raise Exception.Create('Erro ao obter lista de históricos');

 end;


end;

function TfrmManterHistorico.qtdUso(pIdOrganizacao, pIdHistorico: string): Integer;
  var
qryTP, qryTR : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
  qtd := 0;

  try

    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_PAGAR_HISTORICO  FROM TITULO_PAGAR_HISTORICO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;


    cmd := ' SELECT FIRST 1 TP.ID_TITULO_PAGAR FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;



    if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TITULO_RECEBER_HISTORICO FROM TITULO_RECEBER_HISTORICO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;

     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TITULO_RECEBER FROM TITULO_RECEBER TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryTP.Open;

      qtd := qtd + qryTP.RecordCount;

    end;


     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_CREDITO FROM TESOURARIA_CREDITO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;



     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TESOURARIA_DEBITO FROM TESOURARIA_DEBITO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;


     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TIPO_ACRESCIMO FROM TIPO_ACRESCIMO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;


     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1 TP.ID_TIPO_DEDUCAO FROM TIPO_DEDUCAO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryTP := TFDQuery.Create(Self);
      qryTP.Close;
      qryTP.Connection := dmConexao.conn;
      qryTP.SQL.Clear;
      qryTP.SQL.Add(cmd);
      qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTP.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryTP.Open;

    qtd := qtd + qryTP.RecordCount;

    end;


  except
    raise Exception.Create('Erro ao buscar uso dos históricos ');

  end;

  Result := qtd;

end;

procedure TfrmManterHistorico.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function TfrmManterHistorico.obterTipoHistorico(pTipo :String) :Integer;
var
  posicao: Integer;
  I: Integer;
begin
  posicao := 0;

  for I := 0 to FslistaTipo.Count -1 do begin
       if FslistaTipo[I].Equals(pTipo) then begin
         posicao := I;
       end;
  end;

  Result := posicao;
end;

procedure TfrmManterHistorico.preencheComboTipo;
begin

  FslistaTipo :=TStringList.Create;
  FslistaTipo.Clear;
  FslistaTipo.Add('0');
  FslistaTipo.Add('G');
  FslistaTipo.Add('P');
  FslistaTipo.Add('R');
  FslistaTipo.Add('D');
  FslistaTipo.Add('A');

  cbbTipo.Clear;
  cbbTipo.Items.Add(' >>Selecione<<');
  cbbTipo.Items.Add('Geral');
  cbbTipo.Items.Add('Pagamentos');
  cbbTipo.Items.Add('Recebimentos');
  cbbTipo.Items.Add('Deduções');
  cbbTipo.Items.Add('Acréscimos');
  cbbTipo.Items.Add('Caixa');
end;


function  TfrmManterHistorico.salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil, pTipo, pDescricao :string; pCodigo :Integer) :Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

   cmdSalvar := ' UPDATE HISTORICO  SET DESCRICAO = :PDESCRICAO ,  TIPO = :PTIPO, '+
                ' ID_CONTA_CONTABIL = :PIDCONTA , CODIGO = :PCODIGO, ' +
                ' DESCRICAO_REDUZIDA = :PDESCREDUZ ' +
                ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_HISTORICO = :PIDHISTORICO) ';



   if UUTIL.Empty(pIdHistorico) then begin

     pIdHistorico := dmConexao.obterNewID;


   cmdSalvar := ' INSERT  INTO HISTORICO (ID_HISTORICO, ID_ORGANIZACAO, ' +
                ' DESCRICAO, TIPO, CODIGO, ID_CONTA_CONTABIL, DESCRICAO_REDUZIDA  ) ' +
                ' VALUES (:PIDHISTORICO, :PIDORGANIZACAO, :PDESCRICAO, :PTIPO, :PCODIGO, :PIDCONTA, :PDESCREDUZ)' ;
   end;

    if not uUtil.Empty(pIdHistorico) then
    begin

      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySalvar.ParamByName('PDESCRICAO').AsString := UpperCase(pDescricao);
      qrySalvar.ParamByName('PDESCREDUZ').AsString := UpperCase(pDescricao);
      qrySalvar.ParamByName('PTIPO').AsString := UpperCase(pTipo);
      qrySalvar.ParamByName('PIDCONTA').AsString := pIdContaContabil;
      qrySalvar.ParamByName('PCODIGO').AsInteger := pCodigo;
      qrySalvar.ExecSQL;

      dmConexao.conn.CommitRetaining;
    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o historico.');
 end;

  Result :=True;
end;


 function TfrmManterHistorico.isValidForm :Boolean;
var i:integer;
liberado : Boolean;

begin
 liberado :=false;

 msgStatusBar(1, 'Verifique os campos obrigatórios.');

      for i := 0 to Self.ComponentCount - 1 do
      begin
          {  if ActiveControl is Tedit then begin
                 Showmessage(TEdit(ActiveControl).Name); end; }
        if Self.components[i] is TEdit then
        begin
          if (Tedit(components[i]).tag = 1) and uutil.Empty((Tedit(components[i]).text)) then
          begin
                    liberado := false;

                    TEdit(Components[i]).Enabled := True;
                    TEdit(Components[i]).Visible := True;
                    TEdit(Components[i]).SetFocus;
                    PempecMsg.MsgWarning('Alguns campos obrigatórios não foram preenchidos!' );
                    Break


          end
          else
          begin
            liberado := True;
          end;

        end;
      end;



Result := liberado;
end;

end.
