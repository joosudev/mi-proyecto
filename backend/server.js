const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();

// Habilitar CORS
app.use(cors());

// Servir archivos estáticos del frontend
app.use(express.static(path.join(__dirname, '../frontend')));

app.get('/api', (req, res) => {
  res.json({ message: "Hola desde el Back End!" });
});

// Cualquier otra ruta servirá el archivo `index.html` del frontend
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend', 'index.html'));
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor en ejecución en el puerto ${port}`);
});
