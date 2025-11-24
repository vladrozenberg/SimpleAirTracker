
import requests
from datetime import datetime
import time

# opensky/states/all index constants
ICAO24=0
CALLSIGN=1
TIME_POSITION=3
LONGITUDE=5
LATITUDE=6
GROUND_STATUS=8 #True if it's on the ground, False if it's flying in the air
VELOCITY=9
HEADING=10 # Angle of the aircraft heading in degrees
ALTITUDE=13 # precisely geo-altitude regarding physical height of the aircraft while the other is barometric altitude (air-pressure altitude)//not used

# Time constants:
OPENSKY_PING_INTERVAL = 30 # seconds


def import_url(url):
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    return data


def opensky_ping():   #opensky pings - used to ping aircraft position on map if possible
    opensky_url = "https://opensky-network.org/api/states/all"
    data = import_url(opensky_url)
    return data

def ping_test_5_mins(plane_callsign_list):
    now=time.time()
    next_run = now -0.001
    test_time=0
    current_sec = now % 60
    if current_sec < 30:
        wait_time = 30 - current_sec
    else:
        wait_time = 60 - current_sec
    time.sleep(wait_time)

    while test_time<300:
        now = time.time()
        if now>=next_run:
            get_plane_dictionary(plane_callsign_list)
            next_run = now + OPENSKY_PING_INTERVAL
            test_time+=OPENSKY_PING_INTERVAL

def get_plane_dictionary(plane_callsign_list):
    data = opensky_ping()
    plane_dictionary = {}
    info=None
    for i in range (len(plane_callsign_list)):
        for state in data['states']:
            if state[CALLSIGN].strip() == plane_callsign_list[i].strip():
                info={
                    "icao24": state[ICAO24].strip(),
                    "longitude": state[LONGITUDE],
                    "latitude": state[LATITUDE],
                    'time position': state[TIME_POSITION],
                    'velocity': state[VELOCITY],
                    'heading': state[HEADING],
                    'altitude': state[ALTITUDE],
                }

        if info is not None:
            plane_dictionary[plane_callsign_list[i]] = info
        info=None

    print(plane_dictionary)
    return  plane_dictionary
def main():
    plane_callsign_list = ["SIA7973", "EAL3071"]
    ping_test_5_mins(plane_callsign_list)

if __name__ == "__main__":
    main()

# Unused code
"""for i in plane_database:
    if i[CALLSIGN].strip() == plane_callsign.strip():
        print(f"Time:{i[TIME_POSITION]} callsign {i[CALLSIGN]} {i[LONGITUDE]} {i[LATITUDE]} {int(now)} {data['time']}")"""
"EAL3071"