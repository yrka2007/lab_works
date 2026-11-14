unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, c, P: integer;
  alfa, beta, gamma, S, r: real;
begin
  // Проверка на пустые поля
  if (Edit1.Text = '') or (Edit2.Text = '') or (Edit3.Text = '') then
  begin
    ShowMessage('Заполните все поля a, b, c!');
    Exit;
  end;

  // Ввод данных
  try
    a := StrToInt(Edit1.Text);
    b := StrToInt(Edit2.Text);
    c := StrToInt(Edit3.Text);
  except
    ShowMessage('Введите целые числа для сторон треугольника!');
    Exit;
  end;

  // Проверка на положительные стороны
  if (a <= 0) or (b <= 0) or (c <= 0) then
  begin
    ShowMessage('Стороны треугольника должны быть положительными числами!');
    Exit;
  end;

  // Проверка существования треугольника
  if (a + b <= c) or (a + c <= b) or (b + c <= a) then
  begin
    ShowMessage('Треугольник с такими сторонами не существует!');
    Exit;
  end;

  // Периметр
  P := a + b + c;

  // Полупериметр
  r := P / 2;

  // Площадь по формуле Герона
  S := sqrt(r * (r - a) * (r - b) * (r - c));

  // Угол α (против стороны a) по теореме косинусов
  alfa := arccos((sqr(b) + sqr(c) - sqr(a)) / (2 * b * c));

  // Угол β (против стороны b) по теореме косинусов
  beta := arccos((sqr(a) + sqr(c) - sqr(b)) / (2 * a * c));

  // Угол γ (через сумму углов треугольника)
  gamma := Pi - (alfa + beta);

  // Перевод радиан в градусы
  alfa := alfa * 180 / Pi;
  beta := beta * 180 / Pi;
  gamma := gamma * 180 / Pi;

  // Вывод результатов
  Label6.Caption := 'alfa=' + FloatToStrF(alfa, ffFixed, 6, 2) + '°';
  Label7.Caption := 'betta=' + FloatToStrF(beta, ffFixed, 6, 2) + '°';
  Label8.Caption := 'gamma=' + FloatToStrF(gamma, ffFixed, 6, 2) + '°';
  Edit4.Text := IntToStr(P);
  Edit5.Text := FloatToStrF(S, ffFixed, 10, 3);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit1.SetFocus;
  Label6.Caption := 'alfa=';
  Label7.Caption := 'betta=';
  Label8.Caption := 'gamma=';
end;

end.
