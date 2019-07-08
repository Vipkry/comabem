CREATE OR REPLACE FUNCTION dias_de_ma_alimentacao(param_aluno_id int)
RETURNS TABLE(
    dia_retorno date,
    id_nut_retorno int
) AS $$
DECLARE
    c10 cursor for  select distinct ven_data 
                    from venda
                    where ven_aluno_id=param_aluno_id 
                    and ven_data<=now()
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

CREATE OR REPLACE FUNCTION periodo_de_ma_alimentacao(param_aluno_id int)
RETURNS TABLE(
    id_aluno_retorno int,
    data_ini_retorno date,
    data_fim_retorno date,
    id_nutriente int,
    nome_nut varchar(255)
) AS $$
DECLARE
    c100 cursor for select nut_id, nome from nutriente order by nut_id ASC;
    c200 cursor(param_nut int) for  select DISTINCT dia_retorno 
                                    from dias_de_ma_alimentacao(param_aluno_id)
                                    where id_nut_retorno=param_nut
                                    order by dia_retorno ASC;
    
    dia_ant date;
    dia_prim date;
BEGIN
    for nut in c100 loop
        for dia in c200(nut.nut_id) loop
            raise notice 'Dia: %, dia_ant: %, Nut: %', dia.dia_retorno, dia_ant, nut.nut_id;
            if(dia_ant is NULL) then
                dia_ant = dia.dia_retorno;
                dia_prim = dia.dia_retorno;
            elsif(dia_ant = (dia.dia_retorno - integer '1')) then
                dia_ant = dia.dia_retorno;
            else
                return query select param_aluno_id, dia_prim, dia_ant, nut.nut_id, nut.nome;
                dia_prim = dia.dia_retorno;
                dia_ant = dia.dia_retorno;
            end if;
        end loop;
        
        if (dia_prim is not null and dia_ant is not null) then
            return query select param_aluno_id, dia_prim, dia_ant, nut.nut_id, nut.nome;
        end if;
        
        dia_prim = NULL;
        dia_ant = NULL;

    end loop;
END;$$ language plpgsql;