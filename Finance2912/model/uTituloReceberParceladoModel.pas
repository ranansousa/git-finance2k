unit uTituloReceberParceladoModel;

interface

uses
  Windows, Messages, Classes, SysUtils, System.Generics.Collections,uTituloReceberModel;

type
  TTituloReceberParceladoModel = class(TObject)
  private
    //objetos
     FFTituloReceber        : TTituloReceberModel; //titulo parcelado
     FFparcela  :string;

  public
  property FTituloReceber: TTituloReceberModel read FFTituloReceber write FFTituloReceber;
  property Fparcela :string read FFparcela  write FFparcela ;

    constructor Create;
    destructor Destroy; override;


  end;

implementation

{ TTituloReceberParceladoModel }

constructor TTituloReceberParceladoModel.Create;
begin

end;

destructor TTituloReceberParceladoModel.Destroy;
begin

  inherited;
end;

end.
