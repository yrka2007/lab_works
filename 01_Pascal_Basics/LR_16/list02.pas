program list02;

begin
  var L := new List<integer>(Arr(0, 93, 71, 88, 99, 44, 50, 36, 72, 1));
  Write('список: ');
  L.Print;
  Writeln;
  
  var maxIndex := 0;
  for var i := 1 to L.Count - 1 do
    if L[i] > L[maxIndex] then
      maxIndex := i;
  
  L.RemoveAt(maxIndex);
  
  
  Write('результат: ');
  L.Print;
  Writeln;
end.