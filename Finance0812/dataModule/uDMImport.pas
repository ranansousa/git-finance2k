unit uDMImport;

interface

uses
  System.SysUtils, System.Classes,udmConexao,uDMOrganizacao,uDMMegaContabil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, ELibFnc,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,uUtil;

type
  TdmImport = class(TDataModule)
    qryInserePorLinha: TFDQuery;
  private
    { Private declarations }
     procedure inicializarDM(Sender: TObject);
     procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }
    function insereTRPorImportacao(cmdSql :String): Integer;
  end;

var
  dmImport: TdmImport;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmImport }

procedure TdmImport.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmConexao)) then begin
    FreeAndNil(dmConexao);
  end;

  if (Assigned(dmOrganizacao)) then begin
      FreeAndNil(dmOrganizacao) ;
  end;

  if (Assigned(dmMegaContabil)) then begin
      FreeAndNil(dmMegaContabil) ;
  end;


end;


procedure TdmImport.inicializarDM(Sender: TObject);
begin
     if not(Assigned(dmConexao)) then begin
             dmConexao := TdmConexao.Create(Self);
      end;

      //conectar banco
      dmConexao.conectarBanco;


      if not(Assigned(dmOrganizacao)) then begin
             dmOrganizacao := TdmOrganizacao.Create(Self);
      end;

      if not(Assigned(dmMegaContabil)) then begin
             dmMegaContabil := TdmMegaContabil.Create(Self);
      end;

end;

function TdmImport.insereTRPorImportacao(cmdSql: string): Integer;
var
nDoc,  linha :string;

begin

  Result := 0;
  dmConexao.conectarBanco;
  linha := cmdSql;

  try
    qryInserePorLinha.Close;
    qryInserePorLinha.Connection := dmConexao.Conn;
    qryInserePorLinha.SQL.Clear;

            nDoc := dmConexao.obterIdentificador('', uutil.TOrgAtual.getId,'TR');
            cmdSql := StrToken(cmdSql, ',',9);
            cmdSql := StrSubst(linha,cmdSql,QuotedStr(nDoc)+ ');',0);


    qryInserePorLinha.SQL.Add(cmdSql);
 //   qryInserePorLinha.ParamByName('ID_ORGANIZACAO').AsString := TOrgAtual.getId;


    Result := qryInserePorLinha.ExecSQL(cmdSql);
    dmConexao.conn.CommitRetaining;

  except
       dmConexao.conn.RollbackRetaining;
    raise Exception.Create('Não foi possível realizar importação.');

  end;
end;

end.

