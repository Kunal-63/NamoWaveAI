from fastapi import FastAPI, HTTPException, Request, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import random
import base64
import mysql.connector as con
from typing import Optional, List
from removebg import RemoveBg
# from ColorAI import ColorChangeAI
import requests
import os
from fastapi.staticfiles import StaticFiles
from ColorDetection import detect_all_colors
    
mydb = con.connect(
    host="localhost",
    user="root",
    password="root",
    database="theog"
)

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


otp = ""
app.mount("/templates", StaticFiles(directory="templates"), name="templates")
class LoginRequest(BaseModel):
    phone_number: str

class UserData(BaseModel):
    phone_number: str
    fullname: str
    party: str
    lokhsabha: str
    position: str
    vidhansabha: str
    image: Optional[str] = None


class ColorChangeModel(BaseModel):
    phoneNumber: str
    
def upload_image_to_imgbb(image_path: str) -> str:
    imgbb_api_key = "9ed666bcae79116dea7d068c2aaa3163" 

    with open(image_path, "rb") as image_file:
        encoded_image = base64.b64encode(image_file.read()).decode("utf-8")

    response = requests.post(
        "https://api.imgbb.com/1/upload",
        data={"key": imgbb_api_key, "image": encoded_image}
    )

    result = response.json()

    if "data" in result and "url" in result["data"]:
        return result["data"]["url"]
    else:
        raise Exception("Failed to upload image to ImgBB. Response: {}".format(result))


@app.post("/send_otp")
async def send_otp(request: Request, login_request: LoginRequest):
    phone_number = login_request.phone_number
    
    if not phone_number.isdigit() or len(phone_number) != 10:
        raise HTTPException(status_code=400, detail="Invalid phone number")
    global otp
    otp = str(random.randint(100000, 999999))
    try:
        # Generate a 6-digit random OTP
        otp = str(random.randint(100000, 999999))
        apiKeys = "x10fCNTlP2gecAOj86aLuYXZJ9qzKFMnbwVsGBD5rvIEydHhk7BMceCQjPR6IVkmqa0t1FAoxNhrwgus"
        
        url = f"https://www.fast2sms.com/dev/bulkV2?authorization={apiKeys}&variables_values={otp}&route=otp&numbers={phone_number}"
        

        response = requests.get(url)
        result = response.json()
        print(result)
        print(f"Phone Number: {phone_number} OTP: {otp}")
        if result['return']:
            return {'success': True, 'otp': otp}
        else:
            raise Exception(result['message'])

    except Exception as e:
        raise Exception(str(e))
    

   

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
    cur.execute(f"SELECT fullname,position,party,lokhsabha,profile_url,vidhansabha FROM users WHERE phonenumber = '{phone_number}'")
    result = cur.fetchall()
    if len(result) == 0:
        return {"message": "User not found"}
    else:
        return {"fullname":result[0][0],"position":result[0][1],"party":result[0][2],"lokhsabha":result[0][3],"profile_url":result[0][4],"vidhansabha":result[0][5],"message": "user found"}

        
@app.post("/process_user_data")
async def process_user_data(user_data: UserData):
    cur = mydb.cursor()
    print("Processing user data...")
    if user_data.image:
        image_bytes = base64.b64decode(user_data.image)
        with open("profiles/{}.jpg".format(user_data.phone_number), "wb") as image_file:
            image_file.write(image_bytes)
        RemoveBg("profiles/{}.jpg".format(user_data.phone_number), "profiles/{}.png".format(user_data.phone_number))
        image_path = "profiles/{}.png".format(user_data.phone_number)
        imgbb_url = upload_image_to_imgbb(image_path)
        profile_url = imgbb_url
    else:
        cur.execute("SELECT profile_url FROM users WHERE phonenumber = %s", [user_data.phone_number])
        result = cur.fetchall()
        if len(result) > 0:
            profile_url = result[0][0]
        else:   
            profile_url = ""
    
    print("Profile URL: ", profile_url, "Full Name :", user_data.fullname, "Phone Number: ", user_data.phone_number, "Party: ", user_data.party, "Lokhsabha: ", user_data.lokhsabha, "Position: ", user_data.position)

    cur.execute("select * from users where phonenumber=%s",[user_data.phone_number])
    result = cur.fetchall()
    if len(result) > 0:
        print("Successfully updated")
        cur.execute("UPDATE users SET fullname=%s, party=%s, lokhsabha=%s, position=%s, profile_url=%s WHERE phonenumber=%s", (user_data.fullname, user_data.party, user_data.lokhsabha, user_data.position, profile_url, user_data.phone_number))
    else:
        print("Successfully inserted")
        cur.execute("INSERT INTO users (phonenumber, fullname, party, lokhsabha, position, profile_url, vidhansabha) VALUES (%s, %s, %s, %s, %s, %s, %s)", (user_data.phone_number, user_data.fullname, user_data.party, user_data.lokhsabha, user_data.position, profile_url, user_data.vidhansabha))


    mydb.commit()
    return {"fullname":user_data.fullname,"position":user_data.position,"phonenumber":user_data.phone_number,"party":user_data.party,"lokhsabha":user_data.lokhsabha,"profile_url":profile_url,"vidhansabha":user_data.vidhansabha, "message": "Data received successfully"}

def template_exists(template_name: str, cur):
    cur.execute("SELECT template_name FROM templates WHERE template_name = %s", (template_name,))
    return cur.fetchone() is not None

@app.get("/templates")
async def get_template_links():
    template_links = []
    
    cur = mydb.cursor()
    folder_path = "templates"
    files = os.listdir(folder_path)
    existing_files = []
    for file in files:
        # print("File Name :",file)
        cur.execute("SELECT template_name from templates WHERE template_name = %s",[file])
        result = cur.fetchall()
        # print("Template Name :",result)
        if len(result) == 0:
            # print("No template found")
            file_path = os.path.join(folder_path, file)
            if os.path.isfile(file_path):  # Ensure it's a file (not a directory)
                template_link = upload_image_to_imgbb(file_path)
                cur.execute("INSERT INTO TEMPLATES VALUES(%s,%s)", [file,template_link])
                mydb.commit()
        else:
            pass
    cur.execute("select template_link from templates")
    results = cur.fetchall()
    for template_link in results:
        template_links.append(template_link[0])

    return {"templates_links": template_links}

@app.post("/color_change_template")
async def color_change_template(template_data: ColorChangeModel):
    print("Color Changing...")
    print(template_data)
    try:
        RGBValues, TextColors = detect_all_colors(r"profiles\{}.png".format(template_data.phoneNumber), num_colors=5)
    except: 
        RGBValues = [[0, 0, 0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
        TextColors = [[255,255,255],[255,255,255],[255,255,255],[255,255,255],[255,255,255]]
    print("RGB", [RGBValues], "TextColors", [TextColors])
    return {"RGBValues": RGBValues, "TextColors": TextColors}

    # UploadedURLs, rgb_values = ColorChangeAI(template_data.phoneNumber, template_data.template_url)
    # r, g, b = int(rgb_values[0]), int(rgb_values[1]), int(rgb_values[2])
    # return {"uploaded_url": UploadedURLs, "r": r, "g": g, "b": b}


import uvicorn
uvicorn.run(app, host="0.0.0.0", port=8000)
