unit uTituloPagarParceladoModel;

interface

uses
  Windows, Messages, Classes, SysUtils, System.Generics.Collections,uTituloPagarModel;

type
  TTituloPagarParceladoModel = class(TObject)
  private
    //objetos
     FFTituloPagar        : TTituloPagarModel; //titulo parcelado
  public
  property FTituloPagar: TTituloPagarModel read FFTituloPagar write FFTituloPagar;

    constructor Create;
    destructor Destroy; override;


  end;

implementation

{ TTituloPagarParceladoModel }

constructor TTituloPagarParceladoModel.Create;
begin

end;

destructor TTituloPagarParceladoModel.Destroy;
begin

  inherited;
end;

end.
