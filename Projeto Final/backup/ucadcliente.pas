unit uCadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  uxcadmodelo, DB;

type

  { TCadClienteF }

  TCadClienteF = class(TXCadModelo)
    DBComboBox1: TDBComboBox;
    dbedtCat: TDBEdit;
    dbedtDesc: TDBEdit;
    dbedtID: TDBEdit;
    dsClientes: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    panelDiv: TPanel;
    procedure edtSearchChange(Sender: TObject);
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
  inherited;
end;

end.

