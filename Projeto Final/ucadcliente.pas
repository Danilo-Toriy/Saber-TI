unit uCadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, uxcadmodelo, DB, dm;

type

  { TCadClienteF }

  TCadClienteF = class(TXCadModelo)
    dbComboBType: TDBComboBox;
    dbedTel: TDBEdit;
    dbedtEmail: TDBEdit;
    dbedtClient: TDBEdit;
    dbedtCPF: TDBEdit;
    dbedtClientID: TDBEdit;
    dsClientes: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelCPF: TLabel;
    Panel3: TPanel;
    panelDiv: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnRecClick(Sender: TObject);
    procedure dbComboBTypeChange(Sender: TObject);
    procedure dbedTelChange(Sender: TObject);
    procedure DBGridModelDblClick(Sender: TObject);
    procedure dsClientesStateChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tbCadastroHide(Sender: TObject);
  private

  public

  end;

var
  CadClienteF: TCadClienteF;

implementation

{$R *.lfm}

{ TCadClienteF }

procedure TCadClienteF.edtSearchChange(Sender: TObject);
begin
  DataModule1.zqryClientes.Close;
  DataModule1.zqryClientes.SQL.Clear;
  DataModule1.zqryClientes.SQL.Add('SELECT '+
                                           '* '+
                                           'FROM '+
                                           'cliente '+
                                           'WHERE '+
                                           'CAST(clienteid AS TEXT) ILIKE :termo '+
                                           'OR cpf_cnpj_cliente ILIKE :termo '+
                                           'OR nome_cliente ILIKE :termo ' +
                                           'OR telefone_cliente ILIKE :termo '+
                                           'OR email_cliente ILIKE :termo');
  DataModule1.zqryClientes.ParamByName('termo').AsString := '%' + edtSearch.Text + '%';
  DataModule1.zqryClientes.Open;
end;

procedure TCadClienteF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  DataModule1.zqryClientes.Close;
  CloseAction := caFree;
end;

procedure TCadClienteF.FormCreate(Sender: TObject);
begin
  DataModule1.zqryClientes.Open;
end;

procedure TCadClienteF.tbCadastroHide(Sender: TObject);
begin
  if dsClientes.State in [dsEdit, dsInsert] then
     begin
        if ( MessageDlg ('As alterações sendo feitas poderão ser perdidas. Deseja realmente trocar de aba?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryClientes.Cancel;
        PageControl1.ActivePage := tbPesquisa;
        dbedtClient.Enabled := false;
        dbComboBType.Enabled := false;
        dbedTel.Enabled := false;
        dbedtEmail.Enabled := false;
     end
     else
         begin
              PageControl1.ActivePage := tbCadastro;
              dbedtClient.Enabled := true;
              dbComboBType.Enabled := true;
              dbedTel.Enabled := true;
              dbedtEmail.Enabled := true;
         end;
     end;
end;

procedure TCadClienteF.dbComboBTypeChange(Sender: TObject);
begin
    if (dbComboBType.ItemIndex = 0) OR (dbComboBType.ItemIndex = 3) then
       begin
          LabelCPF.Caption := 'CPF:';
          dbedtCPF.Enabled := true;
       end
       else
           begin
             LabelCPF.Caption := 'CNPJ:';
             dbedtCPF.Enabled := true;
           end;
end;

procedure TCadClienteF.dbedTelChange(Sender: TObject);
begin

end;

procedure TCadClienteF.DBGridModelDblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
end;

procedure TCadClienteF.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
  DataModule1.zqryClientes.Insert;
  dbedtClient.Enabled := true;
  dbComboBType.Enabled := true;
  dbedTel.Enabled := true;
  dbedtEmail.Enabled := true;

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtClientes;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('select nextval( ' +QuotedStr('cliente_idtemp') +') as aux');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryClientesclienteid.AsInteger := DataModule1.qryGenerica.FieldByName('aux').AsInteger;
end;

procedure TCadClienteF.btnRecClick(Sender: TObject);
begin
  if DataModule1.zqryClientesnome_cliente.AsString = '' then
     begin
        Showmessage('Por favor, informe pelo menos um nome do cliente!');
        dbedtClient.SetFocus;
     end
     else
         begin
           if dbComboBType.ItemIndex = -1 then
              begin
                 Showmessage('Escolha uma opção válida!');
                 dbComboBType.SetFocus;
              end
              else
                  begin
                    if DataModule1.zqryClientescpf_cnpj_cliente.AsString = '' then
                       begin
                          Showmessage('Informe um CPF ou CNPJ!');
                          dbedtCPF.SetFocus;
                       end
                       else
                           begin
                             if (DataModule1.zqryClientesemail_cliente.AsString = '') AND (DataModule1.zqryClientestelefone_cliente.AsString = '') then
                                begin
                                   ShowMessage('Informe pelo menos um meio de contato com o cliente!');
                                   dbedTel.SetFocus;
                                end
                                else
                                    begin
                                         if Trim(DataModule1.zqryClientesemail_cliente.AsString) = '' then
                                            DataModule1.zqryClientesemail_cliente.AsString := 'Email não informado';
                                         if Trim(DataModule1.zqryClientestelefone_cliente.AsString) = '' then
                                            DataModule1.zqryClientestelefone_cliente.AsString := 'Não cadastrado';

                                         DataModule1.zqryClientes.Post;
                                         PageControl1.ActivePage := tbPesquisa;
                                    end;
                           end;
                  end;
         end;
end;

procedure TCadClienteF.btnCancelClick(Sender: TObject);
begin
  DataModule1.zqryClientes.Cancel;
  PageControl1.ActivePage := tbPesquisa;
  dbedtClient.Enabled := false;
  dbComboBType.Enabled := false;
  dbedTel.Enabled := false;
  dbedtEmail.Enabled := false;

end;

procedure TCadClienteF.btnDelClick(Sender: TObject);
begin
  if ( MessageDlg ('Deseja realmente excluir esse cliente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryClientes.Delete;
        PageControl1.ActivePage := tbPesquisa;
        dbedtClient.Enabled := false;
        dbComboBType.Enabled := false;
        dbedTel.Enabled := false;
        dbedtEmail.Enabled := false
     end;
end;

procedure TCadClienteF.btnEditClick(Sender: TObject);
begin
  DataModule1.zqryClientes.Edit;
  dbedtClient.Enabled := true;
  dbComboBType.Enabled := true;
  dbedTel.Enabled := true;
  dbedtEmail.Enabled := true;
end;

procedure TCadClienteF.dsClientesStateChange(Sender: TObject);
begin
   btnNew.Enabled := (Sender as TDataSource).State in [dsBrowse];
   btnRec.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
   btnCancel.Enabled := btnRec.Enabled;
   btnEdit.Enabled := (btnNew.Enabled) and not ((Sender as TDataSource).DataSet.IsEmpty);
   btnDel.Enabled := btnEdit.Enabled;
   btnClose.Enabled := btnNew.Enabled;
end;


end.

