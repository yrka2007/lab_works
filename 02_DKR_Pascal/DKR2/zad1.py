arr = list(map(int, input().split()))
n = len(arr)
u = [0] * n

for i in range(n):
    if u[i] == 0:
        cnt = 1
        for j in range(i + 1, n):
            if arr[j] == arr[i]:
                cnt += 1
                u[j] = 1
        print(f"{arr[i]} встречается {cnt} раз(а)")