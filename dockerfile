# Usa una imagen base para el backend
FROM node:16 AS backend

# Establece el directorio de trabajo para el backend
WORKDIR /backend

# Copia los archivos necesarios del backend
COPY backend/package*.json ./
RUN npm install

COPY backend/ ./
# Asegúrate de que el backend esté listo para ejecutarse
RUN npm run build || echo "No build script for backend"

# Usa una imagen base para el frontend
FROM node:16 AS frontend

# Establece el directorio de trabajo para el frontend
WORKDIR /frontend

# Copia los archivos necesarios del frontend
COPY frontend/package*.json ./
RUN npm install

COPY frontend/ ./
RUN npm run build

# Usa una imagen ligera para servir la aplicación
FROM node:16-alpine

# Instala el servidor estático para el frontend
RUN npm install -g serve

# Copia el backend y frontend ya construidos en la imagen final
COPY --from=backend /backend /backend
COPY --from=frontend /frontend/dist /frontend

# Configura los puertos
EXPOSE 80
EXPOSE 3000

# Inicia el backend y el frontend en paralelo
CMD ["sh", "-c", "node /backend/server.js & serve -s /frontend -l 80"]

