unit uCriptografia;

interface

function Criptografa(texto: string; chave: integer): String;
function DesCriptografa(texto: string; chave: integer): String;
function AsciiToInt(Caracter: Char): integer;

implementation

uses
  System.SysUtils;

// funcao que retorno o código ASCII dos caracteres
function AsciiToInt(Caracter: Char): integer;
var
  i: integer;
begin
  i := 32;
  while i < 255 do
  begin
    if Chr(i) = Caracter then
      Break;
    i := i + 1;
  end;
  Result := i;
end;

{ Esta funcao tem como objetivo criptografar uma string utilizando o código ASCII de cada caracter e
  somando a esse código o valor da CHAVE }

Function Criptografa(texto: string; chave: integer): String;
var
  cont: integer;
  retorno: string;
begin

  if chave < 32 then
    chave := 64;

  if (trim(texto) = EmptyStr) or (chave = 0) then
  begin
    Result := texto;
  end
  else
  begin
    retorno := '';
    for cont := 1 to length(texto) do
    begin
      retorno := retorno + Chr(AsciiToInt(texto[cont]) + chave);
    end;
    Result := retorno;
  end;
end;

{ Esta funcao é semelhante a funcao de Criptografia mais com o objetivo de descriptografar a string }

Function DesCriptografa(texto: string; chave: integer): String;
var
  cont: integer;
  retorno: string;
begin
  if chave < 32 then
    chave := 64;

  if (trim(texto) = EmptyStr) or (chave = 0) then
  begin
    Result := texto;
  end
  else
  begin
    retorno := '';
    for cont := 1 to length(texto) do
    begin
      retorno := retorno + Chr(AsciiToInt(texto[cont]) - chave);
    end;
    Result := retorno;
  end;
end;

end.
