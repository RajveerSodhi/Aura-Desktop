from os import getenv
from dotenv import load_dotenv
import requests

load_dotenv()

timeout = 10

def fetch_weather(location):
    weather_url = ""
    try:
        return {
            "weather": "test"
        }
    except requests.exceptions.RequestException as e:
        print(f"Error fetching weather data for {location}: {e}")
        return None