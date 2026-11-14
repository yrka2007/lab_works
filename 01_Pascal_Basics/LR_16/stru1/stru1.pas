program stru1;

var
  f1, f2: text;
  numbers: array of integer;
  n, i: integer;

begin
  Assign(f1, 'input.txt');
  Reset(f1);
  
  n := 0;
  while not Eof(f1) do
  begin
    var temp: integer;
    Read(f1, temp);
    n := n + 1;
  end;
  
  Reset(f1);
  
  SetLength(numbers, n);
  
  for i := 0 to n - 1 do
    Read(f1, numbers[i]);
  
  Close(f1);
  
  Assign(f2, 'output.txt');
  Rewrite(f2);
  
  for i := n - 1 downto 0 do
    Write(f2, numbers[i], ' ');
  
  Close(f2);
  
  Writeln('Файл успешно обработан!');
  Writeln('Числа из файла input.txt записаны в обратном порядке в файл output.txt');
end.