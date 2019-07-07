-- Restricao 1 - perde desconto na bolsa caso notas estejam abaixo do minimo requerido


CREATE OR REPLACE FUNCTION verifica_bolsa()
RETURNS trigger AS $$
DECLARE
	minimo float;
	data_cancel date;
	media float;
	vs float;
	insc_aluno int;
	desconto float;
BEGIN
	-- Armazena data de cancelamento e media minima da bolsa do aluno cujas notas estao sendo utilizadas em alguma operacao
	SELECT B.bol_data_fim, B.bol_media_min, B.bol_val_percent
	INTO data_cancel, minimo, desconto
	FROM Bolsa B
	INNER JOIN Aluno A ON (B.bol_aluno_id = A.alu_id)
	INNER JOIN Inscricao I ON (I.insc_aluno_id = A.alu_id)
	WHERE NEW.inscricao_id = I.insc_id;
	
	-- Calcula media do aluno
	SELECT AVG(N.nota),  AVG(I1.insc_aluno_id)
	INTO media, insc_aluno
	FROM Nota N
	INNER JOIN Inscricao I1 ON (I1.insc_id = N.inscricao_id)
	WHERE N.inscricao_id=NEW.inscricao_id
	AND N.avaliacao_id IN (SELECT avaliacao_id
			       FROM Avaliacao 
			       WHERE nome<>'VS');
	
	-- Se ficou de VS, verifica nota da VS
	IF(media < 6 AND media > 4) THEN 
		SELECT N1.nota, I2.insc_aluno_id
		INTO vs, insc_aluno
		FROM Nota N1
		INNER JOIN Inscricao I2 ON (I2.insc_id = N1.inscricao_id)
		WHERE N1.inscricao_id=NEW.inscricao_id
		AND N1.avaliacao_id IN (SELECT av_id
					FROM Avaliacao 
					WHERE nome='VS');
		-- Se fez VS, altera media
		IF (vs >= 6) THEN
			media = 6;
		ELSE
			media = vs;
		END IF;
	END IF;

	
	
	-- Se bolsa ativa e aluno teve um mau desempenho
	IF (data_cancel is NULL AND minimo > media) THEN
		raise notice 'min: %, med: %', minimo,media;
		raise notice 'data: %', insc_aluno;
		-- Cancela bolsa
		UPDATE Bolsa
   		SET bol_data_fim = now()
		WHERE bol_aluno_id =insc_aluno;
		-- Altera valor das vendas do contrato
		UPDATE Venda
		SET ven_valor_pago = ven_valor_pago + (desconto * ven_valor_pago / 100)
		WHERE 	ven_data >= now()
			AND ven_contrato_id IN (SELECT V2.ven_contrato_id
					     FROM Venda V2
					     INNER JOIN Contrato C ON C.contr_id = V2.ven_contrato_id
						 WHERE C.contr_aluno_id = insc_aluno);

	END IF;

	RETURN NEW;
	
END; $$ language plpgsql;


DROP TRIGGER if exists verifica_bolsa_trigger ON Nota CASCADE;

CREATE TRIGGER verifica_bolsa_trigger
AFTER INSERT OR UPDATE ON Nota
FOR EACH ROW EXECUTE PROCEDURE verifica_bolsa();



-- minimo pode ser colocado como uma condiçao no WHERE de SELECT em Aluno?
-- valor_porcentagem fica como 0 ou 100?
-- trigger eh chamado depois de insercao e alteracao em Nota?
