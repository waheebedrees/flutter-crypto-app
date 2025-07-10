import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../providers/local_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Local State Variables (Only for non-persistent settings)
  bool _notificationsEnabled = true;
  bool _twoFactorAuth = false;
  bool _fingerprintAuth = false;
  bool _pinAuth = false;
  bool _updateNotifications = true; // Separate toggle for update notifications

  @override
  Widget build(BuildContext context) {
    // Get Providers
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    // Get current settings from providers
    bool isDarkMode = themeProvider.isDarkMode;
    String selectedLanguage =
        localeProvider.locale.languageCode == 'ar' ? 'Arabic' : 'English';

    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات التطبيق'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Theme'),
          SwitchListTile(
            title: const Text('Dark'),
            value: isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),

          _buildSectionHeader('Language'),
          DropdownButtonFormField<String>(
            value: selectedLanguage,
            items: ['Arabic', 'English'].map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              final locale =
                  value == 'Arabic' ? const Locale('ar') : const Locale('en');
              localeProvider.setLocale(locale);
            },
            decoration: const InputDecoration(labelText: 'choose Language'),
          ),

          _buildSectionHeader('Notifications'),
          SwitchListTile(
            title: const Text('تفعيل الإشعارات'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),

          _buildSectionHeader('الأمان'),
          SwitchListTile(
            title: const Text('المصادقة الثنائية'),
            value: _twoFactorAuth,
            onChanged: (value) {
              setState(() {
                _twoFactorAuth = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('البصمة'),
            value: _fingerprintAuth,
            onChanged: (value) {
              setState(() {
                _fingerprintAuth = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('رمز PIN'),
            value: _pinAuth,
            onChanged: (value) {
              setState(() {
                _pinAuth = value;
              });
            },
          ),

          // الحساب
          _buildSectionHeader('الحساب'),
          ListTile(
            title: const Text('تعديل المعلومات'),
            trailing: const Icon(Icons.edit),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text('تسجيل الخروج'),
            trailing: const Icon(Icons.logout),
            onTap: () {
            },
          ),

          
          _buildSectionHeader('التحديثات'),
          SwitchListTile(
            title: const Text('إشعارات حول التحديثات الجديدة'),
            value: _updateNotifications,
            onChanged: (value) {
              setState(() {
                _updateNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }


  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
