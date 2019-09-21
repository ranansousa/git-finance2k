unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  Vcl.Dialogs, IniFiles,uFrmRegistraBaseDados,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, uUtil,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    Conn: TFDConnection;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    ConnMega: TFDConnection;
    qryEstacoesConectadas: TFDQuery;
    qryObterGUID: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    database: string;
    databaseMega: string;
    pathMega: string;
    host: string;
    porta: string;
    user: string;
    password: string;
    function conectarBanco: boolean;
    function conectarMega: boolean;
    function obterHostONLINE: boolean;
    function obterNewID():string; // retorna o id novo do banco




  end;

var
  dmConexao: TdmConexao;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmConexao.conectarBanco: boolean;
var  Arquivo: TIniFile { uses IniFiles };
databaseFinance:String;
begin
//      teste := uUtil.GetPathConfigIni;
  if not(Conn.Connected) then
   begin

    Result := False;

    Arquivo := TIniFile.Create(uUtil.GetPathConfigIni);


    if not uUtil.ArquivoExist(Arquivo.FileName) then
    begin
          raise Exception.Create('N�o foi poss�vel conectar ao banco de dados!');
    end ;

databaseFinance :=  Arquivo.ReadString('DADOSFINANCE','DATABASE', '');
uUtil.TOrgAtual.setPathSGBD(databaseFinance);
      try
            begin
              Conn.Params.Clear;
              Conn.LoginPrompt := false;
              Conn.DriverName := 'FB';
              Conn.Params.Add('database=' + databaseFinance);
              // Conn.Params.Add('drivername=' + Conn.DriverName);
             // Conn.Params.Add('hostname=' + '192.168.25.101');

              Conn.Params.Add('user_name=' + 'SYSDBA');
              Conn.Params.Add('password=' + 'masterkey');
              //Conn.Params.Add('port=' + '3050');
              Conn.Params.Add('blobsize=-1');
              Conn.Params.Add('SQLDialect=3');
              Conn.Params.Add('CharacterSet = iso8859_1');
              Conn.Params.Add('PageSize=4096');
              Conn.ConnectionString;
              Conn.Open;
            end;

    except
      raise Exception.Create('N�o foi poss�vel conectar ao banco de dados!  ' + databaseFinance);
     // Exception.Create('O Caminho do banco de dados parece estar incorreto.');

    end;
 end;

  Arquivo.Free;
  Result := Conn.Connected;
end;

function TdmConexao.conectarMega: boolean;
 var
 Arquivo: TIniFile ;
 databaseMega:String;
begin
Arquivo := TIniFile.Create(uUtil.GetPathConfigIni);
databaseMega :=  Arquivo.ReadString('DADOSMEGA','DATABASE', '');

  if not(ConnMega.Connected) then
   begin

    try
      begin
        ConnMega.Params.Clear;
        ConnMega.LoginPrompt := false;
        ConnMega.DriverName := 'FB';
        ConnMega.Params.Add('database=' + databaseMega);
        //ConnMega.Params.Add('drivername=' + ConnMega.DriverName);
        //ConnMega.Params.Add('hostname=' + host);
        //ConnMega.Params.Add('port=' + '3050');
        ConnMega.Params.Add('user_name=' + 'SYSDBA');
        ConnMega.Params.Add('password=' + 'masterkey');//
        ConnMega.Params.Add('blobsize=-1');
        ConnMega.Params.Add('SQLDialect=3');
        ConnMega.Params.Add('CharacterSet = iso8859_1');
        ConnMega.Params.Add('PageSize=4096');
        ConnMega.Open;
      end;
      if not ConnMega.Ping then
      begin

        raise Exception.Create('N�o foi poss�vel conectar ao Sistema Cont�bil! '   + databaseMega);
      end;
    except
      raise Exception.Create('Erro ao tentar acessar a base do Sistema Cont�bil !');
    end;
  end;// chamar o registra base de dados aqui



   Arquivo.Free;
  Result := ConnMega.Connected;
end;


function TdmConexao.obterHostONLINE: boolean;
begin
 //verifica as estacoes que estao ativas no momento

  if not qryEstacoesConectadas.Connection.Connected then
  begin
    qryEstacoesConectadas.Connection := dmConexao.Conn;
  end;

  qryEstacoesConectadas.Close;
  qryEstacoesConectadas.Open;


  Result := not qryEstacoesConectadas.IsEmpty;

end;




function TdmConexao.obterNewID: string;
var id:string;
begin
//fornece um novo id.
//o banco precisa ter instalado a UDF createguid
   id := '0';
Result := id;

 if not qryObterGUID.Connection.Connected then
  begin
    qryObterGUID.Connection := dmConexao.Conn;
  end;

  qryObterGUID.Close;
  qryObterGUID.Open;


if  not qryObterGUID.IsEmpty then begin id := qryObterGUID.FieldByName('NEWID').AsString;
 qryObterGUID.Free;
 end;

 Result := id;



end;

end.
