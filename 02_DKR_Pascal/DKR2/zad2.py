s = input()
n = len(s)
subs = []
for i in range(n - 2):
    sub = s[i] + s[i + 1] + s[i + 2]
    found = False
    for j in range(len(subs)):
        if subs[j][0] == sub[0] and subs[j][1] == sub[1] and subs[j][2] == sub[2]:
            found = True
            break
    if not found:
        subs.append(sub)
print(len(subs))
