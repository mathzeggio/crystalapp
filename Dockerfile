FROM crystallang/crystal:1.0.0

# Instalação do PostgreSQL e dependências
RUN apt-get update && apt-get install -y postgresql

# Copia os arquivos de configuração do PostgreSQL
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY start_postgres.sh /docker-entrypoint-initdb.d/start_postgres.sh
RUN chmod +x /docker-entrypoint-initdb.d/start_postgres.sh

# Define o diretório de trabalho da aplicação
WORKDIR /app

# Copia o código-fonte da aplicação
COPY . /app

# Instala as dependências do Crystal
RUN shards install

# Executa as migrações do banco de dados
RUN crystal sam.cr db:migrate

# Inicia o servidor da aplicação
CMD crystal run src/app.cr
