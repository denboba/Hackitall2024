from flask import Flask, render_template, request, redirect, url_for, jsonify
import database_operations as db
import functions as lf
import sqlite3
from flask_cors import CORS
import json
import functions

app = Flask(__name__)
CORS(app)

@app.route('/')
def index():
    conn, c = db.open_connection()
    c.execute('SELECT * FROM Users')  # Ensure we are querying the 'Users' table
    my_tasks = c.fetchall()
    db.close_connection(conn)
    return render_template('index.html', tasks=my_tasks)

# Get all users
@app.route('/users', methods=['GET'])
def get_users():
    users = db.get_users()  # This should now return a raw list or dict
    if users:
        return jsonify(users)  # Use jsonify to format the response as JSON
    return jsonify({'message': 'No users found'}), 404

# Add a new user
@app.route('/users', methods=['POST'])
def add_user():
    response = db.add_user(request)  # This returns a raw dict
    return jsonify(response), 200  # Return the response as JSON with a 200 status

# Update an existing user
@app.route('/users/<username>', methods=['PUT'])
def update_user_route(username):
    response = db.update_user(username, request)  # This returns a raw dict
    return jsonify(response), 200  # Return the response as JSON with a 200 status

# Get a single user by username
@app.route('/users/<username>', methods=['GET'])
def get_user(username):
    user = db.get_user(username)  # This returns a raw dict
    if user:
        return jsonify(user)  # Return the user as a JSON response
    return jsonify({'success': False, 'message': 'User not found'}), 404

# Login route
@app.route('/login', methods=['POST'])
def login_route():
    # Extract the username and password from the request
    request_data = request.get_json()
    username = request_data.get('username')
    password = request_data.get('password')

    if not username or not password:
        return jsonify({'success': False, 'message': 'Username and password are required'}), 400

    # Call the login function
    return db.login(username, password)  # Directly return the response from the login function


@app.route('/register', methods=['POST'])
def register_route():
    # Extract the user data from the request
    request_data = request.get_json()

    # Check if necessary fields are present
    required_fields = ['username', 'password', 'email']
    for field in required_fields:
        if field not in request_data:
            return jsonify({'success': False, 'message': f'{field} is required'}), 400

    # Call the register function and return the response
    return db.register(request_data)


@app.route('/users/filter', methods=['GET'])
def filter_users():
    """
    Filters users based on a query parameter.

    Example: /users/filter?field=residence_country&value=USA
    """
    # Get the field and value from query parameters
    field = request.args.get('field')
    value = request.args.get('value')

    if not field or not value:
        return jsonify({'success': False, 'message': 'Missing required query parameters: field and value'}), 400

    # Call the database function to filter users
    return db.filter_users_by_field(field, value)

def reset_users_table():
    conn = sqlite3.connect('database.db')
    c = conn.cursor()

    # Drop the old table if it exists
    c.execute('DROP TABLE IF EXISTS Users;')
    print("Old 'Users' table dropped.")

    # Recreate the table with the new schema
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
        profile_picture TEXT DEFAULT '',
        latitude REAL DEFAULT 0.0,
        longitude REAL DEFAULT 0.0
    );
    ''')
    conn.commit()
    conn.close()
    print("New 'Users' table created successfully.")

# json with 2 names as input (name1, name2) and return the distance between them
@app.route('/distance', methods=['GET'])
def get_distance():
    # Get the names from the query parameters
    name1 = request.args.get('user1')
    name2 = request.args.get('user2')

    if not name1 or not name2:
        return jsonify({'success': False, 'message': 'Missing required query parameters: user1 and user2'}), 400

    # obtain users from the database
    user1 = db.get_user(name1)
    user2 = db.get_user(name2)
    dict_dist = functions.get_distance(user1['latitude'], user1['longitude'], user2['latitude'], user2['longitude'])
    return jsonify(dict_dist)



if __name__ == '__main__':
    # reset_users_table()  # Uncomment to reset the table if needed
    db.create_database()  # Ensure the database is created
    app.run(debug=True, host='0.0.0.0', port=5000)
