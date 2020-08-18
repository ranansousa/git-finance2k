unit uFrmTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uDMOrganizacao,udmConexao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Organizacao,uUtil;

type
  TfrmTeste = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    idOrganizacao : String;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }

  end;

var
  frmTeste: TfrmTeste;

implementation

{$R *.dfm}


procedure TfrmTeste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
freeAndNilDM(Self);
Action := caFree;
end;

procedure TfrmTeste.FormCreate(Sender: TObject);
begin
idOrganizacao := uUtil.TOrgAtual.getId;
inicializarDM(Self);
dmConexao.conectarBanco;

 try

   if  TOrgAtual.getId = '' then begin
        MessageDlg('Organização não foi encontrada...',mtWarning,[mbOK],0);
   end else begin
         if dmConexao.Conn.Connected then begin
            dmOrganizacao.carregarDadosOrganizacaoFNC(idOrganizacao);
            DBGrid1.DataSource := dmOrganizacao.dtsOrganizacao;
         end;


   end;
 except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ')
 end;
end;


procedure TfrmTeste.inicializarDM(Sender: TObject);
  begin

      if not(Assigned(dmConexao)) then begin
             dmConexao := TdmConexao.Create(Self);
             dmConexao.conectarBanco;
             dmConexao.conectarMega;
      end;

      if not(Assigned(dmOrganizacao)) then begin
             dmOrganizacao := TdmOrganizacao.Create(Self);
      end;

end;


procedure TfrmTeste.freeAndNilDM(Sender: TObject);
begin
//nada
end;


end.
