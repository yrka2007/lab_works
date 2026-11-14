x = float(input('Введите x: '))
if x < -8:
    result = ((1 - 2 * (x * x)) / (x * x)) * (66 / x)
elif x < -1:
    result = (abs(x) ** (1 / 3)) - (abs(x) ** (0.1 * x))
else:
    result = (x ** 3) / (x ** (0.1 * x)) - (-x) / (x ** 3)
print(f'Результат: {result:.4f}')
