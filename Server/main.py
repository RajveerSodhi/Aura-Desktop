from os import getenv
import json
from datetime import datetime
from dotenv import load_dotenv
from fastapi import Depends, FastAPI, HTTPException, Header
from fastapi.middleware.cors import CORSMiddleware
from fetch_data import fetch_weather
from redis_client import cache

load_dotenv()
REQ_KEY = getenv('REQ_KEY')

app = FastAPI(
    title="Aura Desktop Server",
    version=1.0,
    docs_url=None
)

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def retry_on_failure(func, retries=3, delay=2, *args, **kwargs):
    for attempt in range(retries):
        try:
            return func(*args, **kwargs)
        except Exception as e:
            if attempt < retries - 1:
                time.sleep(delay)
                continue
            raise e

async def validate_secret_key(x_key: str = Header(...)):
    if x_key != REQ_KEY:
        raise HTTPException(status_code=401, detail="Invalid Secret Key")
    return x_key

async def format_location(x_key: str = Header(...)):
    return ["Kelowna, BC, Canada"]

# Root Endpoint
@app.get("/", include_in_schema=False)
def root():
    return {
        "redis_conn_status": cache.ping()
    }

@app.get("/weather")
def get_weather_data(location: str = Depends(format_location), key: str = Depends(validate_secret_key)):
    '''
        Private endpoint for the Aura Desktop app that fetches and caches weather information from external APIs.
        Returns a JSON object with relevant weather information.
    '''
    if not key:
        raise HTTPException(status_code=401, detail="Secret Key not provided or invalid")
    
    try:
        # if cached data, return that
        cached_data = cache.get(f"WEATHER_{location}")
        if cached_data:
            return json.loads(cached_data)

        #fetch weather data
        weather_data = retry_on_failure(fetch_weather, 3, 2, location)
        if not weather_data:
            raise HTTPException(status_code=404, detail="Weather data not found")
        print("weather data found!")

        timestamp = datetime.now(timezone.utc)
        weather_data["timestamp"] = str(timestamp)

        cache_ttl_mins = 60
        cache_ttl_secs = (cache_ttl_mins - 1) * 60

        cache.set(f"WEATHER_{location}", json.dumps(weather_data), ex=cache_ttl_secs)

        return weather_data
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"UNexpected Error: {str(e)}") from e

@app.get("/test")
def get_test():
    return {
        "weather": "test"
    }