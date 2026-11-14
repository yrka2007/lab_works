program slice05;

begin
  var a := Arr(20, 3, 18, 33, 93, 58, 30, 56, 15, 3);
  Writeln('массив: ', a);
  
  Write('введите n: ');
  var n := ReadInteger;
  
  var minIndex := 0;
  for var i := 1 to a.Length - 1 do
    if a[i] < a[minIndex] then
      minIndex := i;
  
  var result := a[:minIndex] + Arr(n) + a[minIndex:];
  
  Writeln('результат: ', result);
end.