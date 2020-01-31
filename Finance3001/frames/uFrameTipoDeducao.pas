unit uFrameTipoDeducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  uDMOrganizacao, uTipoDeducaoModel,  uTipoDeducaoDAO, udmConexao, uUtil,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TframeTipoDeducao = class(TFrame)
    cbbcombo: TComboBox;
    procedure cbbcomboChange(Sender: TObject);
  private
    { Private declarations }
    pIdOrganizacao : string;
    comboItemIndex :Integer;
    FsListaId : TStringList;


  public
    { Public declarations }
 function obterTodos      (pIdOrganizacao: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function getComboItemIndex :Integer;
 function getComboID :string;

function preencheDBGrid(pIDOrganizacao :string ) :TFDQuery;


  end;

implementation

function TframeTipoDeducao.getComboItemIndex: Integer;
begin

Result := comboItemIndex;

end;



function TframeTipoDeducao.preencheDBGrid(pIDOrganizacao: string): TFDQuery;
var
 qryPreencheGrid : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := 'SELECT  TC.ID_TIPO_DEDUCAO, '+
             ' TC.DESCRICAO,'+
             ' TC.ID_ORGANIZACAO, '+
             ' H.DESCRICAO AS DSC_HIST, '+
             ' CC.CODREDUZ, '+
             ' CC.DESCRICAO AS DSC_CONTA, '+
             ' CC.CONTA '+
             ' FROM TIPO_DEDUCAO TC '+
             ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TC.ID_HISTORICO) AND (H.ID_ORGANIZACAO = TC.ID_ORGANIZACAO) '+
             ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = TC.ID_ORGANIZACAO)'+
             ' WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) ';

  try

        qryPreencheGrid := TFDQuery.Create(Self);
        qryPreencheGrid.Close;
        qryPreencheGrid.SQL.Clear;
        qryPreencheGrid.SQL.Add(cmdSql);
        qryPreencheGrid.Connection := dmConexao.conn;
        qryPreencheGrid.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryPreencheGrid.Open;
   except

   raise Exception.Create('Erro preencher grid');

  end;

 Result := qryPreencheGrid;

end;



function TframeTipoDeducao.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
 qryObterTodos : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

 cmdSql := 'SELECT C.ID_TIPO_DEDUCAO AS ID, C.DESCRICAO FROM TIPO_DEDUCAO C WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) ORDER BY C.DESCRICAO' ;

  FsListaId := TStringList.Create;
  FsListaId.Clear;
  FsListaId.Add('Sem ID');



  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');

  combo.Clear;
  combo.Items.Add('<<< Selecione um Tipo  >>>');

  qryObterTodos := TFDQuery.Create(Self);
  qryObterTodos.Close;
  qryObterTodos.SQL.Clear;
  qryObterTodos.SQL.Add(cmdSql);
  qryObterTodos.Connection := dmConexao.conn;
  qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryObterTodos.Open;
  qryObterTodos.Last;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('DESCRICAO').AsString);
          FsListaId.Add(qryObterTodos.FieldByName('ID').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      listaID := FsListaId;
      combo.ItemIndex := 0;

   end;

end;


procedure TframeTipoDeducao.cbbcomboChange(Sender: TObject);
begin
 comboItemIndex := cbbcombo.ItemIndex;
end;

function TframeTipoDeducao.getComboID: string;
var idCombo :string;
begin

 if cbbcombo.ItemIndex > 0 then begin

    idCombo := FsListaId[getComboItemIndex];

 end;

 Result := idCombo;

end;



{$R *.dfm}

end.
