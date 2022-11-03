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

// ignore: non_constant_identifier_names
String avata_null =
    "https://androidtuan.s3.amazonaws.com/img/9f77541b-29a7-4541-ab81-e3121b2a8534.jpeg";

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
//                 "user_job": 1,
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



// list job data
Map list_job;

int indexlist = 0;
int indexdefault = 0;

// finds data
// {
//     "result": [
//         {
//             "user": 1,
//             "phone": "0347913389",
//             "email": "ktap23k@gmail.com",
//             "name_company": "hkkhkhk",
//             "region": "Hà Nội",
//             "city": "Hà Hội",
//             "address_company": "Tân Triều, Thanh Trì",
//             "orther_req": "không",
//             "benefit": ",jhjhhjj",
//             "end_time": "11/2022",
//             "list_id": 1,
//             "job_employer_infos": [
//                 {
//                     "list_job": 1,
//                     "basic_salary": 120202020,
//                     "number": 3,
//                     "gender": 0,
//                     "age": 4,
//                     "exp": 3,
//                     "level_languge": "123",
//                     "position_job": "123",
//                     "info_job": "123",
//                     "languge_job": "python, java",
//                     "job_employer_id": 1
//                 },
//                 {
//                     "list_job": 1,
//                     "basic_salary": 1234,
//                     "number": 12,
//                     "gender": 2,
//                     "age": 33,
//                     "exp": 5,
//                     "level_languge": "master",
//                     "position_job": "lead",
//                     "info_job": "Xu li AI",
//                     "languge_job": "python, R",
//                     "job_employer_id": 2
//                 }
//             ]
//         },
//         {
//             "user": 7,
//             "phone": "0347913389",
//             "email": "ktap23k@gmail.com",
//             "name_company": "ABC",
//             "region": "Thanh Tri",
//             "city": "Ha Noi",
//             "address_company": "Tan Trieu",
//             "orther_req": "Khoong",
//             "benefit": "Khoong",
//             "end_time": "12/2022",
//             "list_id": 2,
//             "job_employer_infos": [
//                 {
//                     "list_job": 2,
//                     "basic_salary": 4355,
//                     "number": 1,
//                     "gender": 0,
//                     "age": 44,
//                     "exp": 2,
//                     "level_languge": "master E, N1",
//                     "position_job": "PM",
//                     "info_job": "ABC",
//                     "languge_job": "python C#",
//                     "job_employer_id": 3
//                 }
//             ]
//         }
//     ]
// }
Map finds;

//list job recruiment
// {
//     "result": [
//         {
//             "job_employer": 1,
//             "cv": 1,
//             "create_at": "2022-11-01T16:27:36.764Z",
//             "id": 1
//         },
//         {
//             "job_employer": 3,
//             "cv": 1,
//             "create_at": "2022-11-01T19:45:45.507Z",
//             "id": 2
//         }
//     ]
// }
Map recruiment;

Map job_user = {
  0: "ios",
  1: "android",
  2: "web",
  3: "fullstack",
};
Map unjob_user = {
  "ios": 0,
  "android": 1,
  "web": 2,
  "fullstack": 3,
};
Map education = {
  0: "High shool",
  1: "College",
  2: "University",
  3: "Master",
  null: "---"
};
Map uneducation = {
  "High shool": 0,
  "College": 1,
  "University": 2,
  "Master": 3,
};
//data fake cv
Map cv_fake = {
  "cv": {
    "cv_id": 0,
    "university_name": "Học Viện Kĩ Thuật Mật Mã",
    "registration_number": null,
    "cmnd_cccd": "12436666",
    "interests": "Yêu màu hồng ghét sự giả dối",
    "character": "bình thường",
    "contryside": null,
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
      "img_link":
          "https://androidtuan.s3.amazonaws.com/img/153200e8-9e2d-4105-9150-f89dbfd7099e.jpg"
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
      "img_link":
          "https://androidtuan.s3.amazonaws.com/img/3d953570-acb6-4fc6-90d0-abfc9d617c67.jpg"
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
