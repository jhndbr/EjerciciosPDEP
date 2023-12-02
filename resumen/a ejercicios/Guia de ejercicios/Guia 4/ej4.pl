%tarea(Tarea, Duracion, Rol)
tarea(login, 80, programador).
tarea(cacheDistribuida, 120, arquitecto).
tarea(pruebasPerformance, 100, tester).
tarea(tuning, 30, arquitecto).

%precede(TareaA, TareaB)
precede(cacheDistribuida, pruebasPerformance).
precede(pruebasPerformance, tuning).

%realizada(Tarea)
realizada(login).

% anterior
anterior(TareaA, TareaB):- precede(TareaA, TareaB).
anterior(TareaA, TareaC):- precede(TareaA, TareaB), anterior(TareaB, TareaC).

% simple
simple(Tarea):- tarea(Tarea, _, programador).
simple(Tarea):- tarea(Tarea, _, tester).
simple(Tarea):- tarea(Tarea, Duracion, _), Duracion < 40.

% riesgo
riesgo(Tarea):- tarea(Tarea, Duracion, _), Duracion > 40, not(realizada(Tarea)).

% me_faltan_para
me_faltan_para(Tarea, Faltantes):- tarea(Tarea), findall(T, (anterior(T,Tarea), not(realizada(T))), Faltantes).

tarea(Tarea):- tarea(Tarea, _, _).

% puedo_hacer
puedo_hacer(Tarea):- tarea(Tarea), not(realizada(Tarea)), forall(anterior(T,Tarea), realizada(T)).

% mucho_testing

tarea2(login, [trabajo(80, programador)]).
tarea2(cacheDistribuida, [trabajo(40, arquitecto), trabajo(80, diseniador)]).
tarea2(pruebasPerformance, [trabajo(100, tester), trabajo(20, analista)]).
tarea2(tuning, [trabajo(40, arquitecto), trabajo(20, tester)]).

mucho_testing(Tarea):- tarea2(Tarea, Trabajos), member(trabajo(Duracion, tester), Trabajos), Duracion > 40.




