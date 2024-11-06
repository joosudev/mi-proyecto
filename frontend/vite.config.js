import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      '/api': 'https://mi-proyecto-zcsv.onrender.com/api',  // Redirige las solicitudes de API al backend
    },
  },
});
