norma = float(input("Норма времени: "))

count = 0
best_result = 1000
best_athlete = ""

n = int(input("Количество спортсменов: "))

for i in range(n):
    surname = input("Фамилия: ")
    result = float(input("Результат: "))

    if result <= norma:
        count += 1


    if result < best_result:
        best_result = result
        best_athlete = surname

print("Выполнили норму:", count)
print("Лучший результат:", best_result)
print("Лучший спортсмен:", best_athlete)