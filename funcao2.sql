CREATE OR REPLACE FUNCTION aluno_passou(param_insc int)
RETURNS float AS $$
DECLARE
	media float;
	vs float;
BEGIN 
	select AVG(nota) into media
	from Nota n
	where n.inscricao_id=param_insc
	and n.avaliacao_id in
		(select avaliacao_id
		from Avaliacao 
		where nome<>'VS');

	if(media>=6) then 
		
		return 1;
	elsif (media<4) then
		return 0;
	else
		select n.nota into vs
		from Nota n
		where n.inscricao_id=param_insc
		and n.avaliacao_id in
			(select av_id
			from Avaliacao 
			where nome='VS');
		
		if(vs>=6) then
			return 1;
		else
			return 0;
		end if;
	end if;
END;$$ language plpgsql;


CREATE OR REPLACE FUNCTION taxa_de_reprovacao(param_disc int)
RETURNS TABLE(
	disc_id int,
	indice_de_reprovacao float,
	ano float
) AS $$
BEGIN
	return query select param_disc, 1-AVG(aluno_passou(insc.insc_id)), EXTRACT(YEAR FROM insc.insc_data) insc_ano
					from inscricao insc
					where insc.insc_disciplina_id=param_disc
					group by insc_ano;
END;$$ language plpgsql;


CREATE OR REPLACE FUNCTION disc_acima_da_media_de_reprovacao()
RETURNS TABLE(
	disc_id_retorno int,
	disc_nome_retorno VARCHAR(255)
) AS $$
DECLARE
	c1 cursor for select disc_id from Disciplina;
	taxa_atual float;
	media float;
BEGIN
	for d in c1 loop
		select AVG(indice_de_reprovacao) into media
			from taxa_de_reprovacao(d.disc_id)
			where ano<>EXTRACT(YEAR FROM now());

		select indice_de_reprovacao into taxa_atual
			from taxa_de_reprovacao(d.disc_id)
			where ano=EXTRACT(YEAR FROM now());
		
		if (taxa_atual>media) then
			return query select disc_id, disc_nome
			from disciplina where disc_id=d.disc_id;
		end if;
	end loop;
END;$$ language plpgsql;
