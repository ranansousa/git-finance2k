unit uFrmEspelhoTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameTP, uDMOrganizacao, udmConexao, uUtil,
  Vcl.StdCtrls, Vcl.Buttons, EEdBtn, ENumEd, cxGraphics, cxControls,uDMEspelhoTP,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxStatusBar, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,uTituloPagarModel, uTituloPagarDAO,
  FireDAC.Comp.Client, frxClass, frxDBSet, Vcl.ComCtrls, EMsgDlg, dxRibbonSkins,
  dxRibbonCustomizationForm, dxBar, cxClasses, dxRibbon, cxTextEdit,
  cxBarEditItem, Vcl.Grids, Vcl.DBGrids;

type
  TformEspelhoTP = class(TForm)
    qryBusca: TFDQuery;
    statStatusEsp: TStatusBar;
    PempecMsg: TEvMsgDlg;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBtnFechar: TdxBarLargeButton;
    dxBtnImprimir: TdxBarLargeButton;
    dxBarEdit1: TdxBarEdit;
    cxbrdtmPesquisa: TcxBarEditItem;
    dbgrdMain: TDBGrid;
    qryPreencheGrid: TFDQuery;
    dsTitulos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBtnFecharClick(Sender: TObject);
    procedure dxBtnImprimirClick(Sender: TObject);
    procedure cxbrdtmPesquisaCurChange(Sender: TObject);
    procedure dsTitulosDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdTP : TStringList;
    indexCombo :Integer;
    pNumeroDoc, pId :string;


    procedure limpaPanel;
    procedure preencheStatus(posicalPanel: Integer; msg: string);
    function obterTP(pIdOrganizacao, pidTP, pNumeroDoc: string): Boolean;
    function obterIndiceLista(pId: string; lista: TStringList): Integer;
    function preencheGrid(pIdOrganizacao: string): Boolean;
  public
    { Public declarations }

   constructor Create(AOwner: TComponent; nDoc :String);  overload;

  end;

var
  formEspelhoTP: TformEspelhoTP;

implementation

{$R *.dfm}


function TformEspelhoTP.obterIndiceLista(pId: string;  lista: TStringList): Integer;
var
  I: Integer;
begin
 Result :=0;

  for I := 0 to lista.Count-1 do begin
    if(lista[I].Equals(pId)) then begin
       Result := I;
       Break;
    end;

  end;

end;


constructor TformEspelhoTP.Create(AOwner: TComponent; nDoc: String);
var
tituloEntrada :TTituloPagarModel;

begin
  inherited Create(AOwner);
  tituloEntrada := TTituloPagarModel.Create;
  if uUtil.Empty(idOrganizacao) then begin idOrganizacao := uutil.TOrgAtual.getId;end;

  FsListaIdTP := TStringList.Create;
  FsListaIdTP.Clear;

  if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;
  if not (Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end;

  limpaPanel;


    if not (uutil.Empty(nDoc)) then
    begin

      tituloEntrada.FIDorganizacao := idOrganizacao;
      tituloEntrada.FnumeroDocumento := nDoc;
      tituloEntrada := TTituloPagarDAO.obterPorNumeroDocumento(tituloEntrada);

    end;

    if not uutil.Empty(tituloEntrada.FID) then begin

         pNumeroDoc := tituloEntrada.FnumeroDocumento;
         pId  := tituloEntrada.FID;
       //seta para impressao


         FsListaIdTP.Add(pId);



         dxBtnImprimir.Click;

    end else begin

        preencheGrid(idOrganizacao);


    end;

end;

procedure TformEspelhoTP.cxbrdtmPesquisaCurChange(Sender: TObject);
begin
 dbgrdMain.DataSource.DataSet.Locate('NUMERO_DOCUMENTO',UpperCase(cxbrdtmPesquisa.CurEditValue),[loPartialKey]);
end;

procedure TformEspelhoTP.dsTitulosDataChange(Sender: TObject; Field: TField);
var
tituloPagar : TTituloPagarModel;
begin
      tituloPagar := TTituloPagarModel.Create;
      tituloPagar.FIDorganizacao  := qryPreencheGrid.FieldByName('ID_ORGANIZACAO').AsString;
      tituloPagar.FID             := qryPreencheGrid.FieldByName('ID').AsString;
      tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);

  if not uUtil.Empty(tituloPagar.FID) then
  begin
     pNumeroDoc := tituloPagar.FnumeroDocumento;
     pId := tituloPagar.FID;
    obterTP(idOrganizacao, tituloPagar.FID, tituloPagar.FnumeroDocumento);
    preencheStatus(1, 'Espelho pronto para ser impresso.');
    dxBtnImprimir.Enabled := True;

  end
  else
  begin
    preencheStatus(1, 'Precisa selecionar um número de documento..');
    PempecMsg.MsgWarning('Selecione um título ');
  end;


end;

procedure TformEspelhoTP.dxBtnFecharClick(Sender: TObject);
begin
  limpaPanel;
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TformEspelhoTP.dxBtnImprimirClick(Sender: TObject);
begin

if (dmEspelhoTP.obterPorNumeroDocumento(idOrganizacao, pNumeroDoc)) then begin

     if (qryBusca.RecordCount > 0) then  begin
              preencheStatus(1,'Espelho pronto para ser impresso.');
              dmEspelhoTP.exibirRelatorio(uutil.getDataServer, uutil.getDataServer);
              limpaPanel;
      end
      else
      begin
        dxBtnImprimir.Enabled := false;
        limpaPanel;
        preencheStatus(1,'Não foi possível imprmir.');
        PempecMsg.MsgWarning('Não existem dados para imprimir.');
      end

  end;
end;

 procedure TformEspelhoTP.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if  (Assigned(dmEspelhoTP)) then
  begin
    FreeAndNil(dmEspelhoTP);
  end;



end;

procedure TformEspelhoTP.FormCreate(Sender: TObject);
begin

 idOrganizacao := uUtil.TOrgAtual.getId;
 //frameTP1.obterTodos(idOrganizacao,frameTP1.cbbTP,FsListaIdTP);


 if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


  if not(Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end  ;



  limpaPanel;

end;

procedure TformEspelhoTP.preencheStatus(posicalPanel :Integer; msg :string);
 begin
  statStatusEsp.Panels[posicalPanel].Text := msg;
 end;


 function TformEspelhoTP.obterTP(pIdOrganizacao, pidTP, pNumeroDoc :string) :Boolean;
 var
  cmdSql :string;
  begin

    dmConexao.conectarBanco;

    try
      if uUtil.Empty(pIdOrganizacao) then begin
          pIdOrganizacao := uutil.TOrgAtual.getId;
      end;


    if not uUtil.Empty(pidTP) then
    begin
      try
        qryBusca.Close;
        qryBusca.Connection := dmConexao.conn;
        qryBusca.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryBusca.ParamByName('PIDTP').AsString := pidTP;
        qryBusca.ParamByName('PNUMDOC').AsString := pNumeroDoc;
        qryBusca.Open;
      except
        raise Exception.Create('Erro ao tentar consultar dados dos títulos.');
      end;
    end;
    except
    raise Exception.Create('Erro ao consultar o título :' + pNumeroDoc);
    end;
    preencheStatus(1,'A consulta retornou ' + IntToStr(qryBusca.RecordCount) + ' registros. ');
    Result := not qryBusca.IsEmpty;

  end;

procedure TformEspelhoTP.limpaPanel;
begin

 preencheStatus(0,' Status : ');
 preencheStatus(1,'Pronto');

 dxBtnImprimir.Enabled := false;

 if  (Assigned(dmEspelhoTP)) then
  begin
    FreeAndNil(dmEspelhoTP);
  end;

  if not (Assigned(dmEspelhoTP)) then
  begin
    dmEspelhoTP := TdmEspelhoTP.Create(Self);
  end;


  dbgrdMain.Enabled := True;
  preencheGrid(idOrganizacao);

  //limpaStatusBar;


end;


function TformEspelhoTP.preencheGrid(pIdOrganizacao: string) :Boolean;
var
sqlCmd :string;
begin

 dmConexao.conectarBanco;

 try
    qryPreencheGrid.Close;
    qryPreencheGrid.Connection := dmConexao.conn;
    qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryPreencheGrid.Open;

 except
 raise Exception.Create('Erro ao obter lista de títulos...' );

 end;

 Result := not qryPreencheGrid.IsEmpty;

end;


end.
