unit uFrameTipoCedente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  udmConexao,uUtil,uContaContabilModel,uCedenteModel,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TfrmTipoCedente = class(TFrame)
    cbbcombo: TComboBox;
    procedure cbbcomboChange(Sender: TObject);
 private
    pIdOrganizacao : string;
    comboItemIndex :Integer;
    FsListaId : TStringList;


  public
    { Public declarations }
 function obterTodos      (pIdOrganizacao: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function getTipoCedente      (pIDOrganizacao, pIDTipoCedente :string) : String;
 function getComboItemIndex :Integer;
 function getComboID :string;
// function preencheDBGrid(pIDOrganizacao :string; var dBGrid: TDBGrid ) :TFDQuery;
function preencheDBGrid(pIDOrganizacao :string ) :TFDQuery;




  end;

implementation

{$R *.dfm}

procedure TfrmTipoCedente.cbbcomboChange(Sender: TObject);
begin
 comboItemIndex := cbbcombo.ItemIndex;

end;

function TfrmTipoCedente.getTipoCedente(pIDOrganizacao,  pIDTipoCedente: string): String;
var
qryObterC : TFDQuery;
 cmdSql :string;
begin

 dmConexao.conectarBanco;


       cmdSql := ' SELECT *  FROM TIPO_CEDENTE C WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO ) ';


  try

        qryObterC := TFDQuery.Create(Self);
        qryObterC.Close;
        qryObterC.SQL.Clear;
        qryObterC.SQL.Add(cmdSql);
        qryObterC.Connection := dmConexao.conn;
        qryObterC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterC.Open;

   except

   raise Exception.Create('Erro ao tentar obter o tipo cedente');

   end;


 Result := qryObterC.FieldByName('DESCRICAO').AsString;

end;

function TfrmTipoCedente.getComboID: string;
var idCombo :string;
begin

 if cbbcombo.ItemIndex > 0 then begin

    idCombo := FsListaId[getComboItemIndex];

 end;

 Result := idCombo;

end;

function TfrmTipoCedente.getComboItemIndex: Integer;
begin

Result := comboItemIndex;

end;


function TfrmTipoCedente.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
 qryObterTodos : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

 cmdSql := 'SELECT C.ID_TIPO_CEDENTE AS ID, C.DESCRICAO FROM TIPO_CEDENTE C WHERE (C.ID_ORGANIZACAO = :PIDORGANIZACAO) ORDER BY C.DESCRICAO' ;

  FsListaId := TStringList.Create;
  FsListaId.Clear;
  FsListaId.Add('Sem ID');



  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');

  combo.Clear;
  combo.Items.Add('<<< Selecione um Cedente  >>>');

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

function TfrmTipoCedente.preencheDBGrid(pIDOrganizacao: string): TFDQuery;
var
 qryPreencheGrid : TFDQuery;
 cmdSql :string;
begin

dmConexao.conectarBanco;
if uutil.Empty(pIdOrganizacao) then begin pIdOrganizacao := TOrgAtual.getId; end;

   cmdSql := ' SELECT C.ID_TIPO_CEDENTE AS ID, C.ID_ORGANIZACAO,' +
                     ' C.DESCRICAO '+
                     ' FROM TIPO_CEDENTE C WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO )' ;
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

