unit HarterHeighway;

interface

uses System.Collections.Generic;

function GenerateDragonPoints(x, y, length, angle: real; depth: integer): List<(real, real)>;

implementation

function GenerateDragonPoints(x, y, length, angle: real; depth: integer): List<(real, real)>;
var
  points: List<(real, real)>;
  x1, y1, x2, y2: real;
begin
  points := new List<(real, real)>;
  if depth = 0 then
  begin
    x1 := x + length * Cos(angle);
    y1 := y + length * Sin(angle);
    points.Add((x, y));
    points.Add((x1, y1));
    Result := points;
    exit;
  end;
  
  // Рекурсивное построение двух половин
  points.AddRange(GenerateDragonPoints(x, y, length / Sqrt(2), angle + Pi / 4, depth - 1));
  x2 := points[points.Count - 1].Item1;
  y2 := points[points.Count - 1].Item2;
  points.AddRange(GenerateDragonPoints(x2, y2, length / Sqrt(2), angle - Pi / 4, depth - 1));
  
  Result := points;
end;

end.