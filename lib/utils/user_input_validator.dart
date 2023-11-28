class UserInputValidator {
  static bool validEmailFormat(String email) {
    // 이메일 형식을 검증하기 위한 정규 표현식
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    // 정규 표현식과 문자열을 비교하여 형식이 일치하는지 확인
    bool validEmail = emailRegExp.hasMatch(email);

    if (!validEmail) {
      return false;
    }
    return true;
  }

  static bool validPasswordFormat(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');

    // 정규 표현식과 문자열을 비교하여 형식이 일치하는지 확인
    return passwordRegExp.hasMatch(password);
  }

  static bool validEmailAndPasswordFormat(String email, String password) {
    return validEmailFormat(email) && validPasswordFormat(password);
  }
}
