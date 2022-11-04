import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';
import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'create_cv.dart';
import 'package:http/http.dart' as http;

class EditCV extends StatefulWidget {
  @override
  _EditCV createState() => _EditCV();
}

final listJobs_ = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];
var listJobs = [listJobs_];

class _EditCV extends State<EditCV> {
  // final name_job = TextEditingController();

  var listContainer = <Widget>[];
  final container_ = Container(
    height: 510,
    child: Column(
      children: [
        Text(
          "Job",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(
          thickness: 1.50,
          color: Colors.black26,
        ),
        SizedBox(
          height: 40,
        ),
        TextFormField(
          decoration:
              InputDecoration(hintText: "Name Job ${globals.indexlist}"),
          controller: listJobs[0][0],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Position"),
          controller: listJobs[0][1],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "User Job"),
          controller: listJobs[0][2],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Address Company"),
          controller: listJobs[0][3],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Info Job"),
          controller: listJobs[0][4],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Start At (ex: 09/10/2022)"),
          controller: listJobs[0][5],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "End At (ex: 10/10/2022)"),
          controller: listJobs[0][6],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    ),
  );

  void addNewField() {
    setState(() {
      globals.indexlist = globals.indexlist + 1;
      listJobs.add([]);
      for (var i in [0, 1, 2, 3, 4, 5, 6]) {
        print("add: $i");
        listJobs[globals.indexlist].add(TextEditingController());
      }
      final container__ = Container(
        height: 510,
        child: Column(
          children: [
            Text(
              "Job",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 1.50,
              color: Colors.black26,
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration:
                  InputDecoration(hintText: "Name Job ${globals.indexlist}"),
              controller: listJobs[globals.indexlist][0],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Position"),
              controller: listJobs[globals.indexlist][1],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "User Job"),
              controller: listJobs[globals.indexlist][2],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Address Company"),
              controller: listJobs[globals.indexlist][3],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Info Job"),
              controller: listJobs[globals.indexlist][4],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration:
                  InputDecoration(hintText: "Start At (ex: 09/10/2022)"),
              controller: listJobs[globals.indexlist][5],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "End At (ex: 10/10/2022)"),
              controller: listJobs[globals.indexlist][6],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
      listContainer.add(container__);
      print('index: ${globals.indexlist} length: ${listJobs.length}');
    });
  }

  void subNewField() {
    setState(() {
      if (globals.indexlist >= 0) {
        listJobs.remove(listJobs[globals.indexlist]);
        listContainer.remove(listContainer[globals.indexlist]);
        globals.indexlist = globals.indexlist - 1;
      }
    });
  }

  final _post = Data.postList;
  String _dropGender = "Gender";
  String _dropRegion = "Region";
  String _dropEducation = "Education";

  var avata = globals.profile['avatar'];
  final name = TextEditingController();
  final date = TextEditingController();
  final contryside = TextEditingController();
  final salary = TextEditingController();
  final exp = TextEditingController();
  final university = TextEditingController();
  final interests = TextEditingController();
  final character = TextEditingController();
  final city = TextEditingController();

  void setupData() {
    name.text = globals.profile['name'] ?? "Tran Van A";
    date.text = globals.profile['date_of_birth'] ?? "01/01/2000";
    contryside.text = globals.cv['cv']['contryside'] ?? "Hà Nội";
    salary.text = '${globals.cv['cv']['salary']}' ?? "100000";
    exp.text = '${globals.cv['cv']['exp']}' ?? "1";
    print("'${globals.profile['gender']}'");
    _dropGender = globals.gender_[globals.profile['gender']] ?? "Male";
    university.text = globals.cv['cv']['university_name'] ?? "HVKT Mật Mã";
    interests.text =
        globals.cv['cv']['interests'] ?? "Develop Backend and abc xyz";
    character.text = globals.cv['cv']['character'] ?? "";
    city.text = globals.cv['cv']['city'] ?? "";
    _dropRegion = globals.cv['cv']['region'] ?? "Miền Bắc";
    _dropEducation =
        globals.education[globals.cv['cv']['education']] ?? "College";
    for (var i in listJobs) {
      int _c = listJobs.indexOf(i);
      listJobs[_c][0].text =
          '${globals.cv['job_user_info'][_c]['name_job']}' ?? '';
      listJobs[_c][1].text =
          '${globals.cv['job_user_info'][_c]['position']}' ?? '';
      listJobs[_c][2].text =
          '${globals.job_user[globals.cv['job_user_info'][_c]['user_job']]}' ??
              'android';
      listJobs[_c][3].text =
          '${globals.cv['job_user_info'][_c]['address_company']}' ?? '';
      listJobs[_c][4].text =
          '${globals.cv['job_user_info'][_c]['info_job']}' ?? '';
      listJobs[_c][5].text =
          '${globals.cv['job_user_info'][_c]['start_at']}' ?? '';
      listJobs[_c][6].text =
          '${globals.cv['job_user_info'][_c]['end_at']}' ?? '';
    }
  }

  void getData() {
    globals.profile['name'] = name.text ?? null;
    globals.profile['date_of_birth'] = date.text ?? null;
    globals.cv['cv']['contryside'] = contryside.text ?? null;
    globals.cv['cv']['salary'] = int.parse(salary.text) ?? null;
    globals.cv['cv']['exp'] = int.parse(exp.text) ?? null;
    globals.profile['gender'] = globals.ungender_[_dropGender] ?? null;
    globals.cv['cv']['university_name'] == university.text ?? null;
    globals.cv['cv']['interests'] = interests.text ?? null;
    globals.cv['cv']['character'] = character.text ?? null;
    globals.cv['cv']['city'] = city.text ?? null;
    globals.cv['cv']['region'] = _dropRegion ?? null;
    globals.cv['cv']['education'] = globals.uneducation[_dropEducation] ?? "1";

    print('default: ${globals.indexdefault} index: ${globals.indexlist}');
    if (globals.indexdefault < globals.indexlist + 1) {
      for (int i = globals.indexdefault; i <= globals.indexlist; i++) {
        globals.cv['job_user_info'].add({});
      }
    } else {
      int _d = globals.cv['job_user_info'].length - 1;
      if (globals.indexlist + 1 < globals.indexdefault) {
        for (int i = globals.indexlist + 1; i < globals.indexdefault; i++) {
          globals.cv['job_user_info'].remove(globals.cv['job_user_info'][_d]);
          _d--;
        }
      }
    }
    for (var i in listJobs) {
      int _c = listJobs.indexOf(i);
      globals.cv['job_user_info'][_c]['name_job'] =
          listJobs[_c][0].text ?? null;
      globals.cv['job_user_info'][_c]['position'] =
          listJobs[_c][1].text ?? null;
      globals.cv['job_user_info'][_c]['user_job'] =
          globals.unjob_user[listJobs[_c][2].text] ?? '1';
      globals.cv['job_user_info'][_c]['address_company'] =
          listJobs[_c][3].text ?? null;
      globals.cv['job_user_info'][_c]['info_job'] =
          listJobs[_c][4].text ?? null;
      globals.cv['job_user_info'][_c]['start_at'] =
          listJobs[_c][5].text ?? null;
      globals.cv['job_user_info'][_c]['end_at'] = listJobs[_c][6].text ?? null;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    name.dispose();
    date.dispose();
    contryside.dispose();
    salary.dispose();
    exp.dispose();
    university.dispose();
    interests.dispose();
    character.dispose();
    city.dispose();
    super.dispose();
  }

  @override
  void initState() {
    listContainer.add(container_);
    listJobs = [listJobs_];
    globals.indexlist = 0;
    print("index: ${globals.indexdefault} ${globals.indexlist}");
    for (int i = 0; i < globals.indexdefault - 1; i++) {
      addNewField();
    }
    ;
    setupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        // width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: InkWell(
                        onTap: () async {
                          PickedFile pickedFile = await ImagePicker().getImage(
                            source: ImageSource.gallery,
                            maxWidth: 1800,
                            maxHeight: 1800,
                          );
                          if (pickedFile != null) {
                            // File imageFile = File(pickedFile.path);
                            try {
                              var headers = {
                                'Authorization': 'Bearer ${globals.token}'
                              };
                              var request = http.MultipartRequest(
                                  'POST',
                                  Uri.parse(
                                      'http://14.225.254.142:9000/profile/avatar'));
                              request.files.add(
                                  await http.MultipartFile.fromPath(
                                      'avatar_img', '${pickedFile.path}'));
                              request.headers.addAll(headers);

                              http.StreamedResponse response =
                                  await request.send();

                              if (response.statusCode == 200) {
                                print(await response.stream.bytesToString());
                                try {
                                  var headers = {
                                    'Authorization': 'Bearer ${globals.token}',
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request(
                                      'GET',
                                      Uri.parse(
                                          'http://14.225.254.142:9000/profile'));
                                  request.body = json.encode({});
                                  request.headers.addAll(headers);

                                  http.StreamedResponse response_ =
                                      await request.send();

                                  // get proflie
                                  if (response_.statusCode == 200) {
                                    var value =
                                        await response_.stream.bytesToString();
                                    globals.profile =
                                        json.decode(value)['result'];
                                    print(globals.profile);
                                  } else {
                                    print(
                                        'Profile err: ${response_.reasonPhrase}');
                                  }
                                } catch (e) {}
                              } else {
                                print(response.reasonPhrase);
                              }
                            } catch (e) {}
                            setState(() {
                              avata = globals.profile['avatar'];
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: 48, // Image radius
                          backgroundImage:
                              NetworkImage('${avata ?? globals.avata_null}'),
                        ),
                      ),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(100)),
                      //     image: DecorationImage(
                      //         image: AssetImage(_post[1].profileUrl))),
                    ),
                    Container(
                      width: 40,
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        "Edit your CV",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Name"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Name"),
                        controller: name,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Gender"),
                    ),
                    Container(
                        height: 30,
                        width: 200,
                        child: DropdownButton<String>(
                          hint: _dropGender == null
                              ? Text('Dropdown')
                              : Text(_dropGender),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.blue),
                          items: <String>[
                            'Female',
                            'Male',
                            'No answer',
                            'Free description'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              _dropGender = value;
                            });
                          },
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Date of birth"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Date of birth"),
                        controller: date,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Contryside"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Contryside"),
                        controller: contryside,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Salary"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Salary"),
                        controller: salary,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Exp"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Exp"),
                        keyboardType: TextInputType.number,
                        controller: exp,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<String>(
                    hint: _dropEducation == null
                        ? Text('Dropdown')
                        : Text(_dropEducation),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: <String>[
                      'High shool',
                      'College',
                      'University',
                      'Master'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _dropEducation = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "University"),
                    controller: university,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Interests"),
                    controller: interests,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Character"),
                    controller: character,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButton<String>(
                    hint: _dropRegion == null
                        ? Text('Dropdown')
                        : Text(_dropRegion),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: <String>['Miền Bắc', 'Miền Trung', 'Miền Nam']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _dropRegion = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "City"),
                    controller: city,
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listContainer,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Add Form
                  Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side:
                                            BorderSide(color: kPrimaryColor)))),
                            onPressed: () {
                              addNewField();
                            },
                            child: Text(
                              "Add Job",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Center(
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side:
                                            BorderSide(color: kPrimaryColor)))),
                            onPressed: () {
                              subNewField();
                            },
                            child: Text(
                              "Sub Job",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: kPrimaryColor)))),
                        onPressed: () async {
                          try {
                            getData();
                            print("cv: ${globals.cv}");
                            print("profile: ${globals.profile}");
                          } catch (e) {
                            print(e);
                          }
                          try {
                            var headers = {
                              'Authorization': 'Bearer ${globals.token}',
                              'Content-Type': 'application/json'
                            };
                            var request = http.Request(
                                'PUT',
                                Uri.parse(
                                    'http://14.225.254.142:9000/profile'));
                            request.body = json.encode(globals.profile);
                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              print(await response.stream.bytesToString());
                            } else {
                              print(response.reasonPhrase);
                            }
                          } catch (e) {}

                          Map data = json.decode(json.encode(globals.cv));

                          data['cv'].remove('cv_id');
                          data['cv'].remove('user');

                          for (final i in data['job_user_info']) {
                            data['job_user_info']
                                    [data['job_user_info'].indexOf(i)]
                                .remove('cv');
                            data['job_user_info']
                                    [data['job_user_info'].indexOf(i)]
                                .remove('img_link');
                            data['job_user_info']
                                    [data['job_user_info'].indexOf(i)]
                                .remove('job_user_id');
                          }
                          Map detail = data['cv'];
                          detail['job_user_info'] = data['job_user_info'];

                          //save data from form
                          print('data: $detail');

                          // send data
                          try {
                            var headers = {
                              'Authorization': 'Bearer ${globals.token}',
                              'Content-Type': 'application/json'
                            };
                            var request = http.Request('POST',
                                Uri.parse('http://14.225.254.142:9000/cv'));
                            request.body = json.encode(detail);
                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              print(await response.stream.bytesToString());
                            } else {
                              print('Err: ${response.reasonPhrase}');
                            }
                          } catch (e) {
                            print('Err:');
                          }

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => MobileScreen(),
                          ));
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: kPrimaryColor)))),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
