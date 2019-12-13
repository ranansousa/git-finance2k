unit FormBase;

interface

uses
   Util, Forms, Classes, Windows, Sysutils, StdCtrls, Graphics,
   SqlExpr, IBase, DB, QuickRpt, RxLookup, Mask, ENumEd, dialogs, EDateEd,
//  {$IFDEF VER150}
//    ToolEdit, CurrEdit,
//  {$ELSE}
    RxToolEdit, RxCurrEdit, EMonthYear, EChkGrp, ETimeEd,
//  {$ENDIF}
   uFormBaseMaster,
  {Início units do FireDac}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;
  {Fim units do FireDac}

type
  TFormBase = class(TFormBaseMaster)
  private
    FwLastKeyPress: Word;
    FShiftState: TShiftState;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function get_LastKeyPress: Word;
    function get_ShiftState: TShiftState;
    procedure set_LastKeyPress(Value: Word);
    procedure set_ShiftState(Value: TShiftState);
  public
    constructor Create(Aowner: TComponent); override;
    property LastKeyPress: Word read get_LastKeyPress  write set_LastKeyPress;
    property ShiftState: TShiftState read get_ShiftState  write set_ShiftState;
  end;

  TColorFormBase = class(TFormBase)
  private
    FcIniFile: String;
  protected
    procedure doShow; override;
    procedure doConfigureForm(); virtual;
  public
    constructor Create(Aowner: TComponent; IniFile: String); reintroduce; virtual;
  end;

  TDBForm = class(TColorFormBase)
  private
    FoConn: TFDConnection;
  public
    property Conn: TFDConnection read FoConn write FoConn;
  end;

  TDBReport = class(TDBForm)
  private
    FcTabela: String;
  protected
    procedure RaiseIfAcessDeny; virtual; abstract;
    procedure PreviewReport; virtual; abstract;
    procedure PrintReport; virtual; abstract;
    function isValid: Boolean; virtual; abstract;

    function getTabela: string;
    procedure setTabela(Value: String); virtual;
  end;

  TCadFormBase = class(TDBForm)
  private
    FtOperacao: TOperacao;
  protected
    function doInsert(): boolean; virtual; abstract;
    function doUpdate(): boolean; virtual; abstract;
    function doDelete(): boolean; virtual; abstract;
    function doCancel(): boolean; virtual; abstract;
    function doSave(): boolean; virtual; abstract;
    function doLocate(): boolean; virtual; abstract;
    function doLoadData(): boolean; virtual; abstract;
    function isValid: Boolean; virtual; abstract;
    procedure doClearFields(); virtual;
    procedure doSetRegistro(); virtual; abstract;

    procedure setOperacao(Value: TOperacao); virtual;
  public
    constructor Create(Aowner: TComponent; IniFile: String); override;

    property Operacao: TOperacao read FtOperacao write setOperacao;
  end;

  TFormSearch = class(TDBForm)
  private
    FoSQL: TStringList;
  protected
    function get_SQL: TStrings;
    procedure set_SQL(Value: TStrings);

    function get_DataSet: TDataSet; virtual; abstract;

    procedure AddField(lcField, lcDesc: String; loType: IBase.TFieldType; lbSearch: boolean); virtual; abstract;
  public
    constructor Create(Aowner: TComponent; IniFile: String); override;

    property SQL: TStrings read get_SQL write set_SQL;
    property DataSet: TDataSet read get_DataSet;
  end;

implementation

uses Controls, Constants;

{ TFormBase }

constructor TFormBase.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  KeyPreview := True;
  ShowHint := true;
end;

function TFormBase.get_LastKeyPress: Word;
begin
  result := FwLastKeyPress;
end;

function TFormBase.get_ShiftState: TShiftState;
begin
  result := FShiftState;
end;

procedure TFormBase.KeyDown(var Key: Word; Shift: TShiftState);
begin
  set_LastKeyPress(Key);
  set_ShiftState(Shift);
//  if key = vk_return then
//    SelectNext(ActiveControl, true, true)
//  else
    inherited;
end;

procedure TFormBase.set_LastKeyPress(Value: Word);
begin
  FwLastKeyPress := Value;
end;

procedure TFormBase.set_ShiftState(Value: TShiftState);
begin
  FShiftState := Value;
end;

{ TColorFormBase }

constructor TColorFormBase.Create(Aowner: TComponent; IniFile: String);
begin
  inherited Create(Aowner);
  FcIniFile := IniFile;
end;

procedure TColorFormBase.doConfigureForm;
var
  lnCont: Integer;
  ltColorForm: TColor;
  ltColorControl: TColor;
  ltColorFont: TColor;
begin
  // capturando as cores configuradas
//  try
//    {O try/except foi colocado porque caso não exista definição das cores no
//    arquivo ini, o método StringToColor retorna um erro.}
//    ltColorForm    := StringToColor(TUtil.ReadIni(TUtil.IniFile, INI_SESSAO_CORES, INI_KEYS_CONTROLS));
//    ltColorControl := StringToColor(TUtil.ReadIni(TUtil.IniFile, INI_SESSAO_CORES, INI_KEYS_FORMS));
//    ltColorFont    := StringToColor(TUtil.ReadIni(TUtil.IniFile, INI_SESSAO_CORES, INI_KEYS_FONTS));
//
//    // cor do form
//    self.Color := ltColorForm;
//
//    for lnCont := 0 to ControlCount - 1 do begin
//      if Controls[lnCont] is TEdit then begin
//        TEdit(Controls[lnCont]).Color := ltColorControl;
//        TEdit(Controls[lnCont]).Font.Color := ltColorFont;
//      end;
//    end;
//  except
//  end;
end;

procedure TColorFormBase.doShow;
begin
  inherited;
  if FileExists(FcIniFile) then
    doConfigureForm();
end;

{ TCadFormBase }

constructor TCadFormBase.Create(Aowner: TComponent; IniFile: String); 
begin
  inherited Create(Aowner, IniFile);
  FtOperacao := opNenhuma;
end;

procedure TCadFormBase.doClearFields;
var
  lnCont: Integer;
begin
  for lnCont := 0 to ComponentCount - 1 do begin
    if Components[lnCont] is TEdit then begin
      TEdit(Components[lnCont]).Clear;
    end else if Components[lnCont] is TComboBox then begin
      TComboBox(Components[lnCont]).Text := '';
      TComboBox(Components[lnCont]).ItemIndex := -1;
    end else if Components[lnCont] is TMemo then begin
      TMemo(Components[lnCont]).Lines.Clear;
    end else if Components[lnCont] is TDateEdit then begin
      TDateEdit(Components[lnCont]).Date := TP_ZERO;
    end else if Components[lnCont] is TCurrencyEdit then begin
      TCurrencyEdit(Components[lnCont]).Value := TP_ZERO;
    end else if Components[lnCont] is TRxDBLookupCombo then begin
      TRxDBLookupCombo(Components[lnCont]).Value := '';
    end else if Components[lnCont] is TEvMonthYear then begin
      TEvMonthYear(Components[lnCont]).DateValue := TP_DATA_EMPTY;
    end else if Components[lnCont] is TEvDateEdit then begin
      TEvDateEdit(Components[lnCont]).DateValue := TP_DATA_EMPTY;
    end else if Components[lnCont] is TEvTimeEdit then begin
      TEvTimeEdit(Components[lnCont]).TimeValue := TP_ZERO;
    end else if Components[lnCont] is TEvNumEdit then begin
      TEvNumEdit(Components[lnCont]).Value := TP_ZERO;
    end else if Components[lnCont] is TMaskEdit then begin
      TMaskEdit(Components[lnCont]).Text := '';
    {Não pode limpar TEvCheckGroup porque nas telas de lançamentos do MegaFiscal
    é usado esse componente Run Time para utilização, por exemplo, para guardar
    os tipos de atividades exercidas pela empresa, ex: Indústria, comércio, etc.
    E, nesse caso, ele não pode ser limpo.}
//    end else if (Components[lnCont] is TEvCheckGroup ) then begin
//      TEvCheckGroup(Components[lnCont]).SetStates(0);
    end else if (Components[lnCont] is TCheckBox) then begin
      TCheckBox(Components[lnCont]).Checked := False;
    end;
  end;
end;

procedure TCadFormBase.setOperacao(Value: TOperacao);
begin
  FtOperacao := Value;
end;

{ TFormSearch }

constructor TFormSearch.Create(Aowner: TComponent; IniFile: String);
begin
  inherited Create(Aowner, IniFile);
  FoSQL := TStringList.Create;
end;

function TFormSearch.get_SQL: TStrings;
begin
  result := FoSQL;
end;

procedure TFormSearch.set_SQL(Value: TStrings);
begin
  FoSQL.Assign(Value);
end;

{ TDBReport }

function TDBReport.getTabela: string;
begin
  result := FcTabela;
end;

procedure TDBReport.setTabela(Value: String);
begin
  FcTabela := Value;
end;

end.
