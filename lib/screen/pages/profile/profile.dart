import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';
import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;

import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final _post = Data.postList;
  String _dropGender = "Gender";
  String _dropRegion = "Region";
  String _dropEducation = "Education";

  var avata = globals.profile['avatar'];

  final name = TextEditingController();
  final date = TextEditingController();
  final contryside = TextEditingController();
  final salary = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    name.dispose();
    date.dispose();
    contryside.dispose();
    salary.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
                        "Edit Profile",
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
                      child: Text("Email"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Email"),
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
                      child: Text("Address"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Address"),
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
                      child: Text("University"),
                    ),
                    Container(
                        height: 30,
                        width: 200,
                        child: DropdownButton<String>(
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
                    )
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("University"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "University"),
                        controller: contryside,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Interests"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Interests"),
                        controller: contryside,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text("Character"),
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Character"),
                        controller: contryside,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
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
