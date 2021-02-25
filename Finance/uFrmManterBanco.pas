unit uFrmManterBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil, uDMOrganizacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, uBancoModel, uBancoDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer, cxEdit,
  cxTextEdit, cxBarEditItem, EMsgDlg, uConstantes;

type
  TfrmManterBanco = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrd1: TDBGrid;
    edtNome: TEdit;
    edtCodigo: TEdit;
    lbl1: TLabel;
    edtSigla: TEdit;
    lbl2: TLabel;
    lbl3: TLabel;
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
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxBtnEditarClick(Sender: TObject);
    procedure dxBtnSalvarClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnNovoClick(Sender: TObject);
    procedure dxBtnDeletarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure dsGridMainDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    pIdBanco, pIdOrganizacao, pIdUsuario: string;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    function salvarBanco(banco: TBancoModel): Boolean;
    function deletar(banco: TBancoModel): Boolean;
    function isValidForm: Boolean;
  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao: string);
  end;

var
  frmManterBanco: TfrmManterBanco;

implementation

{$R *.dfm}

procedure TfrmManterBanco.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('NOME_BANCO', UpperCase(cxbrdtmPesquisa.CurEditValue), [loPartialKey]);
end;

procedure TfrmManterBanco.dbgrd1TitleClick(Column: TColumn);
begin
  (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames := Column.FieldName;
end;

function TfrmManterBanco.deletar(banco: TBancoModel): Boolean;
var
  cmd: string;
  qryDel: TFDQuery;
  permite, sucesso: Boolean;
begin

  sucesso := False;
  permite := true;

  if banco.FINDICE > 0 then
  begin
    permite := False;

  end;

  try
  // (ID_ORGANIZACAO = :PIDORGANIZACAO) AND

    cmd := ' DELETE FROM BANCO  WHERE  (ID_BANCO = :PID) ';

    qryDel := TFDQuery.Create(Self);
    qryDel.Close;
    qryDel.Connection := dmConexao.conn;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(cmd);
//    qryDel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryDel.ParamByName('PID').AsString := pIdBanco;

    if permite then
    begin
      qryDel.ExecSQL;

      dmConexao.conn.CommitRetaining;

      sucesso := True;

    end;

  except
    dmConexao.conn.RollbackRetaining;
    Result := sucesso;
    raise Exception.Create(' Não foi possível deletar o banco. Inform ao suporte.');

  end;
  limparPanel;
  Result := sucesso;
end;

procedure TfrmManterBanco.dsGridMainDataChange(Sender: TObject; Field: TField);
var
  indice: Integer;
begin

  dxBtnDeletar.Enabled := False;

  edtCodigo.Text := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('CODIGO_BANCO').AsString;
  edtNome.Text := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('NOME_BANCO').AsString;
  edtSigla.Text := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('SIGLA_BANCO').AsString;
  indice := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('INDICE').AsInteger;
  pIdBanco := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_BANCO').AsString;
  dxBtnEditar.Enabled := True;

  if indice = 0 then
  begin

    dxBtnDeletar.Enabled := True;
  end;

end;

procedure TfrmManterBanco.dxBtnDeletarClick(Sender: TObject);
var
  bancoModel: TBancoModel;
begin

  bancoModel := TBancoModel.Create;
  bancoModel.FID := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_BANCO').AsString;
  bancoModel.FIDorganizacao := pIdOrganizacao;
  bancoModel := TBancoDAO.obterPorID(bancoModel);

  if not uutil.Empty(bancoModel.FID) then
  begin
    if bancoModel.FINDICE < 1 then
    begin

      if TBancoDAO.Delete(bancoModel) then
      begin

        PempecMsg.MsgInformation('Banco deletado com sucesso.');

      end;
    end
    else
    begin

      PempecMsg.MsgInformation('Não é possível deletar um registro já utilizado.');
    end;

  end;

  limparPanel;

end;

procedure TfrmManterBanco.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled := False;

  cxbrdtmPesquisa.Enabled := False;

  pIdBanco := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_BANCO').AsString;

  edtCodigo.Enabled := True;
  edtSigla.Enabled := True;
  edtNome.Enabled := True;

  dxBtnSalvar.Enabled := true;
  dxBtnNovo.Enabled := False;

end;

procedure TfrmManterBanco.dxBtnFecharClick(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterBanco.dxBtnLimparClick(Sender: TObject);
begin
  limparPanel;
end;

procedure TfrmManterBanco.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;

  dbgrd1.Enabled := False;
  (dbgrd1.DataSource.DataSet as TFDQuery).Close;

  edtNome.Clear;
  edtSigla.Clear;
  edtCodigo.Clear;

  edtCodigo.Enabled := True;
  edtSigla.Enabled := True;
  edtNome.Enabled := True;

  dxBtnSalvar.Enabled := True;
  dxBtnEditar.Enabled := False;

  pIdBanco := '';
  cxbrdtmPesquisa.Enabled := False;

end;

procedure TfrmManterBanco.dxBtnSalvarClick(Sender: TObject);
var
  bancoModel: TBancoModel;
begin

  if isValidForm then
  begin

    bancoModel := TBancoModel.Create;
    bancoModel.FID := dmConexao.obterNewID;
    bancoModel.FIDorganizacao := pIdOrganizacao;
    bancoModel.FCODIGO_BANCO := edtCodigo.Text;
    bancoModel.FNOME_BANCO := edtNome.Text;
    bancoModel.FSIGLA_BANCO := edtSigla.Text;
    bancoModel.FINDICE := 0;
    bancoModel.Fnovo := True;

    if not uUtil.Empty(pIdBanco) then
    begin
      pIdBanco := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_BANCO').AsString;
      bancoModel.FID := pIdBanco;
      bancoModel.Fnovo := False;
      bancoModel.FINDICE := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('INDICE').AsInteger;


      //altera

    end;

    if salvarBanco(bancoModel) then
    begin

      PempecMsg.MsgInformation('Banco salvo com sucesso.');

    end;

    limparPanel;

  end;

end;

procedure TfrmManterBanco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freeAndNilDM(Self);
  Action := caFree;

end;

procedure TfrmManterBanco.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
end;

procedure TfrmManterBanco.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_f2:
      dxBtnEditar.Click;
    vk_f4:
      dxBtnNovo.Click;
    vk_f10:
      dxBtnSalvar.Click;
  end;

end;

procedure TfrmManterBanco.freeAndNilDM(Sender: TObject);
begin

//nada
end;

procedure TfrmManterBanco.inicializarDM(Sender: TObject);
begin
 //nada
  if not Assigned(dmOrganizacao) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  limparPanel;

end;

procedure TfrmManterBanco.limparPanel();
begin
  limpaStatusBar;
  pIdOrganizacao := UUtil.TOrgAtual.getId;
  pIdUsuario := uutil.TUserAtual.getUserId;

  preencheGrid(pIdOrganizacao);

 //botao editar muda
  dbgrd1.Enabled := True;

  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := False;
  dxBtnSalvar.Enabled := False;
  dxBtnDeletar.Enabled := False;
  cxbrdtmPesquisa.Enabled := True;

end;

procedure TfrmManterBanco.msgStatusBar(pPosicao: Integer; msg: string);
begin
  dxStatusBar.Panels[pPosicao].Text := msg;
  Application.ProcessMessages;
end;

procedure TfrmManterBanco.preencheGrid(pIdOrganizacao: string);
var
  sqlCmd: string;
begin

  dmConexao.conectarBanco;
  try

    sqlCmd := ' SELECT ID_BANCO , ' + ' CODIGO_BANCO, ' + ' NOME_BANCO , ' +
              ' SIGLA_BANCO, ' + ' ID_ORGANIZACAO, ' +
              ' COALESCE(INDICE, 0) as INDICE ' + ' FROM BANCO ' + ' ORDER BY NOME_BANCO ';

    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
//    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;

  except
    raise Exception.Create('Erro ao obter lista de bancos');

  end;

end;

procedure TfrmManterBanco.limpaStatusBar;
begin
  dxStatusBar.Panels[0].Text := 'Status ';
  dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function TfrmManterBanco.salvarBanco(banco: TBancoModel): Boolean;
var
  cmdSalvar: string;
  bancoModel: TBancoModel;
  sucesso: Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;

  try

    bancoModel := TBancoModel.Create;
    bancoModel.FID := banco.FID;
    bancoModel.FIDorganizacao := banco.FIDorganizacao;
    bancoModel.FCODIGO_BANCO := banco.FCODIGO_BANCO;
    bancoModel.FNOME_BANCO := banco.FNOME_BANCO;
    bancoModel.FSIGLA_BANCO := banco.FSIGLA_BANCO;
    bancoModel.FINDICE := 0;

    if banco.Fnovo then
    begin

      sucesso := TBancoDAO.Insert(bancoModel);

    end
    else
    begin

      sucesso := TBancoDAO.Update(bancoModel);

    end;

  except
    Result := sucesso;
    raise Exception.Create('Erro ao tentar salvar o Banco.');
  end;

  Result := sucesso;
end;

function TfrmManterBanco.isValidForm: Boolean;
var
  i: integer;
  liberado: Boolean;
begin
  liberado := false;

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
        PempecMsg.MsgWarning('Alguns campos obrigatórios não foram preenchidos!');
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

