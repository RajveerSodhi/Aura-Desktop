from os import getenv
from dotenv import load_dotenv
import requests

load_dotenv()
WEATHER_API_KEY=getenv('WEATHER_API_KEY')

timeout = 10

def fetch_coordinates(location):
    location_url = f"https://geocoding-api.open-meteo.com/v1/search?name={location}&count=1&language=en&format=json"
    try:
        response = requests.get(location_url, timeout=timeout)
        if response.status_code == 200:
            data = response.json()

            if data.get("error") == "No Record Found" and not data.get("success"):
                print(f"No record found for {location}.")
                return None

            if data:
                coords = data["results"][0]
                lat = coords["latitude"]
                long = coords["longitude"]

                return {
                    "lat": lat,
                    "long": long,
                }
            else:
                print(f"Error fetching details for {location}: {response.status_code}")
                return None
    except requests.exceptions.RequestException as e:
        print(f"Error fetching coordiantes data for {location} : {e}")
        return None


def fetch_weather(lat, long):
    weather_url = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={long}&appid={WEATHER_API_KEY}"
    try:
        response = requests.get(weather_url, timeout=timeout)
        if response.status_code == 200:
            data = response.json()

            if data.get("error") == "No Record Found" and not data.get("success"):
                print(f"No record found for {lat}N, {long}E.")
                return None
            
            if data:
                current_weather_code = data["weather"][0]["id"]
                current_temperature = data["main"]["temp"]
                min_temperature = data["main"]["temp_min"]
                max_temperature = data["main"]["temp_max"]

                return {
                    "temp": current_temperature,
                    "weather_code": current_weather_code,
                    "min_temp": min_temperature,
                    "max_temp": max_temperature
                }
            else:
                print(f"Error fetching details for {lat}N, {long}E: {response.status_code}")
                return None
    except requests.exceptions.RequestException as e:
        print(f"Error fetching weather data for {lat}N, {long}E : {e}")
        return None