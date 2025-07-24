unit uCadProdutos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, uxcadmodelo, DB, dm;

type

  { TCadProdutosF }

  TCadProdutosF = class(TXCadModelo)
    dbComboBCat: TDBComboBox;
    dbradio: TDBRadioGroup;
    dsProdutos: TDataSource;
    dbedtProd: TDBEdit;
    dbedtProdID: TDBEdit;
    dbedtObs: TDBEdit;
    dbedtVal: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    panelDiv: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnRecClick(Sender: TObject);
    procedure dbComboBCatClick(Sender: TObject);
    procedure dsProdutosDataChange(Sender: TObject; Field: TField);
    procedure dsProdutosStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure tbCadastroHide(Sender: TObject);
  private

  public

  end;

var
  CadProdutosF: TCadProdutosF;

implementation

{$R *.lfm}

{ TCadProdutosF }

procedure TCadProdutosF.dsProdutosDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TCadProdutosF.dsProdutosStateChange(Sender: TObject);
begin
   btnNew.Enabled := (Sender as TDataSource).State in [dsBrowse];
   btnRec.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
   btnCancel.Enabled := btnRec.Enabled;
   btnEdit.Enabled := (btnNew.Enabled) and not ((Sender as TDataSource).DataSet.IsEmpty);
   btnDel.Enabled := btnEdit.Enabled;
   btnClose.Enabled := btnNew.Enabled;
end;

procedure TCadProdutosF.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  DataModule1.zqryProdutos.Close;
  DataModule1.zqryCategorias.Close;
  CloseAction := caFree;
end;

procedure TCadProdutosF.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
  DataModule1.zqryProdutos.Insert;
  dbedtProd.Enabled := true;
  dbComboBCat.Enabled := true;
  dbedtObs.Enabled := true;
  dbedtVal.Enabled := true;
  dbradio.Enabled := true;

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtProdutos;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('select nextval( ' +QuotedStr('produto_idtemp') +') as helper');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryProdutosprodutoid.AsInteger := DataModule1.qryGenerica.FieldByName('helper').AsInteger;
end;

procedure TCadProdutosF.btnRecClick(Sender: TObject);
var
  valor: Double;
  id: integer;
begin
  if DataModule1.zqryProdutosds_produto.AsString = '' then
     begin
          ShowMessage('Insira o nome do produto!!');
          dbedtProd.SetFocus;
     end
     else
         begin
              if dbComboBCat.ItemIndex = -1 then
                 begin
                      Showmessage('Insira uma categoria!!');
                      dbComboBCat.SetFocus;
                 end
                 else
                     begin
                          if DataModule1.zqryProdutosvl_venda_produto.AsString = '' then
                             begin
                             ShowMessage('Informe um valor!!');
                             dbedtVal.SetFocus;
                             end
                             else
                                 begin
                                      if dbradio.ItemIndex = -1 then
                                         begin
                                         ShowMessage('Informe o status!!');
                                         dbradio.SetFocus;
                                         end
                                         else
                                             begin
                                                  if TryStrToFloat(StringReplace(DataModule1.zqryProdutosvl_venda_produto.AsString, ',', '.', [rfReplaceAll]), valor) then
                                                     begin
                                                         if DataModule1.zqryProdutosobs_produto.AsString = '' then
                                                            DataModule1.zqryProdutosobs_produto.AsString := 'Sem descrição';
                                                         DataModule1.zqryProdutosvl_venda_produto.AsFloat := valor;
                                                         DataModule1.zqryProdutosdt_cadastro_produto.AsDateTime := Date;
                                                         id := Integer(dbComboBCat.items.Objects[dbComboBCat.ItemIndex]);
                                                         DataModule1.zqryProdutoscategoriaprodutoid.AsInteger := id;
                                                         DataModule1.zqryProdutos.Post;
                                                         PageControl1.ActivePage := tbPesquisa;
                                                     end
                                                     else
                                                         begin
                                                              Showmessage('Informe um valor válido!!');
                                                              dbedtVal.SetFocus;
                                                         end;

                                             end;
                                 end;
                     end;

         end;
end;

procedure TCadProdutosF.dbComboBCatClick(Sender: TObject);
begin

end;

procedure TCadProdutosF.btnEditClick(Sender: TObject);
begin
  DataModule1.zqryProdutos.Edit;
  dbedtProd.Enabled := true;
  dbComboBCat.Enabled := true;
  dbedtObs.Enabled := true;
  dbedtVal.Enabled := true;
  dbradio.Enabled := true;
end;

procedure TCadProdutosF.btnDelClick(Sender: TObject);
begin
  if ( MessageDlg ('Deseja realmente excluir esse produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryProdutos.Delete;
        PageControl1.ActivePage := tbPesquisa;
        dbedtProd.Enabled := false;
        dbComboBCat.Enabled := false;
        dbedtObs.Enabled := false;
        dbedtVal.Enabled := false;
        dbradio.Enabled := false;
     end;
end;

procedure TCadProdutosF.btnCancelClick(Sender: TObject);
begin
  DataModule1.zqryProdutos.Cancel;
  PageControl1.ActivePage := tbPesquisa;
  dbedtProd.Enabled := false;
  dbComboBCat.Enabled := false;
  dbedtObs.Enabled := false;
  dbedtVal.Enabled := false;
  dbradio.Enabled := false;
end;

procedure TCadProdutosF.FormCreate(Sender: TObject);
begin
  DataModule1.zqryProdutos.Open;
  dbComboBCat.Items.Clear;

  DataModule1.zqryCategorias.Close;
  DataModule1.zqryCategorias.SQL.Clear;
  DataModule1.zqryCategorias.SQL.Add('SELECT '+
                                 '* '+
                                 'FROM categoria_produto '+
                                 'ORDER BY '+
                                 'ds_categoria_produto');
  DataModule1.zqryCategorias.Open;

  DataModule1.zqryCategorias.First;
  while not DataModule1.zqryCategorias.EOF do
        begin
          dbComboBCat.Items.AddObject(DataModule1.zqryCategorias.FieldByName('ds_categoria_produto').AsString,
          TObject(DataModule1.zqryCategorias.FieldByName('categoriaprodutoid').AsInteger));
          DataModule1.zqryCategorias.Next;
        end;
end;

procedure TCadProdutosF.Label3Click(Sender: TObject);
begin

end;

procedure TCadProdutosF.Label4Click(Sender: TObject);
begin

end;

procedure TCadProdutosF.Label5Click(Sender: TObject);
begin

end;

procedure TCadProdutosF.tbCadastroHide(Sender: TObject);
begin
  if dsProdutos.State in [dsEdit, dsInsert] then
     begin
        if ( MessageDlg ('As alterações sendo feitas poderão ser perdidas. Deseja realmente trocar de aba?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
        DataModule1.zqryProdutos.Cancel;
        PageControl1.ActivePage := tbPesquisa;
        dbedtProd.Enabled := false;
        dbComboBCat.Enabled := false;
        dbedtObs.Enabled := false;
        dbedtVal.Enabled := false;
        dbradio.Enabled := false;
     end
     else
         begin
              PageControl1.ActivePage := tbCadastro;
              dbedtProd.Enabled := true;
              dbComboBCat.Enabled := true;
              dbedtObs.Enabled := true;
              dbedtVal.Enabled := true;
              dbradio.Enabled := true;
         end;
     end;
end;

end.

