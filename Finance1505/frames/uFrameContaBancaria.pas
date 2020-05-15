unit uFrameContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,uContaContabilModel,    udmConexao, uUtil,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,uContaContabilDAO,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TfrmContaBancaria = class(TFrame)
    cbbConta: TComboBox;
    lbl1: TLabel;
    qryObterContaContabil: TFDQuery;
    qryObterTodos: TFDQuery;

  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdContas : TStringList;



  public
    { Public declarations }
    function obterQtdCheques(pIDconta, pIDOrganizacao :string) :Integer;
    function obterTodosComCheque(pIdValue: string; var combo: TComboBox; var listaID: TStringList): boolean;
    function obterTodos(pIdValue: string; var combo: TComboBox; var listaID: TStringList): boolean;
    function obterContaContabil(pIDOrganizacao, pIDContaBancaria: string): Boolean;
    function getContaContabil(pIDOrganizacao, pIDContaBancaria: string): TContaContabilModel;
    procedure limpaFrame;

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
           {
          conta.FCodigoReduzido := (qryObterContaContabil.FieldByName('CODREDUZ').AsString);
          conta.FConta          := (qryObterContaContabil.FieldByName('CONTA').AsString);
          conta.FDescricao      := (qryObterContaContabil.FieldByName('DESCRICAO').AsString);
          conta.FDgReduz        := (qryObterContaContabil.FieldByName('DGREDUZ').AsString);
          conta.FDgVer          := (qryObterContaContabil.FieldByName('DGVER').AsString);
          }
          conta.FID             := (qryObterContaContabil.FieldByName('ID_CONTA_CONTABIL').AsString);
          conta.FIdOrganizacao  := (qryObterContaContabil.FieldByName('ID_ORGANIZACAO').AsString);

          conta := TContaContabilDAO.obterPorID(conta);



    end;

  except

    raise(Exception).Create('N�o foi poss�vel obter a conta cont�bil.');

  end;


  Result := conta;
end;


procedure TfrmContaBancaria.limpaFrame;
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


function TfrmContaBancaria.obterContaContabil(pIDOrganizacao,
  pIDContaBancaria: string): Boolean;
  var
  sqlCC :string;
begin
dmConexao.conectarBanco;
 idOrganizacao := TOrgAtual.getId;

  sqlCC :=  ' SELECT CB.ID_CONTA_BANCARIA, '+
            ' CB.ID_ORGANIZACAO, '+
            ' CC.ID_CONTA_CONTABIL,'+
            ' CC.DESCRICAO, '+
            ' CC.CONTA,  '+
            ' CC.DGVER,   '+
            ' CC.CODREDUZ,  '+
            ' CC.DGREDUZ   '+
            ' FROM CONTA_BANCARIA CB '+
            ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO) '+
            ' WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND   (CB.ID_CONTA_BANCARIA = :PIDCONTABANCARIA) ' ;


 try
  // qryObterContaContabil := TFDQuery.Create(Self);
   qryObterContaContabil.Close;
   qryObterContaContabil.Connection := dmConexao.conn;
   qryObterContaContabil.SQL.Clear;
   qryObterContaContabil.SQL.Add(sqlCC);
   qryObterContaContabil.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterContaContabil.ParamByName('PIDCONTABANCARIA').AsString := pIDContaBancaria;
   qryObterContaContabil.Open;

 except

    raise(Exception).Create('Problemas ao tentar consultar conta cont�bl');

  end;
 Result := not qryObterContaContabil.IsEmpty;

end;


function TfrmContaBancaria.obterQtdCheques(pIDconta, pIDOrganizacao :string) :Integer;
var
qryPesquisa : TFDQuery;
cmdSql:string;
qtd :Integer;
begin
qtd :=0;
 dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);

 try
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT COUNT(*) AS QTD FROM CONTA_BANCARIA_CHEQUE CBC '  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  AND (ID_CONTA_BANCARIA = :PID) '  );
  qryPesquisa.SQL.Add('AND (CBC.DATA_EMISSAO IS NULL) AND (CBC.DATA_COMPENSACAO IS NULL) '  );
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := pIDOrganizacao;
  qryPesquisa.ParamByName('PID').AsString := pIDconta;
  qryPesquisa.Open;

  qtd := qryPesquisa.FieldByName('QTD').AsInteger;

 except
 raise Exception.Create('Erro ao obter os cheques por conta ');


 end;


  Result := qtd;
end;
function TfrmContaBancaria.obterTodosComCheque(pIdValue: string; var combo: TComboBox; var listaID: TStringList): boolean;
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
              if (obterQtdCheques(qryObterTodos.FieldByName('ID_CONTA_BANCARIA').AsString, idOrganizacao) > 0) then
              begin

                combo.Items.Add(qryObterTodos.FieldByName('CONTA').AsString);
                listaID.Add(qryObterTodos.FieldByName('ID_CONTA_BANCARIA').AsString);

              end;

          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;



function TfrmContaBancaria.obterTodos(pIdValue: string; var combo: TComboBox; var listaID: TStringList): boolean;
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
