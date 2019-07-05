CREATE OR REPLACE FUNCTION comeu_bem(dia date, param_aluno_id int)
RETURNS TABLE(
	nut_id int,
	come_bem boolean
) AS $$
DECLARE
	soma float;
	val float;
	idade_var int;
	margem float;
	diferenca int;
	c1 cursor for select * from nutriente;
	c2 cursor(param_nut_id int) for select rec_ing.ing_id ing_id, rec_ing.qtd qtd, vn.valor val_nut from receita
									natural join refeicao ref
									inner join Venda v on v.ven_refeicao_id=ref.ref_id
									natural join receita_ingrediente rec_ing 
									natural join valor_nutricional vn
									where v.ven_data=dia and v.ven_aluno_id=param_aluno_id and vn.nut_id=param_nut_id;
BEGIN
	select a.idade into idade_var 
	from aluno a
	where a.alu_id = param_aluno_id;

	for nut in c1 loop
		soma=0;
		for ing in c2(nut.nut_id) loop
			soma=soma+ing.qtd*ing.val_nut;
		end loop;

		select valor, margem_percent into val, margem 
		from recomendacao_nutricional rn
		where rn.idade=idade_var and rn.nut_id=nut.nut_id;

		return query select nut.nut_id,(soma between val+(val*margem/100) and val-(val*margem/100)); 
	end loop;
		

END; $$ language plpgsql;


select nut_id , come_bem from comeu_bem('2019-01-01',1);








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

