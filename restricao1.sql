-- Restricao 1 - Um aluno só pode ter uma bolsa (e seus consequentes descontos nas vendas, se tiver nota acima da mínima da bolsa em todas as matérias)

CREATE OR REPLACE FUNCTION calcula_media(insc int) returns float as $$
DECLARE
	media float;
	insc_aluno int;
	vs float;
BEGIN

	-- Calcula media do aluno
	SELECT AVG(N.nota),  AVG(I1.insc_aluno_id)
	INTO media, insc_aluno
	FROM Nota N
	INNER JOIN Inscricao I1 ON (I1.insc_id = N.inscricao_id)
	WHERE N.inscricao_id=insc
	AND N.avaliacao_id IN (SELECT avaliacao_id
			       FROM Avaliacao 
			       WHERE nome<>'VS');
	
	-- Se ficou de VS, verifica nota da VS
	IF(media < 6 AND media > 4) THEN 
		SELECT N1.nota
		INTO vs
		FROM Nota N1
		INNER JOIN Inscricao I2 ON (I2.insc_id = N1.inscricao_id)
		WHERE N1.inscricao_id=insc
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

	return media;
END;$$ language plpgsql;


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
	SELECT B.bol_data_fim, B.bol_media_min
	INTO data_cancel, minimo
	FROM Bolsa B
	INNER JOIN Aluno A ON (B.bol_aluno_id = A.alu_id)
	INNER JOIN Inscricao I ON (I.insc_aluno_id = A.alu_id)
	WHERE NEW.inscricao_id = I.insc_id;
	

	
	media = calcula_media(NEW.inscricao_id);

	-- Se bolsa ativa e aluno teve um mau desempenho
	IF (data_cancel is NULL AND minimo > media) THEN
		raise exception 'NOTA NÃO PODE SER MENOR QUE A MÍNIMA DA BOLSA';
	END IF;

	RETURN NEW;
	
END; $$ language plpgsql;


DROP TRIGGER if exists verifica_bolsa_trigger ON Nota CASCADE;

CREATE TRIGGER verifica_bolsa_trigger
AFTER INSERT OR UPDATE ON Nota
FOR EACH ROW EXECUTE PROCEDURE verifica_bolsa();


CREATE OR REPLACE FUNCTION verifica_insere_bolsa()
RETURNS trigger AS $$
DECLARE
	minimo float;
	data_cancel date;
	media float;
	curs_ins_bolsa cursor FOR SELECT * FROM INSCRICAO WHERE INSC_ALUNO_ID = NEW.BOL_ALUNO_ID AND INSC_ATIVA;
BEGIN

	SELECT B.bol_data_fim, B.bol_media_min
	INTO data_cancel, minimo
	FROM Bolsa B
	INNER JOIN Aluno A ON (B.bol_aluno_id = A.alu_id)
	INNER JOIN Inscricao I ON (I.insc_aluno_id = A.alu_id)
	WHERE NEW.bol_aluno_id = I.insc_id;

	
	IF (NEW.bol_data_fim is null) then
		-- Se a bolsa com insert ou update estiver ativa
		for insc in curs_ins_bolsa loop
	
		

			media = calcula_media(insc.insc_id);

			IF(media<minimo) THEN
				raise exception 'NOTA NÃO PODE SER MENOR QUE A MÍNIMA DA BOLSA';
			END IF;
		END LOOP;
	END IF;

	RETURN NEW;
	
END; $$ language plpgsql;



DROP TRIGGER if exists bloqueia_bolsa_se_media_ruim ON Bolsa CASCADE;

CREATE TRIGGER bloqueia_bolsa_se_media_ruim
AFTER INSERT OR UPDATE ON Bolsa
FOR EACH ROW EXECUTE PROCEDURE verifica_insere_bolsa();


CREATE OR REPLACE FUNCTION verifica_venda_nota_minima()
RETURNS trigger AS $$
DECLARE
	minimo float;
	data_cancel date;
	media float;
	c99 cursor FOR SELECT * FROM INSCRICAO WHERE INSC_ALUNO_ID = NEW.VEN_ALUNO_ID AND INSC_ATIVA;
BEGIN

	IF (NEW.ven_valor_pago = NEW.ven_preco) THEN
		return NEW;
	ELSIF(not EXISTS(SELECT * FROM BOLSA B
					INNER JOIN Aluno A ON (B.bol_aluno_id=A.alu_id)
					WHERE B.bol_aluno_id=NEW.ven_aluno_id)) THEN
		raise exception 'ALUNO NÃO TEM BOLSA';
	ELSE
		-- Armazena data de cancelamento, media minima e porcentagem de desconto da bolsa do aluno cujas notas estao sendo utilizadas em alguma operacao
		SELECT B.bol_data_fim, B.bol_media_min
		INTO data_cancel, minimo
		FROM Bolsa B
		INNER JOIN Aluno A ON (B.bol_aluno_id = A.alu_id)
		WHERE B.bol_aluno_id=NEW.ven_aluno_id;

		if(data_cancel is not null) then
			raise exception 'A BOLSA DO ALUNO JÁ ACABOU';
		end if;
	end if;

	for inscricao_c in c99 loop
		-- Calcula media do aluno
		media = calcula_media(inscricao_c.insc_id);

		-- Se bolsa ativa e aluno teve um mal desempenho
		IF (minimo > media) THEN

			-- Cancela bolsa
			raise exception 'ALUNO NÃO TEM MÉDIA PARA RECEBER DESCONTO';
		END IF;
	END LOOP;
	RETURN NEW;
	
END; $$ language plpgsql;



DROP TRIGGER if exists checa_nota_minima_trigger ON Bolsa CASCADE;

CREATE TRIGGER checa_nota_minima_trigger
AFTER INSERT OR UPDATE ON VENDA
FOR EACH ROW EXECUTE PROCEDURE verifica_venda_nota_minima();
