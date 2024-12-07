import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../post/create_post_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final userName = authProvider.loggedInUserName;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < 26; i++)
                    storyWidget("assets/images/image$i.jpg", USERNAMES[i]),
                ],
              ),
            ),

            for (int i = 0; i < 26; i++)
              InstagramPostWidget(
                username: USERNAMES[i],
                userImage: "assets/images/image$i.jpg",
                postImage: "assets/images/image$i.jpg",
                caption: 'A beautiful day at the beach!',
                likes: 123,
                comments: 45,
              ),
          ],
        ),
      ),
    );
  }

  storyWidget(String link, String username) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(link),
          ),
          const SizedBox(height: 8),
          Text(username),
        ],
      ),
    );
  }
}