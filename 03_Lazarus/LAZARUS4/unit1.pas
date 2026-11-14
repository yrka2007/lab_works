unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    // Панель для фона
    PanelDisplay: TPanel;
    PanelButtons: TPanel;

    // Поле вывода
    edtResult: TEdit;

    // Кнопки
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnDiv: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btnMul: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btnSub: TButton;
    btn0: TButton;
    btnDecimal: TButton;
    btnEquals: TButton;
    btnAdd: TButton;
    btnClear: TButton;
    btnBackspace: TButton;
    btnReciprocal: TButton;  // 1/x

    // События
    procedure FormCreate(Sender: TObject);
    procedure btnDigitClick(Sender: TObject);
    procedure btnOperatorClick(Sender: TObject);
    procedure btnEqualsClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnBackspaceClick(Sender: TObject);
    procedure btnDecimalClick(Sender: TObject);
    procedure btnReciprocalClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
  private
    FCurrentInput: string;      // Текущее вводимое число
    FFirstNumber: Double;        // Первое число
    FOperation: char;            // Операция: '+', '-', '*', '/'
    FNewNumber: Boolean;         // Нужно ли начать новое число
    procedure UpdateDisplay;
    procedure Calculate;
    procedure ClearAll;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

// Инициализация калькулятора
procedure TForm1.FormCreate(Sender: TObject);
begin
  ClearAll;
  UpdateDisplay;

  // Настройка TabOrder
  edtResult.TabOrder := 0;

  // Установка Caption для кнопок
  btn7.Caption := '7';
  btn8.Caption := '8';
  btn9.Caption := '9';
  btnDiv.Caption := '/';
  btn4.Caption := '4';
  btn5.Caption := '5';
  btn6.Caption := '6';
  btnMul.Caption := '*';
  btn1.Caption := '1';
  btn2.Caption := '2';
  btn3.Caption := '3';
  btnSub.Caption := '-';
  btn0.Caption := '0';
  btnDecimal.Caption := '.';
  btnEquals.Caption := '=';
  btnAdd.Caption := '+';
  btnClear.Caption := 'C';
  btnBackspace.Caption := '←';
  btnReciprocal.Caption := '1/x';
end;

// Добавление цифры в конец текущего ввода
procedure TForm1.btnDigitClick(Sender: TObject);
begin
  if FNewNumber then
  begin
    FCurrentInput := '';
    FNewNumber := False;
  end;

  FCurrentInput := FCurrentInput + (Sender as TButton).Caption;
  UpdateDisplay;
end;

// Добавление десятичной точки
procedure TForm1.btnDecimalClick(Sender: TObject);
var
  Sep: string;
begin
  Sep := FormatSettings.DecimalSeparator;

  if FNewNumber then
  begin
    FCurrentInput := '0';
    FNewNumber := False;
  end;

  // Проверка: нет ли уже запятой в числе
  if Pos(Sep, FCurrentInput) = 0 then
  begin
    if FCurrentInput = '' then
      FCurrentInput := '0' + Sep
    else
      FCurrentInput := FCurrentInput + Sep;
    UpdateDisplay;
  end;
end;

// Нажатие на оператор (+, -, *, /)
procedure TForm1.btnOperatorClick(Sender: TObject);
begin
  if FCurrentInput <> '' then
  begin
    if FOperation = #0 then
      FFirstNumber := StrToFloat(FCurrentInput)
    else
      Calculate;

    FOperation := (Sender as TButton).Caption[1];
    FNewNumber := True;
  end;
end;

// Вычисление результата при нажатии "="
procedure TForm1.btnEqualsClick(Sender: TObject);
begin
  if (FOperation <> #0) and (FCurrentInput <> '') then
  begin
    Calculate;
    FOperation := #0;
    FNewNumber := True;
  end;
end;

// Основная логика вычислений
procedure TForm1.Calculate;
var
  SecondNumber: Double;
begin
  try
    SecondNumber := StrToFloat(FCurrentInput);

    case FOperation of
      '+': FFirstNumber := FFirstNumber + SecondNumber;
      '-': FFirstNumber := FFirstNumber - SecondNumber;
      '*': FFirstNumber := FFirstNumber * SecondNumber;
      '/':
        begin
          if SecondNumber = 0 then
            raise Exception.Create('Деление на ноль!');
          FFirstNumber := FFirstNumber / SecondNumber;
        end;
    end;

    FCurrentInput := FloatToStr(FFirstNumber);
    UpdateDisplay;
  except
    on E: Exception do
    begin
      ShowMessage('Ошибка: ' + E.Message);
      ClearAll;
    end;
  end;
end;

// Очистка всего (кнопка C)
procedure TForm1.btnClearClick(Sender: TObject);
begin
  ClearAll;
  UpdateDisplay;
end;

// Полная очистка состояния
procedure TForm1.ClearAll;
begin
  FCurrentInput := '0';
  FFirstNumber := 0;
  FOperation := #0;
  FNewNumber := True;
end;

// Удаление последнего символа (кнопка ←)
procedure TForm1.btnBackspaceClick(Sender: TObject);
begin
  if Length(FCurrentInput) > 1 then
    FCurrentInput := Copy(FCurrentInput, 1, Length(FCurrentInput) - 1)
  else
    FCurrentInput := '0';

  FNewNumber := False;
  UpdateDisplay;
end;

// Вычисление 1/x
procedure TForm1.btnReciprocalClick(Sender: TObject);
var
  Value: Double;
begin
  if FCurrentInput <> '' then
  begin
    try
      Value := StrToFloat(FCurrentInput);
      if Value = 0 then
        raise Exception.Create('Деление на ноль!');

      FCurrentInput := FloatToStr(1 / Value);
      FFirstNumber := StrToFloat(FCurrentInput);
      FOperation := #0;
      FNewNumber := True;
      UpdateDisplay;
    except
      on E: Exception do
      begin
        ShowMessage('Ошибка: ' + E.Message);
        ClearAll;
        UpdateDisplay;
      end;
    end;
  end;
end;

// Обновление дисплея
procedure TForm1.UpdateDisplay;
begin
  edtResult.Text := FCurrentInput;
end;

// Обработка клавиатуры
procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
var
  i: Integer;
begin
  case Key of
    '0'..'9':
      for i := 0 to ComponentCount - 1 do
        if (Components[i] is TButton) and ((Components[i] as TButton).Caption = Key) then
          btnDigitClick(Components[i]);
    '+': btnAdd.Click;
    '-': btnSub.Click;
    '*': btnMul.Click;
    '/': btnDiv.Click;
    '=': btnEquals.Click;
    #13: btnEquals.Click;  // Enter
    #8: btnBackspace.Click; // Backspace
    'c', 'C': btnClear.Click;
    '.', ',': btnDecimal.Click;
  end;
end;

end.
