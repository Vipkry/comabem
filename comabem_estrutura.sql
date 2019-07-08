DROP TABLE IF EXISTS DISCIPLINA CASCADE;
DROP TABLE IF EXISTS RESPONSAVEL CASCADE;
DROP TABLE IF EXISTS ALUNO CASCADE;
DROP TABLE IF EXISTS NUTRIENTE CASCADE;
DROP TABLE IF EXISTS VALOR_NUTRICIONAL CASCADE;
DROP TABLE IF EXISTS INGREDIENTE CASCADE;
DROP TABLE IF EXISTS RECEITA CASCADE;
DROP TABLE IF EXISTS REFEICAO CASCADE;
DROP TABLE IF EXISTS RECEITA_INGREDIENTE CASCADE;
DROP TABLE IF EXISTS VENDA CASCADE;
DROP TABLE IF EXISTS CONTRATO CASCADE;
DROP TABLE IF EXISTS INSCRICAO CASCADE;
DROP TABLE IF EXISTS AVALIACAO CASCADE;
DROP TABLE IF EXISTS NOTA CASCADE;
DROP TABLE IF EXISTS BOLSA CASCADE;
DROP TABLE IF EXISTS RECOMENDACAO_NUTRICIONAL CASCADE;

CREATE TABLE IF NOT EXISTS  Disciplina 
	(disc_id serial PRIMARY KEY,
	 disc_nome VARCHAR(30) NOT NULL);

CREATE TABLE IF NOT EXISTS  Responsavel 
	(resp_id serial PRIMARY KEY,
	 resp_nome VARCHAR(30) NOT NULL);

CREATE TABLE IF NOT EXISTS Aluno 
	(alu_id serial PRIMARY KEY,
	 alu_nome VARCHAR(30) NOT NULL,
	 alu_responsavel_id INT NOT NULL,
	 idade INT NOT NULL,
	 FOREIGN KEY (alu_responsavel_id) REFERENCES Responsavel(resp_id));

CREATE TABLE IF NOT EXISTS Contrato
	(contr_id serial PRIMARY KEY,
	 contr_descricao VARCHAR(100) NOT NULL,
	 contr_aluno_id INT NOT NULL,
	 contr_tem_bolsa BOOLEAN DEFAULT FALSE,
	 FOREIGN KEY (contr_aluno_id) REFERENCES Aluno(alu_id));

CREATE TABLE IF NOT EXISTS Bolsa 
	(bol_id serial PRIMARY KEY,
	 bol_media_min REAL NOT NULL,
	 bol_val_percent REAL NOT NULL,
	 bol_data_ini DATE NOT NULL,
	 bol_data_fim DATE,
	 bol_aluno_id INT NOT NULL,
	 FOREIGN KEY (bol_aluno_id) REFERENCES Aluno(alu_id));
 
CREATE TABLE IF NOT EXISTS Receita
	(rec_id serial PRIMARY KEY,
	 rec_nome VARCHAR(30) NOT NULL);

CREATE TABLE IF NOT EXISTS Refeicao 
	(ref_id serial PRIMARY KEY,
	 ref_nome VARCHAR(30) NOT NULL,
	 ref_descricao VARCHAR(100) NOT NULL,
	 rec_id INT NOT NULL,
	 FOREIGN KEY (rec_id) REFERENCES Receita(rec_id));

CREATE TABLE IF NOT EXISTS Ingrediente
	(ing_id serial PRIMARY KEY,
	 ing_nome VARCHAR(30) NOT NULL);

CREATE TABLE IF NOT EXISTS Receita_Ingrediente
	(rec_ing_id serial PRIMARY KEY,
	 qtd FLOAT NOT NULL,
	 rec_id INT NOT NULL,
	 ing_id INT NOT NULL,
	 FOREIGN KEY (rec_id) REFERENCES Receita(rec_id),
	 FOREIGN KEY (ing_id) REFERENCES Ingrediente(ing_id));

CREATE TABLE IF NOT EXISTS Venda 
	(ven_id serial PRIMARY KEY,
	 ven_preco REAL NOT NULL,
	 ven_valor_pago REAL NOT NULL,
	 ven_contrato_id INT DEFAULT NULL,
	 ven_refeicao_id INT NOT NULL,
	 ven_aluno_id INT NOT NULL,
	 ven_data DATE NOT NULL,
	 ven_desconta_ponto BOOLEAN DEFAULT FALSE,
	 FOREIGN KEY (ven_contrato_id) REFERENCES Contrato(contr_id),
	 FOREIGN KEY (ven_refeicao_id) REFERENCES Refeicao(ref_id),
	 FOREIGN KEY (ven_aluno_id) REFERENCES Aluno(alu_id));

CREATE TABLE IF NOT EXISTS Inscricao
	(insc_id serial PRIMARY KEY,
	 insc_ativa BOOLEAN NOT NULL,
	 insc_aluno_id INT NOT NULL,
	 insc_disciplina_id INT NOT NULL,
	 insc_data DATE NOT NULL,
	 FOREIGN KEY (insc_aluno_id) REFERENCES Aluno(alu_id),
	 FOREIGN KEY (insc_disciplina_id) REFERENCES Disciplina (disc_id));

CREATE TABLE IF NOT EXISTS Avaliacao 
	(av_id serial PRIMARY KEY,
	 nome VARCHAR(255) NOT NULL);

CREATE TABLE IF NOT EXISTS Nota
	(nota_id serial PRIMARY KEY,
	 avaliacao_id INT NOT NULL,
	 inscricao_id INT NOT NULL,
	 nota FLOAT NOT NULL,
	 FOREIGN KEY (avaliacao_id) REFERENCES Avaliacao(av_id),
	 FOREIGN KEY (inscricao_id) REFERENCES Inscricao(insc_id));

CREATE TABLE IF NOT EXISTS Nutriente -- Sódio potássio etc
	(nut_id serial PRIMARY KEY,
	 nome VARCHAR(255) NOT NULL);

CREATE TABLE IF NOT EXISTS Valor_nutricional
	(val_nut_id serial PRIMARY KEY,
	 ing_id INT NOT NULL,
	 nut_id INT NOT NULL,
	 valor FLOAT NOT NULL, -- miligrama
	 FOREIGN KEY (ing_id) REFERENCES Ingrediente(ing_id),
	 FOREIGN KEY (nut_id) REFERENCES Nutriente(nut_id));

CREATE TABLE IF NOT EXISTS Recomendacao_nutricional
	(recomendacao_id SERIAL PRIMARY KEY,
	 valor FLOAT NOT NULL,
	 idade INT NOT NULL,
	 nut_id INT NOT NULL,
	 margem_percent FLOAT NOT NULL,
	 FOREIGN KEY (nut_id) REFERENCES Nutriente(nut_id));
