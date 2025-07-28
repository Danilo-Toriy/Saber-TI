unit uOrcamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ComCtrls, Buttons, DBCtrls, ZDataset, dm;

type

  { TOrcamentosF }

  TOrcamentosF = class(TForm)
    btnClose: TBitBtn;
    btnClose1: TBitBtn;
    btnClose2: TBitBtn;
    btnNew: TBitBtn;
    btnNew1: TBitBtn;
    btnNew2: TBitBtn;
    DBEdit1: TDBEdit;
    dbedtTotalNewOrc: TDBEdit;
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
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure dbedtClienteChange(Sender: TObject);
    procedure dbGridOrcsDblClick(Sender: TObject);
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

procedure TOrcamentosF.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbNovoOrc;
end;

procedure TOrcamentosF.dbedtClienteChange(Sender: TObject);
begin

end;

procedure TOrcamentosF.dbGridOrcsDblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbVisuItem;
end;

procedure TOrcamentosF.FormShow(Sender: TObject);
begin
    DataModule1.zqryProdutos.Close;
    DataModule1.zqryProdutos.SQL.Clear;
    DataModule1.zqryProdutos.SQL.Add('SELECT '+
                                     'produtoid, '+
                                     'ds_produto '+
                                     'FROM produto');
    DataModule1.zqryProdutos.Open;
    DataModule1.zqryOrcamento_Itens.Open;

end;

procedure TOrcamentosF.Label3Click(Sender: TObject);
begin

end;

procedure TOrcamentosF.Label7Click(Sender: TObject);
begin

end;

end.

