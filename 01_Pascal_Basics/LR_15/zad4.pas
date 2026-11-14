uses System;

procedure LoopFor(i, n: integer);
begin
    { БАЗИС: условие выхода из рекурсии - текущий индекс превысил конечное значение }
  if i > n then
    exit;
  
    { ДЕКОМПОЗИЦИЯ: обработка текущей итерации - вывод сообщения с номером }
  Println('привет ', i);
  
    { РЕКУРСИВНЫЙ ВЫЗОВ: переход к следующей итерации с увеличением индекса на 1 }
  LoopFor(i + 1, n);
end;

function IsValid(x, minVal, maxVal: integer): boolean;
begin
  Result := (x >= minVal) and (x <= maxVal);
end;

begin
  var startValue: integer := 1;
  var endValue: integer := 10;
  
  Println('Имитация цикла for через рекурсию:');
  
  startValue += 0;
  endValue += 0;
  
  LoopFor(startValue, endValue);
  
  Print('Введите количество итераций: ');
  var userInput: integer := ReadInteger();
  
  var minVal: integer := 1;
  var maxVal: integer := 100;
  
  if IsValid(userInput, minVal, maxVal) then
  begin
    loop 1 do
    begin
      Println('Результат для ', userInput, ' итераций:');
      LoopFor(1, userInput);
    end;
  end
  else
    Println('Ошибка! Число должно быть от ', minVal, ' до ', maxVal);
end.