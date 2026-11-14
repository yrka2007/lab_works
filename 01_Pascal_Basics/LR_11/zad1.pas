program zad1;

uses GraphABC;

begin
  SetWindowSize(800, 500);
  ClearWindow(clWhite);
  
  SetBrushColor(clBlue);
  SetPenColor(clBlack);
  SetPenWidth(1);
  Polygon((400, 100), (600, 200), (200, 200));
  
  SetBrushColor(clLime);
  SetPenColor(clBlack);
  SetPenWidth(1);
  Polygon((400, 300), (600, 200), (200, 200));
  
  
  SetPenColor(clBlack);
  SetPenWidth(1);
  SetBrushColor(clRed);
  Circle(150, 200, 50);
  FillCircle(150, 200, 50);
  
  SetPenColor(clBlack);
  SetPenWidth(1);
  SetBrushColor(clYellow);
  Circle(650, 200, 50);
  FillCircle(650, 200, 50);
end.