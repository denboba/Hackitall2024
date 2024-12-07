
class User {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  final String phone;
  final String dateOfBirth;
  final String nationalityCountry;
  final String nationalityCity;
  final String residenceCountry;
  final String residenceCity;
  final String profilePicture;
  final double latitude;
  final double longitude;

  User({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.phone,
    required this.dateOfBirth,
    required this.nationalityCountry,
    required this.nationalityCity,
    required this.residenceCountry,
    required this.residenceCity,
    required this.profilePicture,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    final data = map;  // The map passed directly represents a user object in the API response
    final location = data['location'];
    final coordinates = location['coordinates'];

    return User(
      userName: data['login']['username'] ?? '',
      firstName: data['name']['first'] ?? '',
      lastName: data['name']['last'] ?? '',
      email: data['email'] ?? '',
      age: data['dob']['age'] ?? 0,
      phone: data['phone'] ?? '',
      dateOfBirth: data['dob']['date'] ?? '',
      nationalityCountry: data['nat'] ?? '',  // Nationality is a single string
      nationalityCity: location['city'] ?? '',  // Assuming city as nationality city
      residenceCountry: location['country'] ?? '',
      residenceCity: location['city'] ?? '',
      profilePicture: data['picture']['large'] ?? "Image not found",
      latitude: double.tryParse(coordinates['latitude'] ?? '0.0') ?? 0.0,
      longitude: double.tryParse(coordinates['longitude'] ?? '0.0') ?? 0.0,
    );
  }
}

