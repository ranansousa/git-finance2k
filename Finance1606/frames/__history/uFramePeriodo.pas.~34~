unit uFramePeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,DateUtils , Uutil, StrUtils,
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
    function getAno(pData :TDateTime ) :Integer;
    function getMes(pData :TDateTime ) :Integer;
    function getDia(pData :TDateTime ) :Integer;
    function getMesExtenso(pMes :Integer) :string;
    function getDiaExtenso(pDia :Integer) :string;
    function converteDataToStr(pData :TDateTime) :string;
    function compareDatas(nData,pData :TDateTime): ShortInt; // -1 = nData < pData ou  0 = datas iguais ou 1 = nData > pData





    procedure inicializa(pDtInicio, pDtFim :TDateTime);  //quando chamar o frame, passar duas datas. caso nao passem, será a data do servidor no dia




  end;

implementation

{$R *.dfm}

{ TfrmPeriodo }

function TfrmPeriodo.compareDatas(nData, pData: TDateTime): ShortInt;
begin

 Result := CompareDate(nData, pData) ;

end;

function TfrmPeriodo.converteDataToStr(pData: TDateTime): string;
begin
 Result :=  FormatDateTime('DD/MM/YYYY', pData);
end;

function TfrmPeriodo.getAno(pData: TDateTime): Integer;
begin

Result := (YearOf(pData));

end;

function TfrmPeriodo.getDataFinal(): TDateTime;
begin

 Result := StrToDate(FormatDateTime('dd"/"mm"/"yyyy',dtpDataFinal.DateTime) );

end;

function TfrmPeriodo.getDataInicial(): TDateTime;
begin
   Result := StrToDate(FormatDateTime('dd"/"mm"/"yyyy',dtpDataInicial.DateTime) );
end;


function TfrmPeriodo.getDia(pData: TDateTime): Integer;
begin
   Result := (DayOf(pData));
end;

function TfrmPeriodo.getDiaExtenso(pDia: Integer): string;
// recebe o valor do mes e retorna o nome do mes por extenso
  const
  diaSemana: Array[0..6] of String = (
            'Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira',
            'Sexta-Feira', 'Sábado', 'Domingo');
begin

 Result := '';
  if (pDia > 1) and (pDia < 7) then
    Result := diaSemana[pDia-1];
end;


function TfrmPeriodo.getMes(pData: TDateTime): Integer;
begin
 Result := (MonthOf(pData));
end;

function TfrmPeriodo.getMesExtenso(pMes: Integer): string;
 // recebe o valor do mes e retorna o nome do mes por extenso
  const
  aMeses: Array[0..11] of String = (
            'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
            'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
begin

 Result := '';
  if (pMes > 1) and (pMes < 12) then
    Result := aMeses[pMes-1];
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
