program set2;

type
  t_chs = set of Char;

const
  lett: t_chs = ['a'..'z', 'A'..'Z', '_'];
  num: t_chs = ['0'..'9'];

var
  str: string;
  i: byte;
  flag: boolean;

begin
  Write('Введите строку: ');
  Readln(str);
  
  flag := true;
  
  if Length(str) = 0 then
    flag := false
  else
  begin
    if not (str[1] in lett) then
      flag := false
    else
    begin
      for i := 2 to Length(str) do
      begin
        if not ((str[i] in lett) or (str[i] in num)) then
        begin
          flag := false;
          break;
        end;
      end;
    end;
  end;
  
  if flag then
    Writeln('Строка корректна (true)')
  else
    Writeln('Строка некорректна (false)');
end.