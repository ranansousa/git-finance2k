unit uFrmMostraProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uFrameProgressBar;

type
  TfrmMostraProcesso = class(TForm)
    framePB1: TframePB;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   FFvento :string;
  FFMax, FFPosicao :Integer;

  public
    { Public declarations }
    constructor Create (AOwner :TComponent; pEvento :string; pMax, pPosicao :Integer);
    procedure avancaPB(pPosicao :Integer);
  end;

var
  frmMostraProcesso: TfrmMostraProcesso;

implementation

{$R *.dfm}

procedure TfrmMostraProcesso.avancaPB(pPosicao: Integer);
begin
  framePB1.progressBar(pPosicao,FFMax);
  Application.ProcessMessages;

end;

constructor TfrmMostraProcesso.Create(AOwner: TComponent; pEvento: string; pMax,
  pPosicao: Integer);
begin
 inherited Create(AOwner);
  FFvento :=pEvento;
  FFMax := pMax;
  FFPosicao :=  pPosicao;
  framePB1.Visible :=True;
  framePB1.progressBar(FFPosicao,FFMax);

end;

procedure TfrmMostraProcesso.FormCreate(Sender: TObject);
begin
//lblProcesso.Caption := 'Solicitação sendo processada.... Aguarde!';

Self.Caption := FFvento;

end;

end.
