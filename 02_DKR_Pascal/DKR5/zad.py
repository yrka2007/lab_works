import time
import random


def bubble_sort(arr, compare):
    arr = arr.copy()
    for i in range(len(arr) - 1):
        for j in range(len(arr) - 1 - i):
            if not compare(arr[j], arr[j + 1]):
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr


def heap_sort(arr, compare):
    def heapify(n, i):
        largest = i
        left = 2 * i + 1
        right = 2 * i + 2
        if left < n and not compare(arr[largest], arr[left]):
            largest = left
        if right < n and not compare(arr[largest], arr[right]):
            largest = right
        if largest != i:
            arr[i], arr[largest] = arr[largest], arr[i]
            heapify(n, largest)

    arr = arr.copy()
    n = len(arr)

    for i in range(n // 2 - 1, -1, -1):
        heapify(n, i)

    for i in range(n - 1, 0, -1):
        arr[i], arr[0] = arr[0], arr[i]
        heapify(i, 0)

    return arr


def test():
    files = [("test1.txt", 100, "int"), ("test2.txt", 1000, "int")]

    for name, size, kind in files:
        with open(name, 'w') as f:
            for _ in range(size):
                f.write(f"{random.randint(1, 1000)}\n")

    for name, size, kind in files:
        with open(name, 'r') as f:
            data = [line.strip() for line in f]

        def comp_up(a, b):
            return int(a) <= int(b)

        start = time.time()
        bubble = bubble_sort(data, comp_up)
        print(f"Bubble {name}: {time.time() - start:.4f}s")

        start = time.time()
        heap = heap_sort(data, comp_up)
        print(f"Heap {name}: {time.time() - start:.4f}s")

        with open(f"bubble_{name}", 'w') as f:
            for item in bubble:
                f.write(f"{item}\n")

        with open(f"heap_{name}", 'w') as f:
            for item in heap:
                f.write(f"{item}\n")


def demo():
    data = []
    for i in range(10):
        num = random.randint(1, 100)  # случайное число 1-100
        data.append(str(num))

    bubble = bubble_sort(data, lambda a, b: int(a) <= int(b))
    heap = heap_sort(data, lambda a, b: int(a) <= int(b))

    print(f"Пузырьком: {bubble}")
    print(f"Куча: {heap}")


if __name__ == "__main__":
    test()
    demo()