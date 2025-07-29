unit uOrcamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ComCtrls, Buttons, DBCtrls, DBExtCtrls, DBDateTimePicker, ZDataset,
  dm;

type

  { TOrcamentosF }

  TOrcamentosF = class(TForm)
    btnClose: TBitBtn;
    btnBack: TBitBtn;
    btnLeave: TBitBtn;
    btnNew: TBitBtn;
    btnAdd: TBitBtn;
    btnNew2: TBitBtn;
    ds_aux_produtos: TDataSource;
    DBEdit1: TDBEdit;
    dbedtTotalNewOrcIt: TDBEdit;
    dbedtQnt: TDBEdit;
    dbedtOrcItemID: TDBEdit;
    dbLUCBProd: TDBLookupComboBox;
    dsOrcItens: TDataSource;
    dbedtValidade: TDBEdit;
    dbedtTotal: TDBEdit;
    dbedtCliente: TDBEdit;
    dbedtOrcId: TDBEdit;
    dbGridItens: TDBGrid;
    dsOrcamentos: TDataSource;
    dbGridOrcs: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Label10: TLabel;
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
    panelTableNew: TPanel;
    panelHeaderNewOrc: TPanel;
    panelBackground1: TPanel;
    panelBackground2: TPanel;
    panelFooterItens: TPanel;
    panelFooterNew: TPanel;
    panelTable: TPanel;
    panelBackground: TPanel;
    panelFooter: TPanel;
    panelHeader: TPanel;
    panelTableItens: TPanel;
    TextHeader: TStaticText;
    tbVisuItem: TTabSheet;
    tbOrcs: TTabSheet;
    tbNovoOrc: TTabSheet;
    procedure btnBackClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnLeaveClick(Sender: TObject);
    procedure btnNew2Click(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure dbedtClienteChange(Sender: TObject);
    procedure dbedtQntEditingDone(Sender: TObject);
    procedure dbedtQntKeyPress(Sender: TObject; var Key: char);
    procedure dbedtTotalNewOrcItChange(Sender: TObject);
    procedure dbGridOrcsDblClick(Sender: TObject);
    procedure dbLUCBProdChange(Sender: TObject);
    procedure dbLUCBProdCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private

  public

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

procedure TOrcamentosF.btnBackClick(Sender: TObject);
begin
  DataModule1.zqryOrcamento_Itens.Cancel;
  PageControl1.ActivePage := tbVisuItem;
end;

procedure TOrcamentosF.btnAddClick(Sender: TObject);
begin
  DataModule1.zqryOrcamento_Itens.Post;
  PageControl1.ActivePage := tbVisuItem;
end;

procedure TOrcamentosF.btnLeaveClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbOrcs;
end;

procedure TOrcamentosF.btnNew2Click(Sender: TObject);
begin
  DataModule1.zqryOrcamento_Itens.Insert;
  PageControl1.ActivePage := tbNovoOrc;
end;

procedure TOrcamentosF.btnNewClick(Sender: TObject);
begin
  DataModule1.qryGenerica.Close;
  DataModule1.qryGenerica.UpdateObject := DataModule1.updtOrcamentos;
  DataModule1.qryGenerica.SQL.Clear;
  DataModule1.qryGenerica.SQL.Add('select nextval( ' +QuotedStr('orcamento_idtemp') +') as orc_aux');
  DataModule1.qryGenerica.Open;

  DataModule1.zqryOrcamento_Itens.Close;
  DataModule1.zqryOrcamento_Itens.SQL.Clear;
  DataModule1.zqryOrcamento_Itens.SQL.Add('SELECT '+
                                          'orcamentoitemid, '+
                                          'orc_it.produtoid, '+
                                          'ds_produto, '+
                                          'ds_categoria_produto, '+
                                          'qt_produto, '+
                                          'vl_venda_produto, '+
                                          'vl_total, '+
                                          'vl_unitario '+
                                          'FROM orcamento_item orc_it '+
                                          'JOIN produto p '+
                                          'ON orc_it.produtoid = p.produtoid '+
                                          'JOIN categoria_produto c '+
                                          'ON p.categoriaprodutoid = c.categoriaprodutoid '+
                                          'WHERE orcamentoid = :orc_id');
  DataModule1.zqryOrcamento_Itens.ParamByName('orc_id').AsInteger := DataModule1.qryGenerica.FieldByName('orc_aux').AsInteger;
  DataModule1.zqryOrcamento_Itens.Open;
  PageControl1.ActivePage := tbVisuItem;
  DataModule1.zqryOrcamento_Itens.Insert;
end;

procedure TOrcamentosF.dbedtClienteChange(Sender: TObject);
begin

end;

procedure TOrcamentosF.dbedtQntEditingDone(Sender: TObject);
begin
  if DataModule1.zqryOrcamento_Itensqt_produto.AsString <> '' then
     begin
       DataModule1.zqryOrcamento_Itensvl_total.AsString := FloatToStr((DataModule1.zqryOrcamento_Itensvl_venda_produto.AsFloat)*(DataModule1.zqryOrcamento_Itensqt_produto.AsInteger));
     end;
end;

procedure TOrcamentosF.dbedtQntKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', ',', '.', #8]) then
     Key := #0;
end;

procedure TOrcamentosF.dbedtTotalNewOrcItChange(Sender: TObject);
var
  tmp: double;
begin
  tmp := 0;
  tmp := DataModule1.zqryOrcamentosvl_total_orcamento.AsFloat;
  DataModule1.zqryOrcamentosvl_total_orcamento.AsFloat := tmp + DataModule1.zqryOrcamento_Itensvl_total.AsFloat;
end;

procedure TOrcamentosF.dbGridOrcsDblClick(Sender: TObject);
begin
  DataModule1.zqryOrcamento_Itens.Close;
  DataModule1.zqryOrcamento_Itens.SQL.Clear;
  DataModule1.zqryOrcamento_Itens.SQL.Add('SELECT '+
                                          'orcamentoitemid, '+
                                          'orc_it.produtoid, '+
                                          'ds_produto, '+
                                          'ds_categoria_produto, '+
                                          'qt_produto, '+
                                          'vl_venda_produto, '+
                                          'vl_total, '+
                                          'vl_unitario '+
                                          'FROM orcamento_item orc_it '+
                                          'JOIN produto p '+
                                          'ON orc_it.produtoid = p.produtoid '+
                                          'JOIN categoria_produto c '+
                                          'ON p.categoriaprodutoid = c.categoriaprodutoid '+
                                          'WHERE orcamentoid = :orc_id');
  DataModule1.zqryOrcamento_Itens.ParamByName('orc_id').AsInteger := DataModule1.zqryOrcamentos.FieldByName('orcamentoid').AsInteger;
  DataModule1.zqryOrcamento_Itens.Open;
  PageControl1.ActivePage := tbVisuItem;
end;

procedure TOrcamentosF.dbLUCBProdChange(Sender: TObject);
begin

end;

procedure TOrcamentosF.dbLUCBProdCloseUp(Sender: TObject);
begin
    DataModule1.zqryOrcamento_Itensvl_unitario.AsFloat := DataModule1.zqryOrcamento_Itensvl_venda_produto.AsFloat;

end;

procedure TOrcamentosF.FormShow(Sender: TObject);
begin

end;

procedure TOrcamentosF.Label3Click(Sender: TObject);
begin

end;

procedure TOrcamentosF.Label7Click(Sender: TObject);
begin

end;

end.

