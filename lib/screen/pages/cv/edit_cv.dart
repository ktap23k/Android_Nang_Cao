import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';
import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/sign_up/sign_up2.dart';
import 'package:linkedin_clone/size_config.dart';

import 'create_cv.dart';

class EditCV extends StatelessWidget {
  final _post = Data.postList;
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
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: AssetImage(_post[1].profileUrl))),
                      ),

                      Container(
                        width: 60,
                        height: 30,),
                    Container(
                      
                      child: Text(
                    "Edit your CV",
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
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Name"),
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
                      child: Text("Professions"),
                    ),
                    Container(
                      height: 30,
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Professions"),
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
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Gender"),
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
                      child: Text("Date of birth"),
                    ),
                    Container(
                      height: 30,
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Date of birth"),
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
                      child: Text("Mobile"),
                    ),
                    Container(
                      height: 30,
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Mobile"),
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
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Email"),
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
                      width: 230,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Address"),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Education"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Work Experiences"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Interests"),
                  ),
                  SizedBox(
                    height: 30,
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
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MobileScreen(),
                        )),
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
                      width: 120,
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
                        onPressed: () =>
                            Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
