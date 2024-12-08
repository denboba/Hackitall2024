import haversine as hs
from haversine import Unit
import bcrypt

database = 'database.db'

# return a dictionary with one member: the distance
def get_distance(lat1, lon1, lat2, lon2):
    distance = hs.haversine((lat1, lon1), (lat2, lon2), unit=Unit.KILOMETERS)
    return {'distance': distance}

def check_password(password, dbase_hash):
    # compare with the hash in the database
    return bcrypt.checkpw(password.encode('utf-8'), dbase_hash)

# return hashed passsword as string
def hash_password(password):
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')