%servidor(nombre, fila, criticidad)
servidor('PS1', 1, 1).
servidor('PS2', 1, 2).
servidor('WAS1', 2, 1).
servidor('WAS1_2', 2, 4).
servidor('FS_X48', 2, 1).
esCliente('PS1','FS_X48'). % acá dice que el servidor 'PS1' es cliente de 'FS_X48'
esCliente('WAS1','FS_X48'). % acá dice que el servidor 'WAS1' es cliente de 'FS_X48'
% etc...



atencion_normal(Servidor, rebooteo(Servidor)).
atencion_normal(Servidor, rebooteo(Servidor1)):- esCliente(Servidor, Servidor1).
atencion_normal(Servidor, cuelgue_aplicacion(Servidor)):- not(critico(Servidor)).
atencion_inmediata(Servidor, corte_de_luz(Fila)):- servidor(Servidor, Fila, _).
atencion_inmediata(Servidor, cuelgue_aplicacion(Servidor)):- critico(Servidor).

critico(Servidor):- servidor(Servidor, _, Criticidad), member(Criticidad, [1,2]).