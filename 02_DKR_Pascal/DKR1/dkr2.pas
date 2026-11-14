program dkr2;
var
  x, result: real;
begin
  x := -10.0;
  
  while x <= 1.0 do
  begin
    if x < -8 then
      result := (cos(2 * x) / (x * x)) * (66 / x)
    else if x < -1 then
    begin
      if x < 0 then
        result := -exp((1/3) * ln(abs(x))) - exp(0.1 * x * ln(abs(x)))
      else
        result := exp((1/3) * ln(x)) - exp(0.1 * x * ln(x));
    end
    else
      result := exp(3 * ln(x)) / exp(0.1 * x * ln(x)) - (-x) / exp(3 * ln(x));
    
    writeln('x = ', x:6:2, '   f(x) = ', result:10:4);
    x := x + 0.2;
  end;
end.