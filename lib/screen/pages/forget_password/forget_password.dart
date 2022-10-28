import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/screen/pages/forget_password/password_change.dart';
import 'package:linkedin_clone/size_config.dart';

import '../../../../constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;

class ForgetPassword extends StatelessWidget {
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
                width: 40,
                height: 40,
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
                    "Forget Password",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  Text(
                    "Reset password in two quick steps",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email or phone",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    controller: email,
                  ),
                  SizedBox(
                    height: 30,
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
                        try {
                          assert(EmailValidator.validate(email.text));
                          globals.email = email.text;

                          var headers = {'Content-Type': 'application/json'};
                          var request = http.Request(
                              'POST',
                              Uri.parse(
                                  'http://14.225.254.142:9000/password/forgot'));
                          request.body = json.encode({"email": globals.email});
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
                      child: Text(
                        "Reset password",
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
