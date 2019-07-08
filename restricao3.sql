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

CREATE OR REPLACE FUNCTION recom_function()
RETURNS trigger AS $$
DECLARE
	soma float;
	m float;
	desvio float;
	valor float;
	c cursor for select distinct rec_id from receita_ingrediente;
	--cx cursor for select * from nutriente;


	c2 cursor(param_rec int) for select ri.ing_id ing, vn.valor val, ri.qtd qtd
									from valor_nutricional vn
									natural join receita_ingrediente ri
									where vn.nut_id = new.nut_id
									and ri.rec_id = param_rec;
BEGIN
	
	for rec in c loop
		soma=0;
		select media, dp into m, desvio 
			from calcula_media_e_dp(new.nut_id);
		for ingred in c2(rec.rec_id) loop
			raise notice '%', ingred.val;
			soma = soma + ingred.val*ingred.qtd;
		end loop;
			--soma = soma + (rec_ing.qtd*valor);
		if(soma > m+(2*desvio)) then
			--delete from receita_ingrediente where rec_ing_id = rec_ing.rec_ing_id;
			raise exception 'Esta recomendação impossibilita a receita % para o nutriente %. Soma = %, Media = %', rec.rec_id, new.nut_id, soma, m;
		end if;
	end loop;

	return new;


END; $$ language plpgsql;

drop trigger if exists recom_trigger on recomendacao_nutricional;

CREATE TRIGGER recom_trigger
AFTER UPDATE ON recomendacao_nutricional
FOR EACH ROW EXECUTE PROCEDURE recom_function();


CREATE OR REPLACE FUNCTION vn_function()
RETURNS trigger AS $$
DECLARE
	soma float;
	m float;
	desvio float;
	valor float;
	curs_rec cursor for select distinct rec_id, ing_id from receita_ingrediente where ing_id=new.ing_id;


	curs_ing cursor(param_rec int) for select ri.ing_id ing, vn.valor val, ri.qtd qtd
									from valor_nutricional vn
									natural join receita_ingrediente ri
									where vn.nut_id = new.nut_id
									and ri.rec_id = param_rec;
BEGIN
	
	for rec in curs_rec loop
		soma=0;
		select media, dp into m, desvio 
		from calcula_media_e_dp(new.nut_id);
		
		for ingred in curs_ing(rec.rec_id) loop
			raise notice '%', ingred.val;
			soma = soma + ingred.val*ingred.qtd;
		end loop;
		if(soma > m+(2*desvio)) then
			--delete from receita_ingrediente where rec_ing_id = rec_ing.rec_ing_id;
			raise exception 'Esta alteração impossibilita a receita % para o nutriente %. Soma = %, Media = %', rec.rec_id, new.nut_id, soma, m;
		end if;
	end loop;

	return new;


END; $$ language plpgsql;


drop trigger if exists vn_trigger on valor_nutricional;

CREATE TRIGGER vn_trigger
AFTER UPDATE ON valor_nutricional
FOR EACH ROW EXECUTE PROCEDURE vn_function();

