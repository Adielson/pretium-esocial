create table EST_ENVIO_EVENTO (
       COD_ENVIO_EVENTO integer not null, 
       TXT_ERRO_INTERNO text, 
       DTA_GERACAO_EVENTO timestamp, 
       COD_RESPOSTA integer, 
       COD_EVENTO integer, 
       COD_LOTE integer, 
       NUM_VERSAO varchar(100));

create table EST_ERRO_PROCESSAMENTO (
       COD_ERRO_PROCESSAMENTO integer not null, 
       COD_TIPO_ERRO_PROCESSAMENTO integer, 
       COD_ENVIO_EVENTO integer, 
       DES_ERRO varchar(4000), 
       TXT_LOCALIZACAO varchar(300),
       COD_MENSAGEM integer);

create table EST_ESTADO (
       COD_ESTADO integer not null, 
       TXT_DESCRICAO varchar(25) not null);
       
create table EST_LOTE ( 
       COD_LOTE integer not null, 
       COD_ESTADO integer not null, 
       COD_RESPOSTA integer, 
       TXT_PROTOCOLO varchar(35), 
       TXT_RETORNO text, 
       DTA_ENVIO timestamp, 
       TXT_ERRO_INTERNO text, 
       TXT_XML_LOTE text);

create table EST_EVENTO ( 
       COD_EVENTO integer not null, 
  	   COD_OCORRENCIA integer,
       COD_TIPO integer, 
       COD_ESTADO integer, 
       TXT_ID_EVENTO varchar(36),
       TXT_NR_RECIBO varchar(40));
       
create table EST_GRUPO_TIPO_EVENTO ( 
       COD_GRUPO_TIPO integer not null, 
       TXT_DESCRICAO varchar(100) not null);

create table EST_OCORRENCIA ( 
       COD_OCORRENCIA integer not null, 
       TXT_TIPO_OCORRENCIA varchar(30), 
       TXT_REFERENCIA varchar(100), 
       TXT_OPERACAO varchar(15), 
       TXT_RETIFICAR_RECIBO varchar(40),
       DTA_OCORRENCIA timestamp, 
       DTA_RECEBIMENTO timestamp, 
       TXT_DADOS_OCORRENCIA text);

create table EST_TIPO ( 
       COD_TIPO integer not null, 
       COD_GRUPO_TIPO integer, 
       DES_TIPO varchar(100));
       
create table EST_TIPO_ERRO_PROCESSAMENTO ( 
       COD_TIPO_ERRO_PROCESSAMENTO integer not null, 
       DES_TIPO_OCORRENCIA varchar(40) not null);

create table EST_RESPOSTA_GOV ( 
       COD_IDENTIFICADOR integer not null, 
       DES_RESPOSTA varchar(300),
       COD_GRUPO_RESPOSTA integer,
       COD_RESPOSTA integer);
       
create table EST_EVENTO_TOTALIZADOR (
       COD_EVENTO_TOTALIZADOR integer not null, 
       TXT_TIPO varchar(5),
       TXT_NR_RECIBO_ARQ_BASE varchar(40),
       NUM_IND_APURACAO integer,
       TXT_PER_APURACAO varchar(7),
       NUM_CPF_TRABALHADOR varchar(11),
  	   TXT_XML_EVENTO_TOTALIZADOR text);

alter table EST_ENVIO_EVENTO add constraint EST_ENVIO_EVENTO_PK primary key (COD_ENVIO_EVENTO);
alter table EST_ERRO_PROCESSAMENTO add constraint EST_ERRO_PROCESSAMENTO_PK primary key (COD_ERRO_PROCESSAMENTO);
alter table EST_ESTADO add constraint EST_ESTADO_PK primary key (COD_ESTADO);
alter table EST_LOTE add constraint EST_LOTE_PK primary key (COD_LOTE);
alter table EST_EVENTO add constraint EST_EVENTO_PK primary key (COD_EVENTO);
alter table EST_EVENTO add constraint EST_EVENTO_UK01 unique (TXT_NR_RECIBO);
alter table EST_GRUPO_TIPO_EVENTO add constraint EST_GRUPO_TIPO_PK primary key (COD_GRUPO_TIPO);
alter table EST_OCORRENCIA add constraint EST_OCORRENCIA_PK primary key (COD_OCORRENCIA);
alter table EST_TIPO add constraint EST_TIPO_PK primary key (COD_TIPO);
alter table EST_TIPO_ERRO_PROCESSAMENTO add constraint EST_TIPO_OCORRENCIA_RETORNO_PK primary key (COD_TIPO_ERRO_PROCESSAMENTO);
alter table EST_RESPOSTA_GOV add constraint EST_RESPOSTA_PK primary key (COD_IDENTIFICADOR);
alter table EST_EVENTO_TOTALIZADOR add constraint EST_EVENTO_TOTALIZADOR_PK primary key (COD_EVENTO_TOTALIZADOR);

alter table EST_ENVIO_EVENTO add constraint EST_ENVIO_EVENTO_FK01 foreign key (COD_RESPOSTA)
      references EST_RESPOSTA_GOV (COD_IDENTIFICADOR);
alter table EST_ENVIO_EVENTO add constraint EST_ENVIO_EVENTO_FK02 foreign key (COD_LOTE)
      references EST_LOTE (COD_LOTE);
alter table EST_ENVIO_EVENTO add constraint EST_ENVIO_EVENTO_FK03 foreign key (COD_EVENTO)
      references EST_EVENTO (COD_EVENTO);
create index EST_ENVIO_EVENTO_FK01 on EST_ENVIO_EVENTO (COD_RESPOSTA);
create index EST_ENVIO_EVENTO_FK02 on EST_ENVIO_EVENTO (COD_LOTE);
create index EST_ENVIO_EVENTO_FK03 on EST_ENVIO_EVENTO (COD_EVENTO);

alter table EST_ERRO_PROCESSAMENTO add constraint EST_ERRO_PROCESSAMENTO_FK01 foreign key (COD_ENVIO_EVENTO)
      references EST_ENVIO_EVENTO (COD_ENVIO_EVENTO);
alter table EST_ERRO_PROCESSAMENTO add constraint EST_ERRO_PROCESSAMENTO_FK02 foreign key (COD_TIPO_ERRO_PROCESSAMENTO)
      references EST_TIPO_ERRO_PROCESSAMENTO (COD_TIPO_ERRO_PROCESSAMENTO);
create index EST_ERRO_PROCESSAMENTO_FK01 on EST_ERRO_PROCESSAMENTO (COD_ENVIO_EVENTO);
create index EST_ERRO_PROCESSAMENTO_FK02 on EST_ERRO_PROCESSAMENTO (COD_TIPO_ERRO_PROCESSAMENTO);

alter table EST_EVENTO add constraint EST_EVENTO_FK01 foreign key (COD_OCORRENCIA)
    references EST_OCORRENCIA (COD_OCORRENCIA);
alter table EST_EVENTO add constraint EST_EVENTO_FK02 foreign key (COD_ESTADO)
    references EST_ESTADO (COD_ESTADO);
alter table EST_EVENTO add constraint EST_EVENTO_FK03 foreign key (COD_TIPO)
    references EST_TIPO (COD_TIPO);
create index EST_EVENTO_FK01 on EST_EVENTO (COD_OCORRENCIA);
create index EST_EVENTO_FK02 on EST_EVENTO (COD_ESTADO);
create index EST_EVENTO_FK03 on EST_EVENTO (COD_TIPO);

alter table EST_TIPO add constraint EST_TIPO_FK01 foreign key (COD_GRUPO_TIPO)
    references EST_GRUPO_TIPO_EVENTO (COD_GRUPO_TIPO);
create index EST_TIPO_FK01 on EST_TIPO (COD_GRUPO_TIPO); 

alter table EST_LOTE add constraint EST_LOTE_FK01 foreign key (COD_ESTADO)
    references EST_ESTADO (COD_ESTADO);
alter table EST_LOTE add constraint EST_LOTE_FK02 foreign key (COD_RESPOSTA)
    references EST_RESPOSTA_GOV (COD_IDENTIFICADOR);                                    
create index EST_LOTE_FK01 on EST_LOTE (COD_ESTADO);  
create index EST_LOTE_FK02 on EST_LOTE (COD_RESPOSTA);  

alter table EST_EVENTO_TOTALIZADOR add constraint EST_EVENTO_TOTALIZADOR_FK01 foreign key (TXT_NR_RECIBO_ARQ_BASE)
	  references EST_EVENTO (TXT_NR_RECIBO);
create index EST_EVENTO_TOTALIZADOR_FK01 on EST_EVENTO_TOTALIZADOR (TXT_NR_RECIBO_ARQ_BASE);

insert into EST_ESTADO (COD_ESTADO,TXT_DESCRICAO) values (1,'EM FILA');
insert into EST_ESTADO (COD_ESTADO,TXT_DESCRICAO) values (5,'ERRO');
insert into EST_ESTADO (COD_ESTADO,TXT_DESCRICAO) values (2,'PROCESSAMENTO');
insert into EST_ESTADO (COD_ESTADO,TXT_DESCRICAO) values (3,'PROCESSADO COM SUCESSO');
insert into EST_ESTADO (COD_ESTADO,TXT_DESCRICAO) values (4,'PROCESSADO COM ERRO');
insert into EST_GRUPO_TIPO_EVENTO (COD_GRUPO_TIPO,TXT_DESCRICAO) values (1,'Eventos de Tabelas');
insert into EST_GRUPO_TIPO_EVENTO (COD_GRUPO_TIPO,TXT_DESCRICAO) values (2,'Eventos N??o Peri??dicos');
insert into EST_GRUPO_TIPO_EVENTO (COD_GRUPO_TIPO,TXT_DESCRICAO) values (3,'Eventos Peri??dicos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1000,1,'Informa????es do Empregador/Contribuinte/??rg??o P??blico');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1005,1,'Tabela de Estabelecimentos, Obras ou Unidades de ??rg??os P??blicos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1010,1,'Tabela de Rubricas');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1020,1,'Tabela de Lota????es Tribut??rias');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1030,1,'Tabela de Cargos/Empregos P??blicos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1035,1,'Tabela de Carreiras P??blicas');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1040,1,'Tabela de Fun????es/Cargos em Comiss??o');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1050,1,'Tabela de Hor??rios/Turnos de Trabalho');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1060,1,'Tabela de Ambientes de Trabalho');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1070,1,'Tabela de Processos Administrativos/Judiciais');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1080,1,'Tabela de Operadores Portu??rios');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1200,3,'Remunera????o de trabalhador vinculado ao Regime Geral de Previd. Social');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1202,3,'Remunera????o de servidor vinculado a Regime Pr??prio de Previd. Social');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1207,3,'Benef??cios previdenci??rios - RPPS');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1210,3,'Pagamentos de Rendimentos do Trabalho');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1250,3,'Aquisi????o de Produ????o Rural');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1260,3,'Comercializa????o da Produ????o Rural Pessoa F??sica');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1270,3,'Contrata????o de Trabalhadores Avulsos N??o Portu??rios');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1280,3,'Informa????es Complementares aos Eventos Peri??dicos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1295,3,'Solicita????o de Totaliza????o para Pagamento em Conting??ncia');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1298,3,'Reabertura dos Eventos Peri??dicos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1299,3,'Fechamento dos Eventos Peri??dicos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (1300,3,'Contribui????o Sindical Patronal');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2200,2,'Cadastramento Inicial do V??nculo e Admiss??o/Ingresso de Trabalhador');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2205,2,'Altera????o de Dados Cadastrais do Trabalhador');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2206,2,'Altera????o de Contrato de Trabalho');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2210,2,'Comunica????o de Acidente de Trabalho');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2220,2,'Monitoramento da Sa??de do Trabalhador');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2230,2,'Afastamento Tempor??rio');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2240,2,'Condi????es Ambientais do Trabalho - Fatores de Risco');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2241,2,'Insalubridade, Periculosidade e Aposentadoria Especial');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2250,2,'Aviso Pr??vio');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2260,2,'Convoca????o para Trabalho Intermitente');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2298,2,'Reintegra????o');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2299,2,'Desligamento');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2300,2,'Trabalhador Sem V??nculo de Emprego/Estatut??rio - In??cio');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2306,2,'Trabalhador Sem V??nculo de Emprego/Estatut??rio - Altera????o Contratual');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2399,2,'Trabalhador Sem V??nculo de Emprego/Estatut??rio - T??rmino');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (2400,2,'Cadastro de Benef??cios Previdenci??rios - RPPS');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (3000,2,'Exclus??o de eventos');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (5001,2,'Informa????es das contribui????es sociais por trabalhador');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (5002,2,'Imposto de Renda Retido na Fonte');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (5011,2,'Informa????es das contribui????es sociais consolidadas por contribuinte');
insert into EST_TIPO (COD_TIPO,COD_GRUPO_TIPO,DES_TIPO) values (5012,2,'Informa????es do IRRF consolidadas por contribuinte');
insert into EST_TIPO_ERRO_PROCESSAMENTO (COD_TIPO_ERRO_PROCESSAMENTO,DES_TIPO_OCORRENCIA) values (1,'Erro');
insert into EST_TIPO_ERRO_PROCESSAMENTO (COD_TIPO_ERRO_PROCESSAMENTO,DES_TIPO_OCORRENCIA) values (2,'Advert??ncia');
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (23,'Assinante inv??lido. Assinante n??o possui perfil de procura????o eletr??nica para enviar este tipo de evento ou assinante n??o consta como representante legal da empresa. ',2,411);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (22,'Erro na integra????o com o sistema Procura????o Eletr??nica Caixa. ',2,410);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (21,'Erro na integra????o com o sistema Procura????o Eletr??nica RFB',2,409);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (20,'A regra de preced??ncia na transmiss??o de eventos n??o foi seguida. Eventos desse tipo n??o devem ser enviados para processamento em paralelo. Ver se????o 5.6.1 do Manual de Orienta????o do Desenvolvedor. ',2,407);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (19,'Evento n??o pertence ao grupo especificado no lote de eventos ',2,406);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (1,'Sucesso',2,201);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (2,'Sucesso com advert??ncia.',2,202);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (3,'Erro Servidor',2,301);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (4,'Erro no conte??do do evento.',2,401);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (5,'Schema inv??lido',2,402);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (6,'Leiaute inv??lido',2,403);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (7,'Erro do certificado digital da assinatura do evento',2,404);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (8,'Erro na assinatura evento',2,405);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (9,'Erro na integra????o com o sistema CNPJ / CPF. ',2,408);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (10,'Lote Aguardando Processamento',1,101);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (11,'Lote recebido com sucesso',1,201);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (12,'Lote recebido com Advert??ncia',1,202);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (13,'Erro Servidor ESOCIAL',1,301);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (14,'Lote Incorreto - Erro preenchimento',1,401);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (15,'Lote Incorreto - Schema Inv??lido',1,402);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (16,'Lote Incorreto - Vers??o do Schema n??o permitida',1,403);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (17,'Lote Incorreto - Erro Certificado',1,404);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (18,'Lote Incorreto - Lote nulo ou vazio',1,405);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (24,'Solicita????o de Consulta Incorreta - Erro Preenchimento',1,501);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (25,'Solicita????o de Consulta Incorreta - Schema Inv??lido',1,502);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (26,'Solicita????o de Consulta Incorreta - Vers??o do Schema N??o Permitida',1,503);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (27,'Solicita????o de Consulta Incorreta - Erro Certificado',1,504);
insert into EST_RESPOSTA_GOV (COD_IDENTIFICADOR,DES_RESPOSTA,COD_GRUPO_RESPOSTA,COD_RESPOSTA) values (30,'Solicita????o de Consulta Incorreta - Consulta nula o vazia',1,'505');


create sequence SEQ_ERRO_PROCESSAMENTO_ID minvalue 1 maxvalue 99999999 increment by 1 start with 1 cache 20 no cycle;
create sequence SEQ_EVE_ID minvalue 1 maxvalue 99999999999999999 increment by 1 start with 121 cache 20 no cycle;
create sequence SEQ_EVT_ID minvalue 1 maxvalue 99999999999 increment by 1 start with 1 cache 20 no cycle;
create sequence SEQ_OCORRENCIA_ID minvalue 1 maxvalue 99999999 increment by 1 start with 1 cache 20 no cycle;
create sequence SEQ_LOTE_ID minvalue 1 maxvalue 99999999999999999 increment by 1 start with 1 cache 20 no cycle;
create sequence SEQ_RESPOSTA_ID minvalue 100 maxvalue 99999999 increment by 1 start with 100 cache 20 no cycle;
create sequence SEQ_ENV_EVT_ID minvalue 1 maxvalue 99999999999999999 increment by 1 start with 1 cache 20 no cycle;
create sequence SEQ_EVT_TOT_ID minvalue 1 maxvalue 99999999999 increment by 1 start with 1 cache 20 no cycle;
