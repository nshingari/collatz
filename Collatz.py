#!/usr/bin/env python3

# ---------------------------
# projects/collatz/Collatz.py
# Copyright (C)
# Glenn P. Downing
# ---------------------------

# ------------
# collatz_read
# ------------

MEMO = {}

def collatz_read(s):
    """
    read two ints
    s a string
    return a list of two ints, representing the beginning and end of a range, [i, j]
    """
    a = s.split()
    return [int(a[0]), int(a[1])]

# ------------
# collatz_eval
# ------------

def cycle_length (n) :
    assert n > 0
    c = 1
    while n > 1 :
        if (n % 2) == 0 :
            n = (n // 2)
        else :
            n = (3 * n) + 1
        c += 1
    assert c > 0
    return c


def collatz_eval(i, j):
    """
    i the beginning of the range, inclusive
    j the end       of the range, inclusive
    return the max cycle length of the range [i, j]
    """
    assert i > 0
    assert j > 0
    # swap if i is greater than j 
    if i > j:
        j = i + j
        i = j - i   
        j = j - i
    max = 1
    for x in range(i,j+1):
        if x in MEMO:
            ans = MEMO[x]
        if x not in MEMO:
            ans = cycle_length(x)
            MEMO[x] = ans
        if ans > max:
            max = ans
        if ans < max:
            pass
    return max

# -------------
# collatz_print
# -------------


def collatz_print(w, i, j, v):
    """
    print three ints
    w a writer
    i the beginning of the range, inclusive
    j the end       of the range, inclusive
    v the max cycle length
    """
    w.write(str(i) + " " + str(j) + " " + str(v) + "\n")

# -------------
# collatz_solve
# -------------


def collatz_solve(r, w):
    """
    r a reader
    w a writer
    """
    for s in r:
        i, j = collatz_read(s)
        v = collatz_eval(i, j)
        collatz_print(w, i, j, v)

if __name__ == "__main__":
    collatz_eval(3, 7)