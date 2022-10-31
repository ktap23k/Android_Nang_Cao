import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/sign_in/sign_in.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;

class Token extends StatelessWidget {
  final token = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    token.dispose();
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
                    "Welcom",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    //controller: emailAddressController,
                    obscureText: false,
                    controller: token,
                    decoration: InputDecoration(
                      labelText: 'Token',
                      //labelStyle: FlutterFlowTheme.of(context).bodyText1,
                      hintText: 'Enter your token here...',
                      //hintStyle: FlutterFlowTheme.of(context).bodyText1,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          //color: FlutterFlowTheme.of(context).lineGray,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          //color: FlutterFlowTheme.of(context).lineGray,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      // fillColor:
                      //     //FlutterFlowTheme.of(context).secondaryBackground,
                      // contentPadding:
                      //     EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                    ),
                    //style: FlutterFlowTheme.of(context).subtitle2,
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
                        var headers = {'Content-Type': 'application/json'};
                        var request = http.Request(
                            'POST',
                            Uri.parse(
                                'http://14.225.254.142:9000/register/verify'));
                        request.body = json.encode(
                            {"email": globals.email, "token": token.text});
                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          var value = await response.stream.bytesToString();
                          Map valueMap = json.decode(value);
                          valueMap['isLoggedIn'] = false;
                          await globals.storage
                              .writeCounter('login.json', valueMap);
                        } else {
                          print(response.reasonPhrase);
                        }

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SignIn(),
                        ));
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
