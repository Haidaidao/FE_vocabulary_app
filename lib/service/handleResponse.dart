import 'dart:convert';
import '../model/user.dart';
import 'dart:io';
import '../model/user.dart';
import 'package:path_provider/path_provider.dart';

class Respone {
  static void handleResponse(String responseBody) {
    Map<String, dynamic> parsedJson = json.decode(responseBody);

    // Kiểm tra nếu có lỗi trong phản hồi
    if (parsedJson["error"] == 0) {
    } else {
      // Xử lý lỗi
      print("Error in response");
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.txt');
  }

  static Future<String> readFile() async {
    try {
      final file = await _localFile;
      // Đọc file
      String contents = await file.readAsString();
      List<String> lineContent = contents.split('\n');

      User.setUser(lineContent[0], lineContent[1], lineContent[2],
          lineContent[3], lineContent[4]);
      print(lineContent);
      return contents;
    } catch (e) {
      // Nếu gặp lỗi, trả về một chuỗi trống hoặc thông báo lỗi
      return 'Error: $e';
    }
  }

  static Future<File> writeFile(String id, String username, String email,
      String nameCourse, String idCourse) async {
    final file = await _localFile;

    // Viết file
    return file.writeAsString(id +
        '\n' +
        username +
        '\n' +
        email +
        '\n' +
        nameCourse +
        '\n' +
        idCourse);
  }
}
