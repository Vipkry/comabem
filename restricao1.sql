-- Restricao 1 - perde desconto na bolsa caso notas estejam abaixo do minimo requerido


CREATE OR REPLACE FUNCTION verifica_bolsa()
RETURNS trigger AS $$
DECLARE
	minimo float;
	
BEGIN
	-- Extrai dia do mes atual
	SELECT DATE_PART('DAY', current_timestamp) AS dia;

	-- Desempenho minimo requerido
	SELECT b.media_minima
	INTO minimo
	FROM Bolsa b

	-- Mudancao de mes:
	IF (dia = 1) THEN
		UPDATE Bolsa B
    SET valor_porcentagem = 0
    WHERE B.bol_aluno_id IN (SELECT A1.alu_id
										         FROM Aluno A1
										         INNER JOIN Inscricao I1 ON (I1.insc_aluno_id = A1.alu_id AND I1.insc_ativa)
 									           INNER JOIN Nota N1 ON (I1.insc_id = N1.inscricao_id)
										         WHERE minimo > (SELECT AVG(N2.nota)
									 	      		               FROM Nota N2
												                     INNER JOIN Inscricao I2 ON (I2.insc_id = N2.inscricao_id AND I2.insc_ativa)
												                     INNER JOIN Aluno A2 ON (I2.insc_aluno_id = A2.alu_id)));

	END IF;

	RETURN NEW;
	
END; $$ language plpgsql;


DROP TRIGGER if verifica_bolsa_trigger ON Nota CASCADE;

CREATE TRIGGER verifica_bolsa_trigger
AFTER INSERT OR UPDATE ON Nota
FOR EACH ROW EXECUTE PROCEDURE verifica_bolsa();



-- minimo pode ser colocado como uma condiçao no WHERE de SELECT em Aluno?
-- valor_porcentagem fica como 0 ou 100?
-- trigger eh chamado depois de insercao e alteracao em Nota?
