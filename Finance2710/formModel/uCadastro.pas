unit uCadastro;

interface

uses
  Windows, Messages, SysUtils,System.UITypes, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBase, StdCtrls, Buttons, ImgList, ComCtrls, ToolWin,
  ExtCtrls, Util, Mask, EMsgDlg, Vcl.DBCtrls, RxLookup, LibMega, UCBase;

type
  T_frmCadastro = class(TCadFormBase)
    ToolBar1: TToolBar;
    _stbStatus: TStatusBar;
    _btnIncluir: TBitBtn;
    _btnExcluir: TBitBtn;
    _btnCancelar: TBitBtn;
    _btnLocalizar: TBitBtn;
    _btnSair: TBitBtn;
    _pnlEdicao: TPanel;
    _btnSalvar: TBitBtn;
    MsgDlg: TEvMsgDlg;
    _btnAlterar: TBitBtn;
    procedure _btnSalvarClick(Sender: TObject);
    procedure _btnLocalizarClick(Sender: TObject);
    procedure _btnSairClick(Sender: TObject);
    procedure _btnIncluirClick(Sender: TObject);
    procedure _btnExcluirClick(Sender: TObject);
    procedure _btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure _btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    FbNovaInclusao: Boolean;
    FbNovaAtualizacao: Boolean;
    FbSalvo: Boolean;
    FbPermitidoIncluir: Boolean;
    FbPermitidoAlterar: Boolean;
    FbPermitidoExcluir: Boolean;
    FbPermitidoLocalizar: Boolean;
    FoUCControls: TUCControls;
    procedure setOperacao(Value: TOperacao); override;
    function doSave(): boolean; override;
  public
    { Public declarations }
  end;

var
  _frmCadastro: T_frmCadastro;

implementation

{$R *.dfm}

procedure T_frmCadastro._btnSalvarClick(Sender: TObject);
begin
  FbSalvo := False;
  MsgDlg.DefaultButton := mbYes;
  if MsgDlg.MessageDlg('Deseja salvar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if doSave then begin
      FbSalvo := True;
      if (not FbNovaInclusao) then begin
        Operacao := opNenhuma;
        doClearFields;

//        if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
        if TUtil.getUsaUserControl(1) then begin
          if Assigned(FoUCControls) then begin
            FoUCControls.ApplyRights;
          end else begin
            _btnIncluir  .Enabled := true;
            _btnLocalizar.Enabled := true;
          end;
        end else begin
          _btnIncluir  .Enabled := true;
          _btnLocalizar.Enabled := true;
        end;
        _pnlEdicao   .Visible := false;
        _pnlEdicao   .Enabled := false;
        _btnAlterar  .Enabled := false;
        _btnExcluir  .Enabled := false;
        _btnCancelar .Enabled := false;
        _btnSalvar   .Enabled := false;
      end;
    end;
  end;
end;

procedure T_frmCadastro._btnLocalizarClick(Sender: TObject);
begin
  if doLocate then begin
    Operacao := opNenhuma;

    _pnlEdicao.Visible := true;
    _pnlEdicao.Enabled := false;
//    if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
    if TUtil.getUsaUserControl(1) then begin
      if Assigned(FoUCControls) then begin
        FoUCControls.ApplyRights;
      end else begin
        _btnIncluir  .Enabled := true;
        _btnAlterar  .Enabled := true;
        _btnExcluir  .Enabled := true;
        _btnLocalizar.Enabled := true;
      end;
    end else begin
      _btnIncluir  .Enabled := true;
      _btnAlterar  .Enabled := true;
      _btnExcluir  .Enabled := true;
      _btnLocalizar.Enabled := true;
    end;
    _btnSalvar  .Enabled := false;
    _btnSair    .Enabled := true;

    doLoadData;
  end else begin
    _pnlEdicao .Visible := false;
    _btnAlterar.Enabled := false;
    _btnExcluir.Enabled := false;

    Operacao := opNenhuma;
  end;
  if _pnlEdicao.Visible then begin
    _btnCancelar.Enabled := true;
  end else begin
    _btnCancelar.Enabled := false;
  end;
end;

procedure T_frmCadastro._btnSairClick(Sender: TObject);
begin
  Close;
end;

function T_frmCadastro.doSave: boolean;
begin
  result := isValid;

  if result then begin
    doSetRegistro();
  end;
end;

procedure T_frmCadastro.setOperacao(Value: TOperacao);
var
 sModoVisualizacao: String;
begin
  inherited setOperacao(Value);
  _stbStatus.Font.Color := clBtnText;
  if not _pnlEdicao.Visible then begin
    sModoVisualizacao := 'Modo: Visualização';
    if Value = opNenhuma then begin
      _stbStatus.Font.Color := clRed;
    end;
  end else begin
    sModoVisualizacao := '';
  end;

  case Value of
    opInserir: _stbStatus.SimpleText := 'Modo: inclusão';
    opAtualizar: _stbStatus.SimpleText := 'Modo: Alteração';
//    opNenhuma  : _stbStatus.SimpleText := 'Modo: Visualização';
    opExcluir  : _stbStatus.SimpleText := 'Modo: Exclusão';
    opNenhuma  : _stbStatus.SimpleText := sModoVisualizacao;
  end;
end;

procedure T_frmCadastro._btnIncluirClick(Sender: TObject);
begin
  doClearFields;

  if doInsert then begin
    Operacao := opInserir;

   // fHabilita(Self);
//    if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
    if TUtil.getUsaUserControl(1) then begin
      if Assigned(FoUCControls) then begin
        FoUCControls.ApplyRights;
      end;
    end;
    _pnlEdicao   .Visible := true;
    _pnlEdicao   .Enabled := true;
    _btnIncluir  .Enabled := false;
    _btnAlterar  .Enabled := false;
    _btnExcluir  .Enabled := false;
    _btnCancelar .Enabled := true;
    _btnSalvar   .Enabled := true;
    _btnLocalizar.Enabled := false;
  end;
end;

procedure T_frmCadastro._btnExcluirClick(Sender: TObject);
begin
  MsgDlg.DefaultButton := mbNo;
  if MsgDlg.MessageDlg('Tem certeza que deseja excluir o registro selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Operacao := opExcluir;
    doSetRegistro;

    if doDelete then begin
      Operacao := opNenhuma;
      doClearFields;
//      if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
      if TUtil.getUsaUserControl(1) then begin
        if Assigned(FoUCControls) then begin
          FoUCControls.ApplyRights;
        end else begin
          _btnIncluir  .Enabled := true;
          _btnLocalizar.Enabled := true;
        end;
      end else begin
        _btnIncluir  .Enabled := true;
        _btnLocalizar.Enabled := true;
      end;
      _pnlEdicao   .Visible := false;
      _pnlEdicao   .Enabled := false;
      _btnAlterar  .Enabled := false;
      _btnExcluir  .Enabled := false;
      _btnCancelar .Enabled := false;
      _btnSalvar   .Enabled := false;
      ShowMessage('Registro Excluído com Sucesso!');
    end;
  end;
end;

procedure T_frmCadastro._btnCancelarClick(Sender: TObject);
begin
  MsgDlg.DefaultButton := mbNo;
  if MsgDlg.MessageDlg('Tem certeza que deseja cancelar as alterações efetuadas esse registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if doCancel then begin
      Operacao := opNenhuma;

      doClearFields;

//      if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
      if TUtil.getUsaUserControl(0) then begin
        if Assigned(FoUCControls) then begin
          FoUCControls.ApplyRights;
        end else begin
          _btnIncluir  .Enabled := true;
          _btnLocalizar.Enabled := true;
        end;
      end else begin
        _btnIncluir  .Enabled := true;
        _btnLocalizar.Enabled := true;
      end;
      _pnlEdicao   .Visible := false;
      _pnlEdicao   .Enabled := false;
      _btnAlterar  .Enabled := false;
      _btnExcluir  .Enabled := false;
      _btnCancelar .Enabled := false;
      _btnSalvar   .Enabled := false;
    end;
  end;
end;

procedure T_frmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
var
  liFor: Integer;
  lbClose: Boolean;
begin
  lbClose := False;
  if (Operacao = opInserir) or (Operacao = opAtualizar) then begin
    if MsgDlg.MessageDlg('Tem certeza que deseja cancelar as alterações efetuadas esse registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      lbClose := True;
    end;
  end else begin
    lbClose := True;
  end;
  if lbClose then begin
    for liFor := 0 to Self.ComponentCount-1 do begin
      if (Self.Components[liFor] is TDBLookupComboBox) then begin
        TDBLookupComboBox(Self.Components[liFor]).CloseUp(true);
      end else if (Self.Components[liFor] is TRxDBLookupCombo) then begin
        TRxDBLookupCombo(Self.Components[liFor]).CloseUp(true);
      end;
    end;
  end else begin
    Action := caNone;
  end;
end;

procedure T_frmCadastro.FormCreate(Sender: TObject);
begin
  _pnlEdicao   .Visible := false;
  _pnlEdicao   .Enabled := false;
  _btnAlterar  .Enabled := false;
  _btnExcluir  .Enabled := false;
  _btnCancelar .Enabled := false;
  _btnSalvar   .Enabled := false;
end;

procedure T_frmCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then begin
    if _btnSalvar.CanFocus then begin
      _btnSalvar.Click;
    end;
  end;
end;

procedure T_frmCadastro._btnAlterarClick(Sender: TObject);
begin
  if doUpdate then begin
    Operacao := opAtualizar;

    _pnlEdicao   .Visible := true;
    _pnlEdicao   .Enabled := true;

//    if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
    if TUtil.getUsaUserControl(0) then begin
      if Assigned(FoUCControls) then begin
        FoUCControls.ApplyRights;
        end else begin
        _btnExcluir  .Enabled := true;
       end;
    end else begin
      _btnExcluir  .Enabled := true;
    end;

    _btnIncluir  .Enabled := false;
    _btnAlterar  .Enabled := false;
    _btnCancelar .Enabled := true;
    _btnSalvar   .Enabled := true;
    _btnLocalizar.Enabled := false;
  end;
end;

end.
