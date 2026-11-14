unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, ExtCtrls,
  Buttons, Edit; // подключили модуль редактора контактов

type
  // Запись для хранения одного контакта
  Contacts = record
    Name: string[100];
    Telephon: string[20];
    Note: string[20];
  end;

  { TfMain }

  TfMain = class(TForm)
    bAdd: TSpeedButton;
    bDel: TSpeedButton;
    bEdit: TSpeedButton;
    bSort: TSpeedButton;
    Panel1: TPanel;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SGDblClick(Sender: TObject); // двойной клик по сетке
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fMain: TfMain;
  adres: string; // путь к папке программы

implementation

{$R *.lfm}

{ TfMain }

// Инициализация программы
procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Contacts;
  f: file of Contacts;
  i: integer;
begin
  // Получаем путь к программе
  adres := ExtractFilePath(ParamStr(0));

  // Настройка заголовков и ширины столбцов сетки
  SG.Cells[0, 0] := 'Имя';
  SG.Cells[1, 0] := 'Телефон';
  SG.Cells[2, 0] := 'Примечание';
  SG.ColWidths[0] := 365;
  SG.ColWidths[1] := 150;
  SG.ColWidths[2] := 150;

  // Если файла с данными нет - выходим
  if not FileExists(adres + 'telephones.dat') then
    Exit;

  // Загрузка данных из файла
  try
    AssignFile(f, adres + 'telephones.dat');
    Reset(f);
    while not Eof(f) do
    begin
      Read(f, MyCont);
      SG.RowCount := SG.RowCount + 1;
      SG.Cells[0, SG.RowCount - 1] := MyCont.Name;
      SG.Cells[1, SG.RowCount - 1] := MyCont.Telephon;
      SG.Cells[2, SG.RowCount - 1] := MyCont.Note;
    end;
  finally
    CloseFile(f);
  end;
end;

// Закрытие программы – сохранение данных
procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Contacts;
  f: file of Contacts;
  i: integer;
begin
  // Если нет строк с данными (только заголовок)
  if SG.RowCount = 1 then
    Exit;

  try
    AssignFile(f, adres + 'telephones.dat');
    Rewrite(f);
    for i := 1 to SG.RowCount - 1 do
    begin
      MyCont.Name := SG.Cells[0, i];
      MyCont.Telephon := SG.Cells[1, i];
      MyCont.Note := SG.Cells[2, i];
      Write(f, MyCont);
    end;
  finally
    CloseFile(f);
  end;
end;

// Добавление контакта
procedure TfMain.bAddClick(Sender: TObject);
begin
  fEdit.eName.Text := '';
  fEdit.eTelephone.Text := '';
  fEdit.ModalResult := mrNone;
  fEdit.ShowModal;

  if (fEdit.eName.Text = '') or (fEdit.eTelephone.Text = '') then
    Exit;
  if fEdit.ModalResult <> mrOk then
    Exit;

  SG.RowCount := SG.RowCount + 1;
  SG.Cells[0, SG.RowCount - 1] := fEdit.eName.Text;
  SG.Cells[1, SG.RowCount - 1] := fEdit.eTelephone.Text;
  SG.Cells[2, SG.RowCount - 1] := fEdit.CBNote.Text;
end;

// Редактирование контакта
procedure TfMain.bEditClick(Sender: TObject);
begin
  if SG.RowCount = 1 then
    Exit;

  fEdit.eName.Text := SG.Cells[0, SG.Row];
  fEdit.eTelephone.Text := SG.Cells[1, SG.Row];
  fEdit.CBNote.Text := SG.Cells[2, SG.Row];
  fEdit.ModalResult := mrNone;
  fEdit.ShowModal;

  if fEdit.ModalResult = mrOk then
  begin
    SG.Cells[0, SG.Row] := fEdit.eName.Text;
    SG.Cells[1, SG.Row] := fEdit.eTelephone.Text;
    SG.Cells[2, SG.Row] := fEdit.CBNote.Text;
  end;
end;

// Удаление контакта
procedure TfMain.bDelClick(Sender: TObject);
begin
  if SG.RowCount = 1 then
    Exit;

  if MessageDlg('Требуется подтверждение',
    'Вы действительно хотите удалить контакт "' +
    SG.Cells[0, SG.Row] + '"?',
    mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
    SG.DeleteRow(SG.Row);
end;

// Сортировка по имени
procedure TfMain.bSortClick(Sender: TObject);
begin
  if SG.RowCount = 1 then
    Exit;
  SG.SortColRow(True, 0);
end;

// Двойной клик по сетке = редактирование
procedure TfMain.SGDblClick(Sender: TObject);
begin
  bEditClick(Sender);
end;

end.
