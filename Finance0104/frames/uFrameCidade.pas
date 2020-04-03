unit uFrameCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameGeneric, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,udmConexao;

type
  TfrmCidade = class(TframeGeneric)
    qryObterEstado: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
   function obterPorEstado(pIdEstado:string; var combo: TComboBox;  var listaID: TStringList): boolean ;
   procedure limpaFrame;

  end;

var
  frmCidade: TfrmCidade;

implementation

{$R *.dfm}

{ TfrmCidade }

procedure TfrmCidade.limpaFrame;
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




function TfrmCidade.obterPorEstado(pIdEstado:string; var combo: TComboBox;  var listaID: TStringList): boolean;
var cmd :String;
begin
dmConexao.conectarBanco;

  cmd := ' SELECT C.ID_CIDADE, C.CIDADE  FROM CIDADE C  WHERE (C.ID_ESTADO = :PIDESTADO) ORDER BY C.CIDADE' ;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');

    qryObterEstado.Close;
    qryObterEstado.Connection := dmConexao.Conn;
    qryObterEstado.SQL.Clear;
    qryObterEstado.SQL.Add(cmd);
    qryObterEstado.ParamByName('PIDESTADO').AsString := pIdEstado;
    qryObterEstado.Open;


   qryObterEstado.First;

  while not qryObterEstado.Eof do
  begin
    combo.Items.Add(qryObterEstado.FieldByName('CIDADE').AsString);
    listaID.Add(qryObterEstado.FieldByName('ID_CIDADE').AsString)  ;
    qryObterEstado.Next;
  end;
  qryObterEstado.Close;
  combo.ItemIndex := 0;

    //

end;

end.
