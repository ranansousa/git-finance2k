unit uFrameBairro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  uFrameGeneric, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao,
  Vcl.StdCtrls,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.Graphics,
  sFrameAdapter, sSkinManager;

type
  TfrmBairro = class(TframeGeneric)
  private
    { Private declarations }
  public
    { Public declarations }

     function obterTodosPorCidade(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
     procedure limpaFrame;


  end;

var
  frmBairro: TfrmBairro;

implementation

{$R *.dfm}


function TfrmBairro.obterTodosPorCidade(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
var
cmd, field_ : string ;
begin


  cmd := ' SELECT B.ID_BAIRRO,B.ID_CIDADE, B.BAIRRO FROM BAIRRO B ' +
         ' WHERE (B.ID_CIDADE = :pId) ';


  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');

  //carrega a qry
  dmConexao.conectarBanco;

  qryObterTodos.Close;
  qryObterTodos.Connection := dmConexao.Conn;
  qryObterTodos.SQL.Clear;
  qryObterTodos.SQL.Add(cmd);
  qryObterTodos.ParamByName('pId').AsString := pIdValue;
  qryObterTodos.Open;
  qryObterTodos.First;

  while not qryObterTodos.Eof do
  begin
    combo.Items.Add(qryObterTodos.FieldByName('BAIRRO').AsString);
    listaID.Add(qryObterTodos.FieldByName('ID_BAIRRO').AsString)  ;
    qryObterTodos.Next;
  end;
  qryObterTodos.Close;
  combo.ItemIndex := 0;

end;



procedure TfrmBairro.limpaFrame;
var
i :Integer;
begin

// limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin

         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin

     // TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;
end;






end.
