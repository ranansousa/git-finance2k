unit uValeTransporteGeral;

interface

uses
  SqlExpr, SysUtils, Forms, Controls, uFormSearchSalarioMinimo, Util, IBase,
  ELibFnc, uPConsts, LibMega, FireDAC.Comp.Client;

type

  TValeTransporteGeral = class(TTableBase)
  Private
  protected
    function canInsert(): Boolean; override;
    function canUpdate(): Boolean; override;
    function canDelete(): Boolean; override;

  public
    constructor Create(Conn: TFDConnection); reintroduce; virtual;

    function Gerador: String; override;
    function ShowModal: ITable; override;
  end;

  TValeTransporteGeralProvider = class(TProviderBase)
  private
//    function doExecuteProcedure(lcOpr: String): boolean; virtual;
  protected
    function doInsert: Boolean; override;
    function doUpdate: Boolean; override;
    function doDelete: Boolean; override;
  end;

implementation

{ TValeTransporteGeral}

function TValeTransporteGeral.canDelete: Boolean;
begin
  result := trim(FieldByName('ID_PVALE_TRANSPORTE_GERAL').AsString) <> '';
end;

function TValeTransporteGeral.canInsert: Boolean;
begin
  result := true;
//  result := (trim(FieldByName('ID_GSALARIO_MINIMO').AsString) <> '') and
//            (FieldByName('VALOR').AsValue > 0) and
//            (FieldByName('DATA').AsDate > 0);
end;

function TValeTransporteGeral.canUpdate: Boolean;
begin
  result := canInsert;
end;

constructor TValeTransporteGeral.Create(Conn: TFDConnection);
begin
  inherited Create(Conn, 'PVALE_TRANSPORTE_GERAL');
end;

function TValeTransporteGeral.Gerador: String;
begin
  result := inherited doGerador;
end;

function TValeTransporteGeral.ShowModal: ITable;
var
  loForm: T_frmFormSearchSalarioMinimo;
  lsSql: String;
begin
  loForm := T_frmFormSearchSalarioMinimo.Create(Application, TUtil.IniFile);
  try
    loForm.Conn := Conn;
    loForm.AddField('DATA', 'DATA', IBase.ftDate, true);
    loForm.AddField('VALOR', 'VALOR', IBase.ftNumber, true);

    loForm.SQL.Text := 'SELECT ID_PVALE_TRANSPORTE_GERAL,FK_TABELA_GERAL,DATA,VALOR FROM PVALE_TRANSPORTE_GERAL ORDER BY DATA';

    if loForm.ShowModal = mrOK then
      begin
      result := TValeTransporteGeral.Create(Conn);
      result.FieldByName('ID_PVALE_TRANSPORTE_GERAL').AsString := loForm.DataSet.FieldByName('ID_PVALE_TRANSPORTE_GERAL').AsString;
      result.LoadData(['ID_PVALE_TRANSPORTE_GERAL']);
      end
    else
      result := nil;
  finally
    FreeAndNil(loForm);
  end;
end;

{ TValeTransporteGeralProvider }

function TValeTransporteGeralProvider.doDelete: Boolean;
begin
//  result := doExecuteProcedure('E');
  Result := Table.Post(dsExcluir,bkPessoa);
end;

//function TValeTransporteGeralProvider.doExecuteProcedure(lcOpr: String): boolean;
//var
//  loQry  : TSQLQuery;
//begin
//  loQry := TSQLQuery.Create(nil);
//  try
//    loQry.SQLConnection := Conn;
//    loQry.SQL.Add('EXECUTE PROCEDURE SP_PVALE_TRANSPORTE_GERAL(:pIdValeTransporteGeral,:pIdTabelaGeral,:pData,:pValor,:pOperacao)');
//
//    loQry.ParamByName('pIdValeTransporteGeral').AsString  := Table.FieldByName('ID_PVALE_TRANSPORTE_GERAL').AsString;
//    loQry.ParamByName('pIdTabelaGeral'        ).AsString  := Table.FieldByName('FK_TABELA_GERAL'          ).AsString;
//    loQry.ParamByName('pData'                 ).AsDate    := Table.FieldByName('Data'                     ).AsDate;
//    loQry.ParamByName('pValor'                ).AsCurrency:= Table.FieldByName('Valor'                    ).AsCurrency;
//    loQry.ParamByName('pOperacao'             ).AsString  := lcOpr;
//    loQry.ExecSQL();
//    result := true;
//  finally
//    loQry.Close;
//    FreeAndNil(loQry);
//  end;
//end;

function TValeTransporteGeralProvider.doInsert: Boolean;
begin
//  result := doExecuteProcedure('I');
  Result := Table.Post(dsInserir,bkPessoa);
end;

function TValeTransporteGeralProvider.doUpdate: Boolean;
begin
//  result := doExecuteProcedure('A');
  Result := Table.Post(dsAtualizar,bkPessoa);
end;

end.
