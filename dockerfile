# Usa una imagen base para el backend
FROM node:16 AS backend

# Establece el directorio de trabajo para el backend
WORKDIR /app/backend

# Copia los archivos necesarios del backend
COPY backend/package*.json ./
RUN npm install

COPY backend/ ./
# Si no tienes un comando de build en el backend, puedes comentar esta línea
RUN npm run build  

# Usa una imagen base para el frontend
FROM node:16 AS frontend

# Establece el directorio de trabajo para el frontend
WORKDIR /app/frontend

# Copia los archivos necesarios del frontend
COPY frontend/package*.json ./
RUN npm install

COPY frontend/ ./
RUN npm run build

# Usa una imagen ligera para servir la aplicación
FROM node:16-alpine

# Instala el servidor estático
RUN npm install -g serve

# Copia el backend y frontend ya construidos en la imagen final
COPY --from=backend /app/backend /app/backend
COPY --from=frontend /app/frontend /app/frontend

# Expone los puertos
EXPOSE 80
EXPOSE 3000

# Inicia el backend y el frontend en paralelo
CMD ["sh", "-c", "node /app/backend/server.js & serve -s /app/frontend -l 80"]
