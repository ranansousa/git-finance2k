unit uFrameSacado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  udmConexao,uUtil,uContaContabilModel,uSacadoModel, uSacadoDAO,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TframeSacado = class(TFrame)
    cbbcombo: TComboBox;
    procedure cbbcomboChange(Sender: TObject);
 private
    pIdOrganizacao : string;
    comboItemIndex :Integer;
    FsListaIdSacados : TStringList;


  public
    { Public declarations }

 function obterTodos    (pIdOrganizacao: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function getComboItemIndex :Integer;
 function getComboID :string;
function preencheDBGrid(pIDOrganizacao :string ) :TFDQuery;




  end;

implementation

{$R *.dfm}

procedure TframeSacado.cbbcomboChange(Sender: TObject);
begin
 comboItemIndex := cbbcombo.ItemIndex;

end;


function TframeSacado.getComboID: string;
var idCombo :string;
begin

 if cbbcombo.ItemIndex > 0 then begin

    idCombo := FsListaIdSacados[getComboItemIndex];

 end;

 Result := idCombo;

end;

function TframeSacado.getComboItemIndex: Integer;
begin

Result := comboItemIndex;

end;

function TframeSacado.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
 qryObterTodos : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

 cmdSql := 'SELECT C.ID_SACADO, C.NOME FROM SACADO C WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) ORDER BY C.NOME' ;

  FsListaIdSacados := TStringList.Create;
  FsListaIdSacados.Clear;
  FsListaIdSacados.Add('Sem ID');


  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');

  combo.Clear;
  combo.Items.Add('<<< Selecione um Sacado  >>>');

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
          combo.Items.Add(uUtil.TFormat.retiraAcento(qryObterTodos.FieldByName('NOME').AsString));
         // listaID.Add(qryObterTodos.FieldByName('ID_SACADO').AsString);
          FsListaIdSacados.Add(qryObterTodos.FieldByName('ID_SACADO').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      listaID := FsListaIdSacados;
      combo.ItemIndex := 0;

   end;

end;

function TframeSacado.preencheDBGrid(pIDOrganizacao: string): TFDQuery;
var
 qryPreencheGrid : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := ' SELECT C.ID_SACADO, C.ID_ORGANIZACAO,' +
                     ' C.ID_TIPO_SACADO, C.ID_ENDERECO,' +
                     ' C.ID_CONTATO, C.NOME, C.CPFCNPJ,' +
                     ' C.PERSONALIDADE, C.CONTA_BANCARIA,' +
                     ' C.AGENCIA, C.ID_BANCO, C.CGA,' +
                     ' C.INSCRICAO_ESTADUAL,  C.ID_CONTA_CONTABIL,' +
                     ' C.INSCRICAO_MUNICIPAL, C.ID_CARTAO_CREDITO,' +
                     ' C.DATA_REGISTRO, C.SACADO, C.STATUS, ' +
                     ' C.DATA_ULTIMA_ATUALIZACAO, C.CODIGO' +
             ' FROM SACADO C ' +
             ' WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO )' ;
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

end.

