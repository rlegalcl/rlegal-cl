# ====================
# Etapa de construcción del Backend
# ====================
# Usa una imagen oficial de Node.js como imagen base
FROM node:16 AS backend-build

# Establece el directorio de trabajo para el backend
WORKDIR /app/backend

# Copia los archivos de dependencias y de configuración
COPY backend/package*.json ./
COPY backend/tsconfig.json ./

# Instala las dependencias del backend
RUN npm install

# Copia el resto del código fuente del backend
COPY backend/ .

# Compila el backend
RUN npm run build

# ====================
# Contenedor final para ejecutar el Backend
# ====================
# Usa una nueva imagen de Node.js
FROM node:16

# Establece el directorio de trabajo en el contenedor final
WORKDIR /app/backend

# Copia los archivos compilados y dependencias desde la etapa anterior
COPY --from=backend-build /app/backend ./

# Expone el puerto utilizado por el backend
EXPOSE 8080

# Define el comando por defecto para ejecutar el backend
CMD ["npm", "start"]
