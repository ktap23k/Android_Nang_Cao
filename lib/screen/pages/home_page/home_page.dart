import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';
import 'package:linkedin_clone/screen/pages/widget/Custom_Buttons.dart';
import 'package:linkedin_clone/screen/pages/widget/custom_appBar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _post = Data.postList;
  bool _showAppNavBar = true;
  ScrollController _scrollController;
  bool _isScrollDown = false;

  Future<void> getImageData() async {
    if (globals.recruiment != null) {
      globals.recruiment['status'] = [];
      for (var i in globals.recruiment['result']) {
        globals.recruiment['status'].add(i['job_employer']);
      }

      for (var i = 0; i < globals.finds['result'].length; i++) {
        globals.like_status.add(0);
        bool check = true;
        for (var j in globals.finds['result'][i]['job_employer_infos']) {
          if (globals.recruiment['status'].contains(j['job_employer_id'])) {
            globals.apply_status.add(1);
            check = false;
            break;
          }
        }
        if (check) {
          globals.apply_status.add(0);
        }
      }
    }
    print(globals.apply_status);

    // setup data finds
    for (int index = 0; index < globals.finds['result'].length; index++) {
      globals.finds['result'][index]['job_employer_id'] = globals
          .finds['result'][index]['job_employer_infos'][0]['job_employer_id'];
      Map d = {'position_job': '', 'languge_job': '', 'job_info': ''};
      if (globals.finds['result'][index]['job_employer_infos'].length > 0) {
        for (var i in globals.finds['result'][index]['job_employer_infos']) {
          d['position_job'] = "${d['position_job']} \n ${i['position_job']}";
          d['languge_job'] = "${d['languge_job']} \n ${i['languge_job']}";
          d['job_info'] = "${d['job_info']} \n ${i['job_info']}";
        }
      }
      globals.finds['result'][index]['position_job'] = d['position_job'];
      globals.finds['result'][index]['languge_job'] = d['languge_job'];
      globals.finds['result'][index]['job_info'] = d['job_info'];
      globals.apply_status.add(0);
      globals.like_status.add(0);
    }
  }

  @override
  void initState() {
    globals.like_status = [];
    globals.apply_status = [];
    getImageData();
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
      return Container(
        color: Colors.black12,
        child: Column(
          children: [
            _showAppNavBar
                ? CustomAppBar(
                    sizingInformation: sizingInformation,
                  )
                : Container(
                    height: 0.0,
                    width: 0.0,
                  ),
            _listPostWidget(sizingInformation),
          ],
        ),
      );
    });
  }

  Widget _listPostWidget(SizingInformation sizingInformation) {
    return Expanded(
        child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: globals.finds['result'].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            margin: EdgeInsets.only(bottom: 0.0, top: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: Colors.black54, width: 0.50),
                    bottom: BorderSide(color: Colors.black54, width: 0.50))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${globals.finds['result'][index]['url_profile'] ?? globals.avata_null}')),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          globals.finds['result'][index]['em_name'] ?? 'Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: sizingInformation.screenSize.width / 1.34,
                          child: Text(
                            _post[index].headline,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  globals.finds['result'][index]['name_company'] ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  globals.finds['result'][index]['orther_req'] ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  globals.finds['result'][index]['benefit'] ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${globals.finds['result'][index]['address_company']} ${globals.finds['result'][index]['city']} ${globals.finds['result'][index]['region']}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  globals.finds['result'][index]['position_job'] ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  globals.finds['result'][index]['languge_job'] ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  globals.finds['result'][index]['info_job'] ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  _post[index].tags,
                  style: TextStyle(color: kPrimaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: sizingInformation.screenSize.width,
                  child: Image(
                    image: NetworkImage(
                        '${globals.finds['result'][index]['url_profile'] ?? globals.avata_null}'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: 25,
                              height: 25,
                              child: Image.asset('assets/icons/like_icon.png')),
                          Container(
                              width: 25,
                              height: 25,
                              child: Image.asset(
                                  'assets/icons/celebrate_icon.png')),
                          if (index == 0 || index == 4 || index == 6)
                            Container(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset('assets/icons/love_icon.png')),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            _post[index].likes,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Text(_post[index].comments),
                    //       Text(" comments")
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                Divider(
                  thickness: 0.50,
                  color: Colors.black26,
                ),
                _rowButton(index),
              ],
            ),
          );
        },
      ),
    ));
  }

  void _hideAppNavBar() {
    setState(() {
      _showAppNavBar = false;
    });
  }

  void _showAppNvBar() {
    setState(() {
      _showAppNavBar = true;
    });
  }

  Widget _rowButton(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (globals.like_status[index] == 0)
                  globals.like_status[index] = 1;
                else
                  globals.like_status[index] = 0;
              });
            },
            child: rowSingleButton(
                color:
                    globals.like_status[index] == 1 ? Colors.red : Colors.black,
                name: "Like",
                iconImage: globals.like_status[index] == 1
                    ? "assets/icons/love_icon.png"
                    : "assets/icons/like_icon_white.png",
                isHover: false),
          ),
          // InkWell(
          //   onTap: () {},
          //   child: rowSingleButton(
          //       color: Colors.black,
          //       name: "Comment",
          //       iconImage: "assets/icons/comment_icon.png",
          //       isHover: false),
          // ),
          InkWell(
            onTap: () async {
              if (globals.cv['cv']['cv_id'] != 0) {
                var job_employer =
                    globals.finds['result'][index]['job_employer_id'];
                var cv_id = globals.cv['cv']['cv_id'];
                print('"$cv_id" "job_employer": "$job_employer"');
                try {
                  var headers = {
                    'Authorization': 'Bearer ${globals.token}',
                    'Content-Type': 'application/json'
                  };
                  var request = http.Request('POST',
                      Uri.parse('http://14.225.254.142:9000/recruitment'));
                  request.body = json.encode(
                      {"cv": "$cv_id", "job_employer": "$job_employer"});
                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    print(await response.stream.bytesToString());
                    globals.apply_status[index] = 1;
                    try {
                      var headers = {'Content-Type': 'application/json'};
                      var request = http.Request(
                          'GET',
                          Uri.parse(
                              'http://14.225.254.142:9000/recruitment/get'));
                      request.body =
                          json.encode({"cv": "${globals.cv['cv']['cv_id']}"});
                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        var value = await response.stream.bytesToString();
                        globals.recruiment = json.decode(value);
                        print(globals.recruiment);
                      } else {
                        print(response.reasonPhrase);
                        globals.recruiment = null;
                      }
                    } catch (e) {
                      print("Err ---recruiment");
                      globals.recruiment = null;
                      globals.apply_status[index] = 0;
                      print("No Cv");
                    }
                  } else {
                    print(response.reasonPhrase);
                    globals.apply_status[index] = 0;
                    print("No Cv");
                  }
                } catch (e) {}
              } else {
                print("No Cv");
              }
            },
            child: rowSingleButton(
                color: globals.apply_status[index] == 1
                    ? Colors.red
                    : Colors.black,
                name: "Apply",
                iconImage: globals.apply_status[index] == 1
                    ? "assets/icons/love_icon.png"
                    : "assets/icons/share_icon.png",
                isHover: false),
          ),
        ],
      ),
    );
  }
}
