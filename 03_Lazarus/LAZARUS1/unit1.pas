unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_a: TEdit;
    Edit_b: TEdit;
    Edit_h: TEdit;
    ButtonCalc: TButton;
    ButtonClear: TButton;
    StringGrid1: TStringGrid;
    procedure ButtonCalcClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    // Удаляем неиспользуемое объявление FillGrid
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Настройка заголовка формы
  Caption := 'Вычисление функции y = x^2';

  // Настройка таблицы
  StringGrid1.ColCount := 2;
  StringGrid1.RowCount := 2;
  StringGrid1.Cells[0, 0] := 'x';
  StringGrid1.Cells[1, 0] := 'y = x^2';
  StringGrid1.Width := 300;
  StringGrid1.Height := 400;

  // Очистка полей ввода
  Edit_a.Clear;
  Edit_b.Clear;
  Edit_h.Clear;
end;

procedure TForm1.ButtonCalcClick(Sender: TObject);
var
  a, b, h, x, y: Double;
  RowIndex: Integer;
begin
  // Проверка на пустые поля
  if (Edit_a.Text = '') or (Edit_b.Text = '') or (Edit_h.Text = '') then
  begin
    ShowMessage('Заполните все поля (a, b, h)!');
    Exit;
  end;

  // Ввод данных
  try
    a := StrToFloat(Edit_a.Text);
    b := StrToFloat(Edit_b.Text);
    h := StrToFloat(Edit_h.Text);
  except
    ShowMessage('Ошибка! Введите корректные числа.');
    Exit;
  end;

  // Проверка шага
  if h <= 0 then
  begin
    ShowMessage('Ошибка! Шаг h должен быть больше 0.');
    Exit;
  end;

  // Проверка отрезка
  if a > b then
  begin
    ShowMessage('Ошибка! Начало отрезка a должно быть меньше конца отрезка b.');
    Exit;
  end;

  // Очистка таблицы (оставляем только заголовки)
  StringGrid1.RowCount := 2;
  StringGrid1.Cells[0, 1] := '';
  StringGrid1.Cells[1, 1] := '';

  // Вычисление и заполнение таблицы
  RowIndex := 1;
  x := a;

  while x <= b + 0.0000001 do  // Добавляем небольшую погрешность для учета последнего значения
  begin
    y := x * x;  // y = x^2

    // Добавляем новую строку при необходимости
    if RowIndex >= StringGrid1.RowCount then
      StringGrid1.RowCount := StringGrid1.RowCount + 1;

    // Записываем значения
    StringGrid1.Cells[0, RowIndex] := FormatFloat('0.0000', x);
    StringGrid1.Cells[1, RowIndex] := FormatFloat('0.0000', y);

    RowIndex := RowIndex + 1;
    x := x + h;
  end;

  // Удаляем последнюю пустую строку, если она есть
  if (StringGrid1.RowCount > 2) and (StringGrid1.Cells[0, RowIndex-1] = '') then
    StringGrid1.RowCount := StringGrid1.RowCount - 1;

  // Показываем количество точек
  ShowMessage('Вычислено ' + IntToStr(StringGrid1.RowCount - 1) + ' точек.');
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  // Очистка полей ввода
  Edit_a.Clear;
  Edit_b.Clear;
  Edit_h.Clear;

  // Очистка таблицы (оставляем только заголовки)
  StringGrid1.RowCount := 2;
  StringGrid1.Cells[0, 1] := '';
  StringGrid1.Cells[1, 1] := '';

  // Устанавливаем фокус на первое поле
  Edit_a.SetFocus;
end;

end.
