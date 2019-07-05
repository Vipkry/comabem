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

		return query select nut.nut_id,(soma<=val+(val*margem/100) and soma>=val-(val*margem/100)); 
	end loop;
		

END; $$ language plpgsql;


select nut_id , come_bem from comeu_bem('2019-01-01',1);
