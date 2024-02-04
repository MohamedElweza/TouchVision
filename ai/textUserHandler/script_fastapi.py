#script_fast
# final script for handling the contiuous process 
#import needed packages 
import fastapi
from fastapi import Request
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from gtts import gTTS
import os
import uvicorn
import langdetect
from langdetect import detect

"""
    The following code handles these tasks:
    1- Read any text given from the app  
    2- taks specific actions if and send back signals to the app according to the command 
    3- chatbot assistant in both arabic and english and might be all languages added 

"""

app = FastAPI()

def detect_language(text):
    try:
        # Detect language using langdetect
        language = detect(text)
        return language
    except Exception as e:
        print(f"Error: {e}")
        return None

def analyze_user_text(user_text):
    # Convert the user's text to lowercase for case-insensitive matching
    user_text_lower = user_text.lower()
    lang = detect_language(user_text)
    # Check if the user wants to read a book
    if any(keyword in user_text_lower for keyword in ["read book","open book", "read for me","اقرأ لي الكتب","عرض الكتب"]):
        signal = "0"
        lang = detect_language()
        if lang == "en":
            commentry = "Sorry!, this feature will be available soon!"
        else:
            commentry = "نأسف، هذه الخاصيه غير متوفره حاليا سيتم اضافتها قريبا"
        return signal,commentry

    # Check if the user wants to talk to the bot (Touch Vision)
    if any(keyword in user_text_lower for keyword in ["talk to touch vision", "talk to bot", "talk to the bot","التحدث الى المساعد","التحدث مع المساعد"]):
        signal = "1"
        if lang == 'en':
            commentry = "Hello, I am  VisionBuddy,your AI assistant! "
        else:
            commentry = "أهلا بك ، انا مساعدك الشخصي، كيف يمكنني مساعدتك اليوم؟"
        return signal,commentry

    # If no specific command is detected, return None
    return None



# text_to_speech function with combined features
from concurrent.futures import ThreadPoolExecutor
import asyncio


executor = ThreadPoolExecutor()


async def text_to_speech(text: str) -> str:
    # Create a unique filename based on the text
    filename = f"{text[:10]}_{hash(text)}.mp3"
    detected_lang = detect_language(text)

    # Check if the audio file already exists
    if not os.path.exists(filename):
        # Perform text-to-speech in a separate thread
        loop = asyncio.get_event_loop()
        await loop.run_in_executor(executor, lambda: gTTS(text=text, lang=detected_lang, slow=False).save(filename))

    return filename




@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()
            #print(f"Received Text: {data}")
            
            audio_filename   = await text_to_speech(data)
            signal,commentry =  analyze_user_text(data)
            voice_comment    = await text_to_speech(commentry)
            #conversion to list then to json to send it to the app
            final_out = {"signal"        :signal,
                         "voice_comment" :voice_comment,
                         "GPT_response"  :audio_filename

                        }
            
            #await websocket.send_text(audio_filename)
            await websocket.send_json(final_out)
            #await websocket.send_text(signal,voice_comment)
    except WebSocketDisconnect:
        print("WebSocket Disconnected")
        pass

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000) 

### this is the final script



