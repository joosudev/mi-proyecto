// src/App.js
import { useEffect, useState } from 'react';

function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('http://localhost:3000/api')
      .then((res) => res.json())
      .then((data) => setMessage(data.message))
      .catch((err) => console.error('Error fetching data:', err));
  }, []);
  

  return (
    <div className="App">
      <h1>Mensaje desde el Back End:</h1>
      <p>{message}</p>
    </div>
  );
}

export default App;

