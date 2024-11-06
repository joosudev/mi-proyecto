const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();

// Configuración de CORS
const corsOptions = {
  origin: 'https://mi-proyecto-zcsv.onrender.com',  // Reemplaza con tu dominio de Render
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));

// Servir archivos estáticos del frontend
app.use(express.static(path.join(__dirname, '../frontend/dist')));

// Ruta de la API
app.get('/api', (req, res) => {
  res.json({ message: "Hola desde el Back End!" });
});

// Manejar cualquier otra ruta con el archivo `index.html` del frontend
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/dist', 'index.html'));
});

// Iniciar el servidor en el puerto indicado por Render
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor en ejecución en el puerto ${port}`);
});
