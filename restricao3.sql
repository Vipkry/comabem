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


