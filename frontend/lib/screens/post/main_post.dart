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
  XFile? _imageFile; // Nullable since no image might be selected

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
        padding: const EdgeInsets.all(20.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Row layout for image and form
              if (_imageFile != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display selected image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(_imageFile!.path),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Spacer to push the form fields to the right
                    const SizedBox(width: 16),

                    // Form fields
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                        ],
                      ),
                    ),
                  ],
                ),

              if (_imageFile == null) const SizedBox(height: 16),

              // Submit button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitPost,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Post'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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



