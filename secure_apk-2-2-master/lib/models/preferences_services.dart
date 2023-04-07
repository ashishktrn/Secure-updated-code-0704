import 'package:secure_apk/models/attenanceResponse_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool("attendanceSuccess", settings.attendanceSuccess);
    await preferences.setBool(
        "attendanceSuccess2", settings.attendanceSuccess2);
    print("saved settings");
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final attendanceSuccess = preferences.getBool("attendanceSuccess");
    final attendanceSuccess2 = preferences.getBool("attendanceSuccess2");
    return Settings(
        //changes done remove true and ?? for normal working of application
        attendanceSuccess: attendanceSuccess ?? true,
        attendanceSuccess2: attendanceSuccess2 ?? true);
  }
}
