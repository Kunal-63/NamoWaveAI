from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import random


app = FastAPI()

otp = ""
# Pydantic model for incoming login requests
class LoginRequest(BaseModel):
    phone_number: str


@app.post("/send_otp")
async def send_otp(request: Request, login_request: LoginRequest):
    # print(f"Received request: {request.url}, {request.headers}, {await request.json()}")
    phone_number = login_request.phone_number
    
    # Validate phone number (add more robust validation as needed)
    if not phone_number.isdigit() or len(phone_number) != 10:
        raise HTTPException(status_code=400, detail="Invalid phone number")
    global otp
    otp = str(random.randint(100000, 999999))
    print(f"OTP: {otp}")
    # return {"message": "OTP sent successfully", "error": None}
    return {"otp": otp, "error": None}

@app.post("/resend_otp")
async def resend_otp(request: Request, login_request: LoginRequest):
    phone_number = login_request.phone_number
    
    
    global otp
    otp = str(random.randint(100000, 999999))
    print(f"Phone Number: {phone_number} Resend OTP: {otp}")
    return {"otp": otp, "error": None}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
