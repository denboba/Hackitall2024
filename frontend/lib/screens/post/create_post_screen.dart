import 'package:flutter/material.dart';

class InstagramPostWidget extends StatelessWidget {
  final String username;
  final String userImage;
  final String postImage;
  final String caption;
  final int likes;
  final int comments;

  const InstagramPostWidget({
    super.key,
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.caption,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildPostImage(),
        _buildActions(),
        _buildLikes(),
        _buildCaption(),
        _buildComments(),
      ],
    );
  }

  Widget _buildHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(userImage),
      ),
      title: Text(username),
      trailing: const Icon(Icons.more_vert),
    );
  }

  Widget _buildPostImage() {
    return Image.asset(postImage, fit: BoxFit.cover, width: double.infinity);
  }

  Widget _buildActions() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            // Handle like action
          },
        ),
        IconButton(
          icon: const Icon(Icons.comment),
          onPressed: () {
            // Handle comment action
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          onPressed: () {
            // Handle bookmark action
          },
        ),
      ],
    );
  }

  Widget _buildLikes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text('$likes likes',
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RichText(
        text: TextSpan(
          text: '$username ',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            TextSpan(
              text: caption,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text('View all $comments comments',
          style: const TextStyle(color: Colors.grey)),
    );
  }
}
