unit uFrameGeneric;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, uUtil,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, udmConexao;

type
  TframeGeneric = class(TFrame)
    cbbcombo: TComboBox;
    lblID: TLabel;
    qryObterPorID: TFDQuery;
    qryObterTodos: TFDQuery;
    procedure cbbcomboChange(Sender: TObject);
    // tabela :string;    field_ : string;

  private
    { Private declarations }
    pIdOrganizacao :string;
  function obterPorID(table, campo, pID: string; var combo: TComboBox; var listaID: TStringList): Boolean;
  function obterTodos(table, campo, ordem : string; var combo: TComboBox; var listaID: TStringList): boolean;

  public
    { Public declarations }

  procedure createComboAll(table, campo, ordem: string; var combo: TComboBox; var listaID: TStringList);
  procedure createComboPorID(table, campo, pID :string; var combo: TComboBox; var listaID: TStringList);
  procedure selectElement(table, campo, ordem: string; pIndice :integer; var combo: TComboBox; var listaID: TStringList);


  end;

implementation

{$R *.dfm}

{ TFrame4 }

procedure TframeGeneric.cbbcomboChange(Sender: TObject);
begin
pIdOrganizacao :=uUtil.TOrgAtual.getId;
end;

procedure TframeGeneric.createComboAll(table, campo, ordem: string; var combo: TComboBox;
  var listaID: TStringList);
begin
  dmConexao.conectarBanco;
  pIdOrganizacao :=uUtil.TOrgAtual.getId;
  obterTodos(table, campo, ordem, combo, listaID);
  //carrega os combos

end;

procedure TframeGeneric.createComboPorID(table, campo, pID: string;
  var combo: TComboBox; var listaID: TStringList);
begin

   dmConexao.conectarBanco;
   pIdOrganizacao :=uUtil.TOrgAtual.getId;
   obterPorID(table, campo, pID, combo, listaID);


end;

function TframeGeneric.obterPorID(table, campo, pID: string; var combo: TComboBox;  var listaID: TStringList): Boolean;
var
field_ : string ;
//pID = é a chave da tupla que deseja o retorno.

begin
  dmConexao.conectarBanco;
  pIdOrganizacao :=uUtil.TOrgAtual.getId;
  field_ := 'ID_'+table; // aqui monta-se o campo do ID da tabela
  listaID := TStringList.Create;
  listaID.Clear;
  combo.Clear;
 //carrega a qry

  qryObterPorID.Close;
  qryObterPorID.Connection := dmConexao.Conn;
  qryObterPorID.ParamByName(field_).AsString := pID;
  qryObterPorID.Open;
// ver se está no inicio
 // qryObterPorID.First;

  while not qryObterPorID.Eof do
  begin
    combo.Items.Add(qryObterPorID.FieldByName(campo).AsString);
        listaID.Add(qryObterPorID.FieldByName(field_).AsString);
    qryObterPorID.Next;
  end;
  qryObterPorID.Close;
  combo.ItemIndex := 0;



end;

function TframeGeneric.obterTodos( table, campo, ordem: string; var combo: TComboBox;
  var listaID: TStringList): boolean;
var
cmd, field_ : string ;
begin
 pIdOrganizacao := uUtil.TOrgAtual.getId;

  field_ := 'ID_'+table; // aqui monta-se o campo do ID da tabela
  cmd := ' SELECT * FROM  ' + table + '  WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  ORDER BY ' + ordem ;
  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');

  //carrega a qry

  qryObterTodos.Close;
  qryObterTodos.Connection := dmConexao.Conn;
  qryObterTodos.SQL.Clear;
  qryObterTodos.SQL.Add(cmd);
  qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;

  qryObterTodos.Open;
  qryObterTodos.First;

  while not qryObterTodos.Eof do
  begin
    combo.Items.Add(qryObterTodos.FieldByName(campo).AsString);
    listaID.Add(qryObterTodos.FieldByName(field_).AsString)  ;
    qryObterTodos.Next;
  end;
  qryObterTodos.Close;
  combo.ItemIndex := 0;

end;

procedure TframeGeneric.selectElement(table, campo, ordem: string; pIndice: integer;
  var combo: TComboBox; var listaID: TStringList);
begin
 pIdOrganizacao :=uUtil.TOrgAtual.getId;
obterTodos(table, campo, ordem, combo, listaID);
combo.ItemIndex := pIndice;

end;

end.
