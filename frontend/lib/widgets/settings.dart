import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  // Method to update notification preference
  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  // Method to update language preference
  void _updateLanguage(String value) {
    setState(() {
      _selectedLanguage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set font size dynamically based on screen width
    double fontSize = screenWidth > 600 ? 18.0 : 16.0;  // Larger font on bigger screens

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),  // Responsive padding
        child: ListView(
          children: [
            // Profile Section
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                'Profile Settings',
                style: TextStyle(fontSize: fontSize),  // Dynamic font size
              ),
              onTap: () {
                // Navigate to profile editing screen
              },
            ),

            const Divider(),

            // Notifications Section
            SwitchListTile(
              title: Text(
                'Enable Notifications',
                style: TextStyle(fontSize: fontSize),  // Dynamic font size
              ),
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),

            const Divider(),

            // Language Section
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(
                'Language: $_selectedLanguage',
                style: TextStyle(fontSize: fontSize),  // Dynamic font size
              ),
              onTap: () {
                // Show language options
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Language'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('English'),
                            onTap: () {
                              _updateLanguage('English');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('Romana'),
                            onTap: () {
                              _updateLanguage('Romana');
                              Navigator.pop(context);
                            },
                          ),
                          // Add more languages if needed
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const Divider(),

            // Privacy Section
            ListTile(
              leading: const Icon(Icons.lock),
              title: Text(
                'Privacy Settings',
                style: TextStyle(fontSize: fontSize),  // Dynamic font size
              ),
              onTap: () {
                // Navigate to privacy settings screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
