import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/screen/pages/forget_password/forget_password.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up1.dart';
import '../home.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool remember = false;

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    password.dispose();
    email.dispose();
    super.dispose();
  }

  Future<void> getImageData() async {
    // setup data finds
    for (int index = 0; index < globals.finds['result'].length; index++) {
      Map d = {'position_job': '', 'languge_job': '', 'job_info': ''};
      if (globals.finds['result'][index]['job_employer_infos'].length > 0) {
        for (var i in globals.finds['result'][index]['job_employer_infos']) {
          d['position_job'] = "${d['position_job']} \n ${i['position_job']}";
          d['languge_job'] = "${d['languge_job']} \n ${i['languge_job']}";
          d['job_info'] = "${d['job_info']} \n ${i['job_info']}";
        }
      }
      globals.finds['result'][index]['position_job'] = d['position_job'];
      globals.finds['result'][index]['languge_job'] = d['languge_job'];
      globals.finds['result'][index]['job_info'] = d['job_info'];
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/Logo.svg",
                    width: 30,
                    height: 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: Text(
                  //     "Join now",
                  //     style: TextStyle(color: kPrimaryColor, fontSize: 16),
                  //   ),
                  // ),

                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SignUp(),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Join now",
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                    controller: email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    controller: password,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: remember,
                          activeColor: Colors.green[900],
                          onChanged: (value) {
                            setState(() {
                              remember = value;
                            });
                          },
                        ),
                        Text(
                          "Remember me.",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Learn more",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ForgetPassword(),
                          )),
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(55),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: kPrimaryColor)))),
                      onPressed: () async {
                        print("=> debug: test");

                        try {
                          print('text field: ${email.text} ${password.text}');
                          var headers = {'Content-Type': 'application/json'};
                          var request = http.Request('POST',
                              Uri.parse('http://14.225.254.142:9000/login'));
                          request.body = json.encode(
                              {"email": email.text, "password": password.text});
                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200 &&
                              response.reasonPhrase == "OK") {
                            var value = await response.stream.bytesToString();
                            Map valueMap = json.decode(value);

                            if (remember) {
                              valueMap['isLoggedIn'] = true;
                              await globals.storage
                                  .writeCounter('login.json', valueMap);

                              globals.isLoggedIn = true;
                            } else {
                              valueMap['isLoggedIn'] = false;
                              await globals.storage
                                  .writeCounter('login.json', valueMap);

                              globals.isLoggedIn = false;
                            }
                            globals.token = valueMap['token'];
                            print('${valueMap}');

                            print('token: ${globals.token}');
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
                              globals.profile = json.decode(value)['result'];
                              print(globals.profile);
                            } else {
                              print('Profile err: ${response_.reasonPhrase}');
                            }

                            request = http.Request('GET',
                                Uri.parse('http://14.225.254.142:9000/cv/get'));
                            request.body = json.encode({});
                            request.headers.addAll(headers);

                            http.StreamedResponse response_1 =
                                await request.send();

                            // get cv
                            if (response_1.statusCode == 200) {
                              var value =
                                  await response_1.stream.bytesToString();
                              globals.cv = json.decode(value)['result'];

                              for (final i in globals.cv['job_user_info']) {
                                request = http.Request(
                                    'GET',
                                    Uri.parse(
                                        'http://14.225.254.142:9000/get/image'));
                                request.body = json.encode(
                                    {"job_user_id": "${i['job_user_id']}"});
                                request.headers.addAll(headers);

                                http.StreamedResponse response_2 =
                                    await request.send();

                                if (response_2.statusCode == 200) {
                                  var value =
                                      await response_2.stream.bytesToString();
                                  Map img = json.decode(value)['result'];
                                  globals.cv['job_user_info'][globals
                                          .cv['job_user_info']
                                          .indexOf(i)]['img_link'] =
                                      '${img['source']}';
                                  print('url : ${img['source']}');
                                } else {
                                  print(response_2.reasonPhrase);
                                }
                              }
                            } else {
                              // xu li data null cho cv
                              globals.cv = globals.cv_fake;
                              print('Cv null : ${response_1.reasonPhrase}');
                            }

                            // get image and name user post job
                            for (final i in globals.finds['result']) {
                              try {
                                var headers = {
                                  'Authorization': 'Bearer ${globals.token}',
                                  'Content-Type': 'application/json'
                                };
                                var request = http.Request(
                                    'GET',
                                    Uri.parse(
                                        'http://14.225.254.142:9000/get/image'));
                                request.body = json.encode({
                                  "job_user_id": "0",
                                  "user_id": "${i['user']}"
                                });
                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  var value =
                                      await response.stream.bytesToString();
                                  Map values = json.decode(value)['result'];
                                  globals.finds['result']
                                          [globals.finds['result'].indexOf(i)]
                                      ['em_name'] = '${values['name']}';
                                  var url =
                                      "https://androidtuan.s3.amazonaws.com/img/3d953570-acb6-4fc6-90d0-abfc9d617c67.jpg";
                                  if (values['source'] != "") {
                                    url =
                                        'https://androidtuan.s3.amazonaws.com/${values['source']}';
                                  }
                                  globals.finds['result']
                                          [globals.finds['result'].indexOf(i)]
                                      ['url_profile'] = url;
                                  globals.finds['result']
                                          [globals.finds['result'].indexOf(i)]
                                      ['job_employer_id'] = i[
                                          'job_employer_infos'][0]
                                      ['job_employer_id'];
                                } else {
                                  print(response.reasonPhrase);
                                }
                              } catch (e) {
                                print("error get profile job");
                              }
                            }
                            for (final i in globals.finds['result']) {
                              print("data finds: $i");
                            }

                            // get list jobs recruiment
                            if (globals.cv['cv']['cv_id'] != 0) {
                              try {
                                var headers = {
                                  'Content-Type': 'application/json'
                                };
                                var request = http.Request(
                                    'GET',
                                    Uri.parse(
                                        'http://14.225.254.142:9000/recruitment/get'));
                                request.body = json.encode(
                                    {"cv": "${globals.cv['cv']['cv_id']}"});
                                request.headers.addAll(headers);

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  var value =
                                      await response.stream.bytesToString();
                                  globals.recruiment = json.decode(value);
                                  print(globals.recruiment);
                                } else {
                                  print(response.reasonPhrase);
                                  globals.recruiment = null;
                                }
                              } catch (e) {
                                print("Err ---recruiment");
                                globals.recruiment = null;
                              }

                              try {
                                if (globals.recruiment != null) {
                                  globals.list_job = {};
                                  for (final i
                                      in globals.recruiment['result']) {
                                    var headers = {
                                      'Content-Type': 'application/json'
                                    };
                                    var request = http.Request(
                                        'GET',
                                        Uri.parse(
                                            'http://14.225.254.142:9000/job/info'));
                                    request.body = json.encode({
                                      "job_employer_id": '${i['job_employer']}'
                                    });
                                    request.headers.addAll(headers);

                                    http.StreamedResponse response =
                                        await request.send();

                                    if (response.statusCode == 200) {
                                      var value =
                                          await response.stream.bytesToString();
                                      Map job = json.decode(value);

                                      globals.list_job[
                                              '${job['result']['cv']["list_id"]}'] =
                                          job['result'];
                                    } else {
                                      print(response.reasonPhrase);
                                    }
                                  }
                                } else {
                                  globals.list_job = null;
                                }
                              } catch (e) {
                                globals.list_job = null;
                              }
                              print(globals.list_job);
                            } else {
                              globals.recruiment = null;
                              globals.list_job = null;
                            }
                            //end list job
                            getImageData();

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => MobileScreen(),
                            ));
                          } else {
                            // login fail popup error email password
                            print("response: " + response.reasonPhrase);
                          }
                        } on Exception catch (_) {
                          print("=> Error : ${_}");
                        } finally {
                          print("=> End : ....");
                        }
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 0.3,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                      Text('OR'),
                      SizedBox(
                        height: 0.3,
                        width: 100,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(55),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: kPrimaryColor)))),
                      onPressed: () {},
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          SvgPicture.asset(
                            "assets/icons-google.svg",
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
