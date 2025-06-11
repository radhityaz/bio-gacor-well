from __future__ import annotations

from fastapi import FastAPI, UploadFile
from fastapi.responses import JSONResponse

app = FastAPI()


@app.post("/deep")
async def deep_analysis(file: UploadFile) -> JSONResponse:
    # Placeholder: just echo filename
    return JSONResponse({"filename": file.filename})
