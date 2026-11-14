program zad4;
var
  surname, best_athlete: string;
  result, norma, best_result: real;
  i, n, count: integer;
begin
  write('Норма времени: ');
  readln(norma);
  
  count := 0;
  best_result := 1000;  
  best_athlete := '';
  
  write('Количество спортсменов: ');
  readln(n);
  
  for i := 1 to n do
  begin
    write('Фамилия: ');
    readln(surname);
    write('Результат: ');
    readln(result);
    
    if result <= norma then
      count := count + 1;
    
    if result < best_result then
    begin
      best_result := result;
      best_athlete := surname;
    end;
  end;
  
  writeln('Выполнили норму: ', count);
  writeln('Лучший результат: ', best_result:0:2);
  writeln('Лучший спортсмен: ', best_athlete);
end.