procedure printSequence(n: integer);
begin
    { БАЗИС: условие выхода из рекурсии }
  if n < 0 then
    exit;
  
    { ДЕКОМПОЗИЦИЯ: вывод текущего элемента последовательности }
  write(n);
  
  if n > 0 then
    write(', ');
  
    { РЕКУРСИВНЫЙ ВЫЗОВ: переход к следующему элементу с уменьшением на 2 }
  printSequence(n - 2);
end;

begin
  writeln('Последовательность от 25 до 0 с шагом -2:');
  writeln('=========================================');
  
  printSequence(25);
  
  writeln;
  readln;
end.