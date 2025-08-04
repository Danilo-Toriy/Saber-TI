unit uEscolheProduto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, ZDataset,
  ZAbstractRODataset;

type

  { TEscolheProdutos }

  TEscolheProdutos = class(TForm)
    dsProdutosEscolha: TDataSource;
    DBGrid1: TDBGrid;
    zqryChoose: TZQuery;
    zqryChooseds_categoria_produto: TZRawStringField;
    zqryChooseds_produto: TZRawStringField;
    zqryChooseprodutoid: TZIntegerField;
    zqryChoosevl_venda_produto: TZBCDField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  EscolheProdutos: TEscolheProdutos;

implementation

{$R *.lfm}

uses uOrcamentos;
{ TEscolheProdutos }

procedure TEscolheProdutos.DBGrid1DblClick(Sender: TObject);
begin
  OrcamentosF.edtProd.Text := zqryChooseds_produto.AsString;
  OrcamentosF.edtPrice.Text := FloatToStr(zqryChoosevl_venda_produto.AsFloat);

  OrcamentosF.edtQuant.Text := '';
  OrcamentosF.edtTotalItem.Text := '';

  OrcamentosF.Id_Cadastro := zqryChooseprodutoid.AsInteger;

  Close;
end;

procedure TEscolheProdutos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  zqryChoose.Close;
end;

procedure TEscolheProdutos.FormCreate(Sender: TObject);
begin
  zqryChoose.Open;
end;

end.

