x = -10.0

while x <= 1.0:
    if x < -8:
        cos_approx = 1 - 8 * (x * x)
        result = (cos_approx / (x * x)) * (66 / x)
    elif x < -1:
        if x < 0:
            result = -(abs(x) ** (1 / 3)) - (abs(x) ** (0.1 * x))
        else:
            result = (x ** (1 / 3)) - (x ** (0.1 * x))
    else:
        result = (x ** 3) / (x ** (0.1 * x)) - (-x) / (x ** 3)
    print(f'x = {x:6.2f}   f(x) = {result:10.4f}')
    x = x + 0.2
