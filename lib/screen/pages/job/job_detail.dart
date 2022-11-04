import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linkedin_clone/repository/data.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:linkedin_clone/globals.dart' as globals;

//import 'edit_cv.dart';

class JobDetail extends StatefulWidget {
  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetail> {
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
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            //color: Colors.black12,
            child: Column(
              children: [
                Container(
                  child: AppBar(
                    title: Text("Job detail"),
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
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
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //globals.finds['name_company'],
                                    '${globals.dataRecruiment['result'][globals.check]['company_name']}',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Region: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['region']}",
                                    //globals.finds['region'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "City: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['city']}",
                                    //globals.finds['city'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Email: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['email']}",
                                    //globals.finds['email'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Phone: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['phone']}",
                                    //globals.finds['email'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Address company:${globals.dataRecruiment['result'][globals.check]['data']['cv']['address_company']}",
                                    //"Address company: ${globals.finds['address_company']}",

                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Orther: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['orther_req']}",
                                    //"Address company: ${globals.finds['address_company']}",

                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Benefit: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['benefit']}",
                                    //"Address company: ${globals.finds['address_company']}",

                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Time End: ${globals.dataRecruiment['result'][globals.check]['data']['cv']['end_time']}",
                                    //"Address company: ${globals.finds['address_company']}",

                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Job Decriptions",
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
                              itemCount: globals
                                  .dataRecruiment['result'][globals.check]
                                      ['data']['job_user_info']
                                  .length,
                              itemBuilder: (context, int index) {
                                return Container(
                                  height: 350,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Position: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['position_job'] ?? '---'}",
                                          //"Position: ${globals.finds[position_job]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Language job: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['languge_job'] ?? '---'}",
                                          //"Language job: ${globals.finds[language_job]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Number: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['number'] ?? '---'}",
                                          //"Number: ${globals.finds[number]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Gender: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['gender'] ?? '---'}",
                                          //"Gender: ${globals.finds[gender]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Exp: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['exp'] ?? '---'}",
                                          //"Exp: ${globals.finds[exp]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Level language: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['level_languge'] ?? '---'}",
                                          //"Level language: ${globals.finds[level_language]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Info job: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['info_job'] ?? '---'}",
                                          //"Info job: ${globals.finds[info_job]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Basic salary: ${globals.dataRecruiment['result'][globals.check]['data']['job_user_info'][index]['basic_salary'] ?? '---'}",
                                          //"Basic salary: ${globals.finds[basic_salary]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Image.network(
                                            "${globals.cv['job_user_info'][index]['img_link'] ?? globals.image_null}",
                                            width: 200)
                                      ]),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 1.50,
                          color: Colors.black26,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Để biết nhiều thông tin hơn hãy liên hệ ${globals.dataRecruiment['result'][globals.check]['data']['cv']['phone']}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
