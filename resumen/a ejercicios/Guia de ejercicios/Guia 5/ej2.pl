/* fibonacci */

fibonacci(1,1).
fibonacci(2,1).
fibonacci(N,F):- between(3,100,N), N1 is N - 1, N2 is N - 2, fibonacci(N1, F1), fibonacci(N2, F2), F is F1 + F2.

/*
1,3,5,10,19,33,56,93,153,250,407,661,1072,1737,2813,4554,7371,11929,19304,31237
*/