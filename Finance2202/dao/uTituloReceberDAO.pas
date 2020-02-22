unit uTituloReceberDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uMD5,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uTituloReceberModel;

  const
   pTable : string = 'TITULO_RECEBER';

type
 TTituloReceberDAO = class
  private
    class function getModel (query :TFDQuery) : TTituloReceberModel;
  public
    {métodos CRUD (Create, Read, Update e Delete)
    para manipulação dos dados}
    class function Insert(value :TTituloReceberModel): Boolean;
    class function obterPorID(value :TTituloReceberModel): TTituloReceberModel;
    class function Update(value :TTituloReceberModel): Boolean;
    class function Delete(value :TTituloReceberModel): Boolean;



  end;


implementation

{ TTituloReceberDAO }

class function TTituloReceberDAO.Delete(value: TTituloReceberModel): Boolean;
begin

end;

class function TTituloReceberDAO.getModel(query: TFDQuery): TTituloReceberModel;
begin

end;

class function TTituloReceberDAO.Insert(value: TTituloReceberModel): Boolean;
begin

end;

class function TTituloReceberDAO.obterPorID(value: TTituloReceberModel): TTituloReceberModel;
begin

end;

class function TTituloReceberDAO.Update(value: TTituloReceberModel): Boolean;
begin

end;

end.
