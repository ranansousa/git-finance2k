unit uFrmManterCentroCusto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters, udmConexao, uUtil,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxStatusBar, cxClasses, dxRibbon, dxBar,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cxContainer,
  uCentroCustoDAO,uCentroCustoModel,
  cxEdit, cxTextEdit, cxBarEditItem, EMsgDlg;

type
  TfrmManterCentroCusto = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxStatusBar: TdxStatusBar;
    dbgrd1: TDBGrid;
    dsMain: TDataSource;
    edtCodigo: TEdit;
    lbl1: TLabel;
    edtSigla: TEdit;
    lbl3: TLabel;
    edtCentroCusto: TEdit;
    lbl4: TLabel;
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
    qryPreencheGridID_CENTRO_CUSTO: TStringField;
    qryPreencheGridID_ORGANIZACAO: TStringField;
    qryPreencheGridDESCRICAO: TStringField;
    qryPreencheGridCODIGO: TIntegerField;
    qryPreencheGridSIGLA: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure dxBtnEditarClick(Sender: TObject);
    procedure dxBtnSalvarClick(Sender: TObject);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnNovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrd1TitleClick(Column: TColumn);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure dxBtnDeletarClick(Sender: TObject);
  private
    { Private declarations }
    pIdCentroCusto,  pIdOrganizacao  :string;
    FsListaIdCedntroCusto : TStringList;
    procedure inicializarDM(Sender: TObject);
    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    function isValidForm: Boolean;
    procedure camposObrigatorios;



  public
    { Public declarations }
    procedure preencheGrid(pIdOrganizacao :string);

  end;

var
  frmManterCentroCusto: TfrmManterCentroCusto;

implementation

{$R *.dfm}

procedure TfrmManterCentroCusto.camposObrigatorios;
begin

 edtSigla.Tag := 1;
 edtCentroCusto.Tag := 1;
 edtCodigo.Tag :=  1;


end;

procedure TfrmManterCentroCusto.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrd1.DataSource.DataSet.Locate('DESCRICAO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmManterCentroCusto.dbgrd1TitleClick(Column: TColumn);
begin
 (dbgrd1.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmManterCentroCusto.dsMainDataChange(Sender: TObject;  Field: TField);
var
 centroCusto : TCentroCustoModel;
begin

   dxBtnDeletar.Enabled := False;
   dxBtnEditar.Enabled := False;
   pIdCentroCusto :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CENTRO_CUSTO').AsString;

        centroCusto                 := TCentroCustoModel.Create;
        centroCusto.FIDorganizacao  := pIdOrganizacao;
        centroCusto.FID             := pIdCentroCusto;
        centroCusto := TCentroCustoDAO.obterPorID(centroCusto);

      if not uUtil.Empty(centroCusto.FID) then
      begin

        edtCentroCusto.Text := UpperCase(centroCusto.FDescricao);
        edtSigla.Text       := UpperCase(centroCusto.FSigla);
        edtCodigo.Text      := IntToStr(centroCusto.FCodigo);

        dxBtnEditar.Enabled := True;

        dxBtnDeletar.Enabled := TCentroCustoDAO.permiteDelete(centroCusto);

      end;

end;

procedure TfrmManterCentroCusto.dxBtnDeletarClick(Sender: TObject);
var
 centroCusto : TCentroCustoModel;
begin
        pIdCentroCusto :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CENTRO_CUSTO').AsString;

        centroCusto                 := TCentroCustoModel.Create;
        centroCusto.FIDorganizacao  := pIdOrganizacao;
        centroCusto.FID             := pIdCentroCusto;
        centroCusto := TCentroCustoDAO.obterPorID(centroCusto);

      if not uUtil.Empty(centroCusto.FID) then
      begin

        if TCentroCustoDAO.permiteDelete(centroCusto) then
        begin

          if TCentroCustoDAO.delete(centroCusto) then
          begin

            PempecMsg.MsgInformation('Registro deletado com sucesso.' + centroCusto.FDescricao);
          end;

        end
        else
        begin

          PempecMsg.MsgInformation('Centro de Custos  ' + centroCusto.FDescricao + ' não pode ser excluído. Já foi utilizado!');

        end;

      end;

        FreeAndNil(centroCusto);

end;

procedure TfrmManterCentroCusto.dxBtnEditarClick(Sender: TObject);
begin
  dbgrd1.Enabled :=False;
  cxbrdtmPesquisa.Enabled :=False;
  pIdCentroCusto :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CENTRO_CUSTO').AsString;
  dxBtnSalvar.Enabled :=true ;
  dxBtnNovo.Enabled :=False;

end;

procedure TfrmManterCentroCusto.dxBtnFecharClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterCentroCusto.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
end;

procedure TfrmManterCentroCusto.dxBtnNovoClick(Sender: TObject);
begin
  limparPanel;

  dbgrd1.Enabled :=False;
 (dbgrd1.DataSource.DataSet as TFDQuery).Close;

  dxBtnSalvar.Enabled      :=True;
  dxBtnEditar.Enabled      :=False;

  pIdCentroCusto :='';
  cxbrdtmPesquisa.Enabled :=False;

end;

procedure TfrmManterCentroCusto.dxBtnSalvarClick(Sender: TObject);
var
 centroCusto : TCentroCustoModel;
begin

    if isValidForm then begin



     if not uUtil.Empty(pIdCentroCusto) then begin
        pIdCentroCusto :=  (dbgrd1.DataSource.DataSet as TFDQuery).FieldByName('ID_CENTRO_CUSTO').AsString;

        centroCusto                 := TCentroCustoModel.Create;
        centroCusto.FIDorganizacao  := pIdOrganizacao;
        centroCusto.FID             := pIdCentroCusto;
        centroCusto := TCentroCustoDAO.obterPorID(centroCusto);

      if not uUtil.Empty(centroCusto.FID) then
      begin

        centroCusto.FDescricao := UpperCase(edtCentroCusto.Text);
        centroCusto.FSigla := UpperCase(edtSigla.Text);

         if not uUtil.Empty(edtCodigo.Text) then begin
           centroCusto.FCodigo         := StrToInt(edtCodigo.Text);
       end;

        if TCentroCustoDAO.Update(centroCusto) then
        begin

          PempecMsg.MsgInformation('Registro atualizado com sucesso.' + centroCusto.FDescricao);

          FreeAndNil(centroCusto);

        end;

      end
      else
      begin

        PempecMsg.MsgInformation('Registro não localizado.');

      end;


     end else begin

       centroCusto                 := TCentroCustoModel.Create;
       centroCusto.FIDorganizacao  := pIdOrganizacao;
       centroCusto.FID             := dmConexao.obterNewID;

       centroCusto.FDescricao      := UpperCase(edtCentroCusto.Text);
       centroCusto.FSigla          := UpperCase(edtSigla.Text);

       if not uUtil.Empty(edtCodigo.Text) then begin
           centroCusto.FCodigo         := StrToInt(edtCodigo.Text);
       end;

        if TCentroCustoDAO.Insert(centroCusto) then
        begin

          PempecMsg.MsgInformation('Registro salvo com sucesso.' + centroCusto.FDescricao);

          FreeAndNil(centroCusto);

        end;
     end;

   limparPanel;

  end;

end;

procedure TfrmManterCentroCusto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action :=caFree;

end;

procedure TfrmManterCentroCusto.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
end;

procedure TfrmManterCentroCusto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
  vk_f2: dxBtnEditar.Click;
  vk_f4: dxBtnNovo.Click;
  vk_f10: dxBtnSalvar.Click;
end;

end;



procedure TfrmManterCentroCusto.inicializarDM(Sender: TObject);
begin
 //nada
 limparPanel;

end;

procedure TfrmManterCentroCusto.limparPanel();
begin
 camposObrigatorios;

 limpaStatusBar;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdCentroCusto := '';

 preencheGrid(pIdOrganizacao);

 //botao editar muda
  dbgrd1.Enabled :=True;

  edtCentroCusto.Clear;
  edtSigla.Clear;
  edtCodigo.Clear;

  dxBtnNovo.Enabled := True;
  dxBtnEditar.Enabled := False;
  dxBtnSalvar.Enabled :=False;
  dxBtnDeletar.Enabled := False;
  cxbrdtmPesquisa.Enabled :=True;


end;

procedure TfrmManterCentroCusto.limpaStatusBar;
begin
   msgStatusBar(0, 'Ativo');
   msgStatusBar(1, 'Manutenção de Centros de Custos ');

   msgStatusBar(1,'Ativo. Teclas de atalho:  [F2] = Editar -  [F4] = Novo - [F10] = Salvar ');


end;

procedure TfrmManterCentroCusto.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

procedure TfrmManterCentroCusto.preencheGrid(pIdOrganizacao: string);
var
sqlCmd :string;
begin

dmConexao.conectarBanco;
 try

    sqlCmd := ' SELECT * FROM CENTRO_CUSTO C  WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) ORDER BY C.DESCRICAO ';

    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.SQL.Clear;
    qryPreencheGrid.SQL.Add(sqlCmd);
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

    (dbgrd1.DataSource.DataSet as TFDQuery).Last;
    (dbgrd1.DataSource.DataSet as TFDQuery).First;

 except
 raise Exception.Create('Erro ao obter lista de ' + pTable );

 end;


end;


function TfrmManterCentroCusto.isValidForm :Boolean;
var i:integer;
liberado : Boolean;

begin
 liberado :=false;

 msgStatusBar(1, 'Verifique os campos obrigatórios.');

      for i := 0 to Self.ComponentCount - 1 do
      begin

        if Self.components[i] is TEdit then
        begin
          if (Tedit(components[i]).tag = 1) and (Tedit(components[i]).text = '') then
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
