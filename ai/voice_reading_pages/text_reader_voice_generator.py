# if gtts not installed uncomment the next line 
# pip install gtts 
import gtts 
from gtts import gTTS
my_text = input("Enter any text you want to hear!")
# English accent is set to be united states you can choose any language or accent 
tts_en = gTTS( my_text , lang='en', slow=False ,tld="us" ) # check documentation for other valid options!
tts_en.save("output.mp3")