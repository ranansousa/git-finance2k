unit uCadastroValeTransporteGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadastro, EMsgDlg, ComCtrls, StdCtrls, Buttons, ToolWin, IBase,
  ExtCtrls, uValeTransporteGeral, ENumEd, Mask, LibMega, Util, EDateEd,
  uMostraErros, SqlExpr, Constants,
//  {$IFDEF VER150}
//    ToolEdit,
//  {$ELSE}
//    RxToolEdit,
//  {$ENDIF}
  UPConsts,  UCBase, udmConexao, FireDAC.Comp.Client;

type
  TFCadastroValeTransporteGeral = class(T_frmCadastro)
    Label1: TLabel;
    edtData: TEvDateEdit;
    Label2: TLabel;
    edtValor: TEvNumEdit;
    UCControls1: TUCControls;
    procedure edtDataExit(Sender: TObject);
    procedure _btnIncluirClick(Sender: TObject);
    procedure _btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FoProvider: TValeTransporteGeralProvider;
    FoValeTransporteGeral: ITable;
    FOldData: TDate;
  protected
    function doInsert(): boolean; override;
    function doUpdate(): boolean; override;
    function doDelete(): boolean; override;
    function doCancel(): boolean; override;
    function doSave(): boolean; override;
    function doLocate(): boolean; override;
    function doLoadData(): boolean; override;
    function isValid(): boolean; override;
    procedure doSetRegistro(); override;
  public
    { Public declarations }
    procedure doInicializa;
  end;

var
  FCadastroValeTransporteGeral: TFCadastroValeTransporteGeral;

implementation

{$R *.dfm}

procedure TFCadastroValeTransporteGeral.edtDataExit(Sender: TObject);
begin
  inherited;
//  ValidaData(TEvDateEdit(Sender));
end;

procedure TFCadastroValeTransporteGeral._btnIncluirClick(Sender: TObject);
begin
  inherited;
  if edtData.CanFocus then begin
    edtData.SetFocus;
  end;
end;

procedure TFCadastroValeTransporteGeral._btnAlterarClick(Sender: TObject);
begin
  inherited;
  if edtData.CanFocus then begin
    edtData.SetFocus;
  end;
end;

function TFCadastroValeTransporteGeral.doCancel: boolean;
begin
  result := true;
end;

function TFCadastroValeTransporteGeral.doDelete: boolean;
begin
  result := FoProvider.Delete;
end;

procedure TFCadastroValeTransporteGeral.doInicializa;
begin
  FoValeTransporteGeral := TValeTransporteGeral.Create(Conn);

  FoProvider := TValeTransporteGeralProvider.Create;
  FoProvider.Conn := Conn;
  FoProvider.Table := FoValeTransporteGeral;
end;

function TFCadastroValeTransporteGeral.doInsert: boolean;
begin
  result := true;
end;

function TFCadastroValeTransporteGeral.doLoadData: boolean;
begin
  FOldData           := FoValeTransporteGeral.FieldByName('DATA' ).AsDate;
  edtData .DateValue := FOldData;
  edtValor.Value     := FoValeTransporteGeral.FieldByName('VALOR').AsCurrency;
end;

function TFCadastroValeTransporteGeral.doLocate: boolean;
var
  loTemp: ITable;
begin
  loTemp := FoValeTransporteGeral.ShowModal;
  result := Assigned(loTemp);

  if result then
    FoValeTransporteGeral.Assign(loTemp);
end;

function TFCadastroValeTransporteGeral.doSave: boolean;
begin
  result := inherited doSave;
  if result then begin
    if Operacao = opInserir then begin
      result := FoProvider.Insert;
     end else begin
      result := FoProvider.Update;
    end;
  end;
end;

procedure TFCadastroValeTransporteGeral.doSetRegistro;
begin
  inherited;
  if Operacao = opInserir then begin
    FoValeTransporteGeral.FieldByName('ID_PVALE_TRANSPORTE_GERAL').AsString := FoValeTransporteGeral.Gerador;
  end;
  FoValeTransporteGeral.FieldByName('FK_TABELA_GERAL').AsString := TUtil.getIDGrupoTabelasGerais(edtData.DateValue);
  FoValeTransporteGeral.FieldByName('DATA'           ).AsDate     := edtData .DateValue;
  FoValeTransporteGeral.FieldByName('VALOR'          ).AsCurrency := edtValor.Value;
end;

function TFCadastroValeTransporteGeral.doUpdate: boolean;
begin
  result := true;
end;

function TFCadastroValeTransporteGeral.isValid: boolean;
var
  FMostraErros : TFMostraErros;
  loQryVerifica: TFDQuery;
begin
  loQryVerifica := TFDQuery.Create(nil);
  FMostraErros := TFMostraErros.Create(self);
  try
    loQryVerifica.Connection := Conn;
    if edtData.DateEmpty then begin
      FMostraErros.Add('-Informe a data de entrada em vígor do vale transporte.');
    end;
    if (edtValor.Value < 0) then begin
      FMostraErros.Add('-Informe um valor maior ou igual a zero.');
    end;
    loQryVerifica.Close;
    loQryVerifica.SQL.Clear;
    loQryVerifica.SQL.Add('SELECT FIRST 1 ID_PVALE_TRANSPORTE_GERAL FROM PVALE_TRANSPORTE_GERAL WHERE (ID_PVALE_TRANSPORTE_GERAL <> :pIdValeTransporteGeral) AND (DATA = :pData)');
    loQryVerifica.ParamByName('pIdValeTransporteGeral').AsString := FoValeTransporteGeral.FieldByName('ID_PVALE_TRANSPORTE_GERAL').AsString;
    loQryVerifica.ParamByName('pData'                 ).AsDate   := edtData.DateValue;
    loQryVerifica.Open;
    if (not loQryVerifica.IsEmpty) then begin
      FMostraErros.Add('-Já existe registro cadastrado para essa data.');
    end;

    if FMostraErros.Count > 0 then begin
      FMostraErros.ShowModal;
      // retorna o valor da função
      result := false;
    end else begin
      // retorna o valor da função
      result := true;
    end;
  finally
    FreeAndNil(loQryVerifica);
    FreeAndNil(FMostraErros);
  end;
end;

procedure TFCadastroValeTransporteGeral.FormCreate(Sender: TObject);
begin
  FoUCControls := UCControls1;
  inherited;
  FOldData := TP_DATA_EMPTY;
end;

end.
