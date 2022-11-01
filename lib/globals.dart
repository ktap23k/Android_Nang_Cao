library my_prj.globals;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

String userName = '';
String userFristName = '';
String email = '';
String uuid = '';
String age = '';
String gender = '';

bool isLoggedIn = false;
String token = '';
final CounterStorage storage = CounterStorage();

// save profile data
// data is: {user_id: 5, age: null, name: Tran Anh Tuan, gender: null, gender_free_description: null, email: ktap1k@gmail.com, avatar: null, date_of_birth: null}
Map profile;

//save cv data
// {
//         "cv": {
//             "cv_id": 1,
//             "university_name": "HVKT Mật Mã",
//             "registration_number": "123",
//             "cmnd_cccd": "12436666",
//             "interests": "Yêu màu hồng ghét sự giả dối",
//             "character": "bình thường",
//             "contryside": "Quảng Nam",
//             "education": 2,
//             "salary": 100000,
//             "region": "Miền Bắc",
//             "city": "Hà Nội",
//             "height": 200,
//             "weight": 60,
//             "exp": 3,
//             "created_at": "2022-10-26T02:22:39+0900",
//             "updated_at": "2022-11-01T17:29:26+0900",
//             "user": 5
//         },
//         "job_user_info": [
//             {
//                 "cv": 1,
//                 "address_company": "chiến thắng",
//                 "name_job": "xử lí hình ảnh",
//                 "position": "TTS",
//                 "info_job": "abcd",
//                 "start_at": "10/10/2022",
//                 "end_at": "20/10/2022",
//                 "user_job": 2,
//                 "job_user_id": 1
//             },
//             {
//                 "cv": 1,
//                 "address_company": "chiến thắng, 123",
//                 "name_job": "xử lí hình ảnh 123",
//                 "position": "TTS, Middle",
//                 "info_job": "abcd 123",
//                 "start_at": "10/10/2022",
//                 "end_at": "20/10/2022",
//                 "user_job": 2,
//                 "job_user_id": 2
//             }
//         ]
//     }
Map cv;

// finds data
Map finds;

// list job data
Map list_job;

//list job recruiment
Map recruiment;

//data fake cv
Map cv_fake = {
  "cv": {
    "cv_id": 0,
    "university_name": "HVKT Mật Mã",
    "registration_number": "123",
    "cmnd_cccd": "12436666",
    "interests": "Yêu màu hồng ghét sự giả dối",
    "character": "bình thường",
    "contryside": "Quảng Nam",
    "education": 2,
    "salary": 100000,
    "region": "Miền Bắc",
    "city": "Hà Nội",
    "height": 200,
    "weight": 60,
    "exp": 3,
    "created_at": "2022-10-26T02:22:39+0900",
    "updated_at": "2022-11-01T17:29:26+0900",
    "user": 5
  },
  "job_user_info": [
    {
      "cv": 1,
      "address_company": "chiến thắng",
      "name_job": "xử lí hình ảnh",
      "position": "TTS",
      "info_job": "abcd",
      "start_at": "10/10/2022",
      "end_at": "20/10/2022",
      "user_job": 2,
      // DEV_IOS = 0
      // DEV_ANDROID = 1
      // DEV_WEB = 2
      // DEV_FULLSTACK = 3
      "job_user_id": 1,
      "img_link": ""
    },
    {
      "cv": 1,
      "address_company": "chiến thắng, 123",
      "name_job": "xử lí hình ảnh 123",
      "position": "TTS, Middle",
      "info_job": "abcd 123",
      "start_at": "10/10/2022",
      "end_at": "20/10/2022",
      "user_job": 2,
      "job_user_id": 2,
      "img_link": ""
    }
  ]
};

//find data fake
Map find_fake = {};

// read write data local
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
