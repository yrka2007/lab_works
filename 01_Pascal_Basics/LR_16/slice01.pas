program slice01;

var
  N: integer;          
  A: array of integer;  
  i: integer;           

begin
  write('Введите количество элементов: ');
  readln(N);
  
  setlength(A, N);
  
  writeln('Введите ', N, ' элементов:');
  for i := 0 to N - 1 do
    read(A[i]);
  
  writeln('Массив в обратном порядке:');
  for i := N - 1 downto 0 do
    write(A[i], ' ');
  
  writeln();
end.