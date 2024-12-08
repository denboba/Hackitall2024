import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Section
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile Settings'),
              onTap: () {
                // Navigate to profile editing screen
              },
            ),

            const Divider(),

            // Notifications Section
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),

            const Divider(),

            // Language Section
            ListTile(
              leading: const Icon(Icons.language),
              title: Text('Language: $_selectedLanguage'),
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
              title: const Text('Privacy Settings'),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
