program set1;

var
  n: integer;

begin
  Write('Введите количество лет: ');
  Readln(n);
  
  Write(n, ' ');
  
  if (n mod 100 >= 11) and (n mod 100 <= 14) then
    Writeln('лет')
  else
    case n mod 10 of
      1: Writeln('год');
      2, 3, 4: Writeln('года');
    else Writeln('лет');
    end;
end.