import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ExploreTheCountry extends StatefulWidget {
  @override
  _ExploreTheCountryState createState() => _ExploreTheCountryState();
}

class _ExploreTheCountryState extends State<ExploreTheCountry> {
  File? _image;
  final _nameController = TextEditingController();
  final _storyController = TextEditingController();
  final _locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourist Sites of the Country'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? Icon(Icons.camera_alt, size: 50, color: Colors.white)
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Site Name'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _storyController,
              decoration: InputDecoration(labelText: 'Story'),
              maxLines: 4,
            ),
            SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Display the tourist site info
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(_nameController.text),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _image == null
                            ? Container()
                            : Image.file(_image!, height: 150),
                        SizedBox(height: 8),
                        Text('Story: ${_storyController.text}'),
                        SizedBox(height: 8),
                        Text('Location: ${_locationController.text}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Show Tourist Site'),
            ),
          ],
        ),
      ),
    );
  }
}
