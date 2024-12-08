import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostUploadForm extends StatefulWidget {
  const PostUploadForm({super.key});

  @override
  _PostUploadFormState createState() => _PostUploadFormState();
}

class _PostUploadFormState extends State<PostUploadForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  XFile? _imageFile;

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  // Function to submit the post (you can replace it with an actual API call)
  void _submitPost() {
    if (_descriptionController.text.isNotEmpty && _tagsController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post Submitted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Reduced padding for better space usage
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Image Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Upload Image'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(200, 50), // Set minimum size to avoid too small button
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Display selected image if available
              if (_imageFile != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      File(_imageFile!.path),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Description field
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),

              // Tags field
              TextField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma-separated)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitPost,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Post'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
