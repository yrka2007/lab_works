type
  TComparator = function(a, b: integer): boolean;

function CompareAscending(a, b: integer): boolean;
begin
  CompareAscending := a <= b;
end;

function CompareDescending(a, b: integer): boolean;
begin
  CompareDescending := a >= b;
end;

function BubbleSort(arr: array of integer; compare: TComparator): array of integer;
var
  i, j: integer;
  temp: integer;
  swapped: boolean;
  res: array of integer;
begin
  SetLength(res, Length(arr));
  for i := 0 to Length(arr) - 1 do
    res[i] := arr[i];
    
  for i := 0 to Length(res) - 2 do
  begin
    swapped := false;
    for j := 0 to Length(res) - 2 - i do
    begin
      if not compare(res[j], res[j + 1]) then
      begin
        temp := res[j];
        res[j] := res[j + 1];
        res[j + 1] := temp;
        swapped := true;
      end;
    end;
    if not swapped then break;
  end;
  
  Result := res;
end;

procedure Heapify(var arr: array of integer; n, i: integer; compare: TComparator);
var
  largest, left, right: integer;
  temp: integer;
begin
  largest := i;
  left := 2 * i + 1;
  right := 2 * i + 2;
  
  if (left < n) and not compare(arr[largest], arr[left]) then
    largest := left;
    
  if (right < n) and not compare(arr[largest], arr[right]) then
    largest := right;
    
  if largest <> i then
  begin
    temp := arr[i];
    arr[i] := arr[largest];
    arr[largest] := temp;
    Heapify(arr, n, largest, compare);
  end;
end;

function HeapSort(arr: array of integer; compare: TComparator): array of integer;
var
  i, n: integer;
  temp: integer;
  res: array of integer;
begin
  SetLength(res, Length(arr));
  for i := 0 to Length(arr) - 1 do
    res[i] := arr[i];
    
  n := Length(res);
  
  for i := (n div 2) - 1 downto 0 do
    Heapify(res, n, i, compare);
    
  for i := n - 1 downto 1 do
  begin
    temp := res[0];
    res[0] := res[i];
    res[i] := temp;
    Heapify(res, i, 0, compare);
  end;
  
  Result := res;
end;

procedure PrintArray(arr: array of integer);
var
  i: integer;
begin
  for i := 0 to Length(arr) - 1 do
    write(arr[i], ' ');
  writeln;
end;

procedure TestBubbleSort;
var
  arr, sorted: array of integer;
begin
  arr := new integer[10];
  arr[0] := 5; arr[1] := 3; arr[2] := 8; arr[3] := 1; arr[4] := 9;
  arr[5] := 2; arr[6] := 7; arr[7] := 4; arr[8] := 6; arr[9] := 0;
  
  writeln('Тест пузырьковой сортировки:');
  write('Исходный массив: ');
  PrintArray(arr);
  
  sorted := BubbleSort(arr, CompareAscending);
  write('По возрастанию: ');
  PrintArray(sorted);
  
  sorted := BubbleSort(arr, CompareDescending);
  write('По убыванию:    ');
  PrintArray(sorted);
  writeln;
end;

procedure TestHeapSort;
var
  arr, sorted: array of integer;
begin
  arr := new integer[10];
  arr[0] := 12; arr[1] := 11; arr[2] := 13; arr[3] := 5; arr[4] := 6;
  arr[5] := 7; arr[6] := 20; arr[7] := 15; arr[8] := 18; arr[9] := 10;
  
  writeln('Тест пирамидальной сортировки:');
  write('Исходный массив: ');
  PrintArray(arr);
  
  sorted := HeapSort(arr, CompareAscending);
  write('По возрастанию: ');
  PrintArray(sorted);
  
  sorted := HeapSort(arr, CompareDescending);
  write('По убыванию:    ');
  PrintArray(sorted);
  writeln;
end;

procedure RandomTest;
var
  arr, bubbleSorted, heapSorted: array of integer;
  i: integer;
  same: boolean;
begin
  Randomize;
  SetLength(arr, 15);
  writeln('Случайный тест (15 элементов):');
  
  for i := 0 to Length(arr) - 1 do
    arr[i] := Random(100);
  
  write('Исходный массив: ');
  PrintArray(arr);
  
  bubbleSorted := BubbleSort(arr, CompareAscending);
  write('Пузырьком (возр.): ');
  PrintArray(bubbleSorted);
  
  heapSorted := HeapSort(arr, CompareAscending);
  write('Куча (возр.):      ');
  PrintArray(heapSorted);
  same := true;
  for i := 0 to Length(arr) - 1 do
    if bubbleSorted[i] <> heapSorted[i] then
      same := false;  
  if same then
    writeln('✓ Результаты совпадают')
  else
    writeln('✗ Результаты различаются');
  writeln;
end;
begin
  writeln('ПРОГРАММА СОРТИРОВКИ');
  writeln('====================');
  writeln;
  TestBubbleSort;
  TestHeapSort;
  RandomTest;
  writeln('Нажмите Enter для выхода...');
  readln;
end.