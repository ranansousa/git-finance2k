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




// Essa fun��o pode ser colocada em uma unit separada. Assim em qualquer formul�rio do programa � poss�vel chamar a fun��o e verificar se tem algum edit vazio no formul�rio passado no par�metro

function Consistencia(Formulario: TForm): Boolean;
  var
    i : Integer;
    Resposta: Boolean;
    Componente: TEdit;
  begin
    // Inicializa a resposta
    Resposta := False;
    // Executa uma repeti��o em todos os componentes
    for i := 0 to formulario.ComponentCount -1 do
    begin
      // Verifica se o componente � um editBox
      if formulario.Components[i] is TEdit then
      begin
        // Grava o componente em uma vari�vel
        Componente := formulario.Components[i] as TEdit;
        // Verifica se o valor est� vazio
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
