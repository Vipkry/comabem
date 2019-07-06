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

		return query select nut.nut_id,(soma between val-(val*margem/100) and val+(val*margem/100)); 
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




/*
CREATE OR REPLACE FUNCTION cria_tab_function()
RETURNS trigger AS
DECLARE
BEGIN
	create temporary table rec_ings_afetados(rec_id int, ing_id int) on commit drop;
	return null;
END;$$ language plpgsql;

CREATE OR REPLACE FUNCTION salva_rec_ings()
RETURNS trigger AS
DECLARE
BEGIN
	if(TG_OP = 'DELETE') then
		insert into rec_ings_afetados values (old.rec_id, old.ing_id);
	end if;

	if(TG_OP = 'INSERT' or TG_OP = 'UPDATE')
		insert into rec_ings_afetados values (new.rec_id, new.ing_id);
		return new;
	end if;

	return old;
END; $$ language plpgsql;

CREATE OR REPLACE FUNCTION check_recomendacao_function()
RETURNS trigger AS
DECLARE
	media float;
	dp float;
	



CREATE OR REPLACE FUNCTION salva_rec_ings()
RETURNS trigger AS
DECLARE
	c1 cursor for select nut_id from valor_nutricional
								where ing_id=new.ing_id;
BEGIN
	for nut in c1 loop
		
	end loop;
END;$$ language plpgsql;


CREATE TRIGGER cria_tabela_trigger()
BEFORE UPDATE OR INSERT OR DELETE ON receita_ingrediente
FOR EACH STATEMENT EXECUTE PROCEDURE cria_tab_function();*/




CREATE OR REPLACE FUNCTION calcula_media_e_dp(nut int)
RETURNS TABLE(
	nut_id int,
	media float,
	dp float
) AS $$
DECLARE
	m float;
	n int;
	soma float;
	c1 cursor for select rn.valor from recomendacao_nutricional rn
							where rn.nut_id=nut;
BEGIN
	soma=0;
	select AVG(valor), COUNT(*) into m,n
	from recomendacao_nutricional rn
	where rn.nut_id=nut
	group by rn.nut_id;

	for r1 in c1 loop
		soma = soma + (abs(r1.valor-m)^2);
	end loop;

	return query select nut, m, sqrt(soma/n);

END; $$ language plpgsql;

CREATE OR REPLACE FUNCTION receita_function()
RETURNS trigger AS $$
DECLARE
	soma float;
	m float;
	desvio float;
	valor float;
	c cursor for select nut_id from valor_nutricional
								where ing_id=new.ing_id;

	c2 cursor(param_nut int) for select ri.ing_id ing, vn.valor val, ri.qtd qtd
									from valor_nutricional vn
									natural join receita_ingrediente ri
									where vn.nut_id = param_nut 
									and ri.rec_id=new.rec_id;
BEGIN
	
	for nut in c loop
		soma=0;
		select media, dp into m, desvio 
			from calcula_media_e_dp(nut.nut_id);
		select vn.valor into valor from valor_nutricional vn where vn.ing_id=new.ing_id and vn.nut_id=nut.nut_id;
		for ingred in c2(nut.nut_id) loop
			raise notice '%', ingred.val;
			soma = soma + ingred.val*ingred.qtd;
		end loop;
		soma = soma + (new.qtd*valor);
		if(soma > m+(2*desvio)) then
			raise exception 'Esta quantidade viola as recomendações nutricionais do nutriente %. Soma = %, Media = %', nut.nut_id, soma, m;
		end if;
	end loop;

	return new;


END; $$ language plpgsql;

CREATE TRIGGER receita_trigger
BEFORE UPDATE OR INSERT ON receita_ingrediente
FOR EACH ROW EXECUTE PROCEDURE receita_function();



