from typing import Dict

from fastapi import Depends, FastAPI
from pydantic import BaseModel
from model import Model, get_model

app = FastAPI()


class Request(BaseModel):
    text: str


class Response(BaseModel):
    sentiment: str


@app.post("/analyse", response_model=Response)
def analyse(request: Request, model: Model = Depends(get_model)):
    sentiment = model.analyse(request.text)
    return Response(
        sentiment=sentiment
    )
