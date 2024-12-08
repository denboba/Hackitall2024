class User {
  final String userName;
  final String password;
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
    required this.password,
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
    return User(
      userName: map['username'] ?? '',
      password: map['password'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      age: int.tryParse(map['age']?.toString() ?? '0') ?? 0, // Handles null, empty, or string "age"
      phone: map['phone'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      nationalityCountry: map['nationality_country'] ?? '', // Corrected key
      nationalityCity: map['nationality_city'] ?? '', // Corrected key
      residenceCountry: map['residence_country'] ?? '', // Corrected key
      residenceCity: map['residence_city'] ?? '',
      profilePicture: map['profile_picture'] ?? 'Image not found',
      latitude: double.tryParse(map['latitude']?.toString() ?? '0.0') ?? 0.0,
      longitude: double.tryParse(map['longitude']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}

