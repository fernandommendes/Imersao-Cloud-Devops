# Etapa 1: Escolher uma imagem base
# Usar uma imagem 'slim' é uma boa prática para manter o tamanho da imagem final menor.
# A versão 3.11 é estável e atende ao pré-requisito do projeto (Python 3.10+).
FROM python:3.11-slim-bullseye

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Isso é feito primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída ao alterar o código.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# O --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 7: Comando para executar a aplicação
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
# O uvicorn é o servidor ASGI recomendado para FastAPI.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

