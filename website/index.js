fetch('https://*.execute-api.us-west-2.amazonaws.com/default/visitorcountfunction')
      .then(response => response.json())
      .then((data) => {
        document.getElementById('visitors').innerText = data.count
})
