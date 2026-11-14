program slice03;

var
  N: integer;
  A: array of integer;
  evenElements: array of integer;

begin
  write('Введите размер массива: ');
  readln(N);

  setlength(A, N);

  writeln('Введите ', N, ' элементов:');
  for var i := 0 to N - 1 do
    read(A[i]);

  var count := 0;
  for var i := 1 to N - 1 do
  begin
    if count >= Length(evenElements) then
      SetLength(evenElements, count + 1);
    
    evenElements[count] := A[i];
    Inc(count);
  end;
  setlength(evenElements, count);

  write('срез: [');
  for var i := 0 to Length(evenElements) - 1 do
  begin
    write(evenElements[i]);
    if i <> Length(evenElements) - 1 then
      write(', ');
  end;
  writeln(']');

  var minValue := evenElements.Min();

  writeln('мин:', minValue);
end.