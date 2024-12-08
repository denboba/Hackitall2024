import requests
import database_operations as db

def send_request(method, extra_url, json=None, params=None):
    response = requests.request(method, base_url + extra_url, json=json, params=params)
    print(response.status_code)
    print(response.json())
    return response

# The base URL of your Flask app
base_url = "http://127.0.0.1:5000"

# Send the POST request with the JSON data
response = send_request('POST', '/users', json={
    'username': 'testuser',
    'password': 'testpassword',
    'email': 'avsah@nxsjn',
    'first_name': 'test',
    'last_name': 'user',
    'age': 20,
    'phone': '1234567890',
    'date_of_birth': '01-01-2000',
    'nationality_country': 'Romania',
    'nationality_city': 'Bucharest',
    'residence_country': 'Romania',
    'residence_city': 'Bucharest',
    'profile_picture': 'https://www.google.com',
    'latitude': 44.4268,
    'longitude': 26.1025
})

print("_________________")

response = send_request('POST', '/users', json={
    'username': 'testuser2',
    'password': 'testpassword2',
    'email': 'avsah@nxsjn',
    'first_name': 'test',
    'last_name': 'user',
    'age': 20,
    'phone': '1234567890',
    'date_of_birth': '01-01-2000',
    'nationality_country': 'Romania',
    'nationality_city': 'Bucharest',
    'residence_country': 'Romania',
    'residence_city': 'Bucharest',
    'profile_picture': 'https://www.google.com',
    'latitude': 44.4268,
    'longitude': 26.1025
})

print("_________________")

response = send_request('GET', '/users')

print("_________________")

response = send_request('GET', '/users/testuser')

# importa vaza de date si dai clear
db.clear_database()
    
