% Dentists
dentista(pereyra).
dentista(deLeon).

% Patients
pacienteObraSocial(karlsson, 1231, osde).
pacienteParticular(rocchio, 24).
pacienteClinica(dodino, odontoklin).

% Dentist can attend to patient
puedeAtenderA(pereyra, karlsson).
puedeAtenderA(pereyra, rocchio).
puedeAtenderA(deLeon, dodino).

% Cost of services for each social security
costo(osde, tratamientoConducto, 200).
costo(omint, tratamientoConducto, 250).

% Cost of services for private care
costo(tratamientoConducto, 1200).

% Percentage that is charged to associated clinics
clinica(odontoklin, 80).

% Patients with social security
pacienteObraSocial('Juan Perez', 12345, 'OSDE').
pacienteObraSocial('Maria Garcia', 67890, 'PAMI').

% Private patients
pacienteParticular('Carlos Rodriguez', 30).
pacienteParticular('Ana Lopez', 25).

% Patients from other dental clinics
pacienteClinica('Pedro Martinez', 'Clinica Dental Sur').
pacienteClinica('Laura Ramirez', 'Clinica Dental Norte').

% Doctor Cureta can attend to all private patients over 60 years old and patients from the Sarlanga clinic
puedeAtenderA(cureta, Paciente) :-
    pacienteParticular(Paciente, Edad), Edad > 60;
    pacienteClinica(Paciente, 'Clinica Sarlanga').

% Doctor Patolinger can attend to all patients that Pereyra can attend to and those that cannot be attended to by De Leon
puedeAtenderA(patolinger, Paciente) :-
    puedeAtenderA(pereyra, Paciente);
    not(puedeAtenderA(deLeon, Paciente)).

% Doctor Saieg can attend to all patients
puedeAtenderA(saieg, _).


% Price of a service for a patient with social security
precio(pacienteObraSocial(Nombre, _, ObraSocial), Servicio, Precio) :-
    costo(ObraSocial, Servicio, Precio).

% Price of a service for a private patient
precio(pacienteParticular(Nombre, Edad), Servicio, Precio) :-
    costo(Servicio, PrecioBase),
    (Edad > 45 -> Precio is PrecioBase + 50 ; Precio = PrecioBase).

% Price of a service for a patient from another clinic
precio(pacienteClinica(Nombre, Clinica), Servicio, Precio) :-
    costo(Servicio, PrecioBase),
    clinica(Clinica, Porcentaje),
    Precio is PrecioBase * (Porcentaje / 100).

