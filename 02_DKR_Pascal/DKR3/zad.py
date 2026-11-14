def f(x):
    return 1 * x ** 3 + 0 * x ** 2 + 1 * x + 9


def left_rectangle_integral(a, b, n):
    dx = (b - a) / n
    integral = 0
    for i in range(n):
        x = a + i * dx
        y = f(x)
        if y > 0:
            integral += y * dx
    return integral


def estimate_error(a, b, n):
    result_n = left_rectangle_integral(a, b, n)
    result_2n = left_rectangle_integral(a, b, 2 * n)
    error_estimate = abs(result_n - result_2n)
    return error_estimate


a = b = None
n = 1000
integral_value = None

while True:
    print("\n1. Ввести пределы интегрирования")
    print("2. Задать количество разбиений")
    print("3. Вычислить площадь")
    print("4. Оценить погрешность")
    print("5. Выход")

    choice = input("Выберите пункт меню: ")

    if choice == '1':
        a = float(input("Введите нижний предел a: "))
        b = float(input("Введите верхний предел b: "))
        print(f"Пределы интегрирования установлены: [{a}, {b}]")

    elif choice == '2':
        n = int(input("Введите количество разбиений n: "))
        print(f"Количество разбиений установлено: {n}")

    elif choice == '3':
        if a is None or b is None:
            print("Сначала установите пределы интегрирования!")
        else:
            integral_value = left_rectangle_integral(a, b, n)
            print(f"Площадь фигуры: {integral_value:.6f}")

    elif choice == '4':
        if integral_value is None:
            print("Сначала вычислите интеграл!")
        else:
            error = estimate_error(a, b, n)
            print(f"Оценка погрешности: {error:.6f}")
            print(f"Относительная погрешность: {error / abs(integral_value) * 100:.2f}%")

    elif choice == '5':
        break

    else:
        print("Неверный выбор!")
