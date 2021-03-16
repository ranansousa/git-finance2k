unit usisException;

interface

uses
 DBTables,
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmModelo, Data.DB, Vcl.ImgList,
  System.Actions,
  Vcl.ActnList, Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, uDMTipoCedente,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uDMCedente, Vcl.Mask, Vcl.DBCtrls;


type
 TSISHandleException = class
 private
  FLogFile: string;
  procedure AppException(Sender:TObject; E:Exception);
 public
  constructor Create;
 end;

implementation

uses uDM;

 {Exception}

procedure TSISHandleException.AppException(Sender:TObject; E:Exception);
var
 Log: TextFile;
 ErrCode,i,x,y :integer;
 AConected :boolean;
 ASource: TComponent;
 Formulario :TForm;
 IdentificadorQuery:tstringlist ;
 IdentificadorForm:tstringlist ;
begin
{$I-}
 try
  IdentificadorQuery := TStringList.Create;
  identificadorQuery.Clear ;
  IdentificadorForm := TStringList.Create;
  identificadorForm.Clear ;


  AssignFile(Log, FLogFile);
  if FileExists(FLogFile) then
    Append(Log)
  else
    Rewrite(Log);
  try
    WriteLn(Log, 'Exception ocorrida em '+
      FormatDateTime('dd" de "mmmm" de "yyyy" às "hh:nn:ss', Now));
    WriteLn(Log,'-------------------------------------------------------------------');
    if TComponent(sender) is TForm then
    begin
      WriteLn(Log,'Form.................: '+ TForm(sender).Name);
      WriteLn(Log,'Caption do Form......: '+TForm(sender).Caption);
    end else
    begin
      WriteLn(Log,'Form.................: '+TForm(TComponent(sender).Owner).Name);
      WriteLn(Log,'Caption do Form......: '+TForm(TComponent(sender).Owner).Caption);
    end;
    WriteLn(Log,'-------------------------------------------------------------------');
    WriteLn(Log,'Classe da Exception..: '+E.ClassName);
    WriteLn(Log,'Mensagem da Exception: '+E.Message);
    if E is EDBEngineError then
    WriteLn(Log,'Erro : '+inttostr((E as EDBEngineError).Errors[0].ErrorCode));
    WriteLn(Log,'');
   // ShowMessage(E.Message);
  finally
    CloseFile(Log);
  end;


 //===== TRATAMENTO
 if TComponent(sender) is TForm then      //---Pegar ...  MENU01.Active
  Formulario := TForm(sender)
 else
  Formulario := TForm(TComponent(sender).Owner) ;

 AConected := false;
 if E is EDBEngineError then
  begin

    ErrCode := (E as EDBEngineError).Errors[0].ErrorCode;

     if ErrCode = 13059 then // --> 'Erro não Foi possivel Conectar com o Host'
      begin
       while not AConected do
        begin
         try
           //===> reconectando ............
           for x := 0 to   uDM.dmGenerico.BDFinance.DataSetCount-1 do
            begin
              //ShowMessage(dm.DATABASE.DataSets[x].Owner.Name+'.'+dm.DATABASE.DataSets[x].Name);
              identificadorQuery.Add(uDM.dmGenerico.BDFinance.DataSets[x].Name);
              //identificadorForm.Add(uDM.dmGenerico.BDFinance[x].Owner.Name);
            end;

           uDM.dmGenerico.BDFinance.Connected := False ;
           uDM.dmGenerico.BDFinance.Connected := True  ;
           AConected := true;

           for i := 0 to Application.ComponentCount-1 do
            if (Application.Components[i] is TForm) then
             begin
              //ShowMessage(TForm(Application.Components[i]).Name);
              for y := 0 to TForm(Application.Components[i]).ComponentCount-1 do
               if TForm(Application.Components[i]).Components[y] is TQuery then //ShowMessage(TForm(Application.Components[i]).Components[y].Name);
                 for x := 0 to identificadorQuery.Count-1 do
                  if (TForm(Application.Components[i]).Components[y].Name = identificadorQuery[x]) and (TForm(Application.Components[i]).Components[y].Owner.Name = identificadorForm[x]) then //ShowMessage(identificadorForm[x]+'.'+identificadorQuery[x]);
                   begin
                     //ShowMessage(TForm(Application.Components[i]).Components[y].Owner.Name+'.'+TForm(Application.Components[i]).Components[y].Name);
                     TQuery(TForm(Application.Components[i]).Components[y]).Open;
                   end;
             end//se existe formulario ...
             else
            if (Application.Components[i] is TDataModule) then
             begin
              //ShowMessage(TDataModule(Application.Components[i]).Name);
              for y := 0 to TDataModule(Application.Components[i]).ComponentCount-1 do
               if TDataModule(Application.Components[i]).Components[y] is TQuery then //ShowMessage(TDataModule(Application.Components[i]).Components[y].Name);
                 for x := 0 to identificadorQuery.Count-1 do
                  if (TDataModule(Application.Components[i]).Components[y].Name = identificadorQuery[x]) and (TDataModule(Application.Components[i]).Components[y].Owner.Name = identificadorForm[x]) then //ShowMessage(identificadorForm[x]+'.'+identificadorQuery[x]);
                   begin
                     //ShowMessage(TDataModule(Application.Components[i]).Components[y].Owner.Name+'.'+TDataModule(Application.Components[i]).Components[y].Name);
                     TQuery(TDataModule(Application.Components[i]).Components[y]).Open;
                   end;
             end;//se existe formulario ...

         except

           On E: Exception do
            begin
             ErrCode := (E as EDBEngineError).Errors[0].ErrorCode;
             if MessageDlg('Cód.Erro :'+inttostr(ErrCode)+' Formulário :'+Formulario.name+'   Mensagem:  '+E.Message+#13+#10+
                           'Deseja tentar se Re-conectar novamente ao Banco de Dados ?', mtConfirmation, [mbYes,MbNo], 0) = mrNo then
               begin
                Break;
               end;
            end;
         end;
        end;// while ;;;;


        if AConected = false then
         Application.Terminate;

      end;
  end;

 finally
  identificadorquery.Free ;
  identificadorform.Free;
 end;


{$I+}
end;




constructor TSISHandleException.Create;
begin
 Application.OnException := AppException;
 FLogFile := ChangeFileExt(Paramstr(0),'_erro_bd.log');
end;

var
  SISExcetion: TSISHandleException;

initialization
 SISExcetion := TSISHandleException.Create;

finalization
  SISExcetion.Free;

end.
