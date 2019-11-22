unit uFrameTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,udmConexao,uUtil,
  System.Variants, System.Classes,  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TframeTP = class(TFrame)
    redt1: TRichEdit;
    cbbTP: TComboBox;

  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdTP : TStringList;
    qryObterTodos: TFDQuery;

  public
    { Public declarations }

 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;




  end;

implementation

{$R *.dfm}

{ TframeTP }

function TframeTP.obterTodos(pIdValue: string; var combo: TComboBox;  var listaID: TStringList): boolean;
var
cmdSql :string;
pSigla,pTable, pCampoSelecao, pCampoID :string;
begin
dmConexao.conectarBanco;
idOrganizacao := pIdValue;
pTable :='TITULO_PAGAR';
pSigla := 'TP';
pCampoSelecao :='NUMERO_DOCUMENTO';
pCampoID := 'ID_'+ pTable;

 cmdSql := 'SELECT ' + pCampoSelecao +',' + pCampoID  +
           ' FROM ' + pTable + ' '+ pSigla +
           ' WHERE ( ' + pSigla + '.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
           ' AND   ( ' + pSigla + '.ID_TIPO_STATUS <> ''EXCLUIDO'' ) ' +
           ' ORDER BY '+ pSigla + '.DATA_EMISSAO DESC' ;


  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione um t�tulo  >>>');
 try
   qryObterTodos := TFDQuery.Create(Self);
   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmdSql);
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTodos.Open;
   qryObterTodos.Last;
   qryObterTodos.First;

 except
  raise Exception.Create('Erro ao tentar consultar dados dos t�tulos.');


 end;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('NUMERO_DOCUMENTO').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_TITULO_PAGAR').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;

end.
