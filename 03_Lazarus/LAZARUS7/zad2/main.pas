unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TfMain }

  TfMain = class(TForm)
    btnCreate: TButton;
    btnRead: TButton;
    ListBox1: TListBox;
    procedure btnCreateClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFileName: string;
  public
    { public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.FormCreate(Sender: TObject);
begin
  Caption := 'Типизированный файл';
  Width := 300;
  Height := 300;
  Position := poDesktopCenter;
  BorderStyle := bsDialog;

  FFileName := 'mytypefile.dat';

  btnCreate.Caption := 'Сформировать файл';
  btnRead.Caption := 'Читать из файла';

  ListBox1.Clear;

  Randomize;  // инициализация генератора случайных чисел
end;

// Формирование файла с 10 случайными числами
procedure TfMain.btnCreateClick(Sender: TObject);
var
  f: File of integer;
  i: integer;
begin
  AssignFile(f, FFileName);

  try
    Rewrite(f);

    for i := 1 to 10 do
      Write(f, Random(1001));  // числа от 0 до 1000

    ShowMessage('Файл сформирован! Записано 10 случайных чисел.');
  finally
    CloseFile(f);
  end;
end;

// Чтение чисел из файла
procedure TfMain.btnReadClick(Sender: TObject);
var
  f: File of integer;
  k: integer;
begin
  if not FileExists(FFileName) then
  begin
    ShowMessage('Файл не найден. Сначала сформируйте файл кнопкой "Сформировать файл"');
    Exit;
  end;

  ListBox1.Clear;
  AssignFile(f, FFileName);

  try
    Reset(f);

    while not Eof(f) do
    begin
      Read(f, k);
      ListBox1.Items.Add(IntToStr(k));
    end;

    ShowMessage(Format('Прочитано %d чисел', [ListBox1.Count]));
  finally
    CloseFile(f);
  end;
end;

end.
