unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,Vcl.Dialogs,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,uUtil,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmPrincipal = class(TDataModule)
    Conn: TFDConnection;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    qryLoadOrgs: TFDQuery;
    DataSource11: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure loadParamentrosSGBD;
    function  conectarBanco: boolean;
    procedure inicializarConexao;
  public
    { Public declarations }
  database: string;
  host: string;
  porta: string;
  user: string;
  password: string;
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//responsavel por pegar os dados para conectar o banco de dados
//esses dados estao registrados pela tela de Backup


procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
  inicializarConexao;
end;

procedure TdmPrincipal.loadParamentrosSGBD;
 begin
    database := LerRegistro('Pempec Enterprise', 'Finance', 'PATH_BD');
    host     := LerRegistro('Pempec Enterprise', 'Finance', 'IPSERVERBD');
    porta    := LerRegistro('Pempec Enterprise', 'Finance', 'PORTABD');
    user     := 'SYSDBA';
    password := 'masterkey';
end;



function TdmPrincipal.conectarBanco: boolean;

begin
{Verificando se o banco esta conectado}
  if not(conn.Connected) then begin
       loadParamentrosSGBD;  //carrega os dados para conectar o banco de dados

    try

      if uUtil.PastaExist(LerRegistro('Pempec Enterprise', 'Finance', 'PATH_SERVER')) then begin
        if uUtil.ArquivoExist(database) then  begin
          Conn.Params.Clear;
          Conn.LoginPrompt := False;
          Conn.DriverName := 'FB';
          Conn.Params.Add('database=' + database);
          Conn.Params.Add('drivername=' + Conn.DriverName);
          Conn.Params.Add('hostname=' + host);
          Conn.Params.Add('user_name=' + user);
          Conn.Params.Add('password=' + password);
          Conn.Params.Add('port=' + porta);
          Conn.Params.Add('blobsize=-1');
          Conn.Params.Add('SQLDialect=3');
          Conn.Params.Add('CharacterSet = iso8859_1');
          Conn.Params.Add('PageSize=4096');
          Conn.Open;
        end;

        if not Conn.Ping then  begin
          raise Exception.Create('N�o foi poss�vel conectar ao banco de dados!');
        end;
      end  else  begin
        raise Exception.Create('O Caminho do banco de dados parece estar incorreto.');
      end;
    except
      raise Exception.Create('ERRO DE REGISTRO. REGISTRE OS SISTEMAS!');
    end;
  end;
    Result := conn.Connected;
end;

procedure TdmPrincipal.inicializarConexao;
begin
  if not (Conn.Connected) then begin
    try
      conectarBanco;
    except
      on e: Exception do
        ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
    end;
  end;
end;

end.
