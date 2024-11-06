# Usa una imagen base para el backend
FROM node:16 AS backend

# Establece el directorio de trabajo para el backend
WORKDIR /app/backend

# Copia y instala las dependencias del backend
COPY backend/package*.json ./
RUN npm install

# Copia el resto del código del backend
COPY backend/ ./

# Usa una imagen base para el frontend
FROM node:16 AS frontend

# Establece el directorio de trabajo para el frontend
WORKDIR /app/frontend

# Copia y instala las dependencias del frontend
COPY frontend/package*.json ./
RUN npm install

# Copia el resto del código del frontend y construye la aplicación
COPY frontend/ ./
RUN npm run build

# Usa una imagen ligera para servir la aplicación en el contenedor final
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
CMD ["sh", "-c", "node /app/backend/server.js & serve -s /app/frontend/dist -l 80"]
