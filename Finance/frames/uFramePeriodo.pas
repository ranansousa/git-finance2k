unit uFramePeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,DateUtils , Uutil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmPeriodo = class(TFrame)
    dtpDataInicial: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    lbl1: TLabel;
    lbl2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }

    function getDataInicial() :TDateTime;
    function getDataFinal  () :TDateTime;
    function validarPeriodo(): Boolean;
    function qtdDiasPeriodo(): Integer;
    procedure inicializa(pDtInicio, pDtFim :TDateTime);  //quando chamar o frame, passar duas datas. caso nao passem, ser� a data do servidor no dia




  end;

implementation

{$R *.dfm}

{ TfrmPeriodo }

function TfrmPeriodo.getDataFinal(): TDateTime;
begin

 Result := StrToDate(FormatDateTime('dd"/"mm"/"yyyy',dtpDataFinal.DateTime) );

end;

function TfrmPeriodo.getDataInicial(): TDateTime;
begin
   Result := StrToDate(FormatDateTime('dd"/"mm"/"yyyy',dtpDataInicial.DateTime) );
end;


procedure TfrmPeriodo.inicializa(pDtInicio, pDtFim: TDateTime);
begin
      dtpDataInicial.DateTime := pDtInicio;
      dtpDataFinal.DateTime := pDtFim;

end;

function TfrmPeriodo.qtdDiasPeriodo(): Integer;
begin
   Result := daysbetween(dtpDataInicial.DateTime, dtpDataFinal.DateTime);
end;

function TfrmPeriodo.validarPeriodo(): Boolean;
var
validador :Boolean;
begin
   validador :=True;
  if(dtpDataInicial.DateTime > dtpDataFinal.DateTime) then begin
     validador := False;
   end;

  Result :=validador;

end;

end.