-- Tarefa 1: Liste todos os passageiros que têm reservas para voos saindo do Aeroporto de Guarulhos (GRU).

Select
p.nome AS Passageiros,
p.cpf as Documento, 
p.data_nascimento as Data_Nasc,
p.telefone as Contato
FROM passageiros p
INNER join Reservas r on p.passageiro_id = r.passageiro_id
join VOOS v on r.voo_ID = v.voo_id
join Aeroportos a on v.aeroporto_origem_id = a.aeroporto_id
where a.codigo_IATA = 'GRU';

-- Tarefa 2: Atualize o número de capacidade de uma aeronave específica para refletir uma nova configuração após uma manutenção.

update Aeronaves set capacidade = 190 where Aeronave_id = '2'; 

-- Tarefa 3: Exclua todos os registros de check-ins feitos em uma data específica.

Delete from checkin where data_checkin = '26/09/24';

SELECT * FROM checkin;

-- Tarefa 4: Calcule o número total de passageiros que já viajaram em voos realizados por aeronaves do modelo "Boeing 737".

SELECT p.nome, count(Distinct p.passageiro_id) As Total_passageiros
FROM passageiros p
INNER join reservas r on p.passageiro_id = r.passageiro_id
join voos v on r.voo_id = v.voo_id
join AERONAVES a on v.aeronave_id = a.aeronave_id
where a.modelo = 'Boeing 737';


SELECT p.nome as Nome_Passageiros, p.cpf as Documento_Passageiro
FROM passageiros p
INNER join reservas r on p.passageiro_id = r.passageiro_id
join voos v on r.voo_id = v.voo_id
join AERONAVES a on v.aeronave_id = a.aeronave_id
where a.modelo = 'Boeing 737';


-- Tarefa 5: Insira novos registros de reservas para passageiros já existentes para voos que partem de um aeroporto diferente.

INSERT INTO Reservas (Reserva_ID, Passageiro_ID, Voo_ID, Data_Reserva, Status_Reserva) 
VALUES (21, 1, 3, TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'Confirmada');

INSERT INTO Reservas (Reserva_ID, Passageiro_ID, Voo_ID, Data_Reserva, Status_Reserva) 
VALUES (22, 2, 4, TO_DATE('2024-10-07', 'YYYY-MM-DD'), 'Confirmada');

INSERT INTO Reservas (Reserva_ID, Passageiro_ID, Voo_ID, Data_Reserva, Status_Reserva) 
VALUES (23, 3, 5, TO_DATE('2024-10-08', 'YYYY-MM-DD'), 'Pendente');

INSERT INTO Reservas (Reserva_ID, Passageiro_ID, Voo_ID, Data_Reserva, Status_Reserva) 
VALUES (24, 4, 6, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Confirmada');

INSERT INTO Reservas (Reserva_ID, Passageiro_ID, Voo_ID, Data_Reserva, Status_Reserva) 
VALUES (25, 5, 7, TO_DATE('2024-10-12', 'YYYY-MM-DD'), 'Cancelada');


-- Atualize o status de uma reserva para "Cancelada" para todos os passageiros que não realizaram check-in até a data do voo.

UPDATE reservas r
SET r.Status_Reserva = 'cancelada'
where r.data_reserva < sysdate
and not exists ( select 1 from checkin c 
where c.reserva_id = r.reserva_id);

-- Listar todos os aeroportos: Escreva uma consulta SQL para listar todos os aeroportos, exibindo o nome e a cidade de cada um.

SELECT nome, cidade from aeroportos;

-- Contar aeronaves: Faça uma consulta que retorne o número total de aeronaves cadastradas no sistema.

SELECT count(*) As Numero_Aeronaves
from Aeronaves;

-- Verificar voos de uma aeronave: Encontre todos os voos realizados por uma aeronave específica, utilizando o ID da aeronave.

SELECT * From voos where aeronave_id = '10'; 

-- Listar reservas de um passageiro: Faça uma consulta que liste todas as reservas de um determinado passageiro (use o CPF como parâmetro).

SELECT 
r.reserva_id as N_Reserva,
r.voo_id as N_Voo,
r.Data_Reserva as Data,
r.Status_Reserva as Status
from Reservas r
INNER join passageiros p
On r.passageiro_id = p.passageiro_id
where p.cpf = '234.567.890-01';

-- Alterar telefone de passageiro: Atualize o número de telefone de um passageiro, fornecendo o ID do passageiro e o novo número de telefone.

UPDATE Passageiros
set telefone = '11991975083'
where Passageiro_id = 12;

select * from passageiros;

-- Escreva uma consulta SQL para listar todos os voos programados para um dia específico. Exiba o número do voo, a data e os aeroportos de origem e destino.

SELECT 
v.numero_voo as Numero_Voo,
v.Data_voo as Data_do_voo,
ao.nome as aeroporto_origem,
ad.nome as aeroporto_destino
From voos v
INNER Join
aeroportos ao
ON v.aeroporto_origem_id = ao.aeroporto_id
join
aeroportos ad
on v.aeroporto_destino_id = ad.aeroporto_id
where v.data_voo = to_date ('14/10/24','DD/MM/YY');

-- Crie uma consulta para identificar todos os passageiros que têm mais de uma reserva registrada. Liste o nome do passageiro e o número total de reservas feitas.

SELECT
p.nome as Nome_Passageiro,
count(r.reserva_id) as Total_Reservas
From
passageiros p
INNER join
reservas r
ON p.passageiro_id = r.passageiro_id
group by p.nome
having count(r.reserva_id) > 1;

-- Escreva uma consulta para listar todos os tripulantes associados a uma aeronave específica, utilizando o ID da aeronave. Exiba o nome do tripulante e o cargo.

SELECT 
t.nome as Tripulante,
t.cargo as cargo_tripulante
From
tripulantes t
where aeronave_id = '9';