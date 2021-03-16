unit uFrmManterBaseGrid;

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
  TfrmManterBaseGrid = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrd1: TDBGrid;
    dsGrid: TDataSource;
    qryPreencheGrid: TFDQuery;
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
    msgDlg: TEvMsgDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsGridDataChange(Sender: TObject; Field: TField);
    procedure frmContaContabil1cbbContaContabilChange(Sender: TObject);
    procedure dxBtnEditarClick(Sender: TObject);
    procedure dxBtnSalvarClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnNovoClick(Sender: TObject);
    procedure dxBtnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
  private
    { Private declarations }
  pIdContaContabil, pIdHistorico,  pIdOrganizacao, pIdUsuario :string;
FslistaTipo,    FsListaIdContas : TStringList;
pTable :string;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    function obterTipoHistorico(pTipo: String): Integer;
    procedure preencheComboTipo;
    function salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil,
      pTipo, pDescricao: string; pCodigo: Integer): Boolean;
    function qtdUso(pIdOrganizacao, pIdHistorico :string): Integer;
    function deletar (pIdOrganizacao, pIdValue :string): Boolean;


  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao :string);

  end;

var
  frmManterBaseGrid: TfrmManterBaseGrid;

implementation

{$R *.dfm}

procedure TfrmManterBaseGrid.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('DESCRICAO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterBaseGrid.dbgrd1TitleClick(Column: TColumn);
begin
qryPreencheGrid.IndexFieldNames :=Column.FieldName;
end;

function TfrmManterBaseGrid.deletar(pIdOrganizacao, pIdValue: string): Boolean;
var cmd :string;
qryDel :TFDQuery;
pIdTable :string;
begin
 pTable := 'qual tabela';
pIdTable:= 'ID_'+pTable;

try

      cmd := ' DELETE FROM '+ pTable  + ' WHERE  ( '+pIdTable +' = :P' + pIdTable + ') AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';

      qryDel := TFDQuery.Create(Self);
      qryDel.Close;
      qryDel.Connection := dmConexao.conn;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(cmd);
      qryDel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryDel.ParamByName('P'+pIdTable).AsString := pIdValue;
      qryDel.ExecSQL;

  dmConexao.conn.CommitRetaining;

except
  dmConexao.conn.RollbackRetaining;
  Result := System.False;
raise Exception.Create(' N�o foi poss�vel deletar o hist�rico. Inform ao suporte.');

end;
  limparPanel;
  Result := System.True;
end;

procedure TfrmManterBaseGrid.dsGridDataChange(Sender: TObject;
  Field: TField);
  var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;


begin

// ver o que fazer aqui

end;

procedure TfrmManterBaseGrid.dxBtnDeletarClick(Sender: TObject);
begin

 if deletar(pIdOrganizacao, pIdHistorico) then begin
  ShowMessage('Hist�rico deletado com sucesso.');
 end;
end;

procedure TfrmManterBaseGrid.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled :=False;
  pIdHistorico := qryObterHistoricos.FieldByName('ID_HISTORICO').AsString;
  pIdContaContabil := qryObterHistoricos.FieldByName('ID_CONTA_CONTABIL').AsString;
  dxBtnSalvar.Enabled :=true ;
  dxBtnNovo.Enabled :=False;

end;

procedure TfrmManterBaseGrid.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterBaseGrid.dxBtnNovoClick(Sender: TObject);
begin

  limparPanel;
  dbgrd1.Enabled :=False;
  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;

end;

procedure TfrmManterBaseGrid.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 pDescricao, pTipo :string;
 pCodigo :Integer;

begin

 //fazer p salvar proprio

  if salvarHistorico(pIdOrganizacao, pIdHistorico,pIdContaContabil,pTipo,pDescricao,pCodigo) then begin

     ShowMessage('Hist�rico salvo com sucesso.');

   end;

   limparPanel;

end;

procedure TfrmManterBaseGrid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterBaseGrid.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmManterBaseGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterBaseGrid.freeAndNilDM(Sender: TObject);
begin

//nada
end;


procedure TfrmManterBaseGrid.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;

end;

procedure TfrmManterBaseGrid.limparPanel();
begin
 limpaStatusBar;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;
// frmPeriodo1.inicializa(IncDay(Now, -1), Now);
 preencheComboTipo();
 preencheGrid(pIdOrganizacao);


 //botao editar muda
  dbgrd1.Enabled :=True;
  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := True;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;

  //botao novo



end;

procedure TfrmManterBaseGrid.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterBaseGrid.preencheGrid(pIdOrganizacao: string);
begin

dmConexao.conectarBanco;
 try

   qryPreencheGrid.Close;
   qryPreencheGrid.Connection := dmConexao.conn;
   qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryPreencheGrid.Open;

   dbgrd1.DataSource.DataSet.Last;
   dbgrd1.DataSource.DataSet.First;
  // dbgrd1.DataSource.DataSet.Refresh;

 except
 raise Exception.Create('Erro ao obter lista de  ' + pTable );

 end;


end;

function TfrmManterBaseGrid.qtdUso(pIdOrganizacao,  pIDvalue: string): Integer;
  var
qryPesquisa  : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
  qtd := 0;

  try

    cmd := ' SELECT FIRST 1 FROM TITULO_PAGAR_HISTORICO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmd);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
    qryPesquisa.Open;


    qtd := qryPesquisa.Recordcount;


    cmd := ' SELECT  FIRST 1  FROM TITULO_PAGAR TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmd);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
    qryPesquisa.Open;

     qtd := qtd+ qryPesquisa.Recordcount;



    if qtd < 1 then
    begin

      cmd := ' SELECT  FIRST 1  FROM TITULO_RECEBER_HISTORICO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryPesquisa := TFDQuery.Create(Self);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryPesquisa.Open;

              qtd := qtd+ qryPesquisa.Recordcount;

    end;

     if qtd < 1 then
    begin

      cmd := ' SELECT  FIRST 1  FROM TITULO_RECEBER TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryPesquisa := TFDQuery.Create(Self);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryPesquisa.Open;

         qtd := qtd+ qryPesquisa.Recordcount;

    end;


     if qtd < 1 then
    begin

      cmd := ' SELECT  FIRST 1  FROM TESOURARIA_CREDITO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryPesquisa := TFDQuery.Create(Self);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryPesquisa.Open;

        qtd := qtd+ qryPesquisa.Recordcount;

    end;



     if qtd < 1 then
    begin

      cmd := ' SELECT  FIRST 1  FROM TESOURARIA_DEBITO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryPesquisa := TFDQuery.Create(Self);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryPesquisa.Open;

         qtd := qtd+ qryPesquisa.Recordcount;

    end;


     if qtd < 1 then
    begin

      cmd := ' SELECT  FIRST 1  FROM TIPO_ACRESCIMO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryPesquisa := TFDQuery.Create(Self);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryPesquisa.Open;

         qtd := qtd+ qryPesquisa.Recordcount;
    end;


     if qtd < 1 then
    begin

      cmd := ' SELECT FIRST 1  FROM TIPO_DEDUCAO TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_HISTORICO = :PIDHISTORICO) ';

      qryPesquisa := TFDQuery.Create(Self);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryPesquisa.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qryPesquisa.Open;

         qtd := qtd+ qryPesquisa.Recordcount;

    end;


  except
    raise Exception.Create('Erro ao buscar uso dos hist�ricos ');

  end;

  Result := qtd;

end;

procedure TfrmManterBaseGrid.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function TfrmManterBaseGrid.obterTipoHistorico(pTipo :String) :Integer;
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

procedure TfrmManterBaseGrid.preencheComboTipo;
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
  cbbTipo.Items.Add('Dedu��es');
  cbbTipo.Items.Add('Acr�scimos');
  cbbTipo.Items.Add('Caixa');
end;


function  TfrmManterBaseGrid.salvarHistorico(pIdOrganizacao, pIdHistorico, pIdContaContabil, pTipo, pDescricao :string; pCodigo :Integer) :Boolean;
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

end.
