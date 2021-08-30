import 'package:flutter/material.dart';
import 'package:shared_prederences_demo/prefences_service.dart';

void main() {
  runApp(MyApp());
}

enum Gender { MALE, FEMALE, OTHER }

enum ProgrammingLanguage { JAVASCRIPT, PYTHON, DART, SWIFT }

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _usernameController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguages = Set<ProgrammingLanguage>();
  var _isEmployed = false;

  final _preferencesService = PrefencesService();

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('User Settings')),
        body: ListView(
          children: [
            ListTile(
              title: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            RadioListTile(
                title: Text('Female'),
                value: Gender.FEMALE,
                groupValue: _selectedGender,
                onChanged: (newVal) {
                  setState(() {
                    _selectedGender = newVal as Gender;
                  });
                }),
            RadioListTile(
                title: Text('Male'),
                value: Gender.MALE,
                groupValue: _selectedGender,
                onChanged: (newVal) {
                  setState(() {
                    _selectedGender = newVal as Gender;
                  });
                }),
            RadioListTile(
                title: Text('Other'),
                value: Gender.OTHER,
                groupValue: _selectedGender,
                onChanged: (newVal) {
                  setState(() {
                    _selectedGender = newVal as Gender;
                  });
                }),
            CheckboxListTile(
                title: Text('Dart'),
                value: _selectedLanguages.contains(ProgrammingLanguage.DART),
                onChanged: (_) {
                  setState(() {
                    _selectedLanguages.contains(ProgrammingLanguage.DART)
                        ? _selectedLanguages.remove(ProgrammingLanguage.DART)
                        : _selectedLanguages.add(ProgrammingLanguage.DART);
                  });
                }),
            CheckboxListTile(
                title: Text('JavaScript'),
                value:
                    _selectedLanguages.contains(ProgrammingLanguage.JAVASCRIPT),
                onChanged: (_) {
                  setState(() {
                    _selectedLanguages.contains(ProgrammingLanguage.JAVASCRIPT)
                        ? _selectedLanguages
                            .remove(ProgrammingLanguage.JAVASCRIPT)
                        : _selectedLanguages
                            .add(ProgrammingLanguage.JAVASCRIPT);
                  });
                }),
            CheckboxListTile(
                title: Text('Python'),
                value: _selectedLanguages.contains(ProgrammingLanguage.PYTHON),
                onChanged: (_) {
                  setState(() {
                    _selectedLanguages.contains(ProgrammingLanguage.PYTHON)
                        ? _selectedLanguages.remove(ProgrammingLanguage.PYTHON)
                        : _selectedLanguages.add(ProgrammingLanguage.PYTHON);
                  });
                }),
            CheckboxListTile(
                title: Text('Swift'),
                value: _selectedLanguages.contains(ProgrammingLanguage.SWIFT),
                onChanged: (_) {
                  setState(() {
                    _selectedLanguages.contains(ProgrammingLanguage.SWIFT)
                        ? _selectedLanguages.remove(ProgrammingLanguage.SWIFT)
                        : _selectedLanguages.add(ProgrammingLanguage.SWIFT);
                  });
                }),
            SwitchListTile(
              title: Text('Is Employed'),
              onChanged: (bool value) {
                setState(() {
                  _isEmployed = value;
                });
              },
              value: _isEmployed,
            ),
            TextButton(
              onPressed: _saveSetting,
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSetting() {
    final newSettings = Settings(
        username: _usernameController.text,
        gender: _selectedGender,
        programmingLanguages: _selectedLanguages,
        isEmployed: _isEmployed);
    _preferencesService.saveSettings(newSettings);
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();

    setState(() {
      _usernameController.text = settings.username;
      _selectedGender = settings.gender;
      _isEmployed = settings.isEmployed;
      _selectedLanguages = settings.programmingLanguages;
    });
  }
}

class Settings {
  final String username;
  final Gender gender;
  final Set<ProgrammingLanguage> programmingLanguages;
  final bool isEmployed;

  Settings(
      {required this.username,
      required this.gender,
      required this.programmingLanguages,
      required this.isEmployed});
}
