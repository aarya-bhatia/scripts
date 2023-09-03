#!/usr/bin/python3
import os
import sys
import requests
from datetime import datetime

CACHE_FILEPATH = "/home/aarya/.cache/weather"


def get_forecast_url(latitude, longitude):
    try:
        response = requests.get(
            f"https://api.weather.gov/points/{latitude},{longitude}")
        print(response.status_code, file=sys.stderr)
        if response.status_code == 200:
            return response.json()["properties"]["forecastHourly"]
    except:
        return None


def temp_in_C(temp_in_F):
    return round((temp_in_F - 32) * 5/9)


def update_cache(url):
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()

        for period in data["properties"]["periods"]:
            date = period["startTime"][:10]
            filename = os.path.join(CACHE_FILEPATH, date)

            shortForecast = period["shortForecast"]

            if period["temperatureUnit"] == "F":
                temperature = temp_in_C(period["temperature"])
            else:
                temperature = period["temperature"]

            with open(filename, "a") as file:
                line = " ".join([
                    period["startTime"][:-6],
                    period["endTime"][:-6],
                    str(temperature),
                    shortForecast
                ])

                file.write(f"{ line }\n")

            print(f"Cache updated: {CACHE_FILEPATH}/{date}", file=sys.stderr)

    else:
        print(f"HTTP status: {response.status_code}", file=sys.stderr)


def get_forecast(url, force_update_cache=False):
    if not url:
        return None, None

    currentDateTime = datetime.now().replace(tzinfo=None)
    currentDate = currentDateTime.strftime("%Y-%m-%d")
    cache_filename = os.path.join(CACHE_FILEPATH, currentDate)

    if force_update_cache:
        update_cache(url)
    elif not os.path.exists(cache_filename):
        update_cache(url)
    else:
        print(f"using cached file: {cache_filename}", file=sys.stderr)

    with open(cache_filename, "r") as file:
        lines = file.readlines()

        for line in lines:
            items = line.split()
            startTime = items[0]
            endTime = items[1]
            temperature = items[2]
            shortForecast = ' '.join(items[3:])

            startTime = datetime.strptime(startTime, "%Y-%m-%dT%H:%M:%S")
            startTime = startTime.replace(tzinfo=None)
            endTime = datetime.strptime(endTime, "%Y-%m-%dT%H:%M:%S")
            endTime = endTime.replace(tzinfo=None)

            if startTime <= currentDateTime and currentDateTime <= endTime:
                return f"{temperature}°C", shortForecast

    return None, None


if __name__ == "__main__":
    force_update_cache = False
    if len(sys.argv) == 2 and sys.argv[1] == "-f":
        force_update_cache = True

    latitude = os.getenv("LATITUDE", "40.11")
    longitude = os.getenv("LONGITUDE", "-88.24")
    print(latitude, longitude, file=sys.stderr)
    url = get_forecast_url(latitude, longitude)

    print(url, file=sys.stderr)

    forecast, short = get_forecast(url, force_update_cache)

    if forecast:
        print(forecast, short)
    else:
        print("Error")
