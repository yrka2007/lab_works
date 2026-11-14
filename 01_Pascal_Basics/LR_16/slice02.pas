program slice02;

var
  N: integer;            
  A: array of integer;   
  i: integer;            

begin

  write('Введите размер массива (чётное число): ');
  readln(N);
  

  N := (N div 2) * 2; 
  
  setlength(A, N);

  writeln('Введите ', N, ' элементов:');
  for i := 0 to N - 1 do
    read(A[i]);
  

  writeln('Элементы с четными номерами:');
  for i := 1 to N - 1 do  
    if (i mod 2 = 1) then   
      write(A[i], ' ');     
  
  writeln();                
end.