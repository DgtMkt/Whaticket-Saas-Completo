FROM node:16

# Atualizando e instalando dependências
RUN apt-get update && \
    apt-get install -y sudo curl wget nginx postgresql redis gnupg && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Define o diretório de trabalho
WORKDIR /usr/src/app

# Copiar arquivos package.json e package-lock.json, se aplicável
COPY ./package*.json ./

# Instalar dependências
RUN npm install --legacy-peer-deps --no-audit --no-fund --verbose

# Copiar o restante do projeto
COPY . .

# Expor a porta que o app usa
EXPOSE 3000

# Rodar o app
CMD ["npm", "start"]
