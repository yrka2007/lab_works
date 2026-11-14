program record1;

type
  anket = record
    fio: string;
    birth: string;
    kurs: 1..5;
  end;

var
  student: anket;

begin
  Writeln('Введите данные студента:');
  Write('Ф.И.О.: ');
  Readln(student.fio);
  Write('Дата рождения (в формате ДД.ММ.ГГГГ): ');
  Readln(student.birth);
  Write('Курс (1-5): ');
  Readln(student.kurs);
  
  Writeln;
  Writeln('Анкетные данные студента:');
  Writeln('Ф.И.О.: ', student.fio);
  Writeln('Дата рождения: ', student.birth);
  Writeln('Курс: ', student.kurs);
end.