from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from fastapi.responses import RedirectResponse
from routers.collections import router
import uvicorn
from logger import LOGGER







app = FastAPI(
    title="Devops labs api"
)

origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)




app.include_router(router)


@app.get("/isAlive")
async def check_if_is_alive():
    LOGGER.info("Life check done")
    LOGGER.debug("Debug set")

    return {"message": "Connected to API"}

@app.get("/isReady")
async def check_if_is_ready():

    return {"message": "App is ready"}

@app.get("/")
def redirect_docs():
    LOGGER.info("Redirected response.")
    return RedirectResponse(url='/docs')


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, log_level="info")