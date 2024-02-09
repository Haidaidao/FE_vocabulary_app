class User {
  static var _id;
  static var _username;
  static var _email;
  static var _nameCourse;
  static var _idCourse;

  static void setNameCourse(var name) {
    _nameCourse = name;
  }

  static void setIdCourse(var id) {
    _idCourse = id;
  }

  static void setUsername(var username) {
    _username = username;
  }

  static void setEmail(var email) {
    _email = email;
  }

  static void setUser(
      var id, var username, var email, var nameCourse, var idCourse) {
    _id = id;
    _email = email;
    _username = username;
    _nameCourse = nameCourse;
    _idCourse = idCourse;
  }

  static String getNameCourse() {
    return _nameCourse;
  }

  static String getIdCourse() {
    return _idCourse;
  }

  static String getId() {
    return _id;
  }

  static String getUsername() {
    return _username;
  }

  static String getEmail() {
    return _email;
  }
}
