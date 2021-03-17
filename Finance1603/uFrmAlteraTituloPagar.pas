unit uFrmAlteraTituloPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,uUtil,  uTituloPagarDAO, uTituloPagarModel,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, udmConexao,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, EMsgDlg, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,UMostraErros,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, cxBarEditItem,
  dxStatusBar;

type
  TfrmAlteraNumDocTP = class(TForm)
    btnConsulta: TButton;
    dbgrdTP: TDBGrid;
    dsPreencheGrid: TDataSource;
    qryObterTodos: TFDQuery;
    btnExcluir: TButton;
    PempecMsg: TEvMsgDlg;
    qryExclusaoFull: TFDQuery;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    cxbrdtmPesquisa: TcxBarEditItem;
    dxStatusBar: TdxStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure dbgrdTPTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dxBarBtnSairClick(Sender: TObject);
  private
    { Private declarations }
    idOrganizacao : string;
    codigoErro :string;
    loMostraErros: TFMostraErros;
    procedure inicializarDM(Sender: TObject);
    function obterTodos(pIdOrganizacao: string): Boolean;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
  public
    { Public declarations }
  end;

var
  frmAlteraNumDocTP: TfrmAlteraNumDocTP;

implementation

{$R *.dfm}


function TfrmAlteraNumDocTP.obterTodos(pIdOrganizacao: string): Boolean;
begin
codigoErro := 'AlteraTP-01';
   try
      qryObterTodos.Close;
      qryObterTodos.Connection := dmConexao.Conn;
      qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTodos.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPs ' + codigoErro );

  end;
  Result := not qryObterTodos.IsEmpty;
end;



procedure TfrmAlteraNumDocTP.btnExcluirClick(Sender: TObject);
var
  titulo : TTituloPagarModel;
  qry : TFDQuery;
 msgGenerica,  cmdProc : string;
 pai, filho, sucesso : Boolean;

  begin

  sucesso := False;
  pai := False;
  filho := False;
  loMostraErros := TFMostraErros.Create(Self);

  dmConexao.conectarBanco;

    titulo := TTituloPagarModel.Create;
    titulo.FIDorganizacao := (dbgrdTP.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
    titulo.FID := (dbgrdTP.DataSource.DataSet as TFDQuery).FieldByName('ID_TITULO_PAGAR').AsString;

    titulo := TTituloPagarDAO.obterPorID(titulo);

    if not uutil.Empty(titulo.FID) then begin
        sucesso := True;

        if TTituloPagarDAO.existFilhos(titulo) then begin
          sucesso := False;
          msgGenerica := 'Existem outros t�tulos vinculados. N�o ser� poss�vel excluir.';

          msgStatusBar(1,msgGenerica);


          PempecMsg.MsgWarning(msgGenerica);

          qry := TFDQuery.Create(Self);

          qry :=  TTituloPagarDAO.obterTodosFilhos(titulo);

          if qry.RecordCount >0  then begin
             qry.First;

             loMostraErros.Add(' Existem ' + IntToStr(qry.RecordCount) + ' t�tulos vinculados ' );

             while not qry.Eof do begin
              loMostraErros.Add('');
              loMostraErros.Add('----------------------------------------------------------------' );
              loMostraErros.Add('DOC      ' + qry.FieldByName('NUMERO_DOCUMENTO').AsString );
              loMostraErros.Add('VALOR    ' + CurrToStr(qry.FieldByName('VALOR_NOMINAL').AsCurrency) );
              loMostraErros.Add('STATUS   ' + qry.FieldByName('ID_TIPO_STATUS').AsString );
              loMostraErros.Add('');
              loMostraErros.Add('----------------------------------------------------------------' );
              qry.Next;

             end;
          end;
        end;

        if loMostraErros.Count > 0 then
        begin
          loMostraErros.ShowModal;
        end else begin

         sucesso :=   PempecMsg.MsgConfirmation('ATEN��O. Tem certeza que desejar deletar o registo? N�o ser� poss�vel reverter a opera��o. Fa�a Backup antes. ')= 6;

        end;

    end;




  if sucesso then begin

    if not uutil.Empty(titulo.FID) then begin



      qry := TFDQuery.Create(Self);

      try
         cmdProc := 'EXECUTE PROCEDURE sp_del_tp(' + QuotedStr(titulo.FIDorganizacao) + ',' + QuotedStr(titulo.FID) +')';
         qry.Close;
         qry.Connection := dmConexao.conn;
         qry.SQL.Clear;
         qry.SQL.Add(cmdProc);
                  //   'EXECUTE PROCEDURE sp_del_tp('familia','23a765d7-5575-48d5-aa2d-90fb89764407')
       {  qry.ParamByName('PID').AsString := titulo.FID;
         qry.ParamByName('PIDORG').AsString := titulo.FIDorganizacao;   }
        if PempecMsg.MsgConfirmation('O t�tulo e tudo que for relacionado a ele ser� removido totalmente da base de dados.' +#13 + ' Confirma a opera��o de exclus�o total ?' ) = 6  then begin

            qry.ExecSQL;
            dmConexao.conn.Commit;
            PempecMsg.MsgInformation('Titulo exclu�do da base de dados.  ' + titulo.FnumeroDocumento);

        end;


      finally
      FreeAndNil(qry);
      end;

    end;
  end;

    dmConexao.conectarBanco;
    obterTodos(idOrganizacao);

end;


procedure TfrmAlteraNumDocTP.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
  dbgrdTP.DataSource.DataSet.Locate('NUMERO_DOCUMENTO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TfrmAlteraNumDocTP.dbgrdTPTitleClick(Column: TColumn);
begin
(dbgrdTP.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;


procedure TfrmAlteraNumDocTP.dxBarBtnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmAlteraNumDocTP.btnConsultaClick(Sender: TObject);
begin
dbgrdTP.DataSource.DataSet.Next;
dbgrdTP.Refresh;

ShowMessage('Dados atualizados com sucesso');

end;

procedure TfrmAlteraNumDocTP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmAlteraNumDocTP.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
end;

procedure TfrmAlteraNumDocTP.inicializarDM(Sender: TObject);
begin

idOrganizacao := TOrgAtual.getId;
obterTodos(idOrganizacao);

//

end;


procedure TfrmAlteraNumDocTP.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;


end.
