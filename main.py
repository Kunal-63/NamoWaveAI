from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import random
import base64
import mysql.connector as con
from removebg import RemoveBg

mydb = con.connect(
    host="localhost",
    user="root",
    password="root",
    database="theog"
)



app = FastAPI()

otp = ""

profile = {
    'profile-picture':"assets/dummy.jpg",
    'full-name': "Guest",
    'phone-number' : '',
    'party': '',
    'lokhsabha':''
}

class LoginRequest(BaseModel):
    phone_number: str

class UserData(BaseModel):
    phone_number: str
    fullname: str
    party: str
    lokhsabha: str
    position: str
    image: str
    


@app.post("/send_otp")
async def send_otp(request: Request, login_request: LoginRequest):
    phone_number = login_request.phone_number
    
    if not phone_number.isdigit() or len(phone_number) != 10:
        raise HTTPException(status_code=400, detail="Invalid phone number")
    global otp
    otp = str(random.randint(100000, 999999))
    print(f"OTP: {otp}")

    return {"otp": otp, "error": None}

@app.post("/resend_otp")
async def resend_otp(request: Request, login_request: LoginRequest):
    phone_number = login_request.phone_number
    
    
    global otp
    otp = str(random.randint(100000, 999999))
    print(f"Phone Number: {phone_number} Resend OTP: {otp}")
    return {"otp": otp, "error": None}

@app.post("/verify_otp")
async def verify_otp(request: Request, login_request: LoginRequest):
    cur = mydb.cursor()
    phone_number = login_request.phone_number
    cur.execute(f"SELECT fullname,position,party,lokhsabha FROM users WHERE phonenumber = '{phone_number}'")
    result = cur.fetchall()
    if len(result) == 0:
        return {"message": "User not found"}
    else:
        return {"fullname":result[0][0],"position":result[0][1],"party":result[0][2],"lokhsabha":result[0][3],"message": "user found"}

        
@app.post("/process_user_data")
async def process_user_data(user_data: UserData):
    print("Processing user data...")
    if user_data.image:
        image_bytes = base64.b64decode(user_data.image)
        with open("profiles/{}.jpg".format(user_data.phone_number), "wb") as image_file:
            image_file.write(image_bytes)
        RemoveBg("profiles/{}.jpg".format(user_data.phone_number), "profiles/{}.png".format(user_data.phone_number))
    
        

    profile_url = r"https://i.ibb.co/k4m1cFv/3335dd2cf1b4.jpg"

    cur = mydb.cursor()
    print("Profile URL: ", profile_url, "Full Name :", user_data.fullname, "Phone Number: ", user_data.phone_number, "Party: ", user_data.party, "Lokhsabha: ", user_data.lokhsabha, "Position: ", user_data.position)

    cur.execute("select * from users where phonenumber=%s",[user_data.phone_number])
    result = cur.fetchall()
    if len(result) > 0:
        cur.execute("UPDATE users SET fullname=%s, party=%s, lokhsabha=%s, position=%s, profile_url=%s WHERE phonenumber=%s", (user_data.fullname, user_data.party, user_data.lokhsabha, user_data.position, profile_url, user_data.phone_number))
    else:
        cur.execute("INSERT INTO users (phonenumber, fullname, party, lokhsabha, position, profile_url) VALUES (%s, %s, %s, %s, %s, %s)", (user_data.phone_number, user_data.fullname, user_data.party, user_data.lokhsabha, user_data.position, profile_url))


    mydb.commit()
    return {"fullname":user_data.fullname,"phonenumber":user_data.phone_number,"party":user_data.party,"lokhsabha":user_data.lokhsabha,"profile_url":profile_url, "message": "Data received successfully"}



if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
