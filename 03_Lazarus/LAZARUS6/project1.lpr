program telephones;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // этот модуль содержит LCL виджеты
  Forms, Main, Edit
  { вы можете добавить другие модули здесь };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfEdit, fEdit);
  Application.Run;
end.
