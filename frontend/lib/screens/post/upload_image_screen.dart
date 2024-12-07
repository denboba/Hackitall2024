
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For selecting images
import 'dart:io';

class MediaUploadWidget extends StatefulWidget {
  const MediaUploadWidget({super.key});

  @override
  _MediaUploadWidgetState createState() => _MediaUploadWidgetState();
}

class _MediaUploadWidgetState extends State<MediaUploadWidget> {
  bool _isUploading = false;
  String? _uploadMessage;
  File? _selectedFile;

  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  @override
  void initState() {
    super.initState();
    _pickImage(); // Automatically pick an image when the widget is loaded
  }

  // Function to automatically pick an image from gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Open gallery to pick image
      if (image != null) {
        setState(() {
          _selectedFile = File(image.path); // Store the selected image file
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Function to upload the selected image
  Future<void> _uploadMedia() async {
    if (_selectedFile != null) {
      setState(() {
        _isUploading = true;
      });

      try {
        // Simulate uploading the file (for example, you can upload to your server here)
        await Future.delayed(const Duration(seconds: 2)); // Simulate a delay for upload
        setState(() {
          _uploadMessage = 'Upload done';
        });
      } catch (e) {
        setState(() {
          _uploadMessage = 'Upload failed';
        });
        print('Error uploading file: $e');
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    } else {
      setState(() {
        _uploadMessage = 'No file selected';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display the selected image
          if (_selectedFile != null) ...[
            Image.file(
              _selectedFile!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text('Selected image: ${_selectedFile!.path.split('/').last}'),
          ],

          // Display the "Upload" button to upload the selected image
          if (_selectedFile != null) ...[
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadMedia,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Upload Image'),
            ),
          ],

          // Display the upload result message
          if (_uploadMessage != null) ...[
            const SizedBox(height: 20),
            Text(
              _uploadMessage!,
              style: TextStyle(
                color: _uploadMessage == 'Upload done' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
