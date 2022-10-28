library my_prj.globals;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

String userName = '';
String userFristName = '';
String email = '';
String uuid = '';

bool isLoggedIn = false;
String token = '';
final CounterStorage storage = CounterStorage();

class CounterStorage {
  String name = 'login.json';
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$name');
  }

  Future<String> readCounter(String nameFile) async {
    try {
      final file = await _localFile;
      name = nameFile;
      // Read the file
      final contents = await file.readAsString();

      return contents.toString();
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> writeCounter(String nameFile, Map counter) async {
    final file = await _localFile;
    name = nameFile;

    // Write the file
    print('write: $counter');
    String counter_ = json.encode(counter);
    return file.writeAsString('$counter_');
  }
}
