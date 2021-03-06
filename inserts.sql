-- Disciplinas
INSERT INTO Disciplina (disc_nome) VALUES ('Educação Alimentar');--1
INSERT INTO Disciplina (disc_nome) VALUES ('Português');--2
INSERT INTO Disciplina (disc_nome) VALUES ('Matemática');--3
INSERT INTO Disciplina (disc_nome) VALUES ('Robótica');--4


-- Responsaveis
INSERT INTO Responsavel (resp_nome) VALUES ('Renata Bahiense');
INSERT INTO Responsavel (resp_nome) VALUES ('Luanna Lima Sá');
INSERT INTO Responsavel (resp_nome) VALUES ('Arly Souza Cruz');
INSERT INTO Responsavel (resp_nome) VALUES ('Gabriel Costa');


-- Alunos
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('João', 1, 10); --1
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Gustavo', 2, 10);--2
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Gabriel', 3, 10); --3
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Luan', 4, 10); --4
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Pedro', 2, 10); --5
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Raíssa', 2, 10); --6
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Carol', 3, 10); --7
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Elisângela', 3, 10); --8
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Bruno', 3, 10); --9
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Lucas', 4, 10); --10
INSERT INTO Aluno (alu_nome, alu_responsavel_id, idade) VALUES ('Márcio', 4, 10); --11


--Inscricao
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 1, 2, '2019-01-01'); --1: Português
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 3, 2, '2019-01-01'); --2
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 4, 2, '2019-01-01'); --3
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 5, 2, '2019-01-01'); --4
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 2, 2, '2018-01-01'); --5
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 3, 2, '2018-01-01'); --6
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 4, 2, '2018-01-01'); --7
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 5, 2, '2018-01-01'); --8
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 5, 2, '2017-01-01'); --9
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 6, 2, '2017-01-01'); --10
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 7, 2, '2017-01-01'); --11
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 8, 2, '2017-01-01'); --12


INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 1, 3, '2019-01-01'); --13: Matemática
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 3, 3, '2019-01-01'); --14
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 4, 3, '2019-01-01'); --15
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 5, 3, '2019-01-01'); --16
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 2, 3, '2018-01-01'); --17
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 9, 3, '2018-01-01'); --18
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 4, 3, '2018-01-01'); --19
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 5, 3, '2018-01-01'); --20
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 10, 3, '2017-01-01');--21
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 6, 3, '2017-01-01'); --22
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 7, 3, '2017-01-01'); --23
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 8, 3, '2017-01-01'); --24


INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 1, 1, '2019-01-01'); --25: Educ. Alimentar
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 4, 1, '2019-01-01'); --26
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 5, 1, '2019-01-01'); --27
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 2, 1, '2018-01-01'); --28
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 3, 1, '2018-01-01'); --29
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 4, 1, '2018-01-01'); --30
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 5, 1, '2018-01-01'); --31
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 5, 1, '2017-01-01'); --32
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 6, 1, '2017-01-01'); --33
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 8, 1, '2017-01-01'); --35


-- INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (true, 3, 1, '2019-02-01'); --36


-- Nutrientes
INSERT INTO Nutriente (nome) VALUES ('Carboidrato'); -- 1
INSERT INTO Nutriente (nome) VALUES ('Proteína'); -- 2
INSERT INTO Nutriente (nome) VALUES ('Fibra'); -- 3
INSERT INTO Nutriente (nome) VALUES ('Gorduras Saturadas'); --4
INSERT INTO Nutriente (nome) VALUES ('Calorias'); --5

-- Ingredientes
INSERT INTO Ingrediente (ing_nome) VALUES ('Batata Frita'); --1
INSERT INTO Ingrediente (ing_nome) VALUES ('Arroz'); -- 2 
INSERT INTO Ingrediente (ing_nome) VALUES ('Creme de Leite'); -- 3
INSERT INTO Ingrediente (ing_nome) VALUES ('Grão de Bico'); -- 4
INSERT INTO Ingrediente (ing_nome) VALUES ('Goiabada'); -- 5
INSERT INTO Ingrediente (ing_nome) VALUES ('Bacon'); -- 6



-- Valore Nutricionais

-- Batata:
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 5, 10); -- caloria
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 4, 10); -- gordura
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 1, 10); -- carboidrato
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 2, 10); -- proteína

-- Arroz:
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (2, 5, 5); -- caloria
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (2, 1, 5); -- carboidrato
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (2, 3, 5); -- fibra

-- Grão de bico
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (4, 5, 1); -- caloria
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (4, 4, 5); -- gordura
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (4, 1, 1);-- carboidrato
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (4, 2, 5);-- proteína

-- Receitas
INSERT INTO Receita (rec_nome) VALUES ('Arroz com Fritas 1'); --1
INSERT INTO Receita (rec_nome) VALUES ('Arroz com grão de bico 1'); --2
INSERT INTO Receita (rec_nome) VALUES ('Arroz com grão de bico 2'); --2

-- Receitas Ingredientes

-- Arroz com fritas
-- 1100
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (1, 2, 100); -- 100g de arroz
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (1, 1, 100); -- 100g de batata frita

-- Arroz com Grão de Bico
-- 600
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (2, 2, 100); -- 100g de arroz
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (2, 4, 100); -- 100g de grão de bico

-- Arroz com Grão de Bico 2
-- 300
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (3, 2, 50); -- 50g de arroz
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (3, 4, 50); -- 50g de grão de bico

-- Refeição
INSERT INTO Refeicao (ref_nome, ref_descricao, rec_id) VALUES ('Arroz com Fritas', 'Arroz com fritas da vovó cilda', 1); 
INSERT INTO Refeicao (ref_nome, ref_descricao, rec_id) VALUES ('Arroz com grão de bico', 'Arroz simples com grão de bico', 2); 
INSERT INTO Refeicao (ref_nome, ref_descricao, rec_id) VALUES ('Arroz com grão de bico INSUF', 'Arroz simples com grão de bico PEQUENO', 3); 

-- Avaliacao
INSERT INTO Avaliacao (nome) VALUES ('P1');
INSERT INTO Avaliacao (nome) VALUES ('P2');
INSERT INTO Avaliacao (nome) VALUES ('VS');

INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 25, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 25,10.0);


-- Nota
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 1, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 1, 3.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (3, 1, 5.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 2, 2.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 2, 2.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 3, 1.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 3, 5.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 4, 8.5);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 4, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 5, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 5, 10.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 6, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 6, 4.9);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (3, 6, 3.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 7, 1.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 7, 1.5);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 8, 2.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 8, 3.7);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 9, 1.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 9, 0.7);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 10, 6.3);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 10, 7.8);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 11, 5.2);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 11, 5.8);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (3, 11, 7.5);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 12, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 12, 7.0);

INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 13, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 13, 3.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (3, 13, 6.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 14, 2.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 14, 10.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 15, 1.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 15, 5.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 16, 8.5);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 16, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 17, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 17, 10.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 18, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 18, 4.9);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (3, 18, 3.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 19, 1.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 19, 1.5);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 20, 2.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 20, 3.7);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 21, 1.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 21, 0.7);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 22, 6.3);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 22, 7.8);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 23, 5.2);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 23, 5.8);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (3, 23, 7.5);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 24, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 24, 7.0);

-- Contrato
INSERT INTO Contrato (contr_descricao, contr_aluno_id, contr_tem_bolsa) VALUES ('Contratinho do pai', 1, TRUE);

-- Venda
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-01', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-01', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 2, 1, '2019-01-02', 1);--bem
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 2, 1, '2019-01-03', 1);--bem
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-04', 1);--mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-04', 1);--mal

INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data) VALUES (19.90, 14.90, 2, 1, '2019-01-05');--bem
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data) VALUES (19.90, 14.90, 2, 1, '2019-01-06');--bem

INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-07', 1);--mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-07', 1);--mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-08', 1);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-08', 1);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-09', 1);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 1, 1, '2019-01-09', 1);

INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 2, 1, '2019-10-10', 1);--bem
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 14.90, 2, 1, '2019-10-11', 1);



-- Recomendacao_nutricional
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (800, 10, 1, 50); -- 20g de gordura pra 10 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (800, 10, 2, 50); -- 40g de carbo pra 10 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (800, 10, 3, 50); -- 30g de proteína pra 10 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (800, 10, 4, 50); -- 0.5g de fibra pra 10 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (800, 10, 5, 50); -- 400 calorias pra 10 anos

INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (400, 6, 1, 50); -- 10g de gordura pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (400, 6, 2, 50); -- 10g de carbo pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (400, 6, 3, 50); -- 1g de proteína pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (400, 6, 4, 50); -- 0.3g de fibra pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (400, 6, 5, 50); -- 300 calorias pra 6 anos

INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (600, 8, 1, 50); -- 10g de gordura pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (600, 8, 2, 50); -- 23g de carbo pra 8 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (600, 8, 3, 50); -- 1g de proteína pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (600, 8, 4, 50); -- 0.6g de fibra pra 6 anos
INSERT INTO Recomendacao_nutricional (valor, idade, nut_id, margem_percent) VALUES (600, 8, 5, 50); -- 300 calorias pra 6 anos


-- --INSERTS PARA QUEBRAR RESTRIÇÃO 3
/*
--Para Receita_Ingrediente
 INSERT INTO Receita (rec_nome) VALUES ('Bacon com creme de goiabada 1'); --3

 INSERT INTO Refeicao (ref_nome, ref_descricao, rec_id) VALUES ('Bacon com creme de goiabada', 'Delicioso prato agridoce', 3); 

-- -- Bacon
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (6, 5, 10); --Calorias
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (6, 3, 10); -- Gordura saturada
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (6, 1, 10); -- Carboidratos
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (6, 4, 10); -- Proteína

-- --Creme de Leite
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (3, 5, 7); --Calorias
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (3, 4, 7); -- Gordura saturada
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (3, 1, 7); -- Carboidratos

 -- Goiabada
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (5, 5, 10); --Calorias
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (5, 1, 10); -- Carboidratos
 INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (5, 2, 10); -- Proteína

 INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (3, 6, 100); -- 100g de bacon
 INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (3, 3, 70); -- 70g de Creme de leite
 INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (3, 5, 100); -- 100g de goiabada

--Para Recomendacao Nutricional
 UPDATE RECOMENDACAO_NUTRICIONAL SET valor=0 where nut_id=1 and idade=6;

--Para Valor Nutricional
UPDATE Valor_Nutricional set valor=100 where nut_id=1 and ing_id=1;
*/

--INSERTS PARA RESTRIÇÃO 1
/*
--Para a Bolsa:
INSERT INTO Bolsa (bol_media_min, bol_val_percent, bol_data_ini, bol_data_fim, bol_aluno_id) VALUES (7, 20, '2019-01-01', null, 1); 

--Para a nota
INSERT INTO Bolsa (bol_media_min, bol_val_percent, bol_data_ini, bol_data_fim, bol_aluno_id) VALUES (7, 20, '2019-01-01', null, 11);
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES  (true, 11, 2, '2019-01-01'); 

INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, 36, 7.0);
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (2, 36, 5.0);


--Para a Venda
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data) VALUES (19.90, 14.90, 1, 10, '2019-01-01');
*/


--INSERTS PARA RESTRICAO 2
--Para a Venda
/*
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (false, 10, 1, '2019-01-01');
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, (select insc_id from inscricao order by insc_id desc limit 1), 9.5);

INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-01', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-01', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-02', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-02', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-03', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-03', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-04', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-04', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-05', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-05', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-06', 1); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 10, '2019-01-06', 1);

-- Para a nota
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (true, 7, 1, '2019-01-01');

INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-01', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-01', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-02', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-02', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-03', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-03', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-04', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-04', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-05', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-05', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-06', null); --mal
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 1, 7, '2019-01-06', null); --mal

INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, (select insc_id from inscricao order by insc_id desc limit 1), 9.1); -- deve retornar erro

-- Para valor nutricional
INSERT INTO Inscricao (insc_ativa, insc_aluno_id, insc_disciplina_id, insc_data) VALUES (true, 6, 1, '2019-01-01'); 
INSERT INTO Nota (avaliacao_id, inscricao_id, nota) VALUES (1, (select insc_id from inscricao order by insc_id desc limit 1), 9.1);

INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 2, 6, '2019-01-01', null);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 2, 6, '2019-01-02', null);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 2, 6, '2019-01-03', null);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 2, 6, '2019-01-04', null);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 2, 6, '2019-01-05', null);
INSERT INTO Venda (ven_preco, ven_valor_pago, ven_refeicao_id, ven_aluno_id, ven_data, ven_contrato_id) VALUES (19.90, 19.90, 2, 6, '2019-01-06', null);

UPDATE Valor_nutricional SET valor = (valor * 10) where ing_id = 2;

*/