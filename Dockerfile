# Etapa 1: Definir a imagem base Node.js
FROM node:16

# Etapa 2: Instalar pacotes necessários
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis && \
    apt-get install -y gnupg && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Etapa 3: Definir diretório de trabalho
WORKDIR /usr/src/app

# Etapa 4: Copiar arquivos package.json e package-lock.json
COPY package*.json ./

# Etapa 5: Instalar dependências do Node.js
RUN npm install --legacy-peer-deps

# Etapa 6: Copiar o restante dos arquivos da aplicação
COPY . .

# Etapa 7: Expor porta da aplicação
EXPOSE 3000

# Etapa 8: Comando para rodar a aplicação
CMD ["npm", "start"]
