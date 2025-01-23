from os import getenv
import json
# from dotenv import load_dotenv
from fastapi import Depends, FastAPI, HTTPException, Header
from fastapi.middleware.cors import CORSMiddleware
from redis_client import cache

# load_dotenv()
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

# Root Endpoint
@app.get("/", include_in_schema=False)
def root():
    return {
        "redis_conn_status": cache.ping()
    }