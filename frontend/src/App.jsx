import React, { useEffect, useState } from 'react';
import axios from 'axios';

const App = () => {
  const [data, setData] = useState();

  useEffect(() => {
    axios.get('http://127.0.0.1:8000/api/data')
      .then(response => {
        setData(response.data.message);
      })
      .catch(error => console.error(error));
  }, []);

  return (
    <div>
      <h1>Data from Laravel API: {data}</h1>
    </div>
  );
};

export default App;
