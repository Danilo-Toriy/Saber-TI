unit ucadusuarios;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, uxcadmodelo, DB, dm;

type

  { TCadUsuariosF }

  TCadUsuariosF = class(TXCadModelo)
    dbedtPass: TDBEdit;
    dsUser: TDataSource;
    dbedtName: TDBEdit;
    dbedtUser: TDBEdit;
    dbedtUserID: TDBEdit;
    edtConfirmacao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    panelDiv: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnRecClick(Sender: TObject);
    procedure dbedtNameChange(Sender: TObject);
    procedure DBGridModelDblClick(Sender: TObject);
    procedure dsUserStateChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure tbCadastroHide(Sender: TObject);
  private

  public

  end;

var
  CadUsuariosF: TCadUsuariosF;

implementation

{$R *.lfm}

{ TCadUsuariosF }

procedure TCadUsuariosF.edtSearchChange(Sender: TObject);
var
  id: integer;
begin
  DataModule1.zqryUsuarios.Close;
  DataModule1.zqryUsuarios.SQL.Clear;

  if TryStrToInt(edtSearch.Text, id) then
     begin
          DataModule1.zqryUsuarios.SQL.Add('SELECT '+
                                           '* '+
                                           'FROM '+
                                           'usuarios '+
                                           'WHERE id = '+
                                           edtSearch.Text);
     end
     else
         begin
              DataModule1.zqryUsuarios.SQL.Add('SELECT '+
                                               '* '+
                                               'FROM '+
                                               'usuarios '+
                                               'WHERE usuario ILIKE :termo '+
                                               'OR nome_completo ILIKE :termo');
              DataModule1.zqryUsuarios.ParamByName('termo').AsString := '%' + edtSearch.Text + '%';
         end;
     DataModule1.zqryUsuarios.Open;
end;

procedure TCadUsuariosF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  DataModule1.zqryUsuarios.Close;
  CloseAction := caFree;
end;

procedure TCadUsuariosF.FormCreate(Sender: TObject);
begin
  DataModule1.zqryUsuarios.Open;
end;

procedure TCadUsuariosF.dsUserStateChange(Sender: TObject);
begin
   btnNew.Enabled := (Sender as TDataSource).State in [dsBrowse];
   btnRec.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
   btnCancel.Enabled := btnRec.Enabled;
   btnEdit.Enabled := (btnNew.Enabled) and not ((Sender as TDataSource).DataSet.IsEmpty);
   btnDel.Enabled := btnEdit.Enabled;
   btnClose.Enabled := btnNew.Enabled;
end;

procedure TCadUsuariosF.dbedtNameChange(Sender: TObject);
begin

end;

procedure TCadUsuariosF.DBGridModelDblClick(Sender: TObject);
begin
     PageControl1.ActivePage := tbCadastro;
end;

procedure TCadUsuariosF.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
  DataModule1.zqryUsuarios.Insert;
  dbedtName.Enabled := true;
  dbedtUser.Enabled := true;
  dbedtPass.Enabled := true;
  edtConfirmacao.Enabled := true;

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtUsuarios;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('select nextval( ' +QuotedStr('usuario_idtemp') +') as cod');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryUsuariosid.AsInteger := DataModule1.qryGenerica.FieldByName('cod').AsInteger;
end;

procedure TCadUsuariosF.btnCancelClick(Sender: TObject);
begin
  DataModule1.zqryUsuarios.Cancel;
  PageControl1.ActivePage := tbPesquisa;
  dbedtName.Enabled := false;
  dbedtUser.Enabled := false;
  dbedtPass.Enabled := false;
  edtConfirmacao.Enabled := false;

end;

procedure TCadUsuariosF.btnDelClick(Sender: TObject);
begin
  if ( MessageDlg ('Deseja realmente excluir essa categoria?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryUsuarios.Delete;
        PageControl1.ActivePage := tbPesquisa;
        dbedtName.Enabled := False;
        dbedtUser.Enabled := False;
        dbedtPass.Enabled := False;
        edtConfirmacao.Enabled := False;
     end;
end;

procedure TCadUsuariosF.btnEditClick(Sender: TObject);
begin
  DataModule1.zqryUsuarios.Edit;
  dbedtName.Enabled := true;
  dbedtUser.Enabled := true;
  dbedtPass.Enabled := true;
  edtConfirmacao.Enabled := true;
end;

procedure TCadUsuariosF.btnRecClick(Sender: TObject);
begin
  if DataModule1.zqryUsuariosnome_completo.AsString = '' then
     begin
        Showmessage('Informe um nome válido!!');
        dbedtName.SetFocus;
     end
     else
         begin
             if DataModule1.zqryUsuariosusuario.AsString = '' then
                begin
                   Showmessage('Informe um nome de usuário válido!!');
                   dbedtUser.SetFocus;
                end
                else
                begin
                    if (DataModule1.zqryUsuariossenha.AsString = '') AND (edtConfirmacao.Text <> '') then
                       begin
                          ShowMessage('Senha divergente!');
                          dbedtPass.SetFocus;
                       end
                    else
                    begin
                    if (DataModule1.zqryUsuariossenha.AsString = '') AND (edtConfirmacao.Text = '') then
                       begin
                          DataModule1.zqryUsuariossenha.AsString := '12345678';
                       end
                       else
                           if (DataModule1.zqryUsuariossenha.AsString <> '') AND (DataModule1.zqryUsuariossenha.AsString <> edtConfirmacao.Text) then
                              begin
                                 ShowMessage('As senhas não coincidem!!');
                                 dbedtPass.SetFocus;
                              end
                              else
                                  begin
                                       DataModule1.zqryUsuarios.Post;
                                       PageControl1.ActivePage := tbPesquisa;
                                       edtConfirmacao.Text := '';
                                  end;
                       end;
                    end;
                end;
         end;

procedure TCadUsuariosF.Panel1Click(Sender: TObject);
begin

end;

procedure TCadUsuariosF.tbCadastroHide(Sender: TObject);
begin
  if dsUser.State in [dsEdit, dsInsert] then
     begin
        if ( MessageDlg ('As alterações sendo feitas poderão ser perdidas. Deseja realmente trocar de aba?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryUsuarios.Cancel;
        PageControl1.ActivePage := tbPesquisa;
        dbedtName.Enabled := False;
        dbedtUser.Enabled := False;
        dbedtPass.Enabled := False;
        edtConfirmacao.Enabled := False;
     end
     else
         begin
              PageControl1.ActivePage := tbCadastro;
              dbedtName.Enabled := true;
              dbedtUser.Enabled := true;
              dbedtPass.Enabled := true;
              edtConfirmacao.Enabled := true;
         end;
     end;
end;

end.

