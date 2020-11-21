#!/bin/python3
import urllib.request

city = "CHANGEME"
api_key = "CHANGEME"

try: 
    weather = eval(str(urllib.request.urlopen("http://api.openweathermap.org/data/2.5/weather?q={}&APPID={}".format(city, api_key)).read())[2:-1])

    info = weather["weather"][0]["description"].capitalize()
    temp = int(float(weather["main"]["temp"]) - 272.15)

    print("%s, %i°C" % (info, temp))
except: 
    print("!")
