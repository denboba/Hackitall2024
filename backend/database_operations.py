import sqlite3
import json

from flask import jsonify

database = 'database.db'


def create_database():
    conn = sqlite3.connect(database)
    c = conn.cursor()
    # Creeate a table with autoincrement id, username, password and email
    c.execute(''' 
    CREATE TABLE IF NOT EXISTS Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        email TEXT NOT NULL,
        first_name TEXT DEFAULT '',
        last_name TEXT DEFAULT '',
        age INTEGER DEFAULT 0,
        phone TEXT DEFAULT '',
        date_of_birth TEXT DEFAULT '',
        nationality_country TEXT DEFAULT '',
        nationality_city TEXT DEFAULT '',
        residence_country TEXT DEFAULT '',
        residence_city TEXT DEFAULT '',
        profile_picture TEXT DEFAULT 'Pictures/default_profile_pic.jpg',
        latitude REAL DEFAULT 0.0,
        longitude REAL DEFAULT 0.0
    );
    ''')
    conn.commit()
    conn.close()


# Fetch all users
def get_users():
    conn, c = open_connection()
    c.execute('SELECT * FROM Users')
    users = c.fetchall()
    close_connection(conn)

    # Convert users to a dict format using dj.get_dict_users (assuming this returns a list of dicts)
    users_list = []
    for user in users:
        user_dict = {
            'id': user[0],
            'username': user[1],
            'password': user[2],
            'email': user[3],
            'first_name': user[4],
            'last_name': user[5],
            'age': user[6],
            'phone': user[7],
            'date_of_birth': user[8],
            'nationality_country': user[9],
            'nationality_city': user[10],
            'residence_country': user[11],
            'residence_city': user[12],
            'profile_picture': user[13],
            'latitude': user[14],
            'longitude': user[15]
        }
        users_list.append(user_dict)

    return users_list  # Return the users as a Python dictionary or list, not JSON


# Function to get a single user by username
def get_user(username):
    conn, c = open_connection()

    # Query the database to find the user by username
    c.execute('SELECT * FROM Users WHERE username = ?', (username,))
    user = c.fetchone()  # This will return the first matching row, or None if no match is found

    close_connection(conn)

    # If a user is found, return the user data in a dictionary form
    if user:
        # Constructing the dictionary based on your table columns
        user_dict = {
            'username': user[1],
            'password': user[2],
            'email': user[3],
            'first_name': user[4],
            'last_name': user[5],
            'age': user[6],
            'phone': user[7],
            'date_of_birth': user[8],
            'nationality_country': user[9],
            'nationality_city': user[10],
            'residence_country': user[11],
            'residence_city': user[12],
            'profile_picture': user[13],
            'latitude': user[14],
            'longitude': user[15]
        }
        return user_dict  # Return as a dictionary, not JSON
    else:
        return {'success': False, 'message': 'User not found'}  # Return a dictionary


# Add a new user whose data was passed in the request
def add_user(request):
    user_data = request.json
    conn, c = open_connection()
    try:
        c.execute(''' 
        INSERT INTO Users (username, password, email, first_name, last_name, age, phone, date_of_birth, nationality_country, nationality_city, residence_country, residence_city, profile_picture, latitude, longitude)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (user_data['username'], user_data['password'], user_data['email'], user_data.get('first_name', ''),
              user_data.get('last_name', ''), user_data.get('age', 0), user_data.get('phone', ''),
              user_data.get('date_of_birth', ''), user_data.get('nationality_country', ''),
              user_data.get('nationality_city', ''), user_data.get('residence_country', ''),
              user_data.get('residence_city', ''), user_data.get('profile_picture', ''), user_data.get('latitude', 0.0),
              user_data.get('longitude', 0.0)))
        conn.commit()
    except sqlite3.IntegrityError as e:
        return {'success': False, 'message': 'Username already exists'}  # Return as a dictionary
    finally:
        close_connection(conn)
    return {'success': True}  # Return as a dictionary


# Update a user's information
def update_user(username, request):
    user_data = request.json
    conn, c = open_connection()

    # Check if the user exists
    c.execute('SELECT * FROM Users WHERE username = ?', (username,))
    user = c.fetchone()

    if not user:
        close_connection(conn)
        return {'success': False, 'message': 'User not found'}  # Return as a dictionary

    # Update the user's data
    c.execute(''' 
    UPDATE Users
    SET 
        password = ?,
        email = ?,
        first_name = ?,
        last_name = ?,
        age = ?,
        phone = ?,
        date_of_birth = ?,
        nationality_country = ?,
        nationality_city = ?,
        residence_country = ?,
        residence_city = ?,
        profile_picture = ?,
        latitude = ?,
        longitude = ?
    WHERE username = ?
    ''', (
        user_data.get('password', user[1]),  # Retain the old value if not updated
        user_data.get('email', user[2]),
        user_data.get('first_name', user[3]),
        user_data.get('last_name', user[4]),
        user_data.get('age', user[5]),
        user_data.get('phone', user[6]),
        user_data.get('date_of_birth', user[7]),
        user_data.get('nationality_country', user[8]),
        user_data.get('nationality_city', user[9]),
        user_data.get('residence_country', user[10]),
        user_data.get('residence_city', user[11]),
        user_data.get('profile_picture', user[12]),
        user_data.get('latitude', user[13]),
        user_data.get('longitude', user[14]),
        username
    ))

    conn.commit()
    close_connection(conn)

    return {'success': True, 'message': 'User updated successfully'}  # Return as a dictionary


# Login function without hashing
def login(username, password):
    conn, c = open_connection()

    # Query the database to find the user by username
    c.execute('SELECT * FROM Users WHERE username = ?', (username,))
    user = c.fetchone()  # This will return the first matching row, or None if no match is found

    close_connection(conn)

    # If no user is found, return failure
    if not user:
        return jsonify({'success': False, 'message': 'User not found'}), 404

    # Retrieve the stored password from the database
    stored_password = user[2]  # Assuming the password is stored in column 2

    # Compare the plain text password
    if password == stored_password:
        # If the password matches, return the user data
        user_dict = {
            'username': user[1],
            'email': user[3],
            'first_name': user[4],
            'last_name': user[5],
            'age': user[6],
            'phone': user[7],
            'date_of_birth': user[8],
            'national_country': user[9],
            'national_city': user[10],
            'residence_country': user[11],
            'residence_city': user[12],
            'profile_picture': user[13],
            'latitude': user[14],
            'longitude': user[15]
        }
        return jsonify({'success': True}), 200
    else:
        return jsonify({'success': False, 'message': 'Incorrect password'}), 401


# Function to register a new user
def register(user_data):
    # Open a connection to the database
    conn, c = open_connection()

    # Check if the username already exists
    c.execute('SELECT * FROM Users WHERE username = ?', (user_data['username'],))
    existing_user = c.fetchone()

    # If the username exists, return an error
    if existing_user:
        close_connection(conn)
        return jsonify({'success': False, 'message': 'Username already exists'}), 400

    # If the username doesn't exist, proceed to insert the new user
    try:
        c.execute(''' 
        INSERT INTO Users (username, password, email, first_name, last_name, age, phone, date_of_birth, nationality_country, nationality_city, residence_country, residence_city, profile_picture, latitude, longitude)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            user_data['username'],
            user_data['password'],  # Note: this is plain text as per your request
            user_data['email'],
            user_data.get('first_name', ''),
            user_data.get('last_name', ''),
            user_data.get('age', 0),
            user_data.get('phone', ''),
            user_data.get('date_of_birth', ''),
            user_data.get('nationality_country', ''),
            user_data.get('nationality_city', ''),
            user_data.get('residence_country', ''),
            user_data.get('residence_city', ''),
            user_data.get('profile_picture', ''),
            user_data.get('latitude', 0.0),
            user_data.get('longitude', 0.0)
        ))

        conn.commit()
        close_connection(conn)

        # Return success response
        return jsonify({'success': True, 'message': 'User registered successfully'}), 201

    except sqlite3.Error as e:
        close_connection(conn)
        return jsonify({'success': False, 'message': str(e)}), 500


def filter_users_by_field(field_name, value):
    """
    Filters users based on a specific field and its value.

    :param field_name: The name of the field to filter by (e.g., 'residence_country').
    :param value: The value to match in the specified field.
    :return: A JSON response with the list of matching users or an error message.
    """
    conn, c = open_connection()

    # Construct the query dynamically using placeholders to avoid SQL injection
    try:
        query = f"SELECT * FROM Users WHERE {field_name} = ?"
        c.execute(query, (value,))
        users = c.fetchall()
        close_connection(conn)

        if not users:
            return jsonify({'success': False, 'message': f'No users found with {field_name} = {value}'}), 404

        # Convert the fetched users to a list of dictionaries
        users_list = [
            {
                'id': user[0],
                'username': user[1],
                'password': user[2],
                'email': user[3],
                'first_name': user[4],
                'last_name': user[5],
                'age': user[6],
                'phone': user[7],
                'date_of_birth': user[8],
                'nationality_country': user[9],
                'nationality_city': user[10],
                'residence_country': user[11],
                'residence_city': user[12],
                'profile_picture': user[13],
                'latitude': user[14],
                'longitude': user[15]
            }
            for user in users
        ]

        return jsonify({'success': True, 'users': users_list})

    except sqlite3.Error as e:
        close_connection(conn)
        return jsonify({'success': False, 'message': f'Database error: {str(e)}'}), 500



def open_connection():
    conn = sqlite3.connect(database)
    c = conn.cursor()
    return conn, c


def close_connection(conn):
    conn.close()


def clear_database():
    conn, c = open_connection()
    c.execute('DELETE FROM Users')
    conn.commit()
    close_connection(conn)
