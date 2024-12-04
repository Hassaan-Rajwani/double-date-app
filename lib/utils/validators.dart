import 'package:double_date/utils/helpers.dart';
import 'package:intl/intl.dart';

passwordValidator(
  String password, {
  String password2 = '',
}) {
  if (password2 != '') {
    if (password.isEmpty) {
      return 'Please Enter Your Password';
    }
    if (password.isNotEmpty && password.length < 8) {
      return 'Please Enter Atleast 8 Characters';
    }
    if (password != password2) {
      return 'Password Does\'nt Match';
    }
  } else {
    if (password.isEmpty) {
      return 'Please Enter Your Password';
    }
    if (password.isNotEmpty && password.length < 8) {
      return 'Please Enter Atleast 8 Characters';
    }
  }
}

oldPasswordValidator(String password) {
  if (password.isEmpty) {
    return 'Please Enter Your Password';
  }
}

emailValidator(String email) {
  if (email.isEmpty) {
    return 'Please Enter Your Email Address';
  }
  if (email.isNotEmpty) {
    RegExp regex = RegExp(emailRegex);
    bool emailValidate = regex.hasMatch(email);
    if (emailValidate) {
      return;
    } else {
      return 'Please Enter Valid Email Address';
    }
  }
}

nameValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Your Name';
  }
}

titleValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Title Of Post';
  }
}

supportTitleValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Ticket Title';
  }
}

supportDesValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Ticket Description';
  }
}

codeValidator(String name) {
  if (name.isEmpty && name.length < 4) {
    return 'Please Enter Valid Code';
  }
  if (name.isNotEmpty && name.length < 4) {
    return 'Please Enter Valid Code';
  }
}

descriptionValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Description Of Post';
  }
}

feedbackDesValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Feedback Description';
  }
}

phoneValidator(String name) {
  if (name.isEmpty) {
    return 'Invalid Phone Number';
  }
}

countryValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Your Country Name';
  }
}

genderValidator(gender) {
  if (gender == "" || gender == null || gender == 'Select Gender') {
    return "Please Select Your Gender";
  } else {
    return null;
  }
}

dateValidator(date) {
  if (date == "" || date == null) {
    return 'Please Select Date Of Birth';
  }
  final dateFormat = DateFormat('yyyy-MM-dd');
  final birthDate = dateFormat.parse(date);
  final now = DateTime.now();
  final age = now.year - birthDate.year - (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day) ? 1 : 0);
  if (age < 18) {
    return 'Age Must Be Atleast 18';
  } else {
    return null;
  }
}

cityValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Your City Name';
  }
}

timerDescriptionValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Description';
  }
}

stateValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter Your State Name';
  }
}

appValidator(String name) {
  if (name.isEmpty) {
    return 'Please Enter required field';
  }
}

heightValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter height';
  }
  final regex = RegExp(r'^\d{1,3}$');
  if (regex.hasMatch(value)) {
    return null;
  }
  return 'Please enter a valid number';
}

otpValidator(String name) {
  if (name.isEmpty) {
    return 'Please enter OTP';
  }
  if (name.isNotEmpty && name.length < 4) {
    return 'Please enter OTP';
  }
}
