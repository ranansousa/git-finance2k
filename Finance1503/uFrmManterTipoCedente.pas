unit uFrmManterTipoCedente;

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
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg, uFrameBanco, ENumEd;

type
  TfrmManterTipoCedente = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrd1: TDBGrid;
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
    dsGrid: TDataSource;
    edtDescricao: TEdit;
    lbl8: TLabel;
    qryPreencheGrid: TFDQuery;
    PempecMsg: TEvMsgDlg;
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
    procedure dsGridDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
   pIdValue,  pIdOrganizacao, pIdUsuario :string;
   pTable, pIdTable :string;

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure LimpaTela(Form: TForm);
    procedure controleEdit(Form: TForm; pValue: Boolean);
    function deletar(pIdOrganizacao, pIdValue: string): Boolean;
    function liberaDeletar(cmd: string): Integer;
    function qtdUso(pIdOrganizacao, pIdValue: string): Integer;
    function salvarContaBancaria(PIDORGANIZACAO, PIDVALUE,  PDESCRICAO: string): Boolean;



  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao :string);

  end;

var
  frmManterTipoCedente: TfrmManterTipoCedente;

implementation

{$R *.dfm}

procedure TfrmManterTipoCedente.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('DESCRICAO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterTipoCedente.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

function TfrmManterTipoCedente.deletar(pIdOrganizacao, pIdValue: string): Boolean;
var cmd :string;
qryDel :TFDQuery;
begin

try

      cmd := ' DELETE FROM '+ pTable + ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND ( ID_' + pTable + '  = :PID) ';

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
raise Exception.Create(' Não foi possível deletar o registro. Inform ao suporte.');

end;
  limparPanel;
  Result := System.True;
end;

procedure TfrmManterTipoCedente.dsGridDataChange(Sender: TObject; Field: TField);
begin

  edtDescricao.Text      := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('DESCRICAO').AsString;
  pIdValue := (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_'+pTable).AsString;


   if qtdUso(pIdOrganizacao, pIdValue) = 0 then
    begin
      dxBtnDeletar.Enabled := True;
    end
    else
    begin
      dxBtnDeletar.Enabled := False;
    end;

      cxbrdtmPesquisa.Enabled := True;


end;

procedure TfrmManterTipoCedente.dxBtnDeletarClick(Sender: TObject);
begin

 if deletar(pIdOrganizacao, pIdValue) then begin
  ShowMessage('Registro deletado com sucesso.');
 end;
end;

procedure TfrmManterTipoCedente.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled := False;
  edtDescricao.Enabled := True;
  dxBtnSalvar.Enabled := true;
  dxBtnNovo.Enabled := False;
  cxbrdtmPesquisa.Enabled := False;

end;

procedure TfrmManterTipoCedente.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterTipoCedente.dxBtnNovoClick(Sender: TObject);
begin

  limparPanel;
  dbgrd1.Enabled :=False;
  (dbgrd1.DataSource.DataSet as TFDQuery).Close;

  edtDescricao.Enabled :=True;
  edtDescricao.Clear;
  pIdValue :='';
  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;
  cxbrdtmPesquisa.Enabled :=False;


end;

procedure TfrmManterTipoCedente.dxBtnSalvarClick(Sender: TObject);
var
 pDescricao :string;
begin

  if not uUtil.Empty(pIdValue) then begin
        pIdValue :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_'+ pTable ).AsString;
 end;

    pDescricao   :=UpperCase(edtDescricao.Text);

 if  salvarContaBancaria(pIdOrganizacao, pIdValue, pDescricao ) then begin

        ShowMessage('Registro salvo com sucesso.');
 end;

   limparPanel;

end;

procedure TfrmManterTipoCedente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action :=caFree;

end;

procedure TfrmManterTipoCedente.FormCreate(Sender: TObject);
begin
 pTable := 'TIPO_CEDENTE';
 Self.Caption := pTable;
 dxRibbon1Tab1.Caption := 'Manutenção de tipos de cedentes';

 inicializarDM(Self);
 limparPanel;
end;

procedure TfrmManterTipoCedente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;

procedure TfrmManterTipoCedente.freeAndNilDM(Sender: TObject);
begin

//nada
end;


procedure TfrmManterTipoCedente.inicializarDM(Sender: TObject);
begin
 //nada
 if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
 end;


end;

procedure TfrmManterTipoCedente.limparPanel();
var
  I: Integer;
begin
 limpaStatusBar;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=IntToStr(uutil.TUserAtual.getUserId);
// frmPeriodo1.inicializa(IncDay(Now, -1), Now);

 //botao editar muda
  dbgrd1.Enabled :=True;

  edtDescricao.Clear;

  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := True;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;

 // LimpaTela(Self);

  //botao novo
   cxbrdtmPesquisa.Enabled := True;
   preencheGrid(pIdOrganizacao);


end;

procedure TfrmManterTipoCedente.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterTipoCedente.preencheGrid(pIdOrganizacao: string);
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try

    sqlCmd := ' SELECT TS.DESCRICAO, TS.ID_'+ pTable + ' FROM ' +pTable +' TS ' +
              ' WHERE (TS.ID_ORGANIZACAO = :PIDORGANIZACAO) '+
              ' ORDER BY TS.DESCRICAO ' ;


    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;

 except
 raise Exception.Create('Erro ao obter lista...' + pTable);

 end;


end;

function TfrmManterTipoCedente.liberaDeletar(cmd :string) : Integer;
var
qryPesquisa, qryTR : TFDQuery;
begin
dmConexao.conectarBanco;

 try

    qryPesquisa := TFDQuery.Create(Self);
    qryPesquisa.Close;
    qryPesquisa.Connection := dmConexao.conn;
    qryPesquisa.SQL.Clear;
    qryPesquisa.SQL.Add(cmd);
    qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPesquisa.ParamByName('PID').AsString := pIdValue ;
    qryPesquisa.Open;

   except
   Result :=0;
    raise Exception.Create('Erro ao consultar dados da conta  ');

  end;

  Result := qryPesquisa.RecordCount;;


end;


function TfrmManterTipoCedente.qtdUso(pIdOrganizacao,  pIdValue: string): Integer;
  var
qryPesquisa, qryTR : TFDQuery;
cmd : string;
qtd :Integer;


begin

  qtd :=0;

  try

      cmd := ' SELECT FIRST 1  CBD.ID_' + pTable + ' FROM CEDENTE CBD WHERE (CBD.ID_ORGANIZACAO =:PIDORGANIZACAO) AND (CBD.ID_'+pTable + '  = :PID) ' ;
      qtd := qtd + liberaDeletar(cmd);



  except
   Result :=0;
    raise Exception.Create('Erro ao consultar dados  ' + pTable );

  end;

  Result := qtd;

end;

procedure TfrmManterTipoCedente.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

function  TfrmManterTipoCedente.salvarContaBancaria(PIDORGANIZACAO, PIDVALUE, PDESCRICAO  :string) :Boolean;
var
cmdSalvar :string;
qrySalvar :TFDQuery;
begin

 dmConexao.conectarBanco;
 try

   cmdSalvar := ' UPDATE '+ pTable + ' SET DESCRICAO = :PDESCRICAO ' +
                ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO) AND (ID_'+pTable +' = :PID) ';



   if UUTIL.Empty(PIDVALUE) then begin

     PIDVALUE := dmConexao.obterNewID;


     cmdSalvar := ' INSERT INTO ' +pTable +' (ID_ORGANIZACAO,  ID_'+pTable + ', DESCRICAO ) '+
                  ' VALUES (:PIDORGANIZACAO, :PID,  :PDESCRICAO ) ';

   end;

    if not uUtil.Empty(PIDVALUE) then
    begin

      qrySalvar := TFDQuery.Create(Self);
      qrySalvar.Close;
      qrySalvar.Connection := dmConexao.conn;
      qrySalvar.SQL.Clear;
      qrySalvar.SQL.Add(cmdSalvar);

      qrySalvar.ParamByName('PID').AsString := PIDVALUE;
      qrySalvar.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
      qrySalvar.ParamByName('PDESCRICAO').AsString := PDESCRICAO;

      qrySalvar.ExecSQL;

      dmConexao.conn.CommitRetaining;
    end;

 except
 Result :=False;
  raise Exception.Create('Erro ao tentar salvar o ContaBancaria.');
 end;

  Result :=True;
end;


procedure TfrmManterTipoCedente.LimpaTela(Form: TForm);
var
  i: Integer;
begin

  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TCustomEdit then
    begin
      (Form.Components[i] as TCustomEdit).Clear;
    end;

    if Form.Components[i] is TLabel then
    begin
      TLabel(Form.Components[i]).Caption := '';
    end;

    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Clear;
    end;

    if Form.Components[i] is TEvNumEdit then
    begin
      TEvNumEdit(Form.Components[i]).Clear ;
    end;

    if Form.Components[i] is TComboBox then
    begin
      TComboBox(Form.Components[i]).Clear ;
      TComboBox(Form.Components[i]).ItemIndex := 0;
    end;



   end;
end;

procedure TfrmManterTipoCedente.controleEdit(Form: TForm; pValue :Boolean);
var
i: Integer;
begin

 for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TCustomEdit then
    begin
      (Form.Components[i] as TCustomEdit).Enabled :=pValue;
    end;

    if Form.Components[i] is TLabel then
    begin
      TLabel(Form.Components[i]).Enabled :=pValue;
    end;

    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Enabled :=pValue;
    end;

    if Form.Components[i] is TEvNumEdit then
    begin
      TEvNumEdit(Form.Components[i]).Enabled :=pValue;
    end;

    if Form.Components[i] is TComboBox then
    begin
      TComboBox(Form.Components[i]).Enabled :=pValue;
    end;

   end;


end;


end.
