import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';

import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/job/job_list.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up2.dart';
import 'package:linkedin_clone/size_config.dart';

class JobDetail extends StatelessWidget {
  final _post = Data.postList;

  get child => null;

  get leading => null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        // width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: AppBar(
                title: Text("Job detail"),
                leading: IconButton(
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MobileScreen(),
                  )),
                ),
              ),
            ),
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
                      child: Text(
                        "Information",
                        style: TextStyle(color: Colors.black, fontSize: 20),
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
                      child: Text(
                        "Job title",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Job title name",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        "Company",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Company name",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        "Number",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Number",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        "Gender:",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        width: 100,
                        child: Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                    Container(
                      height: 30,
                      width: 80,
                      child: Text(
                        "Age:",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        width: 80,
                        child: Text(
                          "Age",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      child: Text(
                        "Job Description",
                        style: TextStyle(color: Colors.black, fontSize: 20),
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
                      child: Text(
                        "Experiences",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Experiences",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        "English level",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "English level",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        "Others",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Others",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 100,
                      child: Text(
                        "Location",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Location",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 150,
                      child: Text(
                        "Basic salaty",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        width: 200,
                        child: Text(
                          "8.000.000~20.0000.000",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 150,
                      child: Text(
                        "Contact Info",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Container(
                        height: 29,
                        child: Text(
                          "Contact Info",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: Colors.black,
                          ),
                        )),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: kPrimaryColor)))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => JobList(),
                        ));
                      },
                      child: Text(
                        "Apply",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Colors.black,
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

  FlutterFlowIconButton(
      {Color borderColor,
      int borderRadius,
      int buttonSize,
      Icon icon,
      Future<Null> Function() onPressed}) {}
}
