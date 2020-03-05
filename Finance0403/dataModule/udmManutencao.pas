unit udmManutencao;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmManutencao = class(TDataModule)
    qryAllTables: TFDQuery;
    qry1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
     procedure inicializarDM(Sender: TObject);



  public
    { Public declarations }

  end;

var
  dmManutencao: TdmManutencao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmManutencao.DataModuleCreate(Sender: TObject);
begin

inicializarDM(self);
//obterTables;
//listaTables;

end;

procedure TdmManutencao.inicializarDM(Sender: TObject);
begin
if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;


end;





end.
