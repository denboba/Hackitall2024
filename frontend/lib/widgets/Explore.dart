import 'package:flutter/material.dart';
import 'package:frontend/constants/color_constant.dart';

class ExploreTheCountry extends StatefulWidget {
  @override
  _ExploreTheCountryState createState() => _ExploreTheCountryState();
}

class _ExploreTheCountryState extends State<ExploreTheCountry> {
  final List<Map<String, dynamic>> touristSites = [
    {
      'name': 'Sighișoara Citadel',
      'location': 'Sighișoara, Romania',
      'story': 'A perfectly preserved medieval citadel known as the birthplace of Vlad the Impaler, offering colorful streets and a step back in time.',
      'image': 'assets/images/sighisoara.png',
    },
    {
      'name': 'Corvin Castle',
      'location': 'Hunedoara, Romania',
      'story': 'A stunning Gothic-style castle, rich in history and legend, known as one of the largest castles in Europe.',
      'image': 'assets/images/corvin_castle.png',
    },
    {
      'name': 'Danube Delta',
      'location': 'Tulcea, Romania',
      'story': 'One of Europe’s most biodiverse areas, offering unique wildlife, serene waterways, and picturesque fishing villages.',
      'image': 'assets/images/danube_delta.png',
    },
    {
      'name': 'Merry Cemetery',
      'location': 'Săpânța, Romania',
      'story': 'A colorful cemetery famous for its brightly painted tombstones with humorous poems and artwork reflecting the lives of the deceased.',
      'image': 'assets/images/merry_cemetery.png',
    },
    {
      'name': 'Bucegi Mountains',
      'location': 'Prahova Valley, Romania',
      'story': 'A majestic mountain range filled with hiking trails, natural rock formations like the Sphinx, and breathtaking panoramic views.',
      'image': 'assets/images/bucegi_mountains.png',
    },
    {
      'name': 'Turda Salt Mine',
      'location': 'Turda, Romania',
      'story': 'An underground wonder featuring a unique amusement park, boat rides, and a surreal experience in the depths of a salt mine.',
      'image': 'assets/images/turda_salt_mine.png',
    },
    {
      'name': 'Bigăr Waterfall',
      'location': 'Caraș-Severin, Romania',
      'story': 'A stunning and unique waterfall where water flows over moss-covered rocks, creating a magical curtain-like effect.',
      'image': 'assets/images/bigar_waterfall.png',
    },
    {
      'name': 'Bâlea Lake',
      'location': 'Făgăraș Mountains, Romania',
      'story': 'A beautiful glacial lake located in the Carpathian Mountains, accessible via the Transfăgărășan Highway.',
      'image': 'assets/images/danube_delta.png',
    },
    {
      'name': 'Scărișoara Ice Cave',
      'location': 'Apuseni Mountains, Romania',
      'story': 'One of the oldest ice caves in the world, featuring ancient ice formations and a unique underground experience.',
      'image': 'assets/images/turda_salt_mine.png',
    },
    {
      'name': 'The Sphinx of Bucegi',
      'location': 'Bucegi Mountains, Romania',
      'story': 'A natural rock formation resembling a human face, surrounded by mystery, legends, and conspiracy theories.',
      'image': 'assets/images/bucegi_mountains.png',
    }
    // Add more sites as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Romania',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: touristSites.length,
        itemBuilder: (context, index) {
          final site = touristSites[index];
          return TouristSiteCard(
            name: site['name']!,
            location: site['location']!,
            story: site['story']!,
            imagePath: site['image']!,
          );
        },
      ),
    );
  }
}

class TouristSiteCard extends StatelessWidget {
  final String name;
  final String location;
  final String story;
  final String imagePath;

  const TouristSiteCard({
    Key? key,
    required this.name,
    required this.location,
    required this.story,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  story,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle Like action
                      },
                      icon: const Icon(Icons.thumb_up_alt_outlined),
                      color: ColorConstant.buttonColor,
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle Comment action
                      },
                      icon: const Icon(Icons.comment_outlined),
                      color: ColorConstant.buttonColor,
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle View action
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      color: ColorConstant.buttonColor
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
