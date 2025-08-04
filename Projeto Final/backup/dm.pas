unit dm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, ZAbstractRODataset, ZSqlUpdate, DB;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    ZConnection1: TZConnection;
    zqryCategorias: TZQuery;
    zqryCategoriascategoriaprodutoid: TZIntegerField;
    zqryCategoriasdescricao: TZRawStringField;
    zqryCategoriasds_categoria_produto: TZRawStringField;
    updtCategorias: TZUpdateSQL;
    zqryClientesclienteid: TZIntegerField;
    zqryClientescpf_cnpj_cliente: TZRawStringField;
    zqryClientesemail_cliente: TZRawStringField;
    zqryClientesnome_cliente: TZRawStringField;
    zqryClientestelefone_cliente: TZRawStringField;
    zqryClientestipo_cliente: TZRawStringField;
    zqryOrcamentosclienteid: TZIntegerField;
    zqryOrcamentosdt_orcamento: TZDateTimeField;
    zqryOrcamentosdt_validade_orcamento: TZDateTimeField;
    zqryOrcamentosnome_cliente: TZRawStringField;
    zqryOrcamentosorcamentoid: TZIntegerField;
    zqryOrcamentosvl_total_orcamento: TZBCDField;
    zqryOrcamento_Itensds_categoria_produto: TZRawStringField;
    zqryOrcamento_Itensds_produto: TZRawStringField;
    zqryOrcamento_Itensorcamentoid: TZBCDField;
    zqryOrcamento_Itensorcamentoitemid: TZIntegerField;
    zqryOrcamento_Itensprodutoid: TZIntegerField;
    zqryOrcamento_Itensqt_produto: TZBCDField;
    zqryOrcamento_Itensvl_total: TZBCDField;
    zqryOrcamento_Itensvl_unitario: TZBCDField;
    zqryOrcamento_Itensvl_venda_produto: TZBCDField;
    zqryProdutoscategoriaprodutoid: TZIntegerField;
    zqryProdutosds_categoria_produto: TZRawStringField;
    zqryProdutosds_produto: TZRawStringField;
    zqryProdutosdt_cadastro_produto: TZDateTimeField;
    zqryProdutosobs_produto: TZRawStringField;
    zqryProdutosprodutoid: TZIntegerField;
    zqryProdutosstatus_produto: TZRawStringField;
    zqryProdutosvl_venda_produto: TZBCDField;
    zqryUsuarios: TZQuery;
    updtUsuarios: TZUpdateSQL;
    zqryUsuariosid: TZIntegerField;
    zqryUsuariosnome_completo: TZRawStringField;
    zqryUsuariossenha: TZRawStringField;
    zqryUsuariosusuario: TZRawStringField;
    qryGenerica: TZQuery;
    zqryClientes: TZQuery;
    updtClientes: TZUpdateSQL;
    zqryProdutos: TZQuery;
    updtProdutos: TZUpdateSQL;
    zqryOrcamentos: TZQuery;
    updtOrcamentos: TZUpdateSQL;
    zqryOrcamento_Itens: TZQuery;
    updtOrcamentos_Itens: TZUpdateSQL;
    procedure DataModuleCreate(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
    procedure zqryCategoriasAfterPost(DataSet: TDataSet);
    procedure zqryClientesAfterPost(DataSet: TDataSet);
    procedure zqryOrcamentosAfterDelete(DataSet: TDataSet);
    procedure zqryOrcamentosAfterPost(DataSet: TDataSet);
    procedure zqryProdutosAfterPost(DataSet: TDataSet);
    procedure zqryUsuariosAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.ZConnection1AfterConnect(Sender: TObject);
begin

end;

procedure TDataModule1.zqryCategoriasAfterPost(DataSet: TDataSet);
begin
  zqryCategorias.Close;
  zqryCategorias.SQL.Clear;
  zqryCategorias.SQL.Add('SELECT '+
                         '* '+
                         'FROM '+
                         'categoria_produto '+
                         'ORDER BY categoriaprodutoid ASC');
  zqryCategorias.Open;
end;

procedure TDataModule1.zqryClientesAfterPost(DataSet: TDataSet);
begin
  zqryClientes.Close;
  zqryClientes.SQL.Clear;
  zqryClientes.SQL.Add('SELECT '+
                       '* '+
                       'FROM '+
                       'cliente '+
                       'ORDER BY clienteid ASC');
  zqryClientes.Open;
end;

procedure TDataModule1.zqryOrcamentosAfterDelete(DataSet: TDataSet);
begin
  zqryOrcamentos.Close;
  zqryOrcamentos.SQL.Clear;
  zqryOrcamentos.SQL.Add('select orcamentoid, '+
                         'nome_cliente, '+
                         'orc.clienteid, '+
                         'dt_orcamento, '+
                         'dt_validade_orcamento, '+
                         'vl_total_orcamento '+
                         'from orcamento orc '+
                         'left join cliente cli '+
                         'on orc.clienteid = cli.clienteid;');
  zqryOrcamentos.Open;
end;

procedure TDataModule1.zqryOrcamentosAfterPost(DataSet: TDataSet);
begin
  zqryOrcamentos.Close;
  zqryOrcamentos.SQL.Clear;
  zqryOrcamentos.SQL.Add('select orcamentoid, '+
                         'nome_cliente, '+
                         'orc.clienteid, '+
                         'dt_orcamento, '+
                         'dt_validade_orcamento, '+
                         'vl_total_orcamento '+
                         'from orcamento orc '+
                         'left join cliente cli '+
                         'on orc.clienteid = cli.clienteid;');
  zqryOrcamentos.Open;
end;
end;

procedure TDataModule1.zqryProdutosAfterPost(DataSet: TDataSet);
begin
  zqryProdutos.Close;
  zqryProdutos.SQL.Clear;
  zqryProdutos.SQL.Add('SELECT '+
                       '* '+
                       'FROM '+
                       'produto '+
                       'ORDER BY produtoid ASC');
  zqryProdutos.Open;
end;

procedure TDataModule1.zqryUsuariosAfterPost(DataSet: TDataSet);
begin
  zqryUsuarios.Close;
  zqryUsuarios.SQL.Clear;
  zqryUsuarios.SQL.Add('SELECT '+
                       '* '+
                       'FROM '+
                       'usuarios '+
                       'ORDER BY id ASC');
  zqryUsuarios.Open;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  ZConnection1.HostName := 'localhost';
  ZConnection1.DataBase := 'postgres';
  ZConnection1.User     := 'postgres';
  ZConnection1.Password := '12345';
  ZConnection1.Port     := 5432;
  ZConnection1.Protocol  := 'postgresql';
  ZConnection1.Connected := True;
end;

end.

