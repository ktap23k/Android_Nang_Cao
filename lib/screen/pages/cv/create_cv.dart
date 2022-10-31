import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';

import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/home_page/home_page.dart';
import 'package:linkedin_clone/screen/pages/home_page/setting.dart';
import 'package:linkedin_clone/screen/pages/widget/Custom_Buttons.dart';
import 'package:linkedin_clone/screen/pages/widget/custom_appBar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../size_config.dart';
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 150,
                          height: 250,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.all(Radius.circular(0)),
                              image: DecorationImage(
                                  image: AssetImage(_post[1].profileUrl))),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Professions", // thay luôn vào
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Gender: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Date of birth: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Mobile: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Email: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Adress: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      "Education",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1.50,
                      color: Colors.black26,
                    ),
                    Text(
                      _post[1].tags,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      "Work Experiences",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 1.50,
                      color: Colors.black26,
                    ),
                    Text(
                      _post[1].tags,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      "Interests",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Divider(
                      thickness: 1.50,
                      color: Colors.black26,
                    ),
                    Text(
                      _post[1].tags,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 50,
                    ),
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
