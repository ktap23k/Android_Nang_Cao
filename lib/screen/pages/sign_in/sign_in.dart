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

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => MobileScreen(),
                            ));
                          } else {
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
                      onPressed: () {  },
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
