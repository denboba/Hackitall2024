
import 'package:flutter/material.dart';
import 'dart:math';

import '../constants/color_constant.dart';  // For random chat list selection

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
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Open the ChatApp when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatApp(), // Open ChatApp here
                    ),
                  );
                },
                child: const Text('Start Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(currentUserName: 'John', chatWithName: 'Alice'), // Pass names here
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String currentUserName;
  final String chatWithName;

  // Multiple lists of chat data
  final List<List<Map<String, dynamic>>> chatLists = [
    [
      {'message': 'Hey, how are you? 😊', 'isSender': true, 'time': '10:45 AM'},
      {'message': 'I am good, what about you?', 'isSender': false, 'time': '10:46 AM'},
      {'message': 'Doing great, just working on a project.', 'isSender': true, 'time': '10:47 AM'},
      {'message': 'That\'s nice! Keep it up 👍', 'isSender': false, 'time': '10:48 AM'},
      {'message': 'Thanks! Will do. 💪', 'isSender': true, 'time': '10:49 AM'},
      {'message': 'What project are you working on?', 'isSender': false, 'time': '10:50 AM'},
      {'message': 'It’s a new mobile app for social connections.', 'isSender': true, 'time': '10:51 AM'},
      {'message': 'Sounds exciting! Good luck with it!', 'isSender': false, 'time': '10:52 AM'},
      {'message': 'Thanks, I’m excited about it too! 😃', 'isSender': true, 'time': '10:53 AM'},
    ],
    [
      {'message': 'Mom, did you send the parcel?', 'isSender': true, 'time': '8:00 AM'},
      {'message': 'Yes, I sent it yesterday. It should arrive today.', 'isSender': false, 'time': '8:05 AM'},
      {'message': 'Great, I’ll keep an eye on it.', 'isSender': true, 'time': '8:06 AM'},
      {'message': 'Don’t forget to eat breakfast too!', 'isSender': false, 'time': '8:10 AM'},
      {'message': 'Haha, yes, I will. Thanks, Mom! ❤️', 'isSender': true, 'time': '8:12 AM'},
      {'message': 'By the way, have you finished your homework?', 'isSender': false, 'time': '8:15 AM'},
      {'message': 'Almost done! Just need to finish math.', 'isSender': true, 'time': '8:16 AM'},
      {'message': 'Let me know if you need help with it.', 'isSender': false, 'time': '8:18 AM'},
      {'message': 'Thanks, I might! I’ll let you know soon.', 'isSender': true, 'time': '8:19 AM'},
    ],
    [
      {'message': 'Can you review the document I shared?', 'isSender': false, 'time': '11:00 AM'},
      {'message': 'Yes, I’ll check it right away.', 'isSender': true, 'time': '11:02 AM'},
      {'message': 'Thank you! Let me know if you have questions.', 'isSender': false, 'time': '11:03 AM'},
      {'message': 'Sure, I’ll message you if I need anything.', 'isSender': true, 'time': '11:04 AM'},
      {'message': 'Perfect, appreciate it.', 'isSender': false, 'time': '11:05 AM'},
      {'message': 'Just finished reading it. A couple of suggestions!', 'isSender': true, 'time': '11:10 AM'},
      {'message': 'Great! What did you think?', 'isSender': false, 'time': '11:12 AM'},
      {'message': 'I think you could make the introduction more concise.', 'isSender': true, 'time': '11:13 AM'},
      {'message': 'Got it! I’ll revise it. Thanks for the feedback.', 'isSender': false, 'time': '11:15 AM'},
    ],
    [
      {'message': 'Hey! Wanna go to the movies tonight?', 'isSender': false, 'time': '6:30 PM'},
      {'message': 'Sounds good! What’s playing?', 'isSender': true, 'time': '6:32 PM'},
      {'message': 'New superhero movie! It’s getting great reviews.', 'isSender': false, 'time': '6:33 PM'},
      {'message': 'Awesome, I’m in. Let’s meet at 7?', 'isSender': true, 'time': '6:35 PM'},
      {'message': 'Cool, see you then!', 'isSender': false, 'time': '6:36 PM'},
      {'message': 'I’m really excited! I’ve been waiting for this movie for weeks.', 'isSender': true, 'time': '6:38 PM'},
      {'message': 'Same here! I love superhero movies. 😎', 'isSender': false, 'time': '6:40 PM'},
      {'message': 'Let’s grab popcorn and snacks too.', 'isSender': true, 'time': '6:41 PM'},
      {'message': 'Definitely! Popcorn is a must. 🍿', 'isSender': false, 'time': '6:43 PM'},
    ],
    [
      {'message': 'Hi, I need help with my order.', 'isSender': true, 'time': '10:00 AM'},
      {'message': 'Sure, can you provide the order number?', 'isSender': false, 'time': '10:02 AM'},
      {'message': 'It’s 12345.', 'isSender': true, 'time': '10:03 AM'},
      {'message': 'Thanks! Your order is being processed.', 'isSender': false, 'time': '10:05 AM'},
      {'message': 'Alright, thank you for the update!', 'isSender': true, 'time': '10:06 AM'},
      {'message': 'Your order is expected to be delivered by 3 PM.', 'isSender': false, 'time': '10:07 AM'},
      {'message': 'Great! I’ll be home by then.', 'isSender': true, 'time': '10:08 AM'},
      {'message': 'Thanks for your patience! If you need further assistance, feel free to reach out.', 'isSender': false, 'time': '10:10 AM'},
      {'message': 'I appreciate it! I’ll let you know if I need anything else.', 'isSender': true, 'time': '10:12 AM'},
    ],
  ];
  // Randomly select one of the chat lists
  late final List<Map<String, dynamic>> chatData;

  ChatScreen({super.key, required this.currentUserName, required this.chatWithName}) {
    final random = Random();
    chatData = chatLists[random.nextInt(chatLists.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.buttonColor,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/image1.jpg'),
              radius: 30  ,
            ),
            const SizedBox(width: 10),
            Text('$chatWithName', style: const TextStyle(fontSize: 18)), // Displaying the name of the person
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call) ,color:ColorConstant.buttonColor, onPressed: () {}),
          IconButton(icon: const Icon(Icons.video_call) ,color:ColorConstant.buttonColor, onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), color:ColorConstant.buttonColor, onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatData.length,
              reverse: true, // Most recent messages at the bottom
              itemBuilder: (context, index) {
                final chat = chatData[index];
                return ChatBubble(
                  message: chat['message'],
                  isSender: chat['isSender'],
                  time: chat['time'],
                );
              },
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;

  const ChatBubble({super.key, required this.message, required this.isSender, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isSender ? ColorConstant.buttonColor : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isSender ? const Radius.circular(12) : const Radius.circular(0),
                  bottomRight: isSender ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.attach_file),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),

          ),
          Icon(Icons.send, color: ColorConstant.buttonColor),
        ],
      ),
    );
  }
}

