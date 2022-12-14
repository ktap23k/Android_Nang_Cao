import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/screen/pages/forget_password/password_change.dart';
import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/profile/profile.dart';
import 'package:linkedin_clone/screen/pages/splash_screens/components/splash_screen.dart';
import 'package:flutter/material.dart';

//import 'package:linkedin_clone/screen/pages/profile/profile.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    // child: Text(
                    //   "",
                    //   style: TextStyle(color: kPrimaryColor, fontSize: 16),
                    // ),
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_right_rounded,
                        size: 40,
                      ),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MobileScreen(),
                      )),
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
                  Row(children: [
                    Container(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${globals.profile['avatar'] ?? globals.avata_null}'))),
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 16),
                          child: Text(
                            globals.profile['name'],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 30,
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
                            borderRadius: BorderRadius.circular(15.0),
                            //side: BorderSide(color: Colors.black)
                          ))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Profile(),
                        ));
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Edit Profile",
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
                    height: 10,
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
                            borderRadius: BorderRadius.circular(15.0),
                            //side: BorderSide(color: Colors.black)
                          ))),
                      onPressed: () async {
                        try {
                          var headers = {'Content-Type': 'application/json'};
                          var request = http.Request(
                              'POST',
                              Uri.parse(
                                  'http://14.225.254.142:9000/password/forgot'));
                          request.body =
                              json.encode({"email": globals.profile['email']});
                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            var value = await response.stream.bytesToString();
                            Map valueMap = json.decode(value);
                            print(valueMap);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChangePassword(),
                            ));
                          } else {
                            print("Error: " + response.reasonPhrase);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Change password",
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
                    height: 10,
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
                            borderRadius: BorderRadius.circular(15.0),
                            //side: BorderSide(color: Colors.black)
                          ))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Dark mode",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.nights_stay,
                              color: Color(0xFF95A1AC),
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                            borderRadius: BorderRadius.circular(15.0),
                            //side: BorderSide(color: Colors.black)
                          ))),
                      onPressed: () async {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Do you want exit?'),
                            content: const Text(''),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Map valueMap = {};
                                  valueMap['isLoggedIn'] = false;
                                  valueMap['token'] = null;

                                  await globals.storage
                                      .writeCounter('login.json', valueMap);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SplashScreen()));
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // onPressed: () {
                  //print("abc xu li tr????c khi chuyen mang hinh, c?? th??? thay th??? b???ng h??m");
                  //Navigator.of(context).push(MaterialPageRoute(
                  //builder: (BuildContext context) => HomeScreen()));
                  //},

                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 20,
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
