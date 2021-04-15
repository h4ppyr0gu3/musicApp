export default async function getData(url = '') {
  const response = await fetch(url, {
    method: 'GET', 
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    redirect: 'follow',
    referrerPolicy: 'no-referrer' 
  });
  return response.json();
};
