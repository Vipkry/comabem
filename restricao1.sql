-- Restricao 1 - perde desconto na bolsa caso notas estejam abaixo do minimo requerido ou quando mudamos o valor da nota mínima na bolsa

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
	-- Armazena data de cancelamento, media minima e porcentagem de desconto da bolsa do aluno cujas notas estao sendo utilizadas em alguma operacao
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
	END IF;

	RETURN NEW;
	
END; $$ language plpgsql;


DROP TRIGGER if exists verifica_bolsa_trigger ON Nota CASCADE;

CREATE TRIGGER verifica_bolsa_trigger
AFTER INSERT OR UPDATE ON Nota
FOR EACH ROW EXECUTE PROCEDURE verifica_bolsa();


CREATE OR REPLACE FUNCTION altera_valor_contrato()
RETURNS trigger AS $$
DECLARE
BEGIN
	IF (NEW.bol_data_fim is not null AND OLD.bol_data_fim is null) then
		-- Altera valor das vendas do contrato
		UPDATE Venda
		SET ven_valor_pago = ven_preco
		WHERE ven_data >= now()
			AND ven_contrato_id IN (SELECT V2.ven_contrato_id
					     FROM Venda V2
					     INNER JOIN Contrato C ON C.contr_id = V2.ven_contrato_id
						 WHERE C.contr_aluno_id = NEW.bol_aluno_id and C.contr_tem_bolsa);

		update contrato set contr_tem_bolsa = false where contr_aluno_id = NEW.bol_aluno_id;
	END IF;

	RETURN NEW;
	
END; $$ language plpgsql;



DROP TRIGGER if exists altera_contrato_perda_bolsa_trigger ON Bolsa CASCADE;

CREATE TRIGGER altera_contrato_perda_bolsa_trigger
AFTER UPDATE ON Bolsa
FOR EACH ROW EXECUTE PROCEDURE altera_valor_contrato();


CREATE OR REPLACE FUNCTION verifica_bolsa_nota_minima()
RETURNS trigger AS $$
DECLARE
	minimo float;
	data_cancel date;
	media float;
	vs float;
	insc_aluno int;
	desconto float;
	c99 cursor FOR SELECT * FROM INSCRICAO WHERE INSC_ALUNO_ID = NEW.BOL_ALUNO_ID AND INSC_ATIVA;
BEGIN
	
	IF (NEW.bol_media_min = OLD.bol_media_min OR NEW.BOL_DATA_FIM IS NOT NULL) THEN
		return NEW;
	end if;

	for inscricao_c in c99 loop

		-- Armazena data de cancelamento, media minima e porcentagem de desconto da bolsa do aluno cujas notas estao sendo utilizadas em alguma operacao
		SELECT B.bol_data_fim, B.bol_media_min, B.bol_val_percent
		INTO data_cancel, minimo, desconto
		FROM Bolsa B
		INNER JOIN Aluno A ON (B.bol_aluno_id = A.alu_id)
		INNER JOIN Inscricao I ON (I.insc_aluno_id = A.alu_id)
		WHERE inscricao_c.insc_id = I.insc_id;
		
		-- Calcula media do aluno
		SELECT AVG(N.nota),  AVG(I1.insc_aluno_id)
		INTO media, insc_aluno
		FROM Nota N
		INNER JOIN Inscricao I1 ON (I1.insc_id = N.inscricao_id)
		WHERE N.inscricao_id=inscricao_c.insc_id
		AND N.avaliacao_id IN (SELECT avaliacao_id
				       FROM Avaliacao 
				       WHERE nome<>'VS');
		
		-- Se ficou de VS, verifica nota da VS
		IF(media < 6 AND media > 4) THEN 
			SELECT N1.nota, I2.insc_aluno_id
			INTO vs, insc_aluno
			FROM Nota N1
			INNER JOIN Inscricao I2 ON (I2.insc_id = N1.inscricao_id)
			WHERE N1.inscricao_id=inscricao_c.insc_id
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

		-- Se bolsa ativa e aluno teve um mal desempenho
		IF (data_cancel is NULL AND minimo > media) THEN
			raise notice 'min: %, med: %', minimo,media;
			raise notice 'data: %', insc_aluno;

			-- Cancela bolsa
			UPDATE Bolsa
	   		SET bol_data_fim = now()
			WHERE bol_aluno_id=NEW.bol_aluno_id;
		END IF;
	END LOOP;
	RETURN NEW;
	
END; $$ language plpgsql;



DROP TRIGGER if exists checa_nota_minima_trigger ON Bolsa CASCADE;

CREATE TRIGGER checa_nota_minima_trigger
AFTER UPDATE ON Bolsa
FOR EACH ROW EXECUTE PROCEDURE verifica_bolsa_nota_minima();
