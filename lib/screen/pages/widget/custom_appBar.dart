import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin_clone/screen/pages/home_page/setting.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;

var findControl = TextEditingController();

class CustomAppBar extends StatelessWidget {
  final SizingInformation sizingInformation;

  const CustomAppBar({Key key, this.sizingInformation}) : super(key: key);

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    findControl.dispose();
  }

  void getImageData() {
    // setup data finds
    for (int index = 0; index < globals.finds['result'].length; index++) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      height: sizingInformation.screenSize.height * 0.08,
      padding: EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(
                    color: Colors.purple[500],
                    // border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide()))),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Setting(),
                    )),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${globals.profile['avatar'] ?? globals.avata_null}')),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 35,
            width: sizingInformation.screenSize.width / 1.40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white70),
            child: TextField(
              controller: findControl,
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding:
                    EdgeInsets.only(left: 20, bottom: 0, right: 0, top: 0),
                border: InputBorder.none,
                // prefixIcon: Icon(
                //   Icons.search,
                //   color: Colors.black87,
                // ),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    var check = [];
                    if (findControl.text != '' &&
                        findControl.text.split('-').length > 1) {
                      globals.finds = {'result': []};
                      for (var i in findControl.text.split('-')) {
                        var headers = {'Content-Type': 'application/json'};
                        var request = http.Request('GET',
                            Uri.parse('http://14.225.254.142:9000/finds'));
                        request.body = json.encode({
                          "languge_job": "$i",
                          "region": "$i",
                          "city": "$i",
                          "name_company": "$i"
                        });
                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          var value = await response.stream.bytesToString();
                          for (var val in json.decode(value)['result']) {
                            if (!check.contains(val['user'])) {
                              check.add(val['user']);
                              globals.finds['result'].add(val);
                            }
                          }
                        } else {
                          print(response.reasonPhrase);
                        }
                      }
                    } else {
                      if (findControl.text != '') {
                        try {
                          var headers = {'Content-Type': 'application/json'};
                          var request = http.Request('GET',
                              Uri.parse('http://14.225.254.142:9000/finds'));
                          request.body = json.encode({
                            "languge_job": "${findControl.text}",
                            "region": "${findControl.text}",
                            "city": "${findControl.text}",
                            "name_company": "${findControl.text}"
                          });
                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            var value = await response.stream.bytesToString();
                            globals.finds = json.decode(value);
                          } else {
                            print(response.reasonPhrase);
                          }
                        } catch (e) {}
                      } else {
                        try {
                          var headers = {'Content-Type': 'application/json'};
                          var request = http.Request('GET',
                              Uri.parse('http://14.225.254.142:9000/finds'));
                          request.body = json.encode({
                            "languge_job": " ",
                            "region": " ",
                            "city": " ",
                            "name_company": " "
                          });
                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            var value = await response.stream.bytesToString();
                            globals.finds = json.decode(value);
                          } else {
                            print(response.reasonPhrase);
                          }
                        } catch (e) {}
                      }
                    }
                    // get image and name user post job
                    for (final i in globals.finds['result']) {
                      try {
                        var headers = {
                          'Authorization': 'Bearer ${globals.token}',
                          'Content-Type': 'application/json'
                        };
                        var request = http.Request('GET',
                            Uri.parse('http://14.225.254.142:9000/get/image'));
                        request.body = json.encode(
                            {"job_user_id": "0", "user_id": "${i['user']}"});
                        request.headers.addAll(headers);

                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          var value = await response.stream.bytesToString();
                          Map values = json.decode(value)['result'];
                          globals.finds['result']
                                  [globals.finds['result'].indexOf(i)]
                              ['em_name'] = '${values['name']}';
                          var url =
                              "https://androidtuan.s3.amazonaws.com/img/3d953570-acb6-4fc6-90d0-abfc9d617c67.jpg";
                          if (values['source'] != "") {
                            url =
                                'https://androidtuan.s3.amazonaws.com/${values['source']}';
                          }
                          globals.finds['result']
                                  [globals.finds['result'].indexOf(i)]
                              ['url_profile'] = url;
                          globals.finds['result']
                                      [globals.finds['result'].indexOf(i)]
                                  ['job_employer_id'] =
                              i['job_employer_infos'][0]['job_employer_id'];
                        } else {
                          print(response.reasonPhrase);
                        }
                      } catch (e) {
                        print("error get profile job");
                      }
                    }
                    getImageData();
                    findControl.text = '';
                  },
                  child: Icon(Icons.search, color: Colors.black87),
                ),
                // suffixIcon: Icon(Icons.qr_code, color: Colors.black87)
              ),
            ),
          ),
          Container(
              height: 30,
              width: 30,
              child: Icon(FontAwesomeIcons.facebookMessenger)),
        ],
      ),
    );
  }
}
