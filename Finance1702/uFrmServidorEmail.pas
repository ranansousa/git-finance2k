unit uFrmServidorEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,udmConexao, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Controls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Forms, Vcl.Dialogs, uVarGlobais,StrUtils , uUtil,
  uDMServerMail;
type
  TfrmServidorEmail = class(TForm)
    lblPrincipal: TLabel;
    btnSalvar: TBitBtn;
    edtHost: TEdit;
    edtConta: TEdit;
    edtPorta: TEdit;
    edtSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chAutentica: TCheckBox;
    lblDados: TLabel;
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    lbl1: TLabel;
    lbl2: TLabel;
    lblPID: TLabel;
    btnFechar: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);

  public
    { Public declarations }
  end;

var
  frmServidorEmail: TfrmServidorEmail;

implementation

{$R *.dfm}

{ tabela    
  
CREATE TABLE SERVIDOR_EMAIL (
    ID_SERVIDOR_EMAIL    NUMERIC(5,0) NOT NULL,
    HOST                 VARCHAR(50) NOT NULL,
    REQUER_AUTENTICACAO  INTEGER,
    REMETENTE            VARCHAR(50) NOT NULL,
    LOGIN                VARCHAR(50),
    SENHA                VARCHAR(50),
    ID_ORGANIZACAO       VARCHAR(36),
    PORTA                VARCHAR(4)
);


}

procedure TfrmServidorEmail.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmServidorEmail.btnSalvarClick(Sender: TObject);
var
id,conta, senha, host, porta, autentica :string;

begin 

      conta     := edtConta.Text;
      senha     := edtSenha.Text;
      host      := edtHost.Text;
      porta     := edtPorta.Text;
      autentica := IfThen(chAutentica.Checked, '1', '0');
      
      id := lblPID.Caption;
                

       if (id =  String.Empty) then begin
       //manda salvar
          try          
            if (dmServerMail.salvarServerMail('',TOrgAtual.getId,conta,senha, host,porta, autentica )) then begin  
            
                if dmServerMail.obterDadosServidorEmail(TOrgAtual.getId) then  begin          
                     lblPID.Caption := dmServerMail.qryObterDadosMail.FieldByName('ID_SERVIDOR_EMAIL').AsString;
                end;
                
            end;                             

           Except 
            on e: Exception do
            MessageDlg( 'Não foi possível salvar os dados do email ' , mtWarning, [mbOK], 0);
          end;
       end else begin
       
         //alterar os dados no banco de dados
          try
           dmServerMail.salvarServerMail(id,TOrgAtual.getId,conta,senha, host,porta, autentica );

               if dmServerMail.obterDadosServidorEmail(TOrgAtual.getId) then  begin          
                     lblPID.Caption := dmServerMail.qryObterDadosMail.FieldByName('ID_SERVIDOR_EMAIL').AsString;
                end;
           
            Except 
            on e: Exception do
            MessageDlg( 'Não foi possível alterar os dados do email ' , mtWarning, [mbOK], 0);
          end;
         
       
       end;
       
   // inicializa as variaveis do host do email a ser enviado.
    uVarGlobais.IniHostEmail(conta, senha, host, porta, autentica);
         
  ShowMessage('Dados gravados com sucesso.');


end;

procedure TfrmServidorEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  freeAndNilDM(Self);
  Action := caFree; // sempre como ultimo comando

end;

procedure TfrmServidorEmail.FormCreate(Sender: TObject);
var
  aut, porta: String;
  autentica: Boolean;
begin
  // LimpaTela(Self);
  lblPID.Visible :=False;

  lblDados.Caption := 'Banco de Dados Não Conectado.';
  if not(Assigned(dmServerMail)) then
  begin
    dmServerMail := TdmServerMail.Create(Self);
  end;

  if dmServerMail.verificaConectarBanco then
  begin
    dmServerMail.obterDadosServidorEmail(TOrgAtual.getId);

    lblDados.Caption := 'Banco de Dados conectado.';
    porta :=dmServerMail.qryObterDadosMail.FieldByName('PORTA').AsString;
    aut   :=IntToStr(dmServerMail.qryObterDadosMail.FieldByName('REQUER_AUTENTICACAO').AsInteger); 
   //    porta := '587';
    
    edtHost.Text := dmServerMail.qryObterDadosMail.FieldByName('HOST').AsString;
    edtConta.Text := dmServerMail.qryObterDadosMail.FieldByName('LOGIN').AsString;
    edtSenha.Text := dmServerMail.qryObterDadosMail.FieldByName
      ('SENHA').AsString;

      edtPorta.Text := dmServerMail.qryObterDadosMail.FieldByName
      ('PORTA').AsString;      
        
    if not(aut = '') then
    begin
      aut := '1';
      chAutentica.Checked := True;;
    end;

    lblPID.Caption :='';    
    lblPID.Caption := dmServerMail.qryObterDadosMail.FieldByName('ID_SERVIDOR_EMAIL').AsString;  

  end;

end;

procedure TfrmServidorEmail.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmServerMail)) then
  begin
    dmServerMail := TdmServerMail.Create(Self);
  end;

end;


procedure TfrmServidorEmail.freeAndNilDM(Sender: TObject);
begin

  if (Assigned(dmServerMail)) then
  begin
    FreeAndNil(dmServerMail);
  end;

end;

end.
