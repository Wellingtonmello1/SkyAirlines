CREATE TABLE Passageiros (
    Passageiro_ID NUMBER(6) PRIMARY KEY,
    Nome VARCHAR2(50) NOT NULL,
    CPF VARCHAR2(14) UNIQUE NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Email VARCHAR2(100),
    Telefone VARCHAR2(15)
);

CREATE TABLE Aeroportos (
    Aeroporto_ID NUMBER(6) PRIMARY KEY,
    Nome VARCHAR2(50) NOT NULL,
    Codigo_IATA VARCHAR2(3) UNIQUE NOT NULL,
    Cidade VARCHAR2(50),
    Pais VARCHAR2(50)
);

CREATE TABLE Aeronaves (
    Aeronave_ID NUMBER(6) PRIMARY KEY,
    Modelo VARCHAR2(50) NOT NULL,
    Capacidade NUMBER(4) NOT NULL
);

CREATE TABLE Voos (
    Voo_ID NUMBER(6) PRIMARY KEY,
    Numero_Voo VARCHAR2(10) UNIQUE NOT NULL,
    Aeronave_ID NUMBER(6),
    Aeroporto_Origem_ID NUMBER(6),
    Aeroporto_Destino_ID NUMBER(6),
    Data_Voo DATE NOT NULL,
    Hora_Partida TIMESTAMP NOT NULL,
    Hora_Chegada TIMESTAMP NOT NULL,
    CONSTRAINT fk_voo_aeronave FOREIGN KEY (Aeronave_ID) REFERENCES Aeronaves(Aeronave_ID),
    CONSTRAINT fk_voo_origem FOREIGN KEY (Aeroporto_Origem_ID) REFERENCES Aeroportos(Aeroporto_ID),
    CONSTRAINT fk_voo_destino FOREIGN KEY (Aeroporto_Destino_ID) REFERENCES Aeroportos(Aeroporto_ID)
);


CREATE TABLE Tripulantes (
    Tripulante_ID NUMBER(6) PRIMARY KEY,
    Nome VARCHAR2(50) NOT NULL,
    Cargo VARCHAR2(30) NOT NULL,
    Data_Contratacao DATE NOT NULL,
    Aeronave_ID NUMBER(6),
    CONSTRAINT fk_tripulante_aeronave FOREIGN KEY (Aeronave_ID) REFERENCES Aeronaves(Aeronave_ID)
);

CREATE TABLE Reservas (
    Reserva_ID NUMBER(6) PRIMARY KEY,
    Passageiro_ID NUMBER(6),
    Voo_ID NUMBER(6),
    Data_Reserva DATE NOT NULL,
    Status_Reserva VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_reserva_passageiro FOREIGN KEY (Passageiro_ID) REFERENCES Passageiros(Passageiro_ID),
    CONSTRAINT fk_reserva_voo FOREIGN KEY (Voo_ID) REFERENCES Voos(Voo_ID)
);

CREATE TABLE Checkin (
    Checkin_ID NUMBER(6) PRIMARY KEY,
    Reserva_ID NUMBER(6),
    Data_Checkin DATE NOT NULL,
    Bagagem NUMBER(1) CHECK (Bagagem IN (0, 1)), -- 0 para 'não' e 1 para 'sim'
    CONSTRAINT fk_checkin_reserva FOREIGN KEY (Reserva_ID) REFERENCES Reservas(Reserva_ID)
);



add table aeronaves 