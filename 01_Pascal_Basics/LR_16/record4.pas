program record4;

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
  toys_read: array [1..n] of toy;
  f: file of toy;
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
  
  Assign(f, 'toys.dat');
  Rewrite(f);
  
  for i := 1 to n do
    write(f, toys[i]);
  
  Close(f);
  Writeln('Данные успешно записаны в файл toys.dat');
  Writeln;
  
  Assign(f, 'toys.dat');
  Reset(f);
  
  for i := 1 to n do
    read(f, toys_read[i]);
  
  Close(f);
  
  Writeln('================================================================================');
  Writeln('|  №  |         Название игрушки          |  Цена (руб.)  | Возрастной диапазон |');
  Writeln('================================================================================');
  
  for i := 1 to n do
  begin
    with toys_read[i] do
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