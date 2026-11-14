program list01;

begin
  Write('Введите размер массива n: ');
  var n := ReadlnInteger;
  
  var a := ArrRandomInteger(n, -5, 20);
  Writeln('массив: ', a);
  
  var L1 := new List<integer>;
  var L2 := new List<integer>;
  
  foreach var x in a do
    if x > 0 then
      L1.Add(x)
    else if x < 0 then
      L2.Add(x);
  
  Write('L1: ');
  L1.Print;
  Writeln;
  
  Write('L2: ');
  L2.Print;
  Writeln;
end.