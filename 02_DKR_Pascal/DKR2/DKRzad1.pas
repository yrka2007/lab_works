var
  arr: array of integer;
  u: array of integer;
  i, j, n, cnt: integer;
begin
  read(n);
  SetLength(arr, n);
  SetLength(u, n);
  for i := 0 to n-1 do
    read(arr[i]);
  
  for i := 0 to n-1 do
  begin
    if u[i] = 0 then
    begin
      cnt := 1;
      for j := i + 1 to n-1 do
      begin
        if arr[j] = arr[i] then
        begin
          cnt := cnt + 1;
          u[j] := 1;
        end;
      end;
      writeln(arr[i], ' встречается ', cnt, ' раз(а)');
    end;
  end;
end.