
// import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:get/get.dart';

import 'regex.dart';


class Validations {
  var error = 0;
  static String? emailValidation(String? email) {
    if (email!.isEmpty) {
      return 'email_null'.tr;

    } else if (RegExp(Regex.EMAIL_PATTERN).hasMatch(email)) {
      return null;
    }
    // The pattern of the email didn't match the regex above.
    return 'invalid_email'.tr;
  }

  static String? passwordValidation(String? password) {
    if (password!.isEmpty) {
      return 'enter_pass'.tr;
    } else if (RegExp(Regex.PASSWORD_PATTERN).hasMatch(password)) {
      return null;
    }
    return 'invalid_pass'.tr;
  }

  static String? confirmPasswordValidation(
      {String? password, String? confirmPassword}) {
    if (password!.isEmpty) {
      return 'enter_pass'.tr;
    }
    if (confirmPassword != password) {
      return 'pass_not_match'.tr;
    }
    return null;
  }

  static String? fieldValidation({String? value, String? field}) {
    if (value!.isEmpty) {
      return "$field ${'cannot_be_empty'.tr}";
    }
    return null;
  }

  static String? dropDownValidation(
      {dynamic value, String? field, List<String>? list}) {
    if (value == null || value == "") {
      return "${'set'.tr} $field";
    }
    else if (list == null) {
      return null;
    }
    else {
      if (list.contains(value)) {
        return null;
      }
      else {
        return "${'set'.tr} $field";
      }
    }
  }
}


