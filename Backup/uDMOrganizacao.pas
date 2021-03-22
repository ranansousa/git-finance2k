unit uDMOrganizacao;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,udmConexao, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdmOrganizacao = class(TDataModule)
    qryDadosEmpresa: TFDQuery;
    qryLoadOrgs: TFDQuery;
    qryOrganizacoes: TFDQuery;
    qryServidorEmail: TFDQuery;
    qryValidaLogin: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
   function carregarOrganizacoes: Boolean;
   function carregarServidorEmail: Boolean;
   function carregarDadosEmpresa(pIdOrganizacao :string) : Boolean;
  end;

var
  dmOrganizacao: TdmOrganizacao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmOrganizacao.carregarDadosEmpresa(pIdOrganizacao :string) : Boolean;
begin
    dmOrganizacao.qryDadosEmpresa.Close;
    dmOrganizacao.qryDadosEmpresa.ParamByName('pIdOrganizacao').AsString :=pIdOrganizacao ;
//    qryDadosEmpresa.ParamByName('pIdOrganizacao').AsString := FsListaIdOrganizacoes[cbxOrganizacoes.ItemIndex];
    dmOrganizacao.qryDadosEmpresa.Open;
    Result := not dmOrganizacao.qryDadosEmpresa.IsEmpty;
end;



function TdmOrganizacao.carregarOrganizacoes: Boolean;
begin
    dmOrganizacao.qryOrganizacoes.Close;
    dmOrganizacao.qryOrganizacoes.Connection := dmConexao.Conn;
    dmOrganizacao.qryOrganizacoes.Open;

    Result := not dmOrganizacao.qryOrganizacoes.IsEmpty;
end;

function TdmOrganizacao.carregarServidorEmail: Boolean;
begin
    dmOrganizacao.qryServidorEmail.Close;
    dmOrganizacao.qryServidorEmail.Connection := dmConexao.Conn;
    dmOrganizacao.qryServidorEmail.Open;

    Result := not dmOrganizacao.qryServidorEmail.IsEmpty;
end;



end.
