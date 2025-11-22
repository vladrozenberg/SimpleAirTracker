import json
import requests
from datetime import datetime

# opensky/states/all index constants
ICAO24=0
CALLSIGN=1
TIME_POSITION=3
LONGITUDE=5
LATITUDE=6
GROUND_STATUS=8 #True if it's on the ground, False if it's flying in the air
VELOCITY=9
HEADING=10 # Angle of the aircraft in degrees
ALTITUDE=13 # precisely geo-altitude regarding physical height of the aircraft while the other is barometric altitude (air-pressure altitude)

def import_url(url):
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    return data
def opensky_ping():   #opensky pings - used to ping aircraft position on map if possible
    opensky_url = "https://opensky-network.org/api/states/all"
    data = import_url(opensky_url)
    print(data)
def main():
    opensky_ping()



if __name__ == "__main__":
    main()
