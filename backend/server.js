const express = require('express');
const cors = require('cors');  // Importa el middleware de CORS
const app = express();

// Habilitar CORS
app.use(cors());

app.get('/api', (req, res) => {
  res.json({ message: "Hola desde el Back End!" });
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor en ejecución en el puerto ${port}`);
});
