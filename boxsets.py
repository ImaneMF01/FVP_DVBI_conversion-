
######## Request Boxset from the MDS using NID ########
#### A new Pair x-auth-timestamp and x-auth-hash needs to be generated EVERY 2DAYS ####
import requests

headers = {
    'x-auth-timestamp': '1659094878',
    'x-auth-hash': '0x8eeee60474d786a34ccf1e60c2863f8aaeed3903',
    'Accept': 'application/vnd.fvc.v1+xml',
}

params = {

    'nid': '4164'

}

response = requests.get('http://api.freeviewplay.net/groups/collections/boxsets/categories', params=params, headers=headers)

# http://api.freeviewplay.net/schedules?start=1657789200&end=1657810800&sids[]=4164

with open("boxsets_4164.xml", "w") as f:
    f.write(response.text)
    print(response)
