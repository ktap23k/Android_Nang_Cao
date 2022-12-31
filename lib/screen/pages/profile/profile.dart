import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';
import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/home_page/setting.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final _post = Data.postList;
  String _dropGender = "Gender";

  var avata = globals.profile['avatar'];

  final name = TextEditingController();
  final age = TextEditingController();
  final date = TextEditingController();

  setData() {
    setState(() {
      globals.profile['name'] = name.text ?? null;
      globals.profile['age'] = age.text ?? null;
      globals.profile['gender'] = globals.ungender_[_dropGender] ?? 0;
      globals.profile['date_of_birth'] = date.text ?? null;
    });
  }

  setDefault() {
    setState(() {
      name.text = globals.profile['name'] ?? '';
      age.text = '${globals.profile['age']}' ?? '';
      _dropGender = globals.gender_[globals.profile['gender']] ?? '';
      date.text = globals.profile['date_of_birth'] ?? '';
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    name.dispose();
    age.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setDefault();
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
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Text(
                          "${globals.profile['name'] ?? 'Your Profile'}",
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
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
                      child: Text("Age"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Age: 20"),
                        controller: age,
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
                    height: 40,
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
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Do you want save?'),
                              content: const Text(''),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      var headers = {
                                        'Authorization':
                                            'Bearer ${globals.token}',
                                        'Content-Type': 'application/json'
                                      };
                                      var request = http.Request(
                                          'PUT',
                                          Uri.parse(
                                              'http://14.225.254.142:9000/profile'));
                                      request.body = json.encode({
                                        "age": age.text,
                                        "name": name.text,
                                        "gender":
                                            globals.ungender_[_dropGender],
                                        "date_of_birth": date.text
                                      });
                                      request.headers.addAll(headers);

                                      http.StreamedResponse response =
                                          await request.send();

                                      if (response.statusCode == 200) {
                                        print(await response.stream
                                            .bytesToString());
                                      } else {
                                        print(response.reasonPhrase);
                                      }
                                    } catch (e) {}
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Setting()));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
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
