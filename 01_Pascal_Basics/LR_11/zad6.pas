program zad6;
uses GraphABC;

const
  BoardSize = 8;
  CellSize = 40;

var
  x, y, i, j: integer;
  startX, startY: integer;
  color1, color2: Color;

begin
  startX := 100;
  startY := 100;
  
  color1 := Color.White;
  color2 := Color.Brown;
  
  for i := 0 to BoardSize - 1 do
  begin
    for j := 0 to BoardSize - 1 do
    begin
      x := startX + j * CellSize;
      y := startY + i * CellSize;
      
      if (i + j) mod 2 = 0 then
        SetBrushColor(color1)
      else
        SetBrushColor(color2);
      
      Rectangle(x, y, x + CellSize, y + CellSize);
    end;
  end;
  
  SetBrushStyle(bsClear);
  SetPenWidth(3);
  Rectangle(startX, startY, 
            startX + BoardSize * CellSize, 
            startY + BoardSize * CellSize);
end.