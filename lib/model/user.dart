class User {
  static var _username;
  static var _email;

  static void setUsername(var username) {
    _username = username;
  }

  static void setEmail(var email) {
    _email = email;
  }

  static void setUser(var username, var email) {
    _email = email;
    _username = username;
  }

  static String getUsername() {
    return _username;
  }

  static String getEmail() {
    return _email;
  }
}
