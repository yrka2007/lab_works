program dkr1;
var
  x, result: real;
begin
  write('Введите x: ');
  readln(x);
  
  if x < -8 then
    result := (cos(2 * x) / (x * x)) * (66 / x)
  else if x < -1 then
    result := exp((1/3) * ln(abs(x))) - exp(0.1 * x * ln(abs(x)))
  else
    result := exp(3 * ln(x)) / exp(0.1 * x * ln(x)) - (-x) / exp(3 * ln(x));
  
  writeln('Результат: ', result:0:4);
end.