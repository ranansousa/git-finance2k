unit uFrameEstadoOLD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, udmConexao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmEstado = class(TFrame)
    cbbEstado: TComboBox;
    lblID: TLabel;
    qryObterPorID: TFDQuery;
    qryObterTodos: TFDQuery;

  private
    { Private declarations }
    //FsListaId: TStringList;
    function obterPorID(table, campo, pID: string; var combo: TComboBox; var listaID: TStringList): Boolean;
    function obterTodos(table, campo : string; var combo: TComboBox; var listaID: TStringList): boolean;

  public
    { Public declarations }
    procedure createComboEstado(table, campo: string; var combo: TComboBox; var listaID: TStringList);
    procedure createComboEstadoPorID(table, campo, pID :string; var combo: TComboBox; var listaID: TStringList);
    procedure selectEstado(table, campo: string; pIndice :integer; var combo: TComboBox; var listaID: TStringList);

    procedure limpa;


  end;

implementation

{$R *.dfm}

{ TfrmEstado }

//quem chamar precisa ter uma lista para armazenar os IDs





procedure TfrmEstado.createComboEstado(table, campo: string; var combo: TComboBox; var listaID: TStringList);
begin

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

  obterTodos(table, campo, combo, listaID);
  //carrega os combos

end;


procedure TfrmEstado.createComboEstadoPorID(table, campo, pID :string; var combo: TComboBox; var listaID: TStringList);
begin

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

   obterPorID(table, campo, pID, combo, listaID);

end;

procedure TfrmEstado.limpa;
begin
  qryObterTodos.Free;
end;

function TfrmEstado.obterPorID(table, campo, pID: string; var combo: TComboBox; var listaID: TStringList): Boolean;
var
field_ : string ;
//pID = � a chave da tupla que deseja o retorno.

begin
  field_ := 'ID_'+table; // aqui monta-se o campo do ID da tabela
  listaID := TStringList.Create;
  listaID.Clear;
  combo.Clear;
 //carrega a qry

 if not qryObterPorID.Connection.Connected then
  begin
    qryObterPorID.Connection := dmConexao.Conn;
  end;

  qryObterPorID.Close;
  qryObterPorID.ParamByName(field_).AsString := pID;
  qryObterPorID.Open;
// ver se est� no inicio
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



function TfrmEstado.obterTodos(table, campo : string; var combo: TComboBox; var listaID: TStringList): boolean;
var
field_ : string ;
begin
  field_ := 'ID_'+table; // aqui monta-se o campo do ID da tabela

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');

  //carrega a qry

 if not qryObterTodos.Connection.Connected then
  begin
    qryObterTodos.Connection := dmConexao.Conn;
  end;

  qryObterTodos.Close;
  qryObterTodos.Open;
  qryObterTodos.First;

  while not qryObterTodos.Eof do
  begin
    combo.Items.Add(qryObterTodos.FieldByName(campo).AsString);
    listaID.Add(qryObterTodos.FieldByName(field_).AsString);
    qryObterTodos.Next;
  end;
  qryObterTodos.Close;
  combo.ItemIndex := 0;

end;


procedure TfrmEstado.selectEstado(table, campo: string; pIndice :integer; var combo: TComboBox; var listaID: TStringList);
begin
obterTodos(table, campo, combo, listaID);
combo.ItemIndex := pIndice;

end;

end.
