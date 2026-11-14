program sp1;

uses
  System.Collections.Generic;

var
  dict: Dictionary<string, integer>;
  word: string;
  words: array of string;

begin
  dict := new Dictionary<string, integer>;
  
  words := Arr('apple', 'banana', 'apple', 'orange', 'banana', 'apple', 'grape');
  
  foreach var w in words do
  begin
    if dict.ContainsKey(w) then
      dict[w] := dict[w] + 1
    else
      dict.Add(w, 1);
  end;
  
  Writeln('Алфавитно-частотный словарь:');
  foreach var kv in dict.OrderBy(k -> k.Key) do
    Writeln(kv.Key, ': ', kv.Value);
  
  Writeln;
  Writeln('Количество различных слов: ', dict.Count);
end.