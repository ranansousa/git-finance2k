unit uFrameHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameGeneric, FireDAC.Stan.Intf, uHistoricoModel,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,udmConexao,uUtil,uContaContabilModel,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uContaContabilDAO,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TframeHistorico = class(TframeGeneric)
    qryObterContaContabil: TFDQuery;
  private
    idOrganizacao : string;
    FsListaIdHistoricos : TStringList;
    function obterContaContabil(pIDOrganizacao, pIDHistorico: string): Boolean;

  public
    { Public declarations }

 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterTodosPorCodigo(pIDOrganizacao :string; pCodigoHistorico :Integer; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterTodosPorTipo (pIDOrganizacao, pTipoHistorico :string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterHistorico    (pIDOrganizacao, pIDHistorico :string) : Boolean;
 function getHistorico      (pIDOrganizacao, pIDHistorico :string) : THistoricoModel;
 function getContaContabil  (pIDOrganizacao, pIDHistorico :string) : TContaContabilModel;


  end;

var
  frameHistorico: TframeHistorico;

implementation

{$R *.dfm}

function TframeHistorico.getHistorico(pIDOrganizacao,  pIDHistorico: string): THistoricoModel;
var
historico : THistoricoModel;

begin
   historico :=THistoricoModel.Create;

 try

   if obterHistorico(pIDOrganizacao,pIDHistorico) then begin

      historico.FIdOrganizacao   := (qryObterPorID.FieldByName('ID_ORGANIZACAO').AsString);
      historico.FDescricao       := (qryObterPorID.FieldByName('DESCRICAO_HISTORICO').AsString);
      historico.FIdHistorico     := (qryObterPorID.FieldByName('ID_HISTORICO').AsString);
      historico.FCodigo          := (qryObterPorID.FieldByName('CODIGO').AsInteger);
      historico.FIdContaContabil := (qryObterPorID.FieldByName('ID_CONTA_CONTABIL').AsString);

   end;


  except

    raise(Exception).Create('N�o foi poss�vel obter o hist�rico.');

  end;


  Result := historico;
end;

function TframeHistorico.obterHistorico(pIDOrganizacao,  pIDHistorico: string): Boolean;
var
sqlCmd :string;
begin
 dmConexao.conectarBanco;

 try
     sqlCmd :=  ' SELECT H.ID_HISTORICO, H.ID_ORGANIZACAO, H.DESCRICAO AS DESCRICAO_HISTORICO, H.TIPO, '+
                ' H.CODIGO, H.DESCRICAO_REDUZIDA, CC.ID_CONTA_CONTABIL, CC.CONTA, CC.DESCRICAO AS DESCRICAO_CONTA, CC.CODREDUZ AS CODIGO_REDUZ '+
                ' FROM HISTORICO H '+
                ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
                ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (H.ID_HISTORICO = :PID) ORDER BY CC.CONTA ';


    qryObterPorID.Close;
    qryObterPorID.Connection := dmConexao.conn;
    qryObterPorID.SQL.Clear;
    qryObterPorID.SQL.Add(sqlCmd);

    qryObterPorID.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
    qryObterPorID.ParamByName('PID').AsString := pIDHistorico;
    qryObterPorID.Open;


 except
 raise Exception.Create('Erro ao obter historico por ID');

 end;

 Result := not qryObterPorID.IsEmpty;

end;

function TframeHistorico.obterTodos(pIdValue: string; var combo: TComboBox; var listaID: TStringList): boolean;
begin

dmConexao.conectarBanco;
idOrganizacao := TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione um Historico  >>>');

   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdValue;
   qryObterTodos.Open;
   qryObterTodos.Last;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('DESCRICAO_HISTORICO').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_HISTORICO').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;



function TframeHistorico.obterTodosPorCodigo(pIDOrganizacao :string; pCodigoHistorico :Integer; var combo: TComboBox;   var listaID: TStringList): boolean;
var
qryObterPorCodigo :TFDQuery;
sqlCmd : string;
begin
 dmConexao.conectarBanco;
 //CODIGO = Codigo de historico padrao


 try

   sqlCmd :=  ' SELECT H.ID_HISTORICO, H.ID_ORGANIZACAO,  H.DESCRICAO AS DESCRICAO_HISTORICO, H.TIPO, '+
              ' H.CODIGO, H.DESCRICAO_REDUZIDA, CC.CONTA, CC.DESCRICAO AS DESCRICAO_CONTA, CC.CODREDUZ AS CODIGO_REDUZ '+
              ' FROM HISTORICO H '+
              ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
              ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (H.CODIGO = :PCODIGO) ORDER BY CC.CONTA ';


   qryObterPorCodigo := TFDQuery.Create(Self);
   qryObterPorCodigo.Close;
   qryObterPorCodigo.Connection := dmConexao.conn;
   qryObterPorCodigo.SQL.Clear;
   qryObterPorCodigo.sql.Add(sqlCmd);


   qryObterPorCodigo.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
   qryObterPorCodigo.ParamByName('PCODIGO').AsInteger := pCodigoHistorico;
   qryObterPorCodigo.Open;



   listaID := TStringList.Create;
    listaID.Clear;
   listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione  >>>');


   if not qryObterPorCodigo.IsEmpty then begin
          qryObterPorCodigo.First;

      while not qryObterPorCodigo.Eof do
        begin
          combo.Items.Add(qryObterPorCodigo.FieldByName('DESCRICAO_HISTORICO').AsString);
          listaID.Add(qryObterPorCodigo.FieldByName('ID_HISTORICO').AsString);
          qryObterPorCodigo.Next;
        end;
      qryObterPorCodigo.Close;
      combo.ItemIndex := 0;

   end;


 except

 raise Exception.Create('Erro ao obter hist�ricos por c�digo padr�o');

 end;


end;


function TframeHistorico.obterTodosPorTipo(pIDOrganizacao,  pTipoHistorico: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterPorTipo :TFDQuery;
sqlCmd : string;
begin
 dmConexao.conectarBanco;

 try

   sqlCmd :=  ' SELECT H.ID_HISTORICO, H.ID_ORGANIZACAO,  H.DESCRICAO AS DESCRICAO_HISTORICO, H.TIPO, '+
              ' H.CODIGO, H.DESCRICAO_REDUZIDA, CC.CONTA, CC.DESCRICAO AS DESCRICAO_CONTA, CC.CODREDUZ AS CODIGO_REDUZ '+
              ' FROM HISTORICO H '+
              ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
              ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO)   AND ((H.TIPO = :PTIPO) OR (H.TIPO = ''G'') OR (H.TIPO = ''N'') ) ORDER BY H.DESCRICAO ';


   qryObterPorTipo := TFDQuery.Create(Self);
   qryObterPorTipo.Close;
   qryObterPorTipo.Connection := dmConexao.conn;
   qryObterPorTipo.SQL.Clear;
   qryObterPorTipo.sql.Add(sqlCmd);


   qryObterPorTipo.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
   qryObterPorTipo.ParamByName('PTIPO').AsString := pTipoHistorico;
   qryObterPorTipo.Open;
   qryObterPorTipo.Last;
   //qryObterPorTipo.RecordCount;





   listaID := TStringList.Create;
    listaID.Clear;
   listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione  >>>');


   if not qryObterPorTipo.IsEmpty then begin
          qryObterPorTipo.First;

      while not qryObterPorTipo.Eof do
        begin
          combo.Items.Add(qryObterPorTipo.FieldByName('DESCRICAO_HISTORICO').AsString);
          listaID.Add(qryObterPorTipo.FieldByName('ID_HISTORICO').AsString);
          qryObterPorTipo.Next;
        end;
      qryObterPorTipo.Close;
      combo.ItemIndex := 0;

   end;


 except

 raise Exception.Create('Erro ao obter hist�ricos por tipo');

 end;


end;

function TframeHistorico.getContaContabil(pIDOrganizacao, pIDHistorico: string): TContaContabilModel;
var
conta : TContaContabilModel;

begin
   conta :=TContaContabilModel.Create;

 try
    if obterContaContabil(pIDOrganizacao, pIDHistorico) then begin

         { conta.FCodigoReduzido := (qryObterContaContabil.FieldByName('CODREDUZ').AsString);
          conta.FConta := (qryObterContaContabil.FieldByName('CONTA').AsString);
          conta.FDescricao := (qryObterContaContabil.FieldByName('DESCRICAO').AsString);
          conta.FDgReduz := (qryObterContaContabil.FieldByName('DGREDUZ').AsString);
          conta.FDgVer := (qryObterContaContabil.FieldByName('DGVER').AsString);
          }

          conta.FID := (qryObterContaContabil.FieldByName('ID_CONTA_CONTABIL').AsString);
          conta.FIdOrganizacao := (qryObterContaContabil.FieldByName('ID_ORGANIZACAO').AsString);
          conta := TContaContabilDAO.obterPorID(conta);

    end;

  except

    raise(Exception).Create('N�o foi poss�vel obter a conta cont�bil.');

  end;


  Result := conta;
end;


function TframeHistorico.obterContaContabil(pIDOrganizacao,  pIDHistorico: string): Boolean;
  var
  sqlCC :string;
begin
 dmConexao.conectarBanco;
 idOrganizacao := TOrgAtual.getId;
 pIDOrganizacao := idOrganizacao;

  sqlCC :=  ' SELECT H.ID_HISTORICO, '+
            ' H.ID_ORGANIZACAO, '+
            ' CC.ID_CONTA_CONTABIL,'+
            ' CC.DESCRICAO, '+
            ' CC.CONTA,  '+
            ' CC.DGVER,   '+
            ' CC.CODREDUZ,  '+
            ' CC.DGREDUZ   '+
            ' FROM HISTORICO H '+
            ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '+
            ' WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) AND   (H.ID_HISTORICO = :PIDHISTORICO) ' ;


 try

  // qryObterContaContabil := TFDQuery.Create(Self);
   qryObterContaContabil.Close;
   qryObterContaContabil.Connection := dmConexao.conn;
   qryObterContaContabil.SQL.Clear;
   qryObterContaContabil.SQL.Add(sqlCC);
   qryObterContaContabil.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
   qryObterContaContabil.ParamByName('PIDHISTORICO').AsString := pIDHistorico;
   qryObterContaContabil.Open;

 except

    raise(Exception).Create('Problemas ao tentar consultar conta cont�bl');

  end;
 Result := not qryObterContaContabil.IsEmpty;

end;


end.
