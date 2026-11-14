program pointer1;

var
  i: integer;
  i_ptr: ^integer;

begin
  i := 2;
  
  i_ptr := @i;
  
  Writeln('Значение по адресу i_ptr: ', i_ptr^);
end.