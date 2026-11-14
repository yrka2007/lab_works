program sp2;

uses
  System.Collections.Generic;

var
  L: List<integer>;
  i: integer;

begin
  L := new List<integer>;
  
  for i := 1 to 10 do
    L.Add(i);
  
  Write('Весь список: ');
  L.Print;
  Writeln;
  
  Write('Чётные элементы: ');
  for i := 0 to L.Count - 1 do
    if L[i] mod 2 = 0 then
      Write(L[i], ' ');
  Writeln;
end.