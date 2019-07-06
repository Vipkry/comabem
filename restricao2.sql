-- Restrição 2 - perde ponto em educação alimentar se come mal

-- Perder 0.1 pontos na matéria se comer mal no dia

CREATE OR REPLACE FUNCTION educacao_alimentar_function()
RETURNS trigger AS $$
DECLARE
	insc_educ_alimentar_id int;
	contador_comeu_mal_dia int;
	contador_ja_descontou int;

	row_nota_educ_alimentar Nota%ROWTYPE;
BEGIN
	-- Pega inscrição na disciplina
	SELECT I.insc_id 
	INTO insc_educ_alimentar_id
	FROM Disciplina D 
	INNER JOIN Inscricao I ON I.insc_disciplina_id = D.disc_id
	WHERE D.disc_nome = 'Educação Alimentar' 
	AND I.insc_aluno_id = new.ven_aluno_id;

	-- Retorna se não encontrar inscrição
	IF (insc_educ_alimentar_id IS NULL) THEN
		RETURN NEW;
	END IF;

	SELECT COUNT(*)
	INTO contador_comeu_mal_dia
	FROM comeu_bem(NEW.ven_data, NEW.ven_aluno_id)
	WHERE come_bem = false;

	SELECT COUNT(*)
	INTO contador_ja_descontou
	FROM Venda V
	WHERE V.ven_data = NEW.ven_data 
		AND V.ven_aluno_id = NEW.ven_aluno_id 
		AND V.ven_desconta_ponto = true;

    
    SELECT *
    INTO row_nota_educ_alimentar
    FROM Nota N
    WHERE inscricao_id = insc_educ_alimentar_id
    LIMIT 1;

	-- se ainda não tiver nota lançada pra educ. alimentar, lançar ela
	IF (row_nota_educ_alimentar is null) THEN
		INSERT INTO Nota (avaliacao_id, inscricao_id, nota)  values ((SELECT A.av_id from Avaliacao A order by a.av_id ASC limit 1), insc_educ_alimentar_id, 10.0);

		-- atibui a nova
		SELECT *
	    INTO row_nota_educ_alimentar
	    FROM Nota N
	    WHERE inscricao_id = insc_educ_alimentar_id
	    LIMIT 1;
	END IF;

	IF (contador_comeu_mal_dia > 0 AND contador_ja_descontou = 0) THEN
		-- desconta ponto e marca como descontado
		UPDATE Venda
		SET ven_desconta_ponto = true
		WHERE ven_id = NEW.ven_id;

		IF (row_nota_educ_alimentar.nota >= 0.1) THEN
			UPDATE Nota N SET nota = Nota - 0.1 WHERE nota_id = row_nota_educ_alimentar.nota_id;
		END IF;
	ELSIF (contador_comeu_mal_dia = 0 AND contador_ja_descontou > 0) THEN
		-- desmarca existentes e retorna ponto
		UPDATE Venda
		SET ven_desconta_ponto = false
		WHERE ven_data = NEW.ven_data 
		AND ven_aluno_id = NEW.ven_aluno_id;	

		UPDATE Nota N SET nota = Nota + 0.1 WHERE nota_id = row_nota_educ_alimentar.nota_id;
	END IF;

	RETURN NEW;

END; $$ language plpgsql;


DROP TRIGGER if exists educacao_alimentar_trigger ON Venda CASCADE;

CREATE TRIGGER educacao_alimentar_trigger
AFTER INSERT ON Venda
FOR EACH ROW EXECUTE PROCEDURE educacao_alimentar_function();


-- INSUFICIENTE: 
--INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data) VALUES (19.90, 14.90, 2, 3, '2019-01-01');
-- SAUDAVEL:
-- INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data) VALUES (19.90, 14.90, 2, 3, '2019-01-01');

--SELECT * FROM COMEU_BEM('2019-01-01', 3);

--select * from venda where ven_aluno_id = 3 and ven_data = '2019-01-01';

--select * from recomendacao_nutricional where idade = 10;

--select * from nota where inscricao_id = 26;