unit UMostraErros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, uVarGlobais;

type
  TFMostraErros = class(TForm)
    StatusBar1: TStatusBar;
    BtnImprimir: TBitBtn;
    BtnFechar: TBitBtn;
//  RDprint1: TRDprint;
    RichEditErros: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);//
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FiLin: Integer;
    FsTitulo: string;
  public
    { Public declarations }
    function Add(const S: String;
      pbAdicionaLinhaBranco: Boolean = false;
      pbPermiteDuplicidade: Boolean = false): Integer;
    procedure Append(const S: String;
      pbAdicionaLinhaBranco: Boolean = false;
      pbPermiteDuplicidade: Boolean = false);
    procedure Insert(Index: Integer; Const S: String;
      pbAdicionaLinhaBranco: Boolean = false;
      pbPermiteDuplicidade: Boolean = false);
    procedure Clear;
    function Count: Integer;

    property MostraErros: TRichEdit read RichEditErros;
    property Titulo: string write FsTitulo;
  end;

var
  FMostraErros: TFMostraErros;

implementation

{$R *.DFM}

{O vetor aErros, declarado na unit uVarGlobais, foi mantido
 por questão de compatibilidade com a forma utilizada no
 MegaContabil.}

procedure TFMostraErros.FormCreate(Sender: TObject);
begin
  RichEditErros.ReadOnly := True;
  RichEditErros.Lines.Clear;
  BtnImprimir.Visible := False;//em 22/07 - Ranan. Aguardando criar funcao.
end;

procedure TFMostraErros.BtnFecharClick(Sender: TObject);
begin

  Close;
end;



procedure TFMostraErros.BtnImprimirClick(Sender: TObject);
var
  iFor : integer;
begin
//  BtnImprimir.Enabled := false;
//  RdPrint1.OpcoesPreview.Preview := true;
//  FiLin := 0;
//  RdPrint1.abrir;
//  if RdPrint1.setup then begin
//    for iFor := 0 to RichEditErros.Lines.Count-1 do begin
//      RdPrint1.impf(FiLin,01,RichEditErros.Lines[iFor],[Comp12]);
//      inc(FiLin);
//      if FiLin >= 57 then begin
//        RdPrint1.Novapagina;
//      end;
//    end;
//    RdPrint1.Fechar;
//  end;
//  BtnImprimir.Enabled := true;
end;

procedure TFMostraErros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//SetLength(aErros,0);
end;

function TFMostraErros.Add(const S: String;
  pbAdicionaLinhaBranco: Boolean = False;
  pbPermiteDuplicidade: Boolean = false): Integer;
begin
  if (Trim(S) = '') or (pbPermiteDuplicidade) or (RichEditErros.FindText(S,0,Length(RichEditErros.Text),[stWholeWord]) < 0) then begin
    Result := RichEditErros.Lines.Add(S);
    if pbAdicionaLinhaBranco then begin
      RichEditErros.Lines.Add(' ');
    end;
  end;
end;

procedure TFMostraErros.Insert(Index: Integer; const S: String;
  pbAdicionaLinhaBranco: Boolean = false;
  pbPermiteDuplicidade: Boolean = false);
begin
  if (Trim(S) = '') or (pbPermiteDuplicidade) or (RichEditErros.FindText(S,0,Length(RichEditErros.Text),[stWholeWord]) < 0) then begin
    RichEditErros.Lines.Insert(Index,S);
    if pbAdicionaLinhaBranco then begin
      RichEditErros.Lines.Insert(Index+1,' ');
    end;
  end;
end;

procedure TFMostraErros.Append(const S: String;
  pbAdicionaLinhaBranco: Boolean = false;
  pbPermiteDuplicidade: Boolean = false);
begin
  if (Trim(S) = '') or (pbPermiteDuplicidade) or (RichEditErros.FindText(S,0,Length(RichEditErros.Text),[stWholeWord]) < 0) then begin
    RichEditErros.Lines.Append(S);
    if pbAdicionaLinhaBranco then begin
      RichEditErros.Lines.Append(' ');
    end;
  end;
end;

procedure TFMostraErros.Clear;
begin
  RichEditErros.Lines.Clear;
//SetLength(aErros,0);
end;

function TFMostraErros.Count: Integer;
var
  liFor: Integer;
begin
//  for liFor := 0 to length(aErros)-1 do begin
//    RichEditErros.Lines.Append(aErros[liFor]);
//  end;
//  SetLength(aErros,0);
  Result := RichEditErros.Lines.Count;
end;

procedure TFMostraErros.FormShow(Sender: TObject);
var
  liFor: Integer;
begin
//  for liFor := 0 to length(aErros)-1 do begin
//    RichEditErros.Lines.Append(aErros[liFor]);
//  end;
//  SetLength(aErros,0);
end;

end.
