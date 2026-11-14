program zad0;

uses GraphABC;

begin;
  SetWindowSize(800, 600);
  ClearWindow(clWhite);
  
  SetPenColor(clBlack);
  SetPenWidth(3);
  
  MoveTo(100, 200);
  LineTo(300, 200);  
  LineTo(300, 400);  
  LineTo(100, 400);  
  LineTo(100, 200);  
  
  SetPenColor(clBlack); 
  SetPenWidth(3);
  
  MoveTo(550, 200);
  LineTo(450, 400);
  LineTo(650, 400);
  LineTo(550, 200);
end.