-- Restrição 2 - Aluno não pode ter nota acima de 9 NA P1 se comeu mal em mais de 5 dias no ano

CREATE OR REPLACE FUNCTION dias_de_ma_alimentacao_neste_ano(param_aluno_id int)
RETURNS TABLE(
    dia_retorno date,
    id_nut_retorno int
) AS $$
DECLARE
    c10 cursor for  select distinct ven_data 
                    from venda
                    where ven_aluno_id=param_aluno_id 
                    and ven_data<=now()
                    and extract(YEAR from ven_data) = extract(YEAR from now())
                    order by ven_data ASC;

    c20 cursor for select nut_id, nome from nutriente;
    comeu_bem_tmp boolean;
BEGIN
    for dia in c10 loop
        for nut in c20 loop
            select come_bem 
            into comeu_bem_tmp 
            from comeu_bem(dia.ven_data, param_aluno_id)
            where nut_id=nut.nut_id;

            if(not comeu_bem_tmp) then
                return query select dia.ven_data, nut.nut_id;
            end if;
        end loop;
    end loop;
END; $$ language plpgsql;

CREATE OR REPLACE FUNCTION verifica_nova_venda()
RETURNS trigger as $$
DECLARE
	conta int;
	nota_p1 float;
	insc_educ_alimentar_id int;
BEGIN
	SELECT I.insc_id 
	INTO insc_educ_alimentar_id
	FROM Disciplina D 
	INNER JOIN Inscricao I ON I.insc_disciplina_id = D.disc_id
	WHERE D.disc_nome = 'Educação Alimentar' and I.insc_ativa
	AND I.insc_aluno_id = new.ven_aluno_id;

	IF (insc_educ_alimentar_id IS NULL) THEN
		RETURN NEW;
	END IF;

	SELECT N1.nota
		INTO nota_p1
		FROM Nota N1
		WHERE N1.inscricao_id=insc_educ_alimentar_id
		AND N1.avaliacao_id IN (SELECT av_id
					FROM Avaliacao 
					WHERE nome='P1');

	if(nota_p1 is null or nota_p1<=9) then
		return NEW;
	end if;

	SELECT COUNT(distinct dia_retorno) 
	into conta
	from dias_de_ma_alimentacao_neste_ano(NEW.ven_aluno_id);

	if(conta>5) then
		raise exception 'ALUNO SE ALIMENTOU MAL EM MAIS DE 5 DIAS NO ANO';
	end if;

	return NEW;
END;$$ language plpgsql;


DROP TRIGGER if exists educacao_alimentar_trigger ON Venda CASCADE;

CREATE TRIGGER educacao_alimentar_trigger
AFTER INSERT OR UPDATE ON Venda
FOR EACH ROW EXECUTE PROCEDURE verifica_nova_venda();

CREATE OR REPLACE FUNCTION verifica_nova_nota()
RETURNS trigger as $$
DECLARE
	conta int;
	nota_aluno_id int;
	nome_avaliacao varchar(30);
	nome_disc_nova_nota varchar(255);
BEGIN

	SELECT D.disc_nome, A.nome, I.insc_aluno_id
	INTO nome_disc_nova_nota, nome_avaliacao, nota_aluno_id
	FROM Nota N
	INNER JOIN Avaliacao A ON A.av_id = NEW.avaliacao_id
	INNER JOIN Inscricao I ON I.insc_id = NEW.inscricao_id
	INNER JOIN Disciplina D ON D.disc_id = I.insc_disciplina_id;

	IF ( (nome_disc_nova_nota <> 'Educação Alimentar') or
		 (nome_avaliacao <> 'P1') or
		 NEW.nota IS NULL or 
		 NEW.nota <= 9) THEN
		RETURN NEW;
	END IF;

	SELECT COUNT(distinct dia_retorno)
	INTO conta
	FROM dias_de_ma_alimentacao_neste_ano(nota_aluno_id);

	if(conta>5) then
		raise exception 'ALUNO SE ALIMENTOU MAL EM MAIS DE 5 DIAS NO ANO, NÃO PODE TER NOTA ACIMA DE 9';
	end if;
	
	RETURN NEW;

END; $$ language plpgsql;

DROP TRIGGER if exists verifica_nova_nota_alimentar_trigger ON Nota CASCADE;

CREATE TRIGGER verifica_nova_nota_alimentar_trigger
AFTER INSERT OR UPDATE ON Nota
FOR EACH ROW EXECUTE PROCEDURE verifica_nova_nota();


CREATE OR REPLACE FUNCTION verifica_novo_valor_nutricional()
RETURNS trigger as $$
DECLARE
	conta int;
	nota_p1 float;
	insc_educ_alimentar_id int;

	cursor_vendas_relacionadas cursor FOR (
		SELECT V.* 
		FROM Valor_nutricional VN
		INNER JOIN INGREDIENTE I ON I.ing_id = NEW.ing_id 
		INNER JOIN RECEITA_INGREDIENTE RI ON RI.ing_id = I.ing_id
		INNER JOIN RECEITA RA ON RA.rec_id = RI.rec_id
		INNER JOIN REFEICAO RF ON RF.rec_id = RA.rec_id 
		INNER JOIN VENDA V ON V.ven_refeicao_id = RF.ref_id);
BEGIN

	FOR r_venda in cursor_vendas_relacionadas LOOP
		insc_educ_alimentar_id = NULL;
		conta = 0;
		nota_p1 = NULL;

		SELECT I.insc_id
		INTO insc_educ_alimentar_id
		FROM Disciplina D
		INNER JOIN Inscricao I ON I.insc_disciplina_id = D.disc_id
		WHERE D.disc_nome = 'Educação Alimentar' and I.insc_ativa
		AND I.insc_aluno_id = r_venda.ven_aluno_id;

		IF (insc_educ_alimentar_id IS NOT NULL) THEN
			SELECT N1.nota
				INTO nota_p1
				FROM Nota N1
				WHERE N1.inscricao_id=insc_educ_alimentar_id
				AND N1.avaliacao_id IN (SELECT av_id
							FROM Avaliacao 
							WHERE nome='P1');

			IF (nota_p1 is not null and nota_p1 > 9) then
				SELECT COUNT(distinct dia_retorno) 
				INTO conta
				FROM dias_de_ma_alimentacao_neste_ano(r_venda.ven_aluno_id);

				IF (conta>5) THEN
					raise exception 'ALGUM ALUNO PASSOU A SE ALIMENTAR MAL EM MAIS DE 5 DIAS NO ANO E TIROU MAIS QUE 9 EM EDUC ALIMENTAR COM ESSE NOVO VALOR NUTRICIONAL';
				END IF;
			END IF;
		END IF;
	END LOOP;

	return NEW;
END;$$ language plpgsql;


DROP TRIGGER if exists verifica_novo_valor_nutricional_trigger ON Valor_nutricional CASCADE;

CREATE TRIGGER verifica_novo_valor_nutricional_trigger
AFTER INSERT OR UPDATE ON Valor_nutricional
FOR EACH ROW EXECUTE PROCEDURE verifica_novo_valor_nutricional();