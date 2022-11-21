#!/usr/local/bin/python3
import sys
import requests
import subprocess
import os.path

# curl -x http://www-cache.rd.bbc.co.uk:8080 -v -H "x-auth-timestamp: 1659094878" -H "x-auth-hash: 0x8eeee60474d786a34ccf1e60c2863f8aaeed3903" -H "Accept: application/vnd.fvc.v1+xml" https://api.freeviewplay.net/services?nid=12339

headers = {
    'x-auth-timestamp': '1668689053',
    'x-auth-hash': '0x493debf2a0e7a7cf0fc9ef7c3495573c974905a9',
    'Accept': 'application/vnd.fvc.v1+xml',
}

params = {
    # London
    'nid': '12339',
    # wales_nid=12368
    #
}
#
# proxies = {
#     'https': 'http://www-cache.rd.bbc.co.uk:8080',
# }

# response = requests.get('https://api.freeviewplay.net/services', params=params, headers=headers, proxies=proxies)
response = requests.get('https://api.freeviewplay.net/services', params=params, headers=headers)
if response.status_code != 200:
    print('Failed to fetch FVP serviceList')
    sys.exit(1)

result = subprocess.run(['xsltproc', '-o', 'LonServ_15nov2.xml', os.path.join(os.path.dirname(os.path.realpath(__file__)),'transf.xsl'), '-'], capture_output=True, input=response.text.encode('utf-8'))
if result.returncode != 0:
    print('Error processing the XML: ')
    print(result.stderr)
    sys.exit(1)

# with open("tst_nid12339.xml", "w") as f:
#     f.write(response.text)
