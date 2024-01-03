import 'dart:convert';
import '../model/user.dart';

class Respone {
  static void handleResponse(String responseBody) {
    Map<String, dynamic> parsedJson = json.decode(responseBody);

    // Kiểm tra nếu có lỗi trong phản hồi
    if (parsedJson["error"] == 0) {
      // Xử lý dữ liệu hợp lệ
      var userData = parsedJson["data"];
      User.setUser(userData['username'], userData['email']);
    } else {
      // Xử lý lỗi
      print("Error in response");
    }
  }
}
