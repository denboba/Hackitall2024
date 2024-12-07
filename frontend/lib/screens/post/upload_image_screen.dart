import 'package:flutter/material.dart';
import 'package:frontend/models/env.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appwrite/appwrite.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MediaUploadWidget extends StatefulWidget {
  const MediaUploadWidget({super.key});

  @override
  _MediaUploadWidgetState createState() => _MediaUploadWidgetState();
}

class _MediaUploadWidgetState extends State<MediaUploadWidget> {
  late final Storage storage;
  bool _isUploading = false;
  String? _uploadMessage;
  List<File> _mediaFiles = [];
  File? _selectedFile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final client = Provider.of<AuthProvider>(context, listen: false).client;
   // storage = Storage(client); // Initialize the storage object
    _loadFiles(); // Load files when widget is initialized
  }

  // Load the image files from the device's storage
  Future<void> _loadFiles() async {
    final directory = await getApplicationDocumentsDirectory(); // Use the appropriate directory for storing images
    final imageDirectory = Directory('${directory.path}/images'); // You can adjust this path based on how you save images

    // Fetch all image files (you may want to filter based on your file naming convention or types)
    final List<FileSystemEntity> files = imageDirectory.listSync();
    setState(() {
      _mediaFiles = files.where((file) {
        return file.path.endsWith('.jpg') || file.path.endsWith('.png'); // You can add more types like '.jpeg', etc.
      }).map((e) => File(e.path)).toList();
    });
  }

  Future<void> _uploadMedia() async {
    if (_selectedFile != null) {
      setState(() {
        _isUploading = true;
      });

      try {
        final response = await storage.createFile(
          bucketId: AppCredentials.userBucket,
          fileId: ID.unique(),
          file: InputFile.fromPath(
            path: _selectedFile!.path,
            filename: _selectedFile!.path.split('/').last,
          ),
        );
        print('File uploaded successfully: ${response.$id}');
        setState(() {
          _uploadMessage = 'Upload done';
        });
      } catch (e) {
        print('Error uploading file: $e');
        setState(() {
          _uploadMessage = 'Upload failed';
        });
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display the available media files for selection
          if (_mediaFiles.isNotEmpty) ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _mediaFiles.length,
              itemBuilder: (context, index) {
                final file = _mediaFiles[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFile = file;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedFile == file ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ] else ...[
            Text("No files available."),
          ],

          // Display the "Next" button to upload the selected file
          if (_selectedFile != null)
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadMedia,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Next'),
            ),
          if (_uploadMessage != null) ...[
            const SizedBox(height: 20),
            Text(
              _uploadMessage!,
              style: TextStyle(
                color:
                _uploadMessage == 'Upload done' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
