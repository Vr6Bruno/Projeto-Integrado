
CREATE TABLE alunos (
                matricula_pk VARCHAR(10) NOT NULL,
                nome_aluno VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                curso VARCHAR(40) NOT NULL,
                endereco VARCHAR(512) NOT NULL,
                CONSTRAINT nome_aluno_pk PRIMARY KEY (matricula_pk)
);
COMMENT ON TABLE alunos IS 'Tabela referente aos alunos.';
COMMENT ON COLUMN alunos.matricula_pk IS 'Número de matrícula dos alunos.';
COMMENT ON COLUMN alunos.nome_aluno IS 'Nome dos alunos.';
COMMENT ON COLUMN alunos.email IS 'Email dos alunos.';
COMMENT ON COLUMN alunos.curso IS 'Curso dos alunos.';
COMMENT ON COLUMN alunos.endereco IS 'Endereço dos alunos.';


CREATE TABLE certificados (
                id_certificado NUMERIC(38) NOT NULL,
                data_envio TIMESTAMP NOT NULL,
                materia VARCHAR(100) NOT NULL,
                situacao VARCHAR(15) NOT NULL,
                matricula_pk VARCHAR(10) NOT NULL,
                CONSTRAINT id_certificado_pk PRIMARY KEY (id_certificado)
);
COMMENT ON TABLE certificados IS 'Tabela referente aos certificados enviados pelos alunos.';
COMMENT ON COLUMN certificados.id_certificado IS 'Número que identifica o certificado.';
COMMENT ON COLUMN certificados.data_envio IS 'Data que enviou o certificado.';
COMMENT ON COLUMN certificados.materia IS 'Matéria dos certificados dos alunos.';
COMMENT ON COLUMN certificados.situacao IS 'Situação do certificado: Aprovado, Pendente e Reprovado.';
COMMENT ON COLUMN certificados.matricula_pk IS 'Número de matrícula dos alunos.';


CREATE TABLE coordenadores (
                id_coordenador NUMERIC(38) NOT NULL,
                nome_coordenador VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                id_certificado NUMERIC(38) NOT NULL,
                CONSTRAINT nome_coordenador_pk PRIMARY KEY (id_coordenador)
);
COMMENT ON TABLE coordenadores IS 'Tabela referente aos coordenadores.';
COMMENT ON COLUMN coordenadores.id_coordenador IS 'Número de identificação dos coordenadores.';
COMMENT ON COLUMN coordenadores.nome_coordenador IS 'Nome dos coordenadores.';
COMMENT ON COLUMN coordenadores.email IS 'Email de contato dos coordenadores.';
COMMENT ON COLUMN coordenadores.id_certificado IS 'Número que identifica o certificado.';


CREATE TABLE login (
                matricula_pk VARCHAR(10) NOT NULL,
                id_coordenador NUMERIC(38) NOT NULL,
                senha_coordenador VARCHAR(20) NOT NULL,
                senha_aluno VARCHAR(20) NOT NULL,
                CONSTRAINT matricula_id_coordenador_pk PRIMARY KEY (matricula_pk, id_coordenador)
);
COMMENT ON TABLE login IS 'Tabela referente ao login dos alunos e coordenadores.';
COMMENT ON COLUMN login.matricula_pk IS 'Número de matrícula dos alunos.';
COMMENT ON COLUMN login.id_coordenador IS 'Número de identificação dos coordenadores.';
COMMENT ON COLUMN login.senha_coordenador IS 'Senha de acesso dos coordenadores.';
COMMENT ON COLUMN login.senha_aluno IS 'Senha de acesso dos alunos.';


ALTER TABLE login ADD CONSTRAINT alunos_login_fk
FOREIGN KEY (matricula_pk)
REFERENCES alunos (matricula_pk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE certificados ADD CONSTRAINT alunos_certificados_fk
FOREIGN KEY (matricula_pk)
REFERENCES alunos (matricula_pk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE coordenadores ADD CONSTRAINT certificados_coordenadores_fk
FOREIGN KEY (id_certificado)
REFERENCES certificados (id_certificado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE login ADD CONSTRAINT coordenadores_login_fk
FOREIGN KEY (id_coordenador)
REFERENCES coordenadores (id_coordenador)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
