class Helper {
  static bool isEmail(String em) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(em);
  }

  static bool isPassword(String em) {
    return RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(em);
  }

  static bool isPhoneNumber(String em) {
    return (RegExp(r'^[0-9]').hasMatch(em) && em.length == 10);
  }

  static bool isCardNumber(String em) {
    return (RegExp(r'^[0-9]').hasMatch(em) && em.length == 16);
  }

  static bool validAddress(String em) {
    List<String> parts = em.split(',');

    if (parts.length < 3) {
      return false;
    }

    for (String part in parts) {
      if (_containsSpecialCharacters(part)) {
        return false;
      }
    }

    return true;
  }

  static bool _containsSpecialCharacters(String input) {
    Set<String> specialCharacters = {'@', '#', '%', '^', '&', '*'};

    return specialCharacters.any((char) => input.contains(char));
  }

  static bool iscvv(String em) {
    return (RegExp(r'^[0-9]').hasMatch(em) && em.length == 3);
  }

  static bool isValidURL(String url) {
    // Regular expression for URL validation
    // This pattern allows URLs with http://, https://, or without any protocol
    RegExp urlRegExp = RegExp(
      r"^(https?:\/\/)?"
      r"((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|"
      r"((\d{1,3}\.){3}\d{1,3}))"
      r"(\:\d+)?(\/[-a-z\d%_.~+]*)*"
      r"(\?[;&a-z\d%_.~+=-]*)?"
      r"(\#[-a-z\d_]*)?$",
      caseSensitive: false,
      multiLine: false,
    );
    return urlRegExp.hasMatch(url);
  }

  static String getMonthName(String date) {
    DateTime formatedDate = DateTime.parse(date).toLocal();
    int day = formatedDate.day;
    int month = formatedDate.month;
    switch (month) {
      case 1:
        return '$day Jan';
      case 2:
        return '$day Feb';
      case 3:
        return '$day Mar';
      case 4:
        return '$day Apr';
      case 5:
        return '$day May';
      case 6:
        return '$day Jun';
      case 7:
        return '$day Jul';
      case 8:
        return '$day Aug';
      case 9:
        return '$day Sep';
      case 10:
        return '$day Oct';
      case 11:
        return '$day Nov';
      case 12:
        return '$day Dec';
      default:
        return '';
    }
  }



  
}
