unit uOrcamentos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBGrids, ComCtrls, Buttons;

type

  { TOrcamentosF }

  TOrcamentosF = class(TForm)
    btnClose: TBitBtn;
    btnClose1: TBitBtn;
    btnClose2: TBitBtn;
    btnNew: TBitBtn;
    btnNew1: TBitBtn;
    btnNew2: TBitBtn;
    dbGridItens: TDBGrid;
    dsOrcamentos: TDataSource;
    dbGridOrcs: TDBGrid;
    logo: TImage;
    PageControl1: TPageControl;
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
    procedure dbGridOrcsDblClick(Sender: TObject);
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

procedure TOrcamentosF.dbGridOrcsDblClick(Sender: TObject);
begin
  PageControl1.ActivePage := tbVisuItem;
end;

end.

