unit uFrmManterTipoAcrescimo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,  uContaContabilModel, uContaContabilDAO, uHistoricoModel,
  uFrameContaContabil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg, uFrameGeneric, uFrameHistorico;

type
  TfrmManterTipoAcrescimo = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrd1: TDBGrid;
    dsGrid: TDataSource;
    edtDescricaoConta: TEdit;
    edtCODREDUZ: TEdit;
    lbl1: TLabel;
    edtContaContabil: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
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
    frameHistorico1: TframeHistorico;
    edtTipo: TEdit;
    frmContaContabil1: TfrmContaContabil;
    lbl6: TLabel;
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
    procedure dxBtnLimparClick(Sender: TObject);
    procedure frameHistorico1cbbcomboChange(Sender: TObject);
    procedure edtTipoExit(Sender: TObject);
  private
    { Private declarations }
 pTipoHistorico,   pIdContaContabil, pIdTipo, pIdHistorico,  pIdOrganizacao, pIdUsuario :string;
   FslistaIdHistorico,   FsListaIdContas : TStringList;
    pTable :string;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;

    function obterIndiceHistorico(pHistorico: String): Integer;

    function salvarTipo(pIdOrganizacao,pIdTipo, pIdHistorico, pDescricao: string): Boolean;

    function qtdUso(pIdOrganizacao, pIdvalue: string): Integer;
    function deletar (pIdOrganizacao, pIdValue :string): Boolean;

  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao :string);

  end;

var
  frmManterTipoAcrescimo: TfrmManterTipoAcrescimo;

implementation

{$R *.dfm}

procedure TfrmManterTipoAcrescimo.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('DESCRICAO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterTipoAcrescimo.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

function TfrmManterTipoAcrescimo.deletar(pIdOrganizacao, pIdValue: string): Boolean;
var cmd :string;
qryDel :TFDQuery;
begin
try

      cmd := ' DELETE FROM ' + pTable + ' WHERE  (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_' + pTable + ' = :PID ) ';

      qryDel := TFDQuery.Create(Self);
      qryDel.Close;
      qryDel.Connection := dmConexao.conn;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(cmd);
      qryDel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryDel.ParamByName('PID').AsString := pIdValue;
      qryDel.ExecSQL;

  dmConexao.conn.CommitRetaining;

except
  dmConexao.conn.RollbackRetaining;
  Result := System.False;
raise Exception.Create(' Não foi possível deletar o tipo. Inform ao suporte.');

end;
  limparPanel;
  Result := System.True;
end;

procedure TfrmManterTipoAcrescimo.dsGridDataChange(Sender: TObject;
  Field: TField);
  var
  idContaContabil :string;
  I: Integer;
  conta :TContaContabilModel;


begin
    pIdTipo                :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_TIPO_ACRESCIMO').AsString;
    edtTipo.Text           :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('DESCRICAO').AsString;
    idContaContabil        :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTA_CONTABIL').AsString;
    edtDescricaoConta.Text :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CONTA').AsString;
    edtCODREDUZ.Text       :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CODREDUZ').AsString;
    pIdHistorico           :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_HISTORICO').AsString;
    edtCodHistPadrao.Text  :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CODIGO').AsString;

    frameHistorico1.cbbcombo.ItemIndex := obterIndiceHistorico(pIdHistorico);


    if qtdUso(pIdOrganizacao, pIdTipo) = 0 then
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

procedure TfrmManterTipoAcrescimo.dxBtnDeletarClick(Sender: TObject);
begin

 if deletar(pIdOrganizacao, pIdTipo) then begin
  ShowMessage('Tipo deletado com sucesso.');
 end;
end;

procedure TfrmManterTipoAcrescimo.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled :=False;
  frameHistorico1.cbbcombo.Enabled :=True;
  edtTipo.Enabled :=True;
  cxbrdtmPesquisa.Enabled :=False;

  pIdHistorico        :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_HISTORICO').AsString;
  pIdContaContabil    := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CONTA_CONTABIL').AsString;

  dxBtnSalvar.Enabled :=true ;
  dxBtnNovo.Enabled :=False;

end;

procedure TfrmManterTipoAcrescimo.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterTipoAcrescimo.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
end;

procedure TfrmManterTipoAcrescimo.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;

  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;

  frameHistorico1.cbbcombo.Enabled :=True;
  frameHistorico1.cbbcombo.ItemIndex :=0;
  edtTipo.Enabled     :=True;

  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;

  pIdHistorico :='';
  pIdTipo :='';
  pIdContaContabil :='';

  cxbrdtmPesquisa.Enabled :=False;




end;

procedure TfrmManterTipoAcrescimo.dxBtnSalvarClick(Sender: TObject);
var
 conta :TContaContabilModel;
 historico :THistoricoModel;
 pDescricao :string;

begin
  historico := THistoricoModel.Create;
  historico := frameHistorico1.getHistorico(pIdOrganizacao, pIdHistorico);

  if not uUtil.Empty(historico.FIdContaContabil) then
  begin
    conta := TContaContabilModel.Create;
    conta := frmContaContabil1.obterPorID(pIdOrganizacao, historico.FIdContaContabil);

    if not uutil.Empty(conta.FID) then
      pIdContaContabil := conta.FID;

  end;

  pDescricao   := UpperCase(edtTipo.Text);

  if salvarTipo(pIdOrganizacao,pIdTipo,historico.FIdHistorico,pDescricao ) then begin

        ShowMessage('Tipo salvo com sucesso.');

  end;

   limparPanel;

end;

procedure TfrmManterTipoAcrescimo.edtTipoExit(Sender: TObject);
begin
if Length(edtTipo.Text) > 20 then begin

    ShowMessage('O tipo só pode ter até 20 caracteres. Verifique!');

  end;
end;

procedure TfrmManterTipoAcrescimo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterTipoAcrescimo.FormCreate(Sender: TObject);
begin
 pTable :='TIPO_ACRESCIMO';
  dxRibbon1Tab1.Caption := 'Manutenção de Acréscimos';
  pTipoHistorico := 'A'; //para preencher o frame historico
 inicializarDM(Self);
end;

procedure TfrmManterTipoAcrescimo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterTipoAcrescimo.frameHistorico1cbbcomboChange(Sender: TObject);
var
conta : TContaContabilModel;
historico :THistoricoModel;
begin
    if frameHistorico1.cbbcombo.ItemIndex > 0 then
    begin
      pIdHistorico := FslistaIdHistorico[frameHistorico1.cbbcombo.ItemIndex];
      historico := THistoricoModel.Create;
      historico := frameHistorico1.getHistorico(pIdOrganizacao, pIdHistorico);

      if not uutil.Empty(historico.FIdHistorico) then
      begin
          edtCodHistPadrao.Text := IntToStr(historico.FCodigo);

        if not uUtil.Empty(historico.FIdContaContabil) then
        begin
          pIdContaContabil := historico.FIdContaContabil;
          conta := TContaContabilModel.Create;
          conta := frmContaContabil1.obterPorID(pIdOrganizacao, pIdContaContabil);

          if not uUtil.Empty(conta.FCodigoReduzido) then
          begin

            edtDescricaoConta.Text := conta.FDescricao;
            edtCODREDUZ.Text := conta.FCodigoReduzido;
            edtContaContabil.Text := conta.FConta;
            pIdContaContabil := conta.FID;
          end;

        end;

      end;
    end;

end;

procedure TfrmManterTipoAcrescimo.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterTipoAcrescimo.frmContaContabil1cbbContaContabilChange(
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

procedure TfrmManterTipoAcrescimo.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;

 limparPanel;

end;

procedure TfrmManterTipoAcrescimo.limparPanel();
begin
 limpaStatusBar;
 frmContaContabil1.Visible :=False;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=IntToStr(uutil.TUserAtual.getUserId);

 frmContaContabil1.obterTodos(pIdOrganizacao, frmContaContabil1.cbbContaContabil,FsListaIdContas);
 frameHistorico1.obterTodosPorTipo(pIdOrganizacao,pTipoHistorico,  frameHistorico1.cbbcombo, FslistaIdHistorico);

 preencheGrid(pIdOrganizacao);

 //botao editar muda
  dbgrd1.Enabled :=True;

  edtCodHistPadrao.Enabled :=False;


  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := false;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;
  cxbrdtmPesquisa.Enabled :=True;

  frmContaContabil1.cbbContaContabil.ItemIndex :=0;
  frameHistorico1.cbbcombo.ItemIndex :=0;

  edtDescricaoConta.Clear;
  edtCodHistPadrao.Clear;
  edtDescricaoConta.Clear;
  edtCODREDUZ.Clear;
  edtContaContabil.Clear;
  edtTipo.Clear;


end;

procedure TfrmManterTipoAcrescimo.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;


procedure TfrmManterTipoAcrescimo.preencheGrid(pIdOrganizacao: string);
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try

    sqlCmd := ' SELECT  D.DESCRICAO, D.ID_TIPO_ACRESCIMO, '+
              ' HST.ID_HISTORICO, '+
              ' HST.ID_ORGANIZACAO, '+
              ' HST.DESCRICAO AS DSC_HIST, '+
              ' HST.CODIGO, '+
              ' HST.ID_CONTA_CONTABIL, '+
              ' CC.CONTA,  CC.CODREDUZ '+
              ' FROM TIPO_ACRESCIMO D '+
              ' LEFT OUTER JOIN HISTORICO HST ON (HST.ID_HISTORICO = D.ID_HISTORICO) AND (HST.ID_ORGANIZACAO = D.ID_ORGANIZACAO) '+
              ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = HST.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = D.ID_ORGANIZACAO) '+
              ' WHERE (HST.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
              ' ORDER BY D.DESCRICAO ' ;

    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;

 except
 raise Exception.Create('Erro ao obter lista de '+ pTable );

 end;

end;

function TfrmManterTipoAcrescimo.qtdUso(pIdOrganizacao, pIdvalue: string): Integer;
  var
qryTP, qryTR : TFDQuery;
cmd : string;
qtd :Integer;

begin
  dmConexao.conectarBanco;
  qtd := 0;

  try

    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_PAGAR_BAIXA_AC  FROM TITULO_PAGAR_BAIXA_AC TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_'+ ptable + ' = :PID) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PID').AsString := pIdvalue;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;


    cmd := ' SELECT  FIRST 1 TP.ID_TITULO_RECEBER_BAIXA_AC  FROM TITULO_RECEBER_BAIXA_AC TP WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TP.ID_'+ ptable + ' = :PID) ';

    qryTP := TFDQuery.Create(Self);
    qryTP.Close;
    qryTP.Connection := dmConexao.conn;
    qryTP.SQL.Clear;
    qryTP.SQL.Add(cmd);
    qryTP.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTP.ParamByName('PID').AsString := pIdvalue;
    qryTP.Open;

    qtd := qtd + qryTP.RecordCount;


  except
    raise Exception.Create('Erro ao buscar uso dos TIPOS ');

  end;

  Result := qtd;

end;

procedure TfrmManterTipoAcrescimo.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function TfrmManterTipoAcrescimo.obterIndiceHistorico(
  pHistorico: String): Integer;
  var
 I, posicao :Integer;

begin
posicao :=0;

if not uutil.Empty(pHistorico) then begin

 if FslistaIdHistorico.Count >0  then begin
   for I := 0 to FslistaIdHistorico.Count -1 do begin
       if FslistaIdHistorico[I].Equals(pHistorico) then begin
         posicao := I;
         Break
       end;
  end;
 end;

end else begin Result := posicao; end;

Result :=posicao;

end;



function TfrmManterTipoAcrescimo.salvarTipo(pIdOrganizacao,pIdTipo, pIdHistorico, pDescricao: string): Boolean;

//salvar tipo
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

   cmdSalvar := ' UPDATE '+ptable + ' SET DESCRICAO = :PDESCRICAO , '+
                ' ID_HISTORICO = :PIDHISTORICO ' +
                ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_' + ptable + ' = :PID) ';



   if UUTIL.Empty(pIdTipo) then begin

     pIdTipo := dmConexao.obterNewID;


   cmdSalvar := ' INSERT  INTO '+ptable + ' (ID_' + ptable + ' , ID_ORGANIZACAO, ' +
                ' DESCRICAO, ID_HISTORICO  ) ' +
                ' VALUES ( :PID,:PIDORGANIZACAO, :PDESCRICAO, :PIDHISTORICO )' ;
   end;

    if not uUtil.Empty(pIdTipo) then
    begin

      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PID').AsString := pIdTipo;
      qrySalvar.ParamByName('PIDHISTORICO').AsString := pIdHistorico;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySalvar.ParamByName('PDESCRICAO').AsString := UpperCase(pDescricao);

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
