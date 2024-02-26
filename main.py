from fastapi import FastAPI, File, UploadFile
import uvicorn
app = FastAPI()

@app.post("/get_mobile_number")
async def get_mobile_number(mobile_number: str):
    print("Getting mobile number", mobile_number)

    return {"mobile_number": mobile_number}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)