from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

# Pydantic model for incoming login requests
class LoginRequest(BaseModel):
    phone_number: str


@app.post("/send_otp")
async def send_otp(request: Request, login_request: LoginRequest):
    print(f"Received request: {request.url}, {request.headers}, {await request.json()}")
    phone_number = login_request.phone_number
    
    # Validate phone number (add more robust validation as needed)
    if not phone_number.isdigit() or len(phone_number) != 10:
        raise HTTPException(status_code=400, detail="Invalid phone number")

    # Add your logic to send OTP (simulate success here)
    # Replace this with your actual OTP sending logic
    # You might want to use a third-party service for OTP generation and sending
    # For example, Twilio, Nexmo, Firebase, etc.

    # Simulate successful OTP sending
    return {"message": "OTP sent successfully", "error": None}

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
