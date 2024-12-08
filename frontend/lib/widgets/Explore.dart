// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';
// //
// // class ExploreTheCountry extends StatefulWidget {
// //   @override
// //   _ExploreTheCountryState createState() => _ExploreTheCountryState();
// // }
// //
// // class _ExploreTheCountryState extends State<ExploreTheCountry> {
// //   File? _image;
// //   final _nameController = TextEditingController();
// //   final _storyController = TextEditingController();
// //   final _locationController = TextEditingController();
// //
// //   final ImagePicker _picker = ImagePicker();
// //
// //   Future<void> _pickImage() async {
// //     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
// //     if (pickedFile != null) {
// //       setState(() {
// //         _image = File(pickedFile.path);
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Tourist Sites of the Country'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             GestureDetector(
// //               onTap: _pickImage,
// //               child: Container(
// //                 width: double.infinity,
// //                 height: 200,
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[300],
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: _image == null
// //                     ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
// //                     : ClipRRect(
// //                   borderRadius: BorderRadius.circular(10),
// //                   child: Image.file(_image!, fit: BoxFit.cover),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             TextField(
// //               controller: _nameController,
// //               decoration: InputDecoration(labelText: 'Site Name'),
// //             ),
// //             SizedBox(height: 8),
// //             TextField(
// //               controller: _storyController,
// //               decoration: InputDecoration(labelText: 'Story'),
// //               maxLines: 4,
// //             ),
// //             SizedBox(height: 8),
// //             TextField(
// //               controller: _locationController,
// //               decoration: InputDecoration(labelText: 'Location'),
// //             ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Display the tourist site info
// //                 showDialog(
// //                   context: context,
// //                   builder: (context) => AlertDialog(
// //                     title: Text(_nameController.text),
// //                     content: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         _image == null
// //                             ? Container()
// //                             : Image.file(_image!, height: 150),
// //                         SizedBox(height: 8),
// //                         Text('Story: ${_storyController.text}'),
// //                         SizedBox(height: 8),
// //                         Text('Location: ${_locationController.text}'),
// //                       ],
// //                     ),
// //                     actions: [
// //                       TextButton(
// //                         onPressed: () {
// //                           Navigator.of(context).pop();
// //                         },
// //                         child: Text('Close'),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //               child: Text('Show Tourist Site'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class ExploreTheCountry extends StatefulWidget {
//   @override
//   _ExploreTheCountryState createState() => _ExploreTheCountryState();
// }
//
//  class _ExploreTheCountryState extends State<ExploreTheCountry> {
//   File? _image;
//   final _nameController = TextEditingController();
//   final _storyController = TextEditingController();
//   final _locationController = TextEditingController();
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tourist Sites of the Country'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: _pickImage,
//               child: Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: _image == null
//                     ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
//                     : ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.file(_image!, fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Site Name'),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: _storyController,
//               decoration: InputDecoration(labelText: 'Story'),
//               maxLines: 4,
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(labelText: 'Location'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Display the tourist site info
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text(_nameController.text),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _image == null
//                             ? Container()
//                             : Image.file(_image!, height: 150),
//                         SizedBox(height: 8),
//                         Text('Story: ${_storyController.text}'),
//                         SizedBox(height: 8),
//                         Text('Location: ${_locationController.text}'),
//                       ],
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Close'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               child: Text('Show Tourist Site'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ExploreTheCountry extends StatefulWidget {
  @override
  _ExploreTheCountryState createState() => _ExploreTheCountryState();
}

class _ExploreTheCountryState extends State<ExploreTheCountry> {
  final List<Map<String, dynamic>> touristSites = List.generate(
    10,
        (index) => {
      'name': 'Site Name $index',
      'location': 'Location $index',
      'story': 'Story about the site $index',
      'rating': 4, // Example rating
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: const Text(
            'Tourist Sites of the Country',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: touristSites.length, // Number of tourist sites
          itemBuilder: (context, index) {
            final site = touristSites[index];
            return TouristSiteCard(
              name: site['name']!,
              location: site['location']!,
              story: site['story']!,
              rating: site['rating']!,
            );
          },
        ),
      ),
    );
  }
}

// widget with text fields for tourist site details that are transmitted
class TouristSiteCard extends StatelessWidget {
  final String name;
  final String location;
  final String story;
  final int rating;

  const TouristSiteCard({
    Key? key,
    required this.name,
    required this.location,
    required this.story,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for an image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.camera_alt, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Name of the site
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Location of the site
            Text(
              "Location: $location",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Story about the site
            Text(
              story,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 16),

            // Star rating
            Row(
              children: List.generate(5, (i) {
                return Icon(
                  Icons.star,
                  color: i < rating ? Colors.amber : Colors.grey,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}