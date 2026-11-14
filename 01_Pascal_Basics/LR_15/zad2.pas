function sumTo(n: integer): integer;
begin
  { БАЗИС: условие завершения рекурсии - достигнуто минимальное значение }
  if n = 1 then
    sumTo := 1
  else
  { ДЕКОМПОЗИЦИЯ: текущее значение n плюс результат рекурсивного вызова }
  { РЕКУРСИВНЫЙ ВЫЗОВ: вычисление суммы для (n-1) }
    sumTo := n + sumTo(n - 1);
end;

begin
  var n: integer;
  var result: integer;
  
  writeln('Вычисление суммы чисел от 1 до n рекурсивным методом');
  writeln('====================================================');
  
  writeln('sumTo(1) = ', sumTo(1));
  writeln('sumTo(2) = ', sumTo(2));
  writeln('sumTo(3) = ', sumTo(3));
  writeln('sumTo(4) = ', sumTo(4));
  writeln('sumTo(5) = ', sumTo(5));
  
  writeln;
  write('Введите n: ');
  n := ReadInteger();
  
  if n < 1 then
    writeln('Ошибка: n должен быть >= 1')
  else
  begin
    result := sumTo(n);
    writeln('Сумма чисел от 1 до ', n, ' = ', result);
  end;
end.