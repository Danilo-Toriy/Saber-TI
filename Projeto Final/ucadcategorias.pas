unit uCadCategorias;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, DBGrids, Buttons, uxcadmodelo, DB, dm;

type

  { TCadCategoriasF }

  TCadCategoriasF = class(TXCadModelo)
    dbedtDesc: TDBEdit;
    dbedtCat: TDBEdit;
    dbedtID: TDBEdit;
    dsCategorias: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    panelDiv: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnRecClick(Sender: TObject);
    procedure dbedtIDChange(Sender: TObject);
    procedure DBGridModelDblClick(Sender: TObject);
    procedure dsCategoriasStateChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure panelCRUDClick(Sender: TObject);
    procedure panelDivClick(Sender: TObject);
    procedure panelSearchClick(Sender: TObject);
    procedure tbCadastroHide(Sender: TObject);
  private

  public

  end;

var
  CadCategoriasF: TCadCategoriasF;

implementation

{$R *.lfm}

{ TCadCategoriasF }

procedure TCadCategoriasF.edtSearchChange(Sender: TObject);
  var
  id: integer;
begin
  DataModule1.zqryCategorias.Close;
  DataModule1.zqryCategorias.SQL.Clear;
  if TryStrToInt(edtSearch.Text, id) then
     begin
          DataModule1.zqryCategorias.SQL.Add('SELECT '+
                                             '* '+
                                             'FROM '+
                                             'categoria_produto '+
                                             'WHERE categoriaprodutoid = '+
                                             edtSearch.Text);
     end
         else
             begin
              DataModule1.zqryCategorias.SQL.Add('SELECT '+
                                                  '* '+
                                                  'FROM '+
                                                  'categoria_produto '+
                                                  'WHERE ds_categoria_produto ILIKE :termo '+
                                                  'OR descricao ILIKE :termo');
              DataModule1.zqryCategorias.ParamByName('termo').AsString := '%' + edtSearch.Text + '%';
             end;
         DataModule1.zqryCategorias.Open;
end;



procedure TCadCategoriasF.dsCategoriasStateChange(Sender: TObject);
begin
   btnNew.Enabled := (Sender as TDataSource).State in [dsBrowse];
   btnRec.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
   btnCancel.Enabled := btnRec.Enabled;
   btnEdit.Enabled := (btnNew.Enabled) and not ((Sender as TDataSource).DataSet.IsEmpty);
   btnDel.Enabled := btnEdit.Enabled;
   btnClose.Enabled := btnNew.Enabled;
end;

procedure TCadCategoriasF.dbedtIDChange(Sender: TObject);
begin

end;

procedure TCadCategoriasF.DBGridModelDblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
end;

procedure TCadCategoriasF.btnRecClick(Sender: TObject);
begin
  if DataModule1.zqryCategoriasds_categoria_produto.AsString = '' then
     begin
     Showmessage('Por favor, cadastre o nome da categoria!');
     dbedtCat.SetFocus;
     end
     else
     begin
       if DataModule1.zqryCategoriasdescricao.AsString = '' then
          begin
             DataModule1.zqryCategoriasdescricao.AsString := 'Sem Descrição';
          end;
       DataModule1.zqryCategorias.Post;
       PageControl1.ActivePage := tbPesquisa;
     end;

end;

procedure TCadCategoriasF.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
  DataModule1.zqryCategorias.Insert;
  dbedtCat.Enabled := true;
  dbedtDesc.Enabled := true;

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtCategorias;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('select nextval( ' +QuotedStr('categoria_id') +') as tmp');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryCategoriascategoriaprodutoid.AsInteger := DataModule1.qryGenerica.FieldByName('tmp').AsInteger;
end;

procedure TCadCategoriasF.btnCancelClick(Sender: TObject);
begin
  DataModule1.zqryCategorias.Cancel;
  PageControl1.ActivePage := tbPesquisa;
  dbedtDesc.Enabled := false;
  dbedtCat.Enabled := false;
end;

procedure TCadCategoriasF.btnDelClick(Sender: TObject);
begin
  if ( MessageDlg ('Deseja realmente excluir essa categoria?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryCategorias.Delete;
        PageControl1.ActivePage := tbPesquisa;
        dbedtCat.Enabled := False;
        dbedtDesc.Enabled := False;
     end;
end;

procedure TCadCategoriasF.btnEditClick(Sender: TObject);
begin
  DataModule1.zqryCategorias.Edit;
  dbedtCat.Enabled := True;
  dbedtDesc.Enabled := True;
end;

procedure TCadCategoriasF.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DataModule1.zqryCategorias.Close;
  CloseAction := caFree;
end;

procedure TCadCategoriasF.FormCreate(Sender: TObject);
begin
  DataModule1.zqryCategorias.Open;
end;

procedure TCadCategoriasF.panelCRUDClick(Sender: TObject);
begin

end;

procedure TCadCategoriasF.panelDivClick(Sender: TObject);
begin

end;

procedure TCadCategoriasF.panelSearchClick(Sender: TObject);
begin

end;

procedure TCadCategoriasF.tbCadastroHide(Sender: TObject);
begin
  if dsCategorias.State in [dsEdit, dsInsert] then
     begin
        if ( MessageDlg ('As alterações sendo feitas poderão ser perdidas. Deseja realmente trocar de aba?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryCategorias.Cancel;
        PageControl1.ActivePage := tbPesquisa;
        dbedtCat.Enabled := false;
        dbedtDesc.Enabled := false;
     end
     else
         begin
              PageControl1.ActivePage := tbCadastro;
              dbedtCat.Enabled := true;
              dbedtDesc.Enabled := true;
         end;
     end;
end;

end.

