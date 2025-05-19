var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=Hanoi&appid=YOUR_API_KEY&units=metric";

function fetchWeather() {
  fetch(weatherUrl)
    .then(response => response.json())
    .then(data => {
      var temp = Math.round(data.main.temp);
      var weatherData = {
        temperature: temp
      };
      // Gửi dữ liệu thời tiết đến thiết bị
      messaging.send(weatherData);
    })
    .catch(error => console.log("Error fetching weather: " + error));
}

// Gọi hàm mỗi 30 phút
setInterval(fetchWeather, 1800000);
fetchWeather();
