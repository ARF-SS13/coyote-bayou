#!/usr/bin/python

import sys
import requests
import json

key = ""
if (len(key) < 1):
  exit(1)
output = requests.get("https://vpnapi.io/api/" + sys.argv[1] + "?key=" + key)
if (output.status_code != 200):
  exit(1)

parsed = json.loads(output.text)
response = ""

if (parsed['security']['vpn'] == True):
  exit(100)
elif (parsed['security']['proxy'] == True):
  exit(101)
elif (parsed['security']['tor'] == True):
  exit(102)
elif (parsed['security']['relay'] == True):
  exit(103)
exit(0)
