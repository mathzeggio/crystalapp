FROM crystallang/crystal:1.8.2

RUN apt-get update && apt-get install -y postgresql

WORKDIR /app

COPY . /app

RUN shards install