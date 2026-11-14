unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TfMain }

  TfMain = class(TForm)
    btnAdd: TButton;
    btnRead: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure btnAddClick(Sender: TObject);
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
  Caption := 'Работа с текстовым файлом';
  Width := 500;
  Height := 400;
  Position := poDesktopCenter;
  BorderStyle := bsDialog;

  FFileName := 'mytext.txt';

  Edit1.Text := '';
  Edit1.Width := 400;

  btnAdd.Caption := 'Добавить в файл';
  btnRead.Caption := 'Считать из файла';

  Memo1.Clear;
  Memo1.ScrollBars := ssAutoBoth;
end;

// Добавление строки в файл
procedure TfMain.btnAddClick(Sender: TObject);
var
  tf: TextFile;
  s: string;
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('Пожалуйста, введите текст для добавления');
    Exit;
  end;

  s := Edit1.Text;
  AssignFile(tf, FFileName);

  try
    if not FileExists(FFileName) then
      Rewrite(tf)      // создаём новый файл
    else
      Append(tf);      // добавляем в конец существующего

    Writeln(tf, s);
    Edit1.Text := '';
    ShowMessage('Строка добавлена в файл');
  finally
    CloseFile(tf);
  end;
end;

// Чтение строк из файла
procedure TfMain.btnReadClick(Sender: TObject);
var
  tf: TextFile;
  s: string;
begin
  if not FileExists(FFileName) then
  begin
    ShowMessage('Файл не найден. Сначала добавьте несколько строк.');
    Exit;
  end;

  Memo1.Clear;
  AssignFile(tf, FFileName);

  try
    Reset(tf);  // открываем для чтения

    while not Eof(tf) do
    begin
      Readln(tf, s);
      Memo1.Lines.Add(s);
    end;
  finally
    CloseFile(tf);
  end;
end;

end.
