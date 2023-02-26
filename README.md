<h1 align="center"> Sistema de Controle de Contêineres e Movimentações </h1>

<h2 align="center"> Descrição </h2>

O projeto é um sistema de controle onde é possível cadastrar, alterar, ler e excluir registros de Contêineres e Movimentações, que também conta com a funcionalidade de gerar relatório.

<h2 align="center"> Requisitos Funcionais da aplicação: </h2>

### Crud de Contêiner:

* Cliente
* Número do contêiner (4 letras e 7 números. Ex: TEST1234567)
* Tipo: 20 / 40
* Status: Cheio / Vazio
* Categoria: Importação / Exportação

### Crud de Movimentações:

* Tipo	de	Movimentação	(embarque,	descarga,	gate	in,	gate	out, reposicionamento, pesagem, scanner)
* Data e Hora do Início
* Data e Hora do Fim

### Relatório  com   o   total   de   movimentações   agrupadas   por   cliente   e   tipo  de movimentação.
* No final do relatório deverá conter um sumário com o total de importação / exportação.

<h2 align="center"> Instalação Local </h2>

Para executar o projeto localmento você pode utilizar o arquivo .WAR que se encontra na pasta dist e implata-lo pelo gerenciador de aplicações web do servidor web Apache Tomcat, ou baixar todo o projeto, abri-lo e executa-lo na IDE Apache NetBeans versão 15 com o Tomcat adicionado na IDE.

<h2 align="center"> Construído Com </h2>

* HTML
* CSS
* JavaScript
* JAVA
* SQL

<h2 align="center"> Versão das Linguagens e Ferramentas

#### Servidor de base de dados

* SQLite - 3.36.0

#### Servidor Web

* Apache Tomcat - 9.0.65

#### Ferramentas

* IDE Apache NetBeans - 15
* [JDBC Para SQLite](https://github.com/xerial/sqlite-jdbc/releases) - 3.36.0.3

<h2 align="center"> Autor </h2>

* **Brian Melisnki Bianchini**
