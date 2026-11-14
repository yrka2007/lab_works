Program zad4;
uses graphabc;
var
  i: integer;
BEGIN
  randomize;
  
  setpencolor(clBlack);
  
  setbrushstyle(bsClear);
  
  for i := 1 to 20 do
  begin
    circle(200, 150, i * 10);
  end;
END.