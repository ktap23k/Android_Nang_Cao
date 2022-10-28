import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up3.dart';
import 'package:linkedin_clone/size_config.dart';

import '../../../../constants.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class SignUp2 extends StatelessWidget {
  final email = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
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
                    "Add your Email",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    controller: email,
                  ),
                  SizedBox(
                    height: 30,
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
                        try {
                          assert(EmailValidator.validate(email.text));

                          globals.email = email.text;

                          var headers = {'Content-Type': 'application/json'};
                          var request = http.Request('POST',
                              Uri.parse('https://cvnl.me/uuid/v1/user/create'));
                          request.body = json.encode(
                              {"account": globals.email, "hash": "check"});
                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            var value = await response.stream.bytesToString();
                            print(value);
                            Map valueMap = json.decode(value);
                            if (valueMap['error']) {
                              print("email exits!");
                            } else {
                              globals.uuid = valueMap['data']['userInfo']['id'];
                              print("uuid: " + globals.uuid);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => SignUp3(),
                              ));
                            }
                          } else {
                            print(response.reasonPhrase);
                          }
                        } catch (e) {
                          print(e);
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
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
