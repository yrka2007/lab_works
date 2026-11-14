unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    ButtonCalc: TButton;
    ButtonClear: TButton;
    Edit_a: TEdit;
    Edit_b: TEdit;
    Edit_t: TEdit;
    EditResult: TEdit;
    Label1: TLabel;
    Label_a: TLabel;
    Label_b: TLabel;
    Label_t: TLabel;
    LabelResult: TLabel;
    procedure ButtonCalcClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
  private
    function CalculateFunction(a, b, t: Double): Double;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function TForm1.CalculateFunction(a, b, t: Double): Double;
begin
  // f = e^(-b*t) * sin(a*t + b) - sqrt(|b*t + a|)
  Result := Exp(-b * t) * Sin(a * t + b) - Sqrt(Abs(b * t + a));
end;

procedure TForm1.ButtonCalcClick(Sender: TObject);
var
  a, b, t, f: Double;
  errorCode: Integer;
begin
  // Проверка на пустые поля
  if (Edit_a.Text = '') or (Edit_b.Text = '') or (Edit_t.Text = '') then
  begin
    ShowMessage('Заполните все поля (a, b, t)!');
    Exit;
  end;

  // Ввод a
  Val(Edit_a.Text, a, errorCode);
  if errorCode <> 0 then
  begin
    ShowMessage('Ошибка! Введите корректное значение a');
    Edit_a.SetFocus;
    Exit;
  end;

  // Ввод b
  Val(Edit_b.Text, b, errorCode);
  if errorCode <> 0 then
  begin
    ShowMessage('Ошибка! Введите корректное значение b');
    Edit_b.SetFocus;
    Exit;
  end;

  // Ввод t
  Val(Edit_t.Text, t, errorCode);
  if errorCode <> 0 then
  begin
    ShowMessage('Ошибка! Введите корректное значение t');
    Edit_t.SetFocus;
    Exit;
  end;

  // Вычисление функции
  f := CalculateFunction(a, b, t);

  // Вывод результата
  EditResult.Text := FloatToStrF(f, ffFixed, 15, 6);
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  Edit_a.Clear;
  Edit_b.Clear;
  Edit_t.Clear;
  EditResult.Clear;
  Edit_a.SetFocus;
end;

end.
