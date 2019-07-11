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
	WHERE D.disc_nome = 'Educação Alimentar' 
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
	disc int;
	ed_alimentar int;
BEGIN
	SELECT I.insc_disciplina_id
	INTO ed_alimentar
	FROM Disciplina D 
	INNER JOIN Inscricao I ON I.insc_disciplina_id = D.disc_id
	WHERE I.insc_id = 'Educação Alimentar' 



	--PERGOLA, TERMINA ESSA AQUI
END; $$ language plpgsql;





-- INSUFICIENTE: 
-- INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data) VALUES (19.90, 14.90, 3, 3, '2019-01-01');

--SELECT * FROM COMEU_BEM('2019-01-01', 3);

--select * from venda where ven_aluno_id = 3 and ven_data = '2019-01-01';

--select * from recomendacao_nutricional where idade = 10;

--select * from nota where inscricao_id = 26;	