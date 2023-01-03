import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/screen/pages/sign_in/token.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up1.dart';
import '../home.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up2.dart';
import 'package:linkedin_clone/size_config.dart';

import '../../../../constants.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;

class SignUp3 extends StatelessWidget {
  final password = TextEditingController();
  final repassword = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    password.dispose();
    repassword.dispose();
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
              child: SvgPicture.asset(
                "assets/Logo.svg",
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set your password",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    controller: password,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "RePassword"),
                    controller: repassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(TextSpan(
                      text: "You agree to the LinkedIn  ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'User Agreement ',
                          style: TextStyle(fontSize: 14, color: kPrimaryColor),

                          // recognizer: TapGestureRecognizer()..onTap = () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()),);
                          // // single tapped
                          // },
                        ),
                        TextSpan(
                          text: ' , Privacy Policy ',
                          style: TextStyle(
                            fontSize: 14,
                            color: kPrimaryColor,
                          ),

                          // recognizer: TapGestureRecognizer()..onTap = () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()),);
                          // // single tapped
                          // },
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(fontSize: 14, color: Colors.grey),

                          // recognizer: TapGestureRecognizer()..onTap = () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()),);
                          // // single tapped
                          // },
                        ),
                        TextSpan(
                          text: 'Cookie Policy ',
                          style: TextStyle(fontSize: 14, color: kPrimaryColor),

                          // recognizer: TapGestureRecognizer()..onTap = () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()),);
                          // // single tapped
                          // },
                        ),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
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
                        var headers = {'Content-Type': 'application/json'};

                        var request = http.Request('POST',
                            Uri.parse('http://14.225.254.142:9000/register'));
                        request.body = json.encode({
                          "email": globals.email,
                          "idfv": globals.uuid,
                          "name":
                              "${globals.userFristName} ${globals.userName}",
                          "password": password.text
                        });
                        request.headers.addAll(headers);

                        http.StreamedResponse response2 = await request.send();

                        if (response2.statusCode == 200) {
                          print(response2.reasonPhrase);
                          print(await response2.stream.bytesToString());
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Token(),
                          ));
                        } else {
                          if (response2.statusCode == 406) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => SignUp2(),
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => SignUp(),
                            ));
                          }
                          print(response2.reasonPhrase);
                        }
                      },
                      child: Text(
                        "Agree & Join",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.white,
                        ),
                      ),
                    ),
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
