CREATE TABLE Disciplina
	(disc_id serial PRIMARY KEY,
	 disc_nome VARCHAR(30) NOT NULL);

CREATE TABLE Responsavel
	(resp_id serial PRIMARY KEY,
	 resp_nome VARCHAR(30) NOT NULL);

CREATE TABLE Aluno
	(alu_id serial PRIMARY KEY,
	 alu_nome VARCHAR(30) NOT NULL,
	 alu_responsavel_id INT NOT NULL,
	 FOREIGN KEY (alu_responsavel_id) REFERENCES Responsavel(resp_id));

CREATE TABLE Contrato
	(contr_id serial PRIMARY KEY,
	 contr_descricao VARCHAR(100) NOT NULL,
	 contr_aluno_id INT NOT NULL,
	 FOREIGN KEY (contr_aluno_id) REFERENCES Aluno(alu_id));

CREATE TABLE Bolsa
	(bol_id serial PRIMARY KEY,
	 bol_media_min REAL NOT NULL,
	 bol_val_percent REAL NOT NULL,
	 bol_data_ini DATE NOT NULL,
	 bol_data_fim DATE,
	 bol_aluno_id INT NOT NULL,
	 FOREIGN KEY (bol_aluno_id) REFERENCES Aluno(alu_id));
 
CREATE TABLE Refeicao
	(ref_id serial PRIMARY KEY,
	 ref_nome VARCHAR(30) NOT NULL,
	 ref_descricao VARCHAR(100) NOT NULL);

CREATE TABLE Venda
	(ven_id serial PRIMARY KEY,
	 ven_preco REAL NOT NULL,
	 ven_valor_pago REAL NOT NULL,
	 ven_contrato_id INT NOT NULL,
	 ven_refeicao_id INT NOT NULL,
	 ven_aluno_id INT NOT NULL,
	 FOREIGN KEY (ven_contrato_id) REFERENCES Contrato(contr_id),
	 FOREIGN KEY (ven_refeicao_id) REFERENCES Refeicao(ref_id),
	 FOREIGN KEY (ven_aluno_id) REFERENCES Aluno(alu_id));

CREATE TABLE Inscricao
	(insc_id serial PRIMARY KEY,
	 insc_ativa BOOLEAN NOT NULL,
	 insc_aluno_id INT NOT NULL,
	 insc_disciplina_id INT NOT NULL,
	 FOREIGN KEY (insc_aluno_id) REFERENCES Aluno(alu_id),
	 FOREIGN KEY (insc_disciplina_id) REFERENCES Disciplina (disc_id));