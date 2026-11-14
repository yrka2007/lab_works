program RingList;

const
  MAX = 100;

type
  Node = record
    Data: Integer;
    Next: Integer;
    Prev: Integer;
    Used: Boolean;
  end;

var
  List: array[1..MAX] of Node;
  Head, Tail, Size: Integer;
  Choice, Value: Integer;

// 1. ИНИЦИАЛИЗАЦИЯ
procedure Init;
var i: Integer;
begin
  for i := 1 to MAX do
    List[i].Used := False;
  Head := 0;
  Tail := 0;
  Size := 0;
end;

// 2. ПРОВЕРКА ПУСТОТЫ
function IsEmpty: Boolean;
begin
  IsEmpty := (Size = 0);
end;

// 3. ПРОВЕРКА ПОЛНОТЫ
function IsFull: Boolean;
begin
  IsFull := (Size = MAX);
end;

// 4. ПОИСК СВОБОДНОГО МЕСТА
function GetFree: Integer;
var i: Integer;
begin
  GetFree := 0;
  for i := 1 to MAX do
    if not List[i].Used then
    begin
      GetFree := i;
      Exit;
    end;
end;

// 5. ДОБАВЛЕНИЕ В НАЧАЛО
procedure AddFront(x: Integer);
var idx: Integer;
begin
  if IsFull then Exit;
  
  idx := GetFree;
  List[idx].Data := x;
  List[idx].Used := True;
  
  if IsEmpty then
  begin
    Head := idx;
    Tail := idx;
    List[idx].Next := idx;
    List[idx].Prev := idx;
  end
  else
  begin
    List[idx].Next := Head;
    List[idx].Prev := Tail;
    List[Head].Prev := idx;
    List[Tail].Next := idx;
    Head := idx;
  end;
  
  Size := Size + 1;
  Writeln('Добавлено в начало');
end;

// 6. ДОБАВЛЕНИЕ В КОНЕЦ
procedure AddBack(x: Integer);
var idx: Integer;
begin
  if IsFull then Exit;
  
  idx := GetFree;
  List[idx].Data := x;
  List[idx].Used := True;
  
  if IsEmpty then
  begin
    Head := idx;
    Tail := idx;
    List[idx].Next := idx;
    List[idx].Prev := idx;
  end
  else
  begin
    List[idx].Prev := Tail;
    List[idx].Next := Head;
    List[Tail].Next := idx;
    List[Head].Prev := idx;
    Tail := idx;
  end;
  
  Size := Size + 1;
  Writeln('Добавлено в конец');
end;

// 7. УДАЛЕНИЕ ИЗ НАЧАЛА
procedure DelFront;
begin
  if IsEmpty then Exit;
  
  if Size = 1 then
  begin
    List[Head].Used := False;
    Head := 0;
    Tail := 0;
  end
  else
  begin
    List[Head].Used := False;
    Head := List[Head].Next;
    List[Tail].Next := Head;
    List[Head].Prev := Tail;
  end;
  
  Size := Size - 1;
  Writeln('Удалено из начала');
end;

// 8. УДАЛЕНИЕ ИЗ КОНЦА
procedure DelBack;
begin
  if IsEmpty then Exit;
  
  if Size = 1 then
  begin
    List[Tail].Used := False;
    Head := 0;
    Tail := 0;
  end
  else
  begin
    List[Tail].Used := False;
    Tail := List[Tail].Prev;
    List[Tail].Next := Head;
    List[Head].Prev := Tail;
  end;
  
  Size := Size - 1;
  Writeln('Удалено из конца');
end;

// 9. ПОИСК
procedure Search(x: Integer);
var cur, pos: Integer;
begin
  if IsEmpty then
  begin
    Writeln('Список пуст');
    Exit;
  end;
  
  cur := Head;
  pos := 1;
  
  repeat
    if List[cur].Data = x then
    begin
      Writeln('Найден на позиции ', pos);
      Exit;
    end;
    cur := List[cur].Next;
    pos := pos + 1;
  until cur = Head;
  
  Writeln('Не найден');
end;

// 10. ВИЗУАЛИЗАЦИЯ
procedure Show;
var cur: Integer;
begin
  if IsEmpty then
  begin
    Writeln('Список пуст');
    Exit;
  end;
  
  Writeln('Список (вперед): ');
  cur := Head;
  repeat
    Write(List[cur].Data, ' ');
    cur := List[cur].Next;
  until cur = Head;
  Writeln;
  Writeln('Размер: ', Size);
end;

// 11. ОЧИСТКА
procedure Clear;
var i: Integer;
begin
  for i := 1 to MAX do
    List[i].Used := False;
  Head := 0;
  Tail := 0;
  Size := 0;
  Writeln('Список очищен');
end;

// 12. МЕНЮ
procedure Menu;
begin
  Writeln;
  Writeln('1-В начало  2-В конец');
  Writeln('3-Из начала 4-Из конца');
  Writeln('5-Поиск     6-Показать');
  Writeln('7-Очистить  8-Выход');
  Write('Выбор: ');
end;

// 13. ОСНОВНАЯ ПРОГРАММА
begin
  Init;
  
  repeat
    Menu;
    Readln(Choice);
    
    case Choice of
      1: begin
        Write('Значение: ');
        Readln(Value);
        AddFront(Value);
      end;
      2: begin
        Write('Значение: ');
        Readln(Value);
        AddBack(Value);
      end;
      3: DelFront;
      4: DelBack;
      5: begin
        Write('Что ищем: ');
        Readln(Value);
        Search(Value);
      end;
      6: Show;
      7: Clear;
      8: Writeln('До свидания');
    else
      Writeln('Ошибка: 1-8');
    end;
  until Choice = 8;
end.