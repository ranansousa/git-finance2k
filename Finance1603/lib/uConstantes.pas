unit uConstantes;

interface
 uses IdHashMessageDigest, Classes, SysUtils;

function getSenhaPadrao(): String;
function getTipoHistoricoNaoProvisiona(): String;

implementation


function getSenhaPadrao(): String;
begin
 //deixar temporaria assim
 //mas poderia colocar no arquivo config.ini

  Result := 'XPTO1234';
end;



function getTipoHistoricoNaoProvisiona(): String;
begin

  Result := 'N';
end;







end.
