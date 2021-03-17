unit uDMDeletaLoteContabil;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uUtil,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxBar,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls ;
type
  TdmDeletaLoteContabil = class(TDataModule)
    qryObterTodosLoteContabil: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure listaLoteContabil(var combo: TComboBox; var listaID: TStringList);
  public
    { Public declarations }
    procedure listaLoteContabilTDX(var combo: TdxBarCombo; var listaID: TStringList);


     function preencheComboLoteContabil(pIdOrganizacao, pAno: string): boolean;
  end;

var
  dmDeletaLoteContabil: TdmDeletaLoteContabil;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDeletaLoteContabil.DataModuleCreate(Sender: TObject);
begin
inicializarDM(Self);

end;

procedure TdmDeletaLoteContabil.freeAndNilDM(Sender: TObject);
begin
  //nada
end;

procedure TdmDeletaLoteContabil.inicializarDM(Sender: TObject);
begin

  dmConexao.conectarBanco;

end;

function TdmDeletaLoteContabil.preencheComboLoteContabil(pIdOrganizacao, pAno : string ) :boolean;
var
ano, cmd :string;
pDataInicial, pDataFinal, dataServer :TDateTime;

begin
  dataServer := uUtil.getDataServer;
  ano := pAno; // FormatDateTime('yyyy', dataServer );
  pDataInicial := StrToDateTime('01/01/'+ano);
   dataServer := StrToDateTime('31/12/'+ano);


  Result := false;
  cmd :=  ' SELECT  LC.ID_LOTE_CONTABIL, LC.LOTE '+
          ' FROM LOTE_CONTABIL LC ' +
          ' WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
          ' (LC.PERIODO_INICIAL BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) AND ' +
          ' (LC.STATUS <> ''REMOVIDO'' )' +
          ' ORDER BY LC.LOTE ' ;


  dmConexao.conectarBanco;

    try
        qryObterTodosLoteContabil.Close;
        qryObterTodosLoteContabil.Connection := dmConexao.Conn;
        qryObterTodosLoteContabil.SQL.Clear;
        qryObterTodosLoteContabil.SQL.Add(cmd);
        qryObterTodosLoteContabil.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryObterTodosLoteContabil.ParamByName('DTDATAINICIAL').AsDate := pDataInicial;
        qryObterTodosLoteContabil.ParamByName('DTDATAFINAL').AsDate := dataServer;
        qryObterTodosLoteContabil.Open;

      except
        raise(Exception).Create('Problemas ao OBTER LOTE CONTABIL');
      end;

    Result := not qryObterTodosLoteContabil.IsEmpty;

end;


procedure TdmDeletaLoteContabil.listaLoteContabilTDX(var combo: TdxBarCombo; var listaID: TStringList);
begin

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Items.Clear;
  combo.Items.Add('<<< LOTES   >>>');
 // preencheComboLoteContabil(uUtil.TOrgAtual.getId, '');
  qryObterTodosLoteContabil.First;
  while not qryObterTodosLoteContabil.Eof do
  begin
    combo.Items.Add(qryObterTodosLoteContabil.FieldByName('LOTE').AsString);
    listaID.Add(qryObterTodosLoteContabil.FieldByName('ID_LOTE_CONTABIL').AsString);
    qryObterTodosLoteContabil.Next;
  end;

  combo.ItemIndex := 0;

end;



procedure TdmDeletaLoteContabil.listaLoteContabil(var combo: TComboBox; var listaID: TStringList);
begin

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< LOTES   >>>');
 // preencheComboLoteContabil(uUtil.TOrgAtual.getId, '');
  qryObterTodosLoteContabil.First;
  while not qryObterTodosLoteContabil.Eof do
  begin
    combo.Items.Add(qryObterTodosLoteContabil.FieldByName('LOTE').AsString);
    listaID.Add(qryObterTodosLoteContabil.FieldByName('ID_LOTE_CONTABIL').AsString);
    qryObterTodosLoteContabil.Next;
  end;

  combo.ItemIndex := 0;

end;


end.
