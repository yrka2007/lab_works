program record3;

type
  toy = record
    name: string;
    price: real;
    age: string;
  end;

const
  n = 3;

var
  toys: array [1..n] of toy;
  i: integer;

begin
  Writeln('Введите данные о ', n, ' игрушках:');
  Writeln;
  
  for i := 1 to n do
  begin
    Writeln('Игрушка ', i, ':');
    with toys[i] do
    begin
      Write('  Название: ');
      Readln(name);
      Write('  Цена (руб.): ');
      Readln(price);
      Write('  Возрастной диапазон (например, 3-5 лет): ');
      Readln(age);
    end;
    Writeln;
  end;
  
  Writeln('================================================================================');
  Writeln('|  №  |         Название игрушки          |  Цена (руб.)  | Возрастной диапазон |');
  Writeln('================================================================================');
  
  for i := 1 to n do
  begin
    with toys[i] do
    begin
      Write('| ', i:2, ' | ');
      Write(name:35, '| ');
      Write(price:12:2, ' | ');
      Write(age:19, ' |');
      Writeln;
    end;
  end;
  
  Writeln('================================================================================');
end.