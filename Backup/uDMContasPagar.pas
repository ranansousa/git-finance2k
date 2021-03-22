unit uDMContasPagar;

// Será responsável por toda parte de acesso a SGBD.
//Usa conexao definida em uDM.

interface

uses
//  System.SysUtils, System.Classes,uDM, Data.DB;
   System.SysUtils, System.Variants, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,UDMOrganizacao,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,udmConexao, FireDAC.Stan.Util, FireDAC.Comp.Script;


type
  TdmContasPagar = class(TDataModule)
    DSPreencheGridMain: TDataSource;
    qryRelPagamentos: TFDQuery;
    qryCentroCusto: TFDQuery;
    sqlScriptContainer: TFDScript;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmContasPagar: TdmContasPagar;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
