unit uDescritorCampos;

interface

implementation



TDescritorCampos = class(TCustomAttribute)
  private
    FDescricao: string;
  public
    constructor Create(const Descricao: string);
    property Descricao: string read FDescricao;
  end;
  { TDescricao }

constructor TDescritorCampos.Create(const Descricao: string);
begin
  FDescricao := Descricao;
end;


end.
