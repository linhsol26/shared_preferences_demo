import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class PrefencesService {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('username', settings.username);
    await preferences.setBool('isEmployed', settings.isEmployed);
    await preferences.setInt('gender', settings.gender.index);
    await preferences.setStringList('programmingLanguages',
        settings.programmingLanguages.map((e) => e.index.toString()).toList());

    print('Saved');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final username = preferences.getString('username');
    final isEmployed = preferences.getBool('isEmployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];
    final programmingLanguages = preferences
        .getStringList('programmingLanguages')!
        .map((e) => ProgrammingLanguage.values[int.parse(e)])
        .toSet();

    return Settings(
        username: username!,
        gender: gender,
        programmingLanguages: programmingLanguages,
        isEmployed: isEmployed!);
  }
}
