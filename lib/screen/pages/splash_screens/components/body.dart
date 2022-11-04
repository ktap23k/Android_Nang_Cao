import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';

import 'package:linkedin_clone/screen/pages/sign_in/sign_in.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up1.dart';
import 'package:linkedin_clone/size_config.dart';

// This is the best practice
import '../../home.dart';
import 'splash_content.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Find and land your next job", "image": "assets/image1.jpg"},
    {"text": "build your network on the go", "image": "assets/image2.jpg"},
    {
      "text": "stay ahead with curated content for your career",
      "image": "assets/image3.jpg"
    },
  ];
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

    //get Image avata user
    // if (globals.finds['result'] != [])
    //   for (var i in globals.finds['result']) {
    //     try {
    //       var headers = {
    //         'Authorization': 'Bearer ${globals.token}',
    //         'Content-Type': 'application/json'
    //       };
    //       var request = http.Request(
    //           'GET', Uri.parse('http://14.225.254.142:9000/get/image'));
    //       request.body = json.encode({"user_id": i['user']});
    //       request.headers.addAll(headers);

    //       http.StreamedResponse response = await request.send();

    //       if (response.statusCode == 200) {
    //         var value = await response.stream.bytesToString();
    //         var val = json.decode(value)['result'];

    //         globals.finds['result'][globals.finds['result'].indexOf(i)]
    //             ['avata'] = val['source'] ?? globals.avata_null;
    //         globals.finds['result'][globals.finds['result'].indexOf(i)]
    //             ['name'] = val['name'] ?? globals.avata_null;
    //       } else {
    //         print(response.reasonPhrase);
    //       }
    //     } catch (e) {
    //       print(e);
    //     }
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(
                "assets/Logo.svg",
                width: 30,
                height: 30,
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) => setState(() {
                  currentPage = value;
                }),
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    // Spacer(flex: 1),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(55),
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
                          Map valueMap = {"isLoggedIn": false, "token": null};
                          await globals.storage
                              .writeCounter('login.json', valueMap);

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SignUp(),
                          ));
                        },
                        child: Text(
                          "Join now",
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

                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(55),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.black)))),
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
                              "Join with Google",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    GestureDetector(
                        onTap: () async {
                          await globals.storage
                              .readCounter('login.json')
                              .then((value) {
                            if (value != '') {
                              Map valueMap = json.decode(value);
                              globals.isLoggedIn = valueMap['isLoggedIn'];
                              globals.token = valueMap['token'];

                              print('dataread: $valueMap');
                            }
                          });

                          try {
                            var headers = {'Content-Type': 'application/json'};
                            var request = http.Request('GET',
                                Uri.parse('http://14.225.254.142:9000/finds'));
                            request.body = json.encode({
                              "languge_job": " ",
                              "region": " ",
                              "city": " ",
                              "name_company": " "
                            });
                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              var value = await response.stream.bytesToString();
                              globals.finds = json.decode(value);
                              // print("data finds: ${globals.finds}");
                            } else {
                              print(response.reasonPhrase);
                            }
                          } catch (e) {
                            print("err");
                          }
                          if (globals.isLoggedIn) {
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

                            // get profile
                            // print('token: ${globals.token}');
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

                            http.StreamedResponse response =
                                await request.send();

                            // get proflie
                            if (response.statusCode == 200) {
                              var value = await response.stream.bytesToString();
                              globals.profile = json.decode(value)['result'];
                              // print(globals.profile);
                            } else {
                              print(response.reasonPhrase);
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
                                  // print('url : ${img['source']}');
                                } else {
                                  print(response_2.reasonPhrase);
                                }
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
                                        "job_employer_id":
                                            '${i['job_employer']}'
                                      });
                                      request.headers.addAll(headers);

                                      http.StreamedResponse response =
                                          await request.send();

                                      if (response.statusCode == 200) {
                                        var value = await response.stream
                                            .bytesToString();
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

                            } else {
                              // xu li data null cho cv
                              globals.cv = globals.cv_fake;
                              print(response_1.reasonPhrase);
                            }
                            getImageData();
                            for (final i in globals.finds['result']) {
                              print("data finds: $i");
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => MobileScreen(),
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => SignIn(),
                            ));
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: currentPage == index ? 10 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.grey[800] : Colors.white,

        border: Border.all(
          color: currentPage == index ? Colors.grey[800] : Colors.black,
        ),
        borderRadius: BorderRadius.circular(10), //Border.all
      ),
    );
  }
}
