FROM debian:bullseye-slim

# Instalar dependencias requeridas
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl wget openssl net-tools screen iptables-persistent dos2unix && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar los archivos necesarios
WORKDIR /app
COPY slipstream.sh .

# Corregir posibles caracteres de fin de línea (CRLF -> LF)
RUN dos2unix slipstream.sh \
    && chmod +x slipstream.sh \
    && sed -i 's/\r$//' slipstream.sh

# Exponer el puerto necesario (aquí el 8080)
EXPOSE 8080

# Iniciar el script al ejecutar el contenedor
CMD ["bash", "/app/slipstream.sh"]
