program record2;

type
  anket = record
    fio: string;
    birth: string;
    kurs: 1..5;
  end;

const
  n = 3;

var
  students: array [1..n] of anket;
  i: integer;

begin
  Writeln('Введите данные о ', n, ' студентах:');
  Writeln;
  
  for i := 1 to n do
  begin
    Writeln('Студент ', i, ':');
    Write('  Ф.И.О.: ');
    Readln(students[i].fio);
    Write('  Дата рождения (ДД.ММ.ГГГГ): ');
    Readln(students[i].birth);
    Write('  Курс (1-5): ');
    Readln(students[i].kurs);
    Writeln;
  end;
  
  Writeln('================================================================================');
  Writeln('|  №  |         Ф.И.О.          |  Дата рождения  | Курс |');
  Writeln('================================================================================');
  
  for i := 1 to n do
  begin
    Write('| ', i:2, ' | ');
    Write(students[i].fio:24, '| ');
    Write(students[i].birth:15, '| ');
    Write(students[i].kurs:4, ' |');
    Writeln;
  end;
  
  Writeln('================================================================================');
end.