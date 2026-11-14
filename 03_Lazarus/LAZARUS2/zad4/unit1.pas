unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type
  TForm2 = class(TForm)
    ButtonCalc: TButton;
    ButtonClear: TButton;
    Edit_c: TEdit;
    Edit_alpha: TEdit;
    Edit_a: TEdit;
    Edit_S: TEdit;
    Label1: TLabel;
    Label_c: TLabel;
    Label_alpha: TLabel;
    Label_a: TLabel;
    Label_S: TLabel;
    procedure ButtonCalcClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
  private
    function DegreesToRadians(deg: Double): Double;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

function TForm2.DegreesToRadians(deg: Double): Double;
begin
  Result := deg * Pi / 180;
end;

procedure TForm2.ButtonCalcClick(Sender: TObject);
var
  c, alpha_deg, alpha_rad, a, S, h: Double;
  errorCode: Integer;
begin
  // Проверка на пустые поля
  if (Edit_c.Text = '') or (Edit_alpha.Text = '') then
  begin
    ShowMessage('Заполните все поля (c и α)!');
    Exit;
  end;

  // Ввод основания c
  Val(Edit_c.Text, c, errorCode);
  if (errorCode <> 0) or (c <= 0) then
  begin
    ShowMessage('Ошибка! Введите положительное число для основания c');
    Edit_c.SetFocus;
    Exit;
  end;

  // Ввод угла α (в градусах)
  Val(Edit_alpha.Text, alpha_deg, errorCode);
  if (errorCode <> 0) or (alpha_deg <= 0) or (alpha_deg >= 90) then
  begin
    ShowMessage('Ошибка! Угол α должен быть в диапазоне (0, 90) градусов');
    Edit_alpha.SetFocus;
    Exit;
  end;

  // Перевод угла в радианы
  alpha_rad := DegreesToRadians(alpha_deg);

  // Вычисление боковой стороны a
  // a = (c/2) / cos(α)
  a := (c / 2) / Cos(alpha_rad);

  // Вычисление высоты h
  // h = a * sin(α)
  h := a * Sin(alpha_rad);

  // Вычисление площади S = (c * h) / 2
  S := (c * h) / 2;

  // Вывод результатов
  Edit_a.Text := FloatToStrF(a, ffFixed, 10, 3);
  Edit_S.Text := FloatToStrF(S, ffFixed, 10, 3);
end;

procedure TForm2.ButtonClearClick(Sender: TObject);
begin
  Edit_c.Clear;
  Edit_alpha.Clear;
  Edit_a.Clear;
  Edit_S.Clear;
  Edit_c.SetFocus;
end;

end.
