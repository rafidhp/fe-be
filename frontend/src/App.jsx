import React, { useEffect, useState } from 'react';
import axios from 'axios';

const App = () => {
  const [data, setData] = useState();

  useEffect(() => {
    axios.get('https://febe.up.railway.app/api/data')
      .then(response => {
        setData(response.data.message);
      })
      .catch(error => console.error(error));
  }, []);

  return (
    <div>
      <h1 style={"color: #000"}>Data from Laravel API: {data}</h1>
    </div>
  );
};

export default App;
