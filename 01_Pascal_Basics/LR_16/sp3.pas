program sp3;

uses
  System.Collections.Generic;

var
  L: List<integer>;
  i: integer;
  minVal, maxVal: integer;

begin
  L := new List<integer>(Arr(15, 42, 7, 89, 23, 56, 3, 91, 34, 18));
  
  Write('Список: ');
  L.Print;
  Writeln;
  
  minVal := L[0];
  maxVal := L[0];
  
  for i := 1 to L.Count - 1 do
  begin
    if L[i] < minVal then
      minVal := L[i];
    if L[i] > maxVal then
      maxVal := L[i];
  end;
  
  Writeln('Минимальный элемент: ', minVal);
  Writeln('Максимальный элемент: ', maxVal);
end.