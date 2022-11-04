import 'package:flutter/material.dart';
import 'package:linkedin_clone/repository/data.dart';

import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/job/job_detail.dart';
import 'package:linkedin_clone/size_config.dart';
import 'package:linkedin_clone/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobList extends StatefulWidget {
  @override
  _JobListState createState() => _JobListState();
}

final _post = Data.postList;
Map dataRecruiment_;
String link;

class _JobListState extends State<JobList> {
  getData(var id) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('GET', Uri.parse('http://14.225.254.142:9000/job/info'));
      request.body = json.encode({"job_employer_id": "$id"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();
        dataRecruiment_ = json.decode(value)['result'];
        print('data : $dataRecruiment_');

        for (var i in dataRecruiment_['job_user_info']) {
          if (i['job_employer_id'] == id) {
            globals.JobName = i['info_job'];
          }
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {}
  }

  getRecruiment(var id) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'GET', Uri.parse('http://14.225.254.142:9000/recruitment/get'));
      request.body = json.encode({"cv": "$id"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();
        globals.recruiment = json.decode(value);
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  getImage(var id) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'GET', Uri.parse('http://14.225.254.142:9000/get/image'));
      request.body = json.encode({"user_id": "$id"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();
        Map data = json.decode(value)["result"];
        link = 'https://androidtuan.s3.amazonaws.com/${data["source"]}';
        print("link: $link");
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      link = globals.image_null;
    }
  }

  setupData() async {
    globals.dataRecruiment = {'result': []};
    await getRecruiment(globals.cv['cv']['cv_id']);

    for (var i in globals.recruiment['result']) {
      await getData(i['job_employer']);
      Map _d = json.decode(json.encode(dataRecruiment_));
      await getImage(_d['cv']['user']);

      globals.dataRecruiment['result'].add({
        "job_employer": i['job_employer'],
        "id_rec": i['id'],
        "create_at": i["create_at"],
        'job_name': globals.JobName,
        'company_name': _d['cv']['name_company'],
        'Description': _d['cv']['orther_req'],
        'image': '$link',
        'data': _d
      });
    }
    addNewField();
  }

  var listContainer = <Widget>[];
  int index = 0;

  void addNewField() {
    setState(() {
      for (var i in globals.dataRecruiment['result']) {
        listContainer.add(_rowButton(index));
        index++;
      }
      if (globals.dataRecruiment['result'].length == 0) {
        listContainer.add(Text("You There's Nothing Here",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              overflow: TextOverflow.visible,
              color: Colors.black,
            )));
      }
    });
  }

  @override
  void initState() {
    listContainer = <Widget>[];
    index = 0;
    setupData();
    super.initState();
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
            Container(
              child: AppBar(
                title: Center(
                  child: Text(
                    "Job list",
                    textAlign: TextAlign.center,
                  ),
                ),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listContainer,
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _rowButton(int index) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(155),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ))),
            onPressed: () {
              globals.check = index;
              print(globals.check);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => JobDetail(),
              ));
            },
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: 100,
                    height: 120,
                    child: Image(
                      image: NetworkImage(
                          '${globals.dataRecruiment['result'][index]['image'] ?? globals.avata_null}'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 15,
                            bottom: 0,
                            right: 0,
                            top: 0), //apply padding to all four sides
                        child: Text(
                          "${globals.dataRecruiment['result'][index]['job_name']}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(20),
                            color: Colors.blue,
                          ),
                        )),
                    Text(
                      "Company: ${globals.dataRecruiment['result'][index]['company_name']}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        overflow: TextOverflow.visible,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, bottom: 10, right: 0, top: 20),
                      child: Text(
                        "${globals.dataRecruiment['result'][index]['Description']}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                          overflow: TextOverflow.visible,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
