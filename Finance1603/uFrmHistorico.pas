unit uFrmHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameGeneric, uFrameHistorico, udmConexao, uUtil,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, uDMOrganizacao,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, frxClass, frxDBSet, Vcl.ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, dxStatusBar, dxRibbonSkins, dxRibbonCustomizationForm,
  dxBar, cxClasses, dxRibbon;

type
  TfrmHistorico = class(TForm)
    qryObterHistoricos: TFDQuery;
    ds1: TDataSource;
    dbgrd1: TDBGrid;
    frxRepHistorico: TfrxReport;
    frxDBHistorico: TfrxDBDataset;
    rgTipos: TRadioGroup;
    qryObterCC: TFDQuery;
    frxDBCC: TfrxDBDataset;
    qryObterTOB: TFDQuery;
    frxTOB: TfrxDBDataset;
    dxStatusBar: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarBtnFechar: TdxBarLargeButton;
    dxBarBtnImprimir: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarBtnFecharClick(Sender: TObject);
    procedure dxBarBtnImprimirClick(Sender: TObject);
  private
  pIdOrganizacao :string;
  FsListaIdHistorico: TStringList;
    procedure inicializarDM(Sender: TObject);
    function obterHistoricos(pIdOrganizacao: string): Boolean;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure limparPanel;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

{$R *.dfm}

procedure TfrmHistorico.dxBarBtnFecharClick(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmHistorico.dxBarBtnImprimirClick(Sender: TObject);
var
pathRelatorio :String;
begin
  pathRelatorio := uUtil.TPathRelatorio.getListaHistoricos;

// pathRelatorio := 'D:\mega\desenvolvimento\Delphi\Finance\bin\rel\relHistoricosV2.fr3';
    if rgTipos.ItemIndex = 1  then begin //busca pelos centros de custos

     qryObterCC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryObterCC.Open;

    end;

    if rgTipos.ItemIndex = 2  then begin //busca pelas TOB

     qryObterTOB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryObterTOB.Open;

    end;

    if rgTipos.ItemIndex = 3  then begin //busca pelas TOB e CC

     qryObterCC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryObterCC.Open;

     qryObterTOB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryObterTOB.Open;

    end;



  if (dmOrganizacao.carregarDadosOrganizacaoFNC(pIdOrganizacao) ) then begin
      if  (obterHistoricos(pIdOrganizacao)) then begin

            if qryObterHistoricos.RecordCount <1 then begin
                 ShowMessage('N�o existem dados para exibir');
            end;

          frxRepHistorico.Clear;
          if not(frxRepHistorico.LoadFromFile(pathRelatorio)) then
          begin
             ShowMessage('Relat�rio n�o encontrado...');
          end
          else
          begin
            inicializarVariaveisRelatorio(now, now);
            frxRepHistorico.OldStyleProgress := True;
            frxRepHistorico.ShowProgress := True;
            frxRepHistorico.ShowReport;
          end;
     end;
  end;

end;

procedure TfrmHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin

Action := caFree;
end;

procedure TfrmHistorico.FormCreate(Sender: TObject);
begin

  inicializarDM(Self);
end;



procedure TfrmHistorico.inicializarDM(Sender: TObject);
begin

if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


   pIdOrganizacao := uUtil.TOrgAtual.getId;


   limparPanel;

 end;



procedure TfrmHistorico.limparPanel();
begin

  rgTipos.ItemIndex :=3;
  rgTipos.Visible :=False;

  obterHistoricos(pIdOrganizacao);
//  frameHistorico1.obterTodos(pIdOrganizacao, frameHistorico1.cbbcombo,FsListaIdHistorico );


end;



function TfrmHistorico.obterHistoricos(pIdOrganizacao: string): Boolean;
begin
  dmConexao.conectarBanco;
  try

    qryObterHistoricos.Close;
    qryObterHistoricos.Connection :=dmConexao.conn;
    qryObterHistoricos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterHistoricos.Open;
    qryObterHistoricos.Last;
    qryObterHistoricos.First;


  except
  raise Exception.Create('Erro ao tentar obter hist�ricos.');

  end;

   Result := not qryObterHistoricos.IsEmpty;

end;


procedure TfrmHistorico.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin
  with frxRepHistorico.Variables do
  begin

    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL').AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));



    // Variables['strTipo'] := QuotedStr(tipo); // muda a depender do lancamento

  end;
end;


end.
