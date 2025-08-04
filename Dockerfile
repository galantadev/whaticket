FROM node:18

# Evita prompts interativos no apt
ENV DEBIAN_FRONTEND=noninteractive

# Garante fontes atualizadas e ignora erros de rede temporários
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia apenas os arquivos de dependência primeiro (melhora cache)
COPY package*.json ./
RUN npm install

# Copia o restante dos arquivos
COPY . .

# Compila a aplicação (pode ser removido se rodar com `dev`)
RUN npm run build

# Expõe a porta usada pelo frontend
EXPOSE 3000

# Comando padrão
CMD ["npm", "start"]
