uses System;

function GCD(x, y: integer): integer;
begin
    { БАЗИС: условие завершения рекурсии - второе число равно 0 }
  if y = 0 then
    GCD := x
  else
  { ДЕКОМПОЗИЦИЯ: НОД(x, y) = НОД(y, x mod y) - подстановка параметров }
  { РЕКУРСИВНЫЙ ВЫЗОВ: вычисление НОД для пары (y, остаток от деления x на y) }
    GCD := GCD(y, x mod y);
end;

begin
  var a: integer;
  var b: integer;
  
  Println('НАХОЖДЕНИЕ НОД МЕТОДОМ ЕВКЛИДА (рекурсия)');
  Println('=========================================');
  Println();
  
  Print('Введите первое число: ');
  a := ReadInteger();
  Print('Введите второе число: ');
  b := ReadInteger();
  
  if (a < 0) or (b < 0) then
    Println('Ошибка: числа должны быть неотрицательными!')
    else
  begin
    Println();
    Println('НОД(', a, ', ', b, ') = ', GCD(a, b));
  end;
end.