unit uxcadmodelo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  DBGrids, StdCtrls, Buttons;

type

  { TXCadModelo }

  TXCadModelo = class(TForm)
    btnCancel: TBitBtn;
    btnDel: TBitBtn;
    btnEdit: TBitBtn;
    btnNew: TBitBtn;
    btnClose: TBitBtn;
    btnRec: TBitBtn;
    DBGridModel: TDBGrid;
    edtSearch: TEdit;
    LabelSearch: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    panelCRUD: TPanel;
    panelSearch: TPanel;
    panelBtns: TPanel;
    tbCadastro: TTabSheet;
    tbPesquisa: TTabSheet;
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnRecClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure panelBtnsClick(Sender: TObject);
  private

  public

  end;

var
  XCadModelo: TXCadModelo;

implementation

{$R *.lfm}

{ TXCadModelo }

procedure TXCadModelo.panelBtnsClick(Sender: TObject);
begin

end;

procedure TXCadModelo.btnNewClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbCadastro;
end;

procedure TXCadModelo.btnRecClick(Sender: TObject);
begin

end;

procedure TXCadModelo.edtSearchChange(Sender: TObject);
begin

end;

procedure TXCadModelo.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

