function f(x: real): real;
begin
    f := 1 * x * x * x + 0 * x * x + 1 * x + 9;
end;

function left_rectangle_integral(a, b: real; n: integer): real;
var
    dx, integral, x, y: real;
    i: integer;
begin
    dx := (b - a) / n;
    integral := 0;
    for i := 0 to n - 1 do
    begin
        x := a + i * dx;
        y := f(x);
        if y > 0 then
            integral := integral + y * dx;
    end;
    left_rectangle_integral := integral;
end;

function estimate_error(a, b: real; n: integer): real;
var
    result_n, result_2n: real;
begin
    result_n := left_rectangle_integral(a, b, n);
    result_2n := left_rectangle_integral(a, b, 2 * n);
    estimate_error := abs(result_n - result_2n);
end;

var
    a, b: real;
    n: integer;
    integral_value, error: real;  // Добавлена переменная error
    choice: string;
begin
    a := 0;
    b := 0;
    n := 1000;
    integral_value := 0;
    error := 0;  // Инициализация

    while true do
    begin
        writeln;
        writeln('1. Ввести пределы интегрирования');
        writeln('2. Задать количество разбиений');
        writeln('3. Вычислить площадь');
        writeln('4. Оценить погрешность');
        writeln('5. Выход');
        write('Выберите пункт меню: ');
        readln(choice);

        if choice = '1' then
        begin
            write('Введите нижний предел a: ');
            readln(a);
            write('Введите верхний предел b: ');
            readln(b);
            writeln('Пределы интегрирования установлены: [', a:0:2, ', ', b:0:2, ']');
        end
        else if choice = '2' then
        begin
            write('Введите количество разбиений n: ');
            readln(n);
            writeln('Количество разбиений установлено: ', n);
        end
        else if choice = '3' then
        begin
            if (a = 0) and (b = 0) then
                writeln('Сначала установите пределы интегрирования!')
            else
            begin
                integral_value := left_rectangle_integral(a, b, n);
                writeln('Площадь фигуры: ', integral_value:0:6);
            end;
        end
        else if choice = '4' then
        begin
            if integral_value = 0 then
                writeln('Сначала вычислите интеграл!')
            else
            begin
                error := estimate_error(a, b, n);
                writeln('Оценка погрешности: ', error:0:6);
                writeln('Относительная погрешность: ', (error / abs(integral_value) * 100):0:2, '%');
            end;
        end
        else if choice = '5' then
            break
        else
            writeln('Неверный выбор!');
    end;
end.