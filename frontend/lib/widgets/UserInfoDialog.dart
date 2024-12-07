import 'package:flutter/material.dart';

class UserInfoDialog extends StatelessWidget {
  final String username;
  final String name;
  final String bio;
  final String profileImageUrl;
  final String currentCity;
  final String homeCity;
  final String job;
  final int followCount;
  final int followersCount;

  const UserInfoDialog({
    super.key,
    required this.username,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    this.currentCity = "New York",  // Default value for current city
    this.homeCity = "Los Angeles", // Default value for home city
    this.job = "Software Developer", // Default job
    this.followCount = 150, // Default follow count
    this.followersCount = 200, // Default followers count
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the dialog when tapping anywhere outside
        Navigator.of(context).pop();
      },
      child: Material(
        color: Colors.transparent, // Make the background transparent
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Center(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(profileImageUrl),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 10.0),
              Text(
                '@$username',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                bio,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                "Current City: $currentCity",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "Home City: $homeCity",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "Job: $job",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "Following: $followCount",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "Followers: $followersCount",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



