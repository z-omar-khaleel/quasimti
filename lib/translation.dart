import 'package:get/get.dart';
import 'package:qasimati/utils/ar.dart';
import 'package:qasimati/utils/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
