unit uMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, uCadCategorias, uCadUsuarios;

type

  { TMenu }

  TMenu = class(TForm)
    MainMenu1: TMainMenu;
    MenuCad: TMenuItem;
    CadCategoria: TMenuItem;
    CadClient: TMenuItem;
    CadProd: TMenuItem;
    CadUser: TMenuItem;
    ReportExport: TMenuItem;
    ReportPrint: TMenuItem;
    ReportCreate: TMenuItem;
    Orcamento: TMenuItem;
    MenuSales: TMenuItem;
    MenuReport: TMenuItem;
    MenuAbout: TMenuItem;
    MenuExit: TMenuItem;
    procedure CadCategoriaClick(Sender: TObject);
    procedure CadClientClick(Sender: TObject);
    procedure CadUserClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure OrcamentoClick(Sender: TObject);
  private

  public

  end;

var
  Menu: TMenu;

implementation

{$R *.lfm}

{ TMenu }

procedure TMenu.MenuExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMenu.OrcamentoClick(Sender: TObject);
begin

end;

procedure TMenu.CadCategoriaClick(Sender: TObject);
begin
  CadCategoriasF := TCadCategoriasF.Create(Self);
  CadCategoriasF.ShowModal;
end;

procedure TMenu.CadClientClick(Sender: TObject);
begin

end;

procedure TMenu.CadUserClick(Sender: TObject);
begin
  CadUsuariosF := TCadUsuariosF.Create(Self);
  CadUsuariosF.ShowModal;
end;

end.

