unit uDMComboBox;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, uDMCedenteConsulta, uUtil;

type
  TdmComboBox = class(TDataModule)
  private
    { Private declarations }
    { FsListaIdOrganizacoes: TStringList;
      FsListaIdCentrosCusto: TStringList;
      FsListaIdFornecedor: TStringList;
      FsListaIdCliente: TStringList;
      FsListaIdHistorico: TStringList;
      FsListaIdContaBancaria: TStringList; }

  public
    { Public declarations }
    procedure listaFornecedor(Var combo: TComboBox; var listaID: TStringList);

  end;

var
  dmComboBox: TdmComboBox;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

procedure TdmComboBox.listaFornecedor(var combo: TComboBox;
  var listaID: TStringList);
begin
  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  // Linha adicionada somente para combatibilizar com os itens do ComboBox cbxCentrosCusto
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');
  dmCedenteConsulta.qryObterTodosPorOrganizacao(TOrgAtual.getId).First;
  while not dmCedenteConsulta.qryObterTodosPorOrganizacao.Eof do
  begin
    combo.Items.Add(dmCedenteConsulta.qryObterTodosPorOrganizacao.FieldByName
      ('NOME').AsString);
    listaID.Add(dmCedenteConsulta.qryObterTodosPorOrganizacao.FieldByName
      ('ID_CEDENTE').AsString);
    dmCedenteConsulta.qryObterTodosPorOrganizacao.Next;
  end;
  dmCedenteConsulta.qryObterTodosPorOrganizacao.Close;
  combo.ItemIndex := 0;
end;

end.
