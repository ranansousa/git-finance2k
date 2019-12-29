unit uMD5;

interface
  uses IdHashMessageDigest, Classes, SysUtils;

function MD5String(const Value: string): string;
function MD5Arquivo(const Value: string): string;


implementation

{Função : MD5String(Const Value : String): String;

Objetivo : Esta função serve para retornarmos Hash de um String em Hexadecimal

Dicas de Uso :
Criptografar uma senha e salvar a mesma no banco
Validação de usuário com MD5 são seguras e precisas
Criptografar determinados dados ao serem enviados ao Banco
Criptografar todos os dados de uma determinada tabela

Modo de Usar : ShowMessage(MD5String(EdtSenha.Text)); }


function MD5String(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  try
    Result := xMD5.HashStringAsHex(Value);
  finally
    xMD5.Free;
  end;
end;

{Função : MD5Arquivo(Const Value : String): String;

Objetivo : Esta função serve para retornarmos Hash de um Arquivo em Hexadecimal

Dicas de Uso :
Comparar o tamanho de dois arquivos
Verificar se eles têm a mesma estrutura

Modo de Usar : ShowMessage(MD5String(‘C:\Program Files\Embarcadero\RAD Studio\7.0\bin\_refactoring.log’)); }


function MD5Arquivo(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
  xArquivo: TFileStream;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  xArquivo := TFileStream.Create(Value, fmOpenRead OR fmShareDenyWrite);
  try
    Result := xMD5.HashStreamAsHex(xArquivo);
  finally
    xArquivo.Free;
    xMD5.Free;
  end;
end;

end.
