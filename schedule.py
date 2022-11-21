import requests

headers = {
    'x-auth-timestamp': '1657818100',
    'x-auth-hash': '0x29a8ebab9596281fc07c84bf829cc0c1e037d775',
    'Accept': 'application/vnd.fvc.v1+xml',
}

params = {
    'start': '1657724400',
    'end': '1657746000',
    'sids': '4164',

}

response = requests.get('http://api.freeviewplay.net/schedules', params=params, headers=headers)

# http://api.freeviewplay.net/schedules?start=1657789200&end=1657810800&sids[]=4164

with open("schedule_bbcLon.xml", "w") as f:
    f.write(response.text)
    print(response)
