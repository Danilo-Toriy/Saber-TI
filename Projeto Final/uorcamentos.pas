unit uOrcamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ComCtrls, Buttons, DBCtrls, ZDataset, dm, DateUtils, uEscolheProduto;

type

  { TOrcamentosF }

  TOrcamentosF = class(TForm)
    btnDeleteOrc: TBitBtn;
    btnDelete: TBitBtn;
    btnPopUpProds: TBitBtn;
    btnSaveandAdd: TBitBtn;
    btnClose: TBitBtn;
    btnBack: TBitBtn;
    btnClose2: TBitBtn;
    btnCancelNewOrc: TBitBtn;
    btnNew: TBitBtn;
    btnSaveItem: TBitBtn;
    btnAddItem: TBitBtn;
    btnSaveNewOrc: TBitBtn;
    cbValidade: TComboBox;
    dbcbClienteNovoOrc: TDBComboBox;
    dbedtIDOrc: TDBEdit;
    dbedtOrcItemID: TDBEdit;
    dsOrcItens: TDataSource;
    dbGridItens: TDBGrid;
    dsOrcamentos: TDataSource;
    dbGridOrcs: TDBGrid;
    edtTotalItem: TEdit;
    edtPrice: TEdit;
    edtQuant: TEdit;
    edtProd: TEdit;
    edtHeaderValid: TEdit;
    edtHeaderTotal: TEdit;
    edtHeaderQuant: TEdit;
    edtHeaderClient: TEdit;
    edtHeaderID: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    logo: TImage;
    PageControl1: TPageControl;
    panelCadastroOrc: TPanel;
    panelBackNew: TPanel;
    panelFooter1: TPanel;
    panelFooter2: TPanel;
    panelFooter3: TPanel;
    panelTableNew: TPanel;
    panelHeaderNewOrc: TPanel;
    panelBackground1: TPanel;
    panelBackground2: TPanel;
    panelTable: TPanel;
    panelBackground: TPanel;
    panelFooter: TPanel;
    panelHeader: TPanel;
    panelTableItens: TPanel;
    tbNovoOrc: TTabSheet;
    TextHeader: TStaticText;
    tbVisuItem: TTabSheet;
    tbOrcs: TTabSheet;
    tbNovoOrcItem: TTabSheet;
    procedure btnAddItemClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCancelNewOrcClick(Sender: TObject);
    procedure btnClose2Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDeleteOrcClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnPopUpProdsClick(Sender: TObject);
    procedure btnSaveandAddClick(Sender: TObject);
    procedure btnSaveItemClick(Sender: TObject);
    procedure btnSaveNewOrcClick(Sender: TObject);
    procedure dbedtQntChange(Sender: TObject);
    procedure dbGridItensDblClick(Sender: TObject);
    procedure dbGridOrcsDblClick(Sender: TObject);
    procedure edtQuantChange(Sender: TObject);
    procedure tbNovoOrcShow(Sender: TObject);
    procedure validacaopost();
    procedure AtualizaItens(id_orcamento: integer);
    procedure AtualizaGridItens();
    function CalculaValidade(Index: integer): TDate;
  private

  public
    OrcamentoAtual: Integer;
    Id_Cadastro: Integer;
  end;

var
  OrcamentosF: TOrcamentosF;

implementation

{$R *.lfm}

{ TOrcamentosF }

procedure TOrcamentosF.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TOrcamentosF.btnDeleteClick(Sender: TObject);
begin
    if ( MessageDlg ('Deseja realmente excluir esse item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
       begin
            DataModule1.zqryOrcamento_Itens.Delete;
            AtualizaItens(OrcamentoAtual);
            PageControl1.ActivePage := tbVisuItem;
       end;
end;

procedure TOrcamentosF.btnDeleteOrcClick(Sender: TObject);
begin
    if ( MessageDlg ('Deseja realmente excluir esse orçamento?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
       begin
            DataModule1.zqryOrcamentos.Delete;
            PageControl1.ActivePage := tbOrcs;
       end;
end;

procedure TOrcamentosF.btnCancelNewOrcClick(Sender: TObject);
begin
  DataModule1.zqryOrcamentos.Cancel;
  PageControl1.ActivePage := tbOrcs;
end;

procedure TOrcamentosF.btnClose2Click(Sender: TObject);
begin
  PageControl1.ActivePage := tbOrcs;
end;

procedure TOrcamentosF.btnAddItemClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbNovoOrcItem;
  DataModule1.zqryOrcamento_Itens.Insert;

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtOrcamentos_Itens;
  DataModule1.qryGenerica.SQL.Add('select nextval('+QuotedStr('orcamento_idtemp')+') as id');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryOrcamento_Itensorcamentoitemid.AsInteger := DataModule1.qryGenerica.FieldByName('id').AsInteger;
end;

procedure TOrcamentosF.btnBackClick(Sender: TObject);
begin
  DataModule1.zqryOrcamento_Itens.Cancel;
  PageControl1.ActivePage := tbVisuItem;
end;

procedure TOrcamentosF.AtualizaGridItens();
begin
   DataModule1.zqryOrcamento_Itens.Close;
   DataModule1.zqryOrcamento_Itens.SQL.Clear;
   DataModule1.zqryOrcamento_Itens.SQL.Add('SELECT orcamentoitemid, '+
                                           'orc_it.produtoid, '+
                                           'ds_produto, '+
                                           'ds_categoria_produto, '+
                                           'qt_produto, '+
                                           'vl_venda_produto, '+
                                           'vl_total, '+
                                           'orcamentoid, '+
                                           'vl_unitario '+
                                           'FROM orcamento_item orc_it '+
                                           'JOIN produto p '+
                                           'ON orc_it.produtoid = p.produtoid '+
                                           'JOIN categoria_produto c '+
                                           'ON p.categoriaprodutoid = c.categoriaprodutoid '+
                                           'WHERE orc_it.orcamentoid = :tmp');
   DataModule1.zqryOrcamento_Itens.ParamByName('tmp').AsInteger := OrcamentoAtual;
   DataModule1.zqryOrcamento_Itens.Open;
end;

procedure TOrcamentosF.AtualizaItens(id_orcamento: integer);
var
  total: double;
  quant: integer;
begin
    total := 0;
    quant := 0;
    DataModule1.zqryOrcamentos.Close;
    DataModule1.zqryOrcamentos.SQL.Clear;
    DataModule1.zqryOrcamentos.SQL.Add('select orcamentoid, '+
                                       'nome_cliente, '+
                                       'orc.clienteid, '+
                                       'dt_orcamento, '+
                                       'dt_validade_orcamento, '+
                                       'vl_total_orcamento '+
                                       'from orcamento orc '+
                                       'left join cliente cli '+
                                       'on orc.clienteid = cli.clienteid '+
                                       'where orcamentoid = :id');
    DataModule1.zqryOrcamentos.ParamByName('id').AsInteger := id_orcamento;
    DataModule1.zqryOrcamentos.Open;

    DataModule1.qryGenerica.Close;
    DataModule1.qryGenerica.SQL.Clear;
    DataModule1.qryGenerica.SQL.Add('SELECT COUNT(*) as total_itens '+
                                    'FROM orcamento_item '+
                                    'WHERE orcamentoid = :aux');
    DataModule1.qryGenerica.ParamByName('aux').AsInteger := id_orcamento;
    DataModule1.qryGenerica.Open;
    quant := DataModule1.qryGenerica.FieldByName('total_itens').AsInteger;

    edtHeaderQuant.Text := IntToStr(quant);
    edtHeaderID.Text := DataModule1.zqryOrcamentosclienteid.AsString;
    edtHeaderClient.Text := DataModule1.zqryOrcamentosnome_cliente.AsString;
    edtHeaderValid.Text := DataModule1.zqryOrcamentosdt_validade_orcamento.AsString;
    edtHeaderTotal.Text := DataModule1.zqryOrcamentosvl_total_orcamento.AsString;

    AtualizaGridItens();

end;

function TOrcamentosF.CalculaValidade(Index: integer): TDate;
begin
  case Index of
       0: Result := Date + 7;
       1: Result := Date + 15;
       2: Result := IncMonth(Date, 1);
       3: Result := IncMonth(Date, 3);
       4: Result := IncMonth(Date, 6);
       5: Result := IncMonth(Date, 12);
  end;
end;


procedure TOrcamentosF.validacaopost();
var
  id: integer;
begin
     if dbcbClienteNovoOrc.ItemIndex = -1 then
        begin
           Showmessage('Informe um cliente!!');
           dbcbClienteNovoOrc.SetFocus;
        end
        else
            begin
              if cbValidade.ItemIndex = -1 then
                 begin
                    Showmessage('Informe um prazo de validade!!');
                    cbValidade.SetFocus;
                 end
                 else
                     begin
                        id := Integer(dbcbClienteNovoOrc.Items.Objects[dbcbClienteNovoOrc.ItemIndex]);
                        DataModule1.zqryOrcamentosvl_total_orcamento.AsFloat := 0;
                        DataModule1.zqryOrcamentosdt_orcamento.AsDateTime := Date;
                        DataModule1.zqryOrcamentosdt_validade_orcamento.AsDateTime := CalculaValidade(cbValidade.ItemIndex);
                        DataModule1.zqryOrcamentosclienteid.AsInteger := id;
                        DataModule1.zqryOrcamentos.Post;
                     end;
            end;
end;

procedure TOrcamentosF.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbNovoOrc;
  DataModule1.zqryOrcamentos.Insert;

  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtOrcamentos ;
  DataModule1.qryGenerica.SQL.Add('select nextval('+QuotedStr('orcamento_idtemp')+') as tmp');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryOrcamentosorcamentoid.AsInteger := DataModule1.qryGenerica.FieldByName('tmp').AsInteger;
  OrcamentoAtual := DataModule1.qryGenerica.FieldByName('tmp').AsInteger;

end;

procedure TOrcamentosF.btnPopUpProdsClick(Sender: TObject);
begin
  EscolheProdutos := TEscolheProdutos.Create(Self);
  EscolheProdutos.ShowModal;
end;

procedure TOrcamentosF.btnSaveandAddClick(Sender: TObject);
begin
  validacaopost();
  AtualizaItens(OrcamentoAtual);
  PageControl1.ActivePage := tbNovoOrcItem;
end;

procedure TOrcamentosF.btnSaveItemClick(Sender: TObject);
var
  somaTotal: double;
begin
  if edtQuant.Text = '' then
     begin
        ShowMessage('Informe uma quantidade válida!!');
        edtQuant.SetFocus;
     end
     else
         begin
              DataModule1.zqryOrcamento_Itensprodutoid.AsInteger := Id_Cadastro;
              DataModule1.zqryOrcamento_Itensorcamentoid.AsInteger := OrcamentoAtual;
              DataModule1.zqryOrcamento_Itensqt_produto.AsFloat := StrToFloat(edtQuant.Text);
              DataModule1.zqryOrcamento_Itensvl_unitario.AsFloat := StrToFloat(edtPrice.Text);
              DataModule1.zqryOrcamento_Itensvl_total.AsFloat := StrToFloat(edtTotalItem.Text);
              DataModule1.zqryOrcamento_Itens.Post;

              somaTotal := 0;
              DataModule1.qryGenerica.Close;
              DataModule1.qryGenerica.SQL.Clear;
              DataModule1.qryGenerica.SQL.Add('SELECT SUM(vl_total) as soma FROM orcamento_item WHERE orcamentoid = :id');
              DataModule1.qryGenerica.ParamByName('id').AsInteger := OrcamentoAtual;
              DataModule1.qryGenerica.Open;

              somaTotal := DataModule1.qryGenerica.FieldByName('soma').AsFloat;

              // atualiza o total no cabeçalho do orçamento
              DataModule1.zqryOrcamentos.Edit;
              DataModule1.zqryOrcamentosvl_total_orcamento.AsFloat := somaTotal;
              DataModule1.zqryOrcamentos.Post;
              AtualizaItens(OrcamentoAtual);
              PageControl1.ActivePage := tbVisuItem;
         end;
end;

procedure TOrcamentosF.btnSaveNewOrcClick(Sender: TObject);
begin
  validacaopost();
  PageControl1.ActivePage := tbOrcs;
end;

procedure TOrcamentosF.dbedtQntChange(Sender: TObject);
begin

end;

procedure TOrcamentosF.dbGridItensDblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbNovoOrcItem;
  DataModule1.zqryOrcamento_Itens.Edit;
end;

procedure TOrcamentosF.dbGridOrcsDblClick(Sender: TObject);
var
  id: integer;
begin
  id := DataModule1.zqryOrcamentos.FieldByName('orcamentoid').AsInteger;
  OrcamentoAtual := id;
  AtualizaItens(OrcamentoAtual);
  PageControl1.ActivePage := tbVisuItem;
  DataModule1.zqryOrcamentos.Edit;
end;

procedure TOrcamentosF.edtQuantChange(Sender: TObject);
var
  valor: double;
begin
  if edtQuant.Text <> '' then
     begin
          valor := StrToFloat(edtPrice.Text);
          edtTotalItem.Text := FloatToStr(Valor*StrToFloat(edtQuant.Text));
     end;
end;

procedure TOrcamentosF.tbNovoOrcShow(Sender: TObject);
begin
  dbcbClienteNovoOrc.Items.Clear;
  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('SELECT '+
                                  'clienteid, '+
                                  'nome_cliente '+
                                  'FROM '+
                                  'cliente '+
                                  'ORDER BY nome_cliente');
  DataModule1.qryGenerica.Open;

  DataModule1.qryGenerica.First;
  while not DataModule1.qryGenerica.EOF do
        begin
          dbcbClienteNovoOrc.Items.AddObject(DataModule1.qryGenerica.FieldByName('nome_cliente').AsString,
          TObject(DataModule1.qryGenerica.FieldByName('clienteid').AsInteger));
          DataModule1.qryGenerica.Next;
        end;
end;

end.

