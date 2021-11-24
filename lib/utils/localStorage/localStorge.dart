import 'package:get_storage/get_storage.dart';

class LocalStorage {
  void saveLanguage(String language) async {
    await GetStorage().write("lang", language);
  }

  Future<String> get languageSelected async {
    return await GetStorage().read("lang");
  }

  saveCountry(String country) async {
    await GetStorage().write('country', country);
  }

  Future<String> get countrySelected async {
    return await GetStorage().read("country");
  }

  void saveToggle(int language) async {
    await GetStorage().write("intLang", language);
  }

  Future<int> get toggleSelected async {
    return await GetStorage().read("intLang");
  }
}
