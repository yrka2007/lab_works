program slice04;

begin
  var a := Arr(66, 46, 26, 64, 73, 62, 37, 57, 46, 9);
  Writeln('массив: ', a);
  
  var maxIndex := 0;
  for var i := 1 to a.Length - 1 do
    if a[i] > a[maxIndex] then
      maxIndex := i;
  
  var result := a[:maxIndex] + a[maxIndex+1:];
  
  Writeln('результат: ', result);
end.