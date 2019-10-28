unit uFrameContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,uContaContabilModel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmContaBancaria = class(TFrame)
    cbbConta: TComboBox;
    lbl1: TLabel;
    qryObterTodos: TFDQuery;
    qryObterContaContabil: TFDQuery;
  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdContas : TStringList;

  public
    { Public declarations }

 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterContaContabil (pIDOrganizacao, pIDContaBancaria :string) : Boolean;
 function getContaContabil  (pIDOrganizacao, pIDContaBancaria :string) : TContaContabilModel;


  end;

implementation

{$R *.dfm}

{ TfrmContaBancaria }

function TfrmContaBancaria.getContaContabil(pIDOrganizacao, pIDContaBancaria: string): TContaContabilModel;
var
conta : TContaContabilModel;

begin
   conta :=TContaContabilModel.Create;

 try
    if obterContaContabil(pIDOrganizacao, pIDContaBancaria) then begin

        conta.SetFCodigoReduzido(qryObterContaContabil.FieldByName('CODREDUZ').AsString);
        conta.SetFConta(qryObterContaContabil.FieldByName('CONTA').AsString);
        conta.SetFDescricao(qryObterContaContabil.FieldByName('DESCRICAO').AsString);
        conta.SetFDgReduz(qryObterContaContabil.FieldByName('DGREDUZ').AsString);
        conta.SetFDgVer(qryObterContaContabil.FieldByName('DGVER').AsString);
        conta.SetFIdContaContabil(qryObterContaContabil.FieldByName('ID_CONTA_CONTABIL').AsString);
        conta.SetFIdOrganizacao(qryObterContaContabil.FieldByName('ID_ORGANIZACAO').AsString);

    end;

  except

    raise(Exception).Create('Não foi possível obter a conta contábil.');

  end;


  Result := conta;
end;



function TfrmContaBancaria.obterContaContabil(pIDOrganizacao,
  pIDContaBancaria: string): Boolean;
begin
dmConexao.conectarBanco;
 idOrganizacao := TOrgAtual.getId;
 try
   qryObterContaContabil.Close;
   qryObterContaContabil.Connection := dmConexao.conn;
   qryObterContaContabil.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterContaContabil.ParamByName('PIDCONTABANCARIA').AsString := pIDContaBancaria;
   qryObterContaContabil.Open;

 except

    raise(Exception).Create('Problemas ao tentar consultar conta contábl');

  end;
 Result := not qryObterContaContabil.IsEmpty;

end;

function TfrmContaBancaria.obterTodos(pIdValue: string; var combo: TComboBox;
  var listaID: TStringList): boolean;
begin

dmConexao.conectarBanco;
idOrganizacao := TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione uma Conta  >>>');

   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTodos.Open;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('CONTA').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_CONTA_BANCARIA').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;


end.
