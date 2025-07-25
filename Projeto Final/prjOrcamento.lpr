program prjOrcamento;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMenu, dm, zcomponent, uxcadmodelo, uCadCategorias, ucadusuarios,
  uCadCliente, uCadProdutos, uOrcamentos;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TOrcamentosF, OrcamentosF);
  Application.CreateForm(TMenu, Menu);
  Application.Run;
end.

