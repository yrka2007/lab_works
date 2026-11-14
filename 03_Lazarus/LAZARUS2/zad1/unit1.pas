unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CalculateFunction(x: Double): Double;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function TForm1.CalculateFunction(x: Double): Double;
begin
  Result := 1 / (Power(x + 1, 2) + 2) + Power(x, 5) - Sqrt(x);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  x, f: Double;
  errorCode: Integer;
begin
  // Проверка ввода
  Val(Edit1.Text, x, errorCode);

  if errorCode <> 0 then
  begin
    ShowMessage('Ошибка! Введите корректное числовое значение x');
    Edit1.Clear;
    Edit2.Clear;
    Edit1.SetFocus;
    Exit;
  end;

  // Проверка на x >= 0 (из-за квадратного корня)
  if x < 0 then
  begin
    ShowMessage('Ошибка! x должен быть >= 0 (из-за квадратного корня)');
    Edit1.Clear;
    Edit2.Clear;
    Edit1.SetFocus;
    Exit;
  end;

  // Вычисление функции
  f := CalculateFunction(x);

  // Вывод результата
  Edit2.Text := FloatToStrF(f, ffFixed, 15, 6);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.
