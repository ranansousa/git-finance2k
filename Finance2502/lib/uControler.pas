unit uControler;

interface

implementation
uses
Vcl.Forms, Vcl.Dialogs, uFrmPrincipal, IdBaseComponent, IdComponent, IdIPWatch;




function getIp(): String;
var
r : TIdIPWatch;
begin

 r := TIdIPWatch.Create(nil);
 Result := r.LocalIP;
 r.free;

 end;




// Essa função pode ser colocada em uma unit separada. Assim em qualquer formulário do programa é possível chamar a função e verificar se tem algum edit vazio no formulário passado no parâmetro

function Consistencia(Formulario: TForm): Boolean;
  var
    i : Integer;
    Resposta: Boolean;
    Componente: TEdit;
  begin
    // Inicializa a resposta
    Resposta := False;
    // Executa uma repetição em todos os componentes
    for i := 0 to formulario.ComponentCount -1 do
    begin
      // Verifica se o componente é um editBox
      if formulario.Components[i] is TEdit then
      begin
        // Grava o componente em uma variável
        Componente := formulario.Components[i] as TEdit;
        // Verifica se o valor está vazio
        if Componente.Text = '' then
        begin
          Resposta := True;
          break;
        end; // Fim do if
      end; // Fim do if
    end; // Fim do for
    Result := Resposta;
  end;


end.
