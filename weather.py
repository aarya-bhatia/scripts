#!/usr/bin/env python3
import os
import sys
import requests
from datetime import datetime

CACHE_FILEPATH = "/home/aarya/.cache/weather"

WEATHER_TYPES = {"Fair": ["☀️",   "🌙"],  # pylint: disable=C0326
                 "Partly cloudy": ["⛅",  "☁️"],  # pylint: disable=C0326
                 "Clear sky": ["☀️",   "🌙"],  # pylint: disable=C0326
                 "Cloudy": ["☁️",   "☁️"],  # pylint: disable=C0326
                 "Light rain": ["🌧️",  "🌧️"],  # pylint: disable=C0326
                 "Rain": ["🌧️",  "🌧️"],  # pylint: disable=C0326
                 "Heavy Rain": ["🌧️",  "🌧️"],  # pylint: disable=C0326
                 "Light snow": ["🌨️",  "🌨️"],  # pylint: disable=C0326
                 "Snow": ["🌨️",  "🌨️"],  # pylint: disable=C0326
                 "Heavy snow": ["🌨️",  "🌨️"],  # pylint: disable=C0326
                 "Foggy": ["🌫️",  "🌫️"],  # pylint: disable=C0326
                 "Fog": ["🌫️",  "🌫️"],  # pylint: disable=C0326
                 "Light snow showers": ["🌨️",  "🌨️"]}  # pylint: disable=C0326


def log(message):
    sys.stderr.write(str(message) + "\n")


def get_forecast_url(latitude, longitude):
    try:
        response = requests.get(
            f"https://api.weather.gov/points/{latitude},{longitude}")
        log(response.status_code)
        if response.status_code == 200:
            return response.json()["properties"]["forecastHourly"]
        log(response.content)
    except Exception as e:
        sys.stderr.write(str(e))
        return None


def temp_in_C(temp_in_F):
    return round((temp_in_F - 32) * 5/9)


def update_cache(url):
    try:
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

                log(f"Cache updated: {CACHE_FILEPATH}/{date}")
        else:
            log(f"ERROR: HTTP {response.status_code}: {response.content}")
    except Exception as e:
        log(e)
        return


def get_forecast(force_update_cache=False) -> (str | None, str | None):
    log(f"get_forecast: {force_update_cache}")

    currentDateTime = datetime.now().replace(tzinfo=None)
    currentDate = currentDateTime.strftime("%Y-%m-%d")
    cache_filename = os.path.join(CACHE_FILEPATH, currentDate)

    if force_update_cache or not os.path.exists(cache_filename):
        url = get_forecast_url(latitude, longitude)
        log(f"forecast url: {url}")
        if url:
            update_cache(url)

    return get_cached_forecast(cache_filename)


def get_cached_forecast(cache_filename) -> (str | None, str | None):
    currentDateTime = datetime.now().replace(tzinfo=None)
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
                print(shortForecast, file=sys.stderr)
                return f"{temperature}°C", shortForecast

    return None, None


if __name__ == "__main__":
    os.system("mkdir -p ~/.cache/weather")
    force_update_cache = False
    if len(sys.argv) == 2 and sys.argv[1] == "-f":
        force_update_cache = True

    latitude = os.getenv("LATITUDE", "40.11")
    longitude = os.getenv("LONGITUDE", "-88.24")
    log((latitude, longitude))

    try:
        forecast, short = get_forecast(force_update_cache)
        if not forecast:
            raise Exception("Forecast unavailable")

        # for t, v in WEATHER_TYPES.items():
        #     if t.lower() in short.lower():
        #         print(v[0] + " " + forecast)
        #         exit(0)

        print(forecast)

    except Exception as e:
        log(e)
