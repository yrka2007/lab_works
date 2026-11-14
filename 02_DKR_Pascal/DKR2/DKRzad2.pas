var
  s: string;
  subs: array[1..1000] of string;
  i, j, n, count: integer;
  found: boolean;
  sub: string;
begin
  readln(s);
  n := length(s);
  count := 0;
  
  for i := 1 to n-2 do
  begin
    sub := s[i] + s[i+1] + s[i+2];
    found := false;
    
    for j := 1 to count do
    begin
      if (subs[j][1] = sub[1]) and (subs[j][2] = sub[2]) and (subs[j][3] = sub[3]) then
      begin
        found := true;
        break;
      end;
    end;
    
    if not found then
    begin
      count := count + 1;
      subs[count] := sub;
    end;
  end;
  
  writeln(count);
end.