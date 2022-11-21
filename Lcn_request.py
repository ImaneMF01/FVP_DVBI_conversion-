#!/usr/local/bin/python3
import sys
import requests
import subprocess
import os.path

import xmltodict
from requests.structures import CaseInsensitiveDict

# url = "https://api.freeviewplay.net/CLMconfig"

##### Construct the MDS requests ####

base_url = "https://api.freeviewplay.net"

clmConfig = 'CLMconfig'
clmAssign = "1.7/CLMassignment/"
london_muxes = "3033.1044_3033.2005_3033.4084_3033.3006_3033.5040_3033.6040_3033.801f-1-"

active_scan = "-1-"

# wales_muxes= "3050.107e_3050.200d_3050.40be_3050.3007_3050.6040_3050.802e-1-"

headers = CaseInsensitiveDict()
headers["x-auth-timestamp"] = "1668689053"
headers["x-auth-hash"] = "0x493debf2a0e7a7cf0fc9ef7c3495573c974905a9"
headers["Accept"] = "application/vnd.fvc.v1+json"
# proxies = "'https': 'http://www-cache.rd.bbc.co.uk:8080'"

# fixed request of london muxes

# curl -x http://www-cache.rd.bbc.co.uk:8080 -v -H "x-auth-timestamp: 1662202295" -H "x-auth-hash: 0x4971b5d1cd2e5b780a96e61b4f0eb001c1362ea0"
# -H "Accept: application/vnd.fvc.v1+json" https://api.freeviewplay.net/CLMconfig > CLMconfigtst.gz

url = '/'.join((base_url, clmConfig))
resp = requests.get(url, headers=headers, stream=True)

# fetch and return a JSON object of the result
clm_config_json = resp.json()
# Convert json to XML
clm_config_xml = xmltodict.unparse({'root': clm_config_json}, pretty=True)

with open('CLMcfg_15nov2.xml','w') as outfile:
    outfile.write(clm_config_xml)

# Construct request in the format CLMbaseurl/<mux-info>-1-
constructReq = clm_config_json['clm_base_url'] + '/' + london_muxes

resp = requests.get(constructReq, headers=headers, stream=True)

print(resp.request.url)
print('----')
print(resp.request.body)
print(resp.request.headers)

print(resp.status_code)

# write the response in chunks to prevent loading the entire response into memory at once
# with open("CLMassig_15nov2.json", 'wb') as f:
#     for chunk in resp.iter_content(chunk_size=1024):
#         if chunk:
#             f.write(chunk)
#             f.flush()

clm_assign_json = resp.json()
# Convert json to XML
clm_assign_xml = xmltodict.unparse({'root': clm_assign_json}, pretty=True)

with open('CLMassign_15nov2.xml','w') as f:
    f.write(clm_assign_xml)
