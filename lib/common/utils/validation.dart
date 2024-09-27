class _AppValidation {
  // 1: Name validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Name must contain only alphabets';
    }
    return null;
  }

  // 2: Number validation
  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number cannot be empty';
    }
    final numberRegExp = RegExp(r'^[0-9]+$');
    if (!numberRegExp.hasMatch(value)) {
      return 'Number must contain only digits';
    }
    return null;
  }

  // 3: Empty field validation
  String? validateEmptyField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  // 4: Empty amount validation
  String? validateEmptyAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount cannot be empty';
    }
    final amountRegExp = RegExp(r'^\d+(\.\d+)?$');
    if (!amountRegExp.hasMatch(value)) {
      return 'Invalid amount';
    }
    return null;
  }

  // 5: Length validation
  String? validateLength(String? value, int minLength, int maxLength) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    if (value.length < minLength || value.length > maxLength) {
      return 'Field must be between $minLength and $maxLength characters';
    }
    return null;
  }

  // 6: Special character validation
  String? validateSpecialChars(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    final specialCharRegExp = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!specialCharRegExp.hasMatch(value)) {
      return 'Field must not contain special characters';
    }
    return null;
  }

  // 7: Only integer validation
  String? validateInteger(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    final integerRegExp = RegExp(r'^[0-9]+$');
    if (!integerRegExp.hasMatch(value)) {
      return 'Field must contain only integers';
    }
    return null;
  }

  // 8: Only string validation
  String? validateString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    final stringRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!stringRegExp.hasMatch(value)) {
      return 'Field must contain only alphabets';
    }
    return null;
  }

  String? email(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

var validation = _AppValidation();

