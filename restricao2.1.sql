-- Restrição 2 - perde ponto em educação alimentar se come mal ao inserir inscrição na disciplina

CREATE OR REPLACE FUNCTION educacao_alimentar_insert_inscricao_function()
RETURNS trigger AS $$
DECLARE
	nome_disciplina varchar(255);
	contador_comeu_mal_dia int;
	contador_ja_descontou int;

	row_nota_educ_alimentar Nota%ROWTYPE;

	c80 cursor FOR SELECT * FROM VENDA WHERE extract(year from ven_data) = extract(year from now()) AND ven_aluno_id = NEW.insc_aluno_id;
BEGIN
	-- checa se inscrição é de educação alimentar
	SELECT D.disc_nome
	INTO nome_disciplina
	FROM Disciplina D
	INNER JOIN Inscricao I ON I.insc_disciplina_id = D.disc_id
	WHERE I.insc_disciplina_id = NEW.insc_disciplina_id;

	raise notice 'trigger educ alimentar insert inscricao disparada';

	IF (nome_disciplina <> 'Educação Alimentar' or not NEW.insc_ativa) THEN
		RETURN NEW;
	END IF;

	raise notice 'trigger educ alimentar insert inscricao sendo executada';

	FOR venda_c in c80 LOOP
		contador_comeu_mal_dia = NULL;
		contador_ja_descontou  = NULL;
		row_nota_educ_alimentar = NULL;

		SELECT COUNT(*)
		INTO contador_comeu_mal_dia
		FROM comeu_bem(venda_c.ven_data, venda_c.ven_aluno_id)
		WHERE come_bem = false;

		SELECT COUNT(*)
		INTO contador_ja_descontou
		FROM Venda V
		WHERE V.ven_data = venda_c.ven_data 
		AND V.ven_aluno_id = venda_c.ven_aluno_id 
		AND V.ven_desconta_ponto = true;

		SELECT *
	    INTO row_nota_educ_alimentar
	    FROM Nota N
	    WHERE inscricao_id = NEW.insc_id
	    LIMIT 1;

	    raise notice 'trigger educ alimentar selects executados';

		-- se ainda não tiver nota lançada pra educ. alimentar, lançar ela
		IF (row_nota_educ_alimentar is null) THEN
			raise notice 'trigger educ alimentar disparando nota';

			INSERT INTO Nota (avaliacao_id, inscricao_id, nota)  values ((SELECT A.av_id from Avaliacao A order by a.av_id ASC limit 1), NEW.insc_id, 10.0);
			
			-- atibui a nova
			SELECT *
		    INTO row_nota_educ_alimentar
		    FROM Nota N
		    WHERE inscricao_id = NEW.insc_id
		    LIMIT 1;
		END IF;

		IF (contador_comeu_mal_dia > 0 AND contador_ja_descontou = 0) THEN
			raise notice 'contador comeu mal dia >0 and ja descontou =0';
			-- desconta ponto e marca como descontado
			UPDATE Venda
			SET ven_desconta_ponto = true
			WHERE ven_id = venda_c.ven_id;

			IF (row_nota_educ_alimentar.nota >= 0.1) THEN
				UPDATE Nota N SET nota = Nota - 0.1 WHERE nota_id = row_nota_educ_alimentar.nota_id;
			END IF;
		ELSIF (contador_comeu_mal_dia = 0 AND contador_ja_descontou > 0) THEN
			raise notice 'contador comeu mal dia =0 and ja descontou >0';

			-- desmarca existentes e retorna ponto
			UPDATE Venda
			SET ven_desconta_ponto = false
			WHERE ven_data = venda_c.ven_data 
			AND ven_aluno_id = venda_c.ven_aluno_id;	

			UPDATE Nota N SET nota = Nota + 0.1 WHERE nota_id = row_nota_educ_alimentar.nota_id;
		END IF;

	END LOOP;

	RETURN NEW;

END; $$ language plpgsql;

DROP TRIGGER if exists educacao_alimentar_insert_inscricao_trigger ON Venda CASCADE;

CREATE TRIGGER educacao_alimentar_insert_inscricao_trigger
AFTER INSERT ON Inscricao
FOR EACH ROW EXECUTE PROCEDURE educacao_alimentar_insert_inscricao_function();