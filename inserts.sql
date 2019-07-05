-- Disciplinas

INSERT INTO Disciplina (disc_nome) VALUES ('Educação Alimentar');
INSERT INTO Disciplina (disc_nome) VALUES ('Português');
INSERT INTO Disciplina (disc_nome) VALUES ('Matemática');
INSERT INTO Disciplina (disc_nome) VALUES ('Robótica');
INSERT INTO Disciplina (disc_nome) VALUES ('Biologia');
INSERT INTO Disciplina (disc_nome) VALUES ('Química');
INSERT INTO Disciplina (disc_nome) VALUES ('Física');
INSERT INTO Disciplina (disc_nome) VALUES ('História');
INSERT INTO Disciplina (disc_nome) VALUES ('Filosofia');
INSERT INTO Disciplina (disc_nome) VALUES ('Geografia');
INSERT INTO Disciplina (disc_nome) VALUES ('Literatura');

-- Responsaveis

INSERT INTO Responsavel (resp_nome) VALUES ('Renata Bahiense');
INSERT INTO Responsavel (resp_nome) VALUES ('Luanna Lima Sá');
INSERT INTO Responsavel (resp_nome) VALUES ('Arly Souza Cruz');
INSERT INTO Responsavel (resp_nome) VALUES ('Gabriel Costa');
INSERT INTO Responsavel (resp_nome) VALUES ('Arthur Nascimento');
INSERT INTO Responsavel (resp_nome) VALUES ('Lucas Sorrentino');

-- Aluno
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('João', 1);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Gustavo', 1);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Gabriel', 1);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Luan', 2);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Pedro', 2);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Raíssa', 2);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Carol', 3);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Elisângela', 3);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Bruno', 3);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Lucas', 4);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Márcio', 4);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Vinícius', 4);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Flávia', 5);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Mariana', 5);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Fernanda', 6);
INSERT INTO Aluno (alu_nome, alu_responsavel_id) VALUES ('Maria', 6);

-- Nutrientes
INSERT INTO Nutriente (nome) VALUES ('Sódio'); -- 1
INSERT INTO Nutriente (nome) VALUES ('Carboidrato'); -- 2
INSERT INTO Nutriente (nome) VALUES ('Potássio'); -- 3
INSERT INTO Nutriente (nome) VALUES ('Vitamina A'); -- 4
INSERT INTO Nutriente (nome) VALUES ('Vitamina B'); -- 5
INSERT INTO Nutriente (nome) VALUES ('Vitamina C'); -- 6
INSERT INTO Nutriente (nome) VALUES ('Proteína'); -- 7
INSERT INTO Nutriente (nome) VALUES ('Fibra'); -- 8
INSERT INTO Nutriente (nome) VALUES ('Gorduras Saturadas'); --9
INSERT INTO Nutriente (nome) VALUES ('Calorias'); --10

-- Ingredientes
INSERT INTO Ingrediente (ing_nome) VALUES ('Batata Frita');
INSERT INTO Ingrediente (ing_nome) VALUES ('Arroz');
INSERT INTO Ingrediente (ing_nome) VALUES ('Creme de Leite');
INSERT INTO Ingrediente (ing_nome) VALUES ('Tomate');
INSERT INTO Ingrediente (ing_nome) VALUES ('Pão');
INSERT INTO Ingrediente (ing_nome) VALUES ('Queijo prato');
INSERT INTO Ingrediente (ing_nome) VALUES ('Alface');
INSERT INTO Ingrediente (ing_nome) VALUES ('Grão de Bico');
INSERT INTO Ingrediente (ing_nome) VALUES ('Hortelã');
INSERT INTO Ingrediente (ing_nome) VALUES ('Cebola');
INSERT INTO Ingrediente (ing_nome) VALUES ('Presunto');
INSERT INTO Ingrediente (ing_nome) VALUES ('Goiabada');
INSERT INTO Ingrediente (ing_nome) VALUES ('Bacon');


-- Valore Nutricionais

-- Batata:
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 10, 2);
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 9, 0.5);
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 2, 0.2);
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 7, 0.02);

-- Arroz:
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 10, 1.3);
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 2, 0.3);
INSERT INTO Valor_Nutricional (ing_id, nut_id, valor) VALUES (1, 8, 0.001);


-- Receitas
INSERT INTO Receita (rec_nome) VALUES ('Arroz com Fritas 1');

-- Receitas Ingredientes
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (1, 2, 200); -- 200g de arroz
INSERT INTO Receita_Ingrediente (rec_id, ing_id, qtd) VALUES (1, 1, 150); -- 150g de batata frita

-- Refeição
INSERT INTO Refeicao (ref_nome, ref_descricao, rec_id) VALUES ('Arroz com Fritas', 'Arroz com fritas da vovó cilda', 1); 