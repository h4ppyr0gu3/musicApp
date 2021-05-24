export default async function deleteData(url = '', data = {}) {
  const response = await fetch(url, {
    method: 'DELETE', 
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    redirect: 'follow',
    referrerPolicy: 'no-referrer',
    body: JSON.stringify(data)
  });
  console.log(data)
  return response.json();
};


