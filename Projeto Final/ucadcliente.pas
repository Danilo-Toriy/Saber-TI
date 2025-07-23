unit uCadCliente;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  StdCtrls, uxcadmodelo, DB;

type

  { TCadClienteF }

  TCadClienteF = class(TXCadModelo)
    dbComboBType: TDBComboBox;
    dbedtClient: TDBEdit;
    dbedtCPF: TDBEdit;
    dbedtClientID: TDBEdit;
    dsClientes: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelCPF: TLabel;
    Panel3: TPanel;
    panelDiv: TPanel;
    procedure dbComboBTypeChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure Label3Click(Sender: TObject);
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

procedure TCadClienteF.dbComboBTypeChange(Sender: TObject);
begin
    if (dbComboBType.ItemIndex = 0) OR (dbComboBType.ItemIndex = 3) then
       begin
          LabelCPF.Caption := 'CNPJ:';
          dbedtCPF.Enabled := true;
       end
       else
           begin
             LabelCPF.Caption := 'CPF:';
             dbedtCPF.Enabled := true;
           end;
end;

procedure TCadClienteF.Label3Click(Sender: TObject);
begin

end;

end.

