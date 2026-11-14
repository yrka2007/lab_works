unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  MMSystem; // для звукового сигнала

type
  { TfMain }

  TfMain = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    lblHours: TLabel;
    lblMinutes: TLabel;
    lblSeconds: TLabel;
    lblColon1: TLabel;
    lblColon2: TLabel;
    edtHours: TEdit;
    edtMinutes: TEdit;
    edtSeconds: TEdit;
    Timer1: TTimer;
    lblStatus: TLabel;
    lblRemaining: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FTotalSeconds: integer;      // общее количество секунд для отсчёта
    FRemainingSeconds: integer;  // оставшееся количество секунд
    function GetTimeInSeconds: integer;
    procedure UpdateDisplay;
    procedure PlayBeep;
  public
    { public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

// Преобразование часов, минут, секунд в общее количество секунд
function TfMain.GetTimeInSeconds: integer;
var
  h, m, s: integer;
begin
  h := StrToIntDef(edtHours.Text, 0);
  m := StrToIntDef(edtMinutes.Text, 0);
  s := StrToIntDef(edtSeconds.Text, 0);
  Result := h * 3600 + m * 60 + s;
end;

// Обновление отображения оставшегося времени
procedure TfMain.UpdateDisplay;
var
  h, m, s: integer;
begin
  h := FRemainingSeconds div 3600;
  m := (FRemainingSeconds mod 3600) div 60;
  s := FRemainingSeconds mod 60;

  lblRemaining.Caption := Format('Осталось: %d ч %d мин %d с', [h, m, s]);
end;

// Звуковой сигнал
procedure TfMain.PlayBeep;
begin
  // Вариант 1: простой системный звук
  Beep;

  // Вариант 2: через Windows API (более заметный)
  // MessageBeep(MB_ICONEXCLAMATION);

  // Вариант 3: несколько коротких сигналов
  // Sleep(100);
  // Beep;
  // Sleep(100);
  // Beep;
end;

// Запуск таймера
procedure TfMain.btnStartClick(Sender: TObject);
begin
  FTotalSeconds := GetTimeInSeconds;

  // Проверка: время не должно быть нулевым
  if FTotalSeconds <= 0 then
  begin
    ShowMessage('Пожалуйста, введите корректное время (больше 0 секунд)');
    Exit;
  end;

  FRemainingSeconds := FTotalSeconds;
  UpdateDisplay;

  // Блокируем поля ввода и кнопку "Старт"
  edtHours.Enabled := False;
  edtMinutes.Enabled := False;
  edtSeconds.Enabled := False;
  btnStart.Enabled := False;
  btnStop.Enabled := True;

  // Запускаем таймер (каждую секунду)
  Timer1.Interval := 1000;
  Timer1.Enabled := True;

  lblStatus.Caption := 'Таймер запущен...';
  lblStatus.Font.Color := clGreen;
end;

// Остановка таймера
procedure TfMain.btnStopClick(Sender: TObject);
begin
  Timer1.Enabled := False;

  // Разблокируем поля ввода и кнопки
  edtHours.Enabled := True;
  edtMinutes.Enabled := True;
  edtSeconds.Enabled := True;
  btnStart.Enabled := True;
  btnStop.Enabled := False;

  lblStatus.Caption := 'Таймер остановлен досрочно';
  lblStatus.Font.Color := clRed;

  // Сбрасываем отображение
  FRemainingSeconds := 0;
  lblRemaining.Caption := 'Осталось: 0 ч 0 мин 0 с';
end;

// Событие таймера (каждую секунду)
procedure TfMain.Timer1Timer(Sender: TObject);
begin
  if FRemainingSeconds > 0 then
  begin
    Dec(FRemainingSeconds);
    UpdateDisplay;

    // Если время вышло
    if FRemainingSeconds = 0 then
    begin
      Timer1.Enabled := False;

      // Подаём звуковой сигнал
      PlayBeep;

      // Сообщение пользователю
      ShowMessage('Время вышло!');

      // Разблокируем элементы управления
      edtHours.Enabled := True;
      edtMinutes.Enabled := True;
      edtSeconds.Enabled := True;
      btnStart.Enabled := True;
      btnStop.Enabled := False;

      lblStatus.Caption := 'Время вышло!';
      lblStatus.Font.Color := clRed;
    end;
  end;
end;

// Инициализация формы
procedure TfMain.FormCreate(Sender: TObject);
begin
  // Настройка формы
  Caption := 'Таймер';
  Width := 400;
  Height := 250;
  Position := poDesktopCenter;
  BorderStyle := bsDialog;

  // Настройка подписей
  lblHours.Caption := 'Часы:';
  lblMinutes.Caption := 'Минуты:';
  lblSeconds.Caption := 'Секунды:';
  lblColon1.Caption := ':';
  lblColon2.Caption := ':';

  // Настройка полей ввода
  edtHours.Text := '0';
  edtMinutes.Text := '0';
  edtSeconds.Text := '5';  // для теста - 5 секунд
  edtHours.Width := 50;
  edtMinutes.Width := 50;
  edtSeconds.Width := 50;

  // Настройка кнопок
  btnStart.Caption := 'Старт';
  btnStop.Caption := 'Стоп';
  btnStop.Enabled := False;

  // Настройка меток статуса
  lblStatus.Caption := 'Введите время и нажмите "Старт"';
  lblStatus.Font.Color := clBlack;
  lblRemaining.Caption := 'Осталось: 0 ч 0 мин 0 с';

  // Инициализация переменных
  FTotalSeconds := 0;
  FRemainingSeconds := 0;

  // Отключаем таймер при старте
  Timer1.Enabled := False;
end;

end.
