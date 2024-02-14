# Utiliza la imagen oficial de Node.js como base
FROM node:14

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo de la aplicación y cualquier otro archivo necesario
COPY package.json package-lock.json /app/
COPY app.js /main.dart.js/  

# Instala las dependencias de la aplicación
RUN npm install

# Expone el puerto en el que se ejecutará la aplicación (predeterminado: 8080)
EXPOSE 8080

# Define el comando para ejecutar la aplicación
CMD ["node", "main.dart.js"]  