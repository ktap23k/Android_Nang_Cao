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
                    onPressed: () =>
                        Navigator.pop(context),
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
                            width: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //globals.finds['name_company'],
                                globals.profile['name'],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Region", 
                                //globals.finds['region'],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "City: ${globals.profile['gender'] ?? '---'}",
                                //globals.finds['city'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              

                              
                              Text(
                                "Email: ${globals.profile['email']}",
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
                                "Address company: ${globals.cv['cv']['contryside'] ?? '---'}",
                                //"Address company: ${globals.finds['address_company']}",
                                 
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "End time: ${globals.cv['cv']['salary'] ?? '---'}",
                                //"End time: ${globals.finds['end_time']}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Benefit: ${globals.cv['cv']['exp'] ?? '---'}",
                                //"Benefit: ${globals.finds[benefit]}",
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
                            itemCount: globals.cv['job_user_info'].length,
                            itemBuilder: (context, int index) {
                              return Container(
                                height: 400,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Position:",
                                        //"Position: ${globals.finds[position_job]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Language job: ${globals.cv['job_user_info'][index]['user_job'] ?? '---'}",
                                        //"Language job: ${globals.finds[language_job]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Number: ${globals.cv['job_user_info'][index]['name_job'] ?? '---'}",
                                        //"Number: ${globals.finds[number]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Gender: ${globals.cv['job_user_info'][index]['position'] ?? '---'}",
                                        //"Gender: ${globals.finds[gender]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Exp: ${globals.cv['job_user_info'][index]['user_job'] ?? '---'}",
                                        //"Exp: ${globals.finds[exp]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Level language: ${globals.cv['job_user_info'][index]['info_job'] ?? '---'}",
                                        //"Level language: ${globals.finds[level_language]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Info job: ${globals.cv['job_user_info'][index]['user_job'] ?? '---'}",
                                        //"Info job: ${globals.finds[info_job]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Basic salary: ${globals.cv['job_user_info'][index]['user_job'] ?? '---'}",
                                        //"Basic salary: ${globals.finds[basic_salary]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 10,
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
                      
                      Divider(
                        thickness: 1.50,
                        color: Colors.black26,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email: ${globals.cv['cv']['interests'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Address: ${globals.cv['cv']['character'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Mobie phone: ${globals.cv['cv']['region'] ?? '---'}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
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
      ) ;
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
