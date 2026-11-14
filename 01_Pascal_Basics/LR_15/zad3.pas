function stepen(a, b: integer): integer;
begin
    { БАЗИС: условие завершения рекурсии - степень равна 0 }
  if b = 0 then
    stepen := 1
  else
  { ДЕКОМПОЗИЦИЯ: основание a умножается на результат рекурсивного вызова }
  { РЕКУРСИВНЫЙ ВЫЗОВ: вычисление степени с показателем (b-1) }
    stepen := a * stepen(a, b - 1);
end;

begin
  var x: integer;
  var y: integer;
  
  writeln('Число?');
  x := ReadInteger();
  
  writeln('Степень?');
  y := ReadInteger();
  
  if y < 0 then
    writeln('Ошибка: степень должна быть неотрицательной!')
  else
    writeln('Результат: ', stepen(x, y));
end.