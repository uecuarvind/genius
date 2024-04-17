import 'package:genius_bank/app_helper/helper.dart';
import 'package:genius_bank/main.dart';

class Validator {
  static String? emailValidator(value){
    if (value== null || value.isEmpty) {
      return '${appLanguage().email}${appLanguage().required}';
    } else if(!Helper.isEmailValid(value)) {
      return appLanguage().please_enter_valid_Email_Address;
    } else {
      return null;
    }
  }

}