import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linkedin_clone/repository/data.dart';

import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:linkedin_clone/globals.dart' as globals;

import 'edit_cv.dart';


class CreateCV extends StatefulWidget {
  @override
  _CreateCVScreenState createState() => _CreateCVScreenState();
}

class _CreateCVScreenState extends State<CreateCV> {
  final _post = Data.postList;
  bool _showAppNavBar = true;
  ScrollController _scrollController;
  bool _isScrollDown = false;

  get child => null;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initialScroll();
  }

  void _initialScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollDown) {
          _isScrollDown = true;
          _hideAppNavBar();
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollDown) {
          _isScrollDown = false;
          _showAppNvBar();
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
      return SingleChildScrollView(
        child: Container(
          color: Colors.white,
          //color: Colors.black12,
          child: Column(
            children: [
              Container(
                child: AppBar(
                  title: Text("Home"),
                  leading: IconButton(
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      size: 30,
                    ),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MobileScreen(),
                    )),
                  ),
                  actions: [
                    Visibility(
                      child: IconButton(
                        icon: Icon(
                          Icons.more_vert_outlined,
                          size: 30,
                        ),
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => EditCV(),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                margin: EdgeInsets.only(bottom: 0.0, top: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.50),
                        bottom:
                            BorderSide(color: Colors.black54, width: 0.50))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 120,
                              height: 120,
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${globals.profile['avatar'] ?? globals.avata_null}'))),
                          SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                globals.profile['name'],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Developer Android", // thay luôn vào
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Gender: ${globals.profile['gender'] ?? '---'}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Date of birth: ${globals.profile['date_of_birth'] ?? '---'}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              // Text(
                              //   "Mobile: ",
                              //   style: TextStyle(
                              //       fontSize: 14, fontWeight: FontWeight.normal),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                "Email: ${globals.profile['email']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Contryside: ${globals.cv['cv']['contryside'] ?? '---'}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Salary: ${globals.cv['cv']['salary'] ?? '---'}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Exp: ${globals.cv['cv']['exp'] ?? '---'}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "Education",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 1.50,
                        color: Colors.black26,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Education: ${globals.education[globals.cv['cv']['education']]}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "University_name: ${globals.cv['cv']['university_name'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Work Experiences",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 1.50,
                        color: Colors.black26,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        margin: EdgeInsets.only(bottom: 0.0, top: 8),
                        height: 300,
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: globals.cv['job_user_info'].length,
                            itemBuilder: (context, int index) {
                              return Container(
                                height: 400,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time: ${globals.cv['job_user_info'][index]['start_at'] ?? '---'} to ${globals.cv['job_user_info'][index]['end_at'] ?? '---'}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Name Job: ${globals.cv['job_user_info'][index]['name_job'] ?? '---'}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Position: ${globals.cv['job_user_info'][index]['position'] ?? '---'}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Job: ${globals.cv['job_user_info'][index]['user_job'] ?? '---'}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Info: ${globals.cv['job_user_info'][index]['info_job'] ?? '---'}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Certificate:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Image.network(
                                          "${globals.cv['job_user_info'][index]['img_link'] ?? 'https://androidtuan.s3.amazonaws.com/img/153200e8-9e2d-4105-9150-f89dbfd7099e.jpg'}",
                                          width: 200)
                                    ]),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Interests",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Divider(
                        thickness: 1.50,
                        color: Colors.black26,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interests: ${globals.cv['cv']['interests'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Character: ${globals.cv['cv']['character'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Region: ${globals.cv['cv']['region'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "City: ${globals.cv['cv']['city'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.50,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void _hideAppNavBar() {
    setState(() {
      //_showAppNavBar = false;
    });
  }

  void _showAppNvBar() {
    setState(() {
      _showAppNavBar = true;
    });
  }
}
