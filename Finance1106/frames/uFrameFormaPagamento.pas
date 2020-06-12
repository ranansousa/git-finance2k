unit uFrameFormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uFormaPagamentoModel,uContaContabilModel,uContaContabilDAO,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmFormaPagto = class(TFrame)
    cbbcombo: TComboBox;
  private
    { Private declarations }
    pIdOrganizacao : string;
    FsListaIdFP : TStringList;

  public
    { Public declarations }

    function obterPorID(pForma :TFormaPagamentoModel): TFormaPagamentoModel;
    function obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
    function getContaContabil(pForma :TFormaPagamentoModel) : TContaContabilModel;

    procedure limpaFrame;

  end;

implementation

{$R *.dfm}

function TfrmFormaPagto.obterPorID(pForma :TFormaPagamentoModel): TFormaPagamentoModel;
var
  qryObter: TFDQuery;
  cmd: string;
  local: TFormaPagamentoModel;
begin
  local := TFormaPagamentoModel.Create;
  dmConexao.conectarBanco;
  try
    cmd :=  ' SELECT FP.ID_FORMA_PAGAMENTO, FP.DESCRICAO, '+
            ' FP.ID_CONTA_CONTABIL, '+
            ' FP.ID_ORGANIZACAO, '+
            ' CC.ID_CONTA_CONTABIL,'+
            ' CC.DESCRICAO AS DSC_CC, '+
            ' CC.CONTA,  '+
            ' CC.DGVER,   '+
            ' CC.CODREDUZ,  '+
            ' CC.DGREDUZ   '+
            ' FROM FORMA_PAGAMENTO FP '+
            ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = FP.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = FP.ID_ORGANIZACAO) '+
            ' WHERE (FP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND   (FP.ID_FORMA_PAGAMENTO = :PID) ' ;




    qryObter := TFDQuery.Create(Self);
    qryObter.Close;
    qryObter.Connection := dmConexao.conn;
    qryObter.SQL.Clear;
    qryObter.SQL.Add(cmd);
    qryObter.ParamByName('PIDORGANIZACAO').AsString := pForma.FIDorganizacao;
    qryObter.ParamByName('PID').AsString := pForma.FID;
    qryObter.Open;

    if not qryObter.IsEmpty then
    begin

      local.FID            := qryObter.FieldByName('ID_FORMA_PAGAMENTO').AsString;
      local.FIDorganizacao := qryObter.FieldByName('ID_ORGANIZACAO').AsString;
      local.FDescricao     := qryObter.FieldByName('DESCRICAO').AsString;

    end;

  except
    raise Exception.Create('Erro ao obter local pagto por ID');

  end;

  Result := local;

end;

function TfrmFormaPagto.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterTodos :TFDQuery;
 cmd :string;
begin
  cmd := ' SELECT FP.ID_FORMA_PAGAMENTO, FP.DESCRICAO ' +
         ' FROM   FORMA_PAGAMENTO FP  ' +
         ' WHERE (FP.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
         ' ORDER BY FP.DESCRICAO ';


  dmConexao.conectarBanco;
  pIdOrganizacao := uUtil.TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione uma FP  >>>');

   qryObterTodos := TFDQuery.Create(Self);
   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmd);

   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObterTodos.Open;
    if not qryObterTodos.IsEmpty then
    begin
      qryObterTodos.First;

      while not qryObterTodos.Eof do
      begin
        combo.Items.Add(qryObterTodos.FieldByName('DESCRICAO').AsString);
        listaID.Add(qryObterTodos.FieldByName('ID_FORMA_PAGAMENTO').AsString);
        qryObterTodos.Next;
      end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

    end;

end;



procedure TfrmFormaPagto.limpaFrame;
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


function TfrmFormaPagto.getContaContabil(pForma :TFormaPagamentoModel) : TContaContabilModel;
  var
  sqlCC :string;
  qryObterContaContabil :TFDQuery;
  conta : TContaContabilModel;
begin
 dmConexao.conectarBanco;
  sqlCC :=  ' SELECT FP.ID_FORMA_PAGAMENTO, '+
            ' FP.ID_ORGANIZACAO, '+
            ' CC.ID_CONTA_CONTABIL,'+
            ' CC.DESCRICAO, '+
            ' CC.CONTA,  '+
            ' CC.DGVER,   '+
            ' CC.CODREDUZ,  '+
            ' CC.DGREDUZ   '+
            ' FROM FORMA_PAGAMENTO FP '+
            ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = FP.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = FP.ID_ORGANIZACAO) '+
            ' WHERE (FP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND   (FP.ID_FORMA_PAGAMENTO = :PID) ' ;


      try

        qryObterContaContabil := TFDQuery.Create(Self);
        qryObterContaContabil.Close;
        qryObterContaContabil.Connection := dmConexao.conn;
        qryObterContaContabil.SQL.Clear;
        qryObterContaContabil.SQL.Add(sqlCC);
        qryObterContaContabil.ParamByName('PIDORGANIZACAO').AsString := pForma.FIDorganizacao;
        qryObterContaContabil.ParamByName('PID').AsString := pForma.FID;
        //qryObterContaContabil.Open;

        conta                 := TContaContabilModel.Create;
        conta.FID             := pForma.FIDcontaContabil;
        conta.FIdOrganizacao  := pForma.FIDorganizacao;
        conta                 := TContaContabilDAO.obterPorID(conta);

       {
        if not qryObterContaContabil.IsEmpty then
        begin

          conta.FCodigoReduzido := (qryObterContaContabil.FieldByName('CODREDUZ').AsString);
          conta.FConta := (qryObterContaContabil.FieldByName('CONTA').AsString);
          conta.FDescricao := (qryObterContaContabil.FieldByName('DESCRICAO').AsString);
          conta.FDgReduz := (qryObterContaContabil.FieldByName('DGREDUZ').AsString);
          conta.FDgVer := (qryObterContaContabil.FieldByName('DGVER').AsString);
          conta.FID             := (qryObterContaContabil.FieldByName('ID_CONTA_CONTABIL').AsString);
          conta.FIdOrganizacao  := (qryObterContaContabil.FieldByName('ID_ORGANIZACAO').AsString);

        end;
          }
      except

        raise(Exception).Create('Problemas ao tentar consultar conta contábl');

      end;
 Result := conta;

end;


end.
