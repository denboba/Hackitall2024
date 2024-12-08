import requests

result = requests.get('https://randomuser.me/api/?results=1')
for i in result.json()['results']:
    print(i)