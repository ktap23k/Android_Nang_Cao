import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkedin_clone/constants.dart';
import 'package:linkedin_clone/repository/data.dart';

import 'package:linkedin_clone/screen/pages/home.dart';
import 'package:linkedin_clone/screen/pages/home_page/home_page.dart';
import 'package:linkedin_clone/screen/pages/job/job_detail.dart';
//import 'package:linkedin_clone/screen/pages/profile/profile.dart';
import 'package:linkedin_clone/size_config.dart';

class JobList extends StatefulWidget {
  @override
  _JobListState createState() => _JobListState();
}
  final _post = Data.postList;
class _JobListState extends State<JobList> {
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
                title: Text("Home"),
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
                children: [
                  Text(
                    "Job List",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: getProportionateScreenHeight(155),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ))),
                      onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => JobDetail(),
                    )),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(0)),
                              image: DecorationImage(
                                  image: AssetImage(_post[1].profileUrl)
                              )
                            )
                          ),
                          
                          Column(children: [
                            SizedBox(
                            height: 30,
                          ),
                            Text(
                              " Job name",textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(20),
                                
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              " Company name",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                overflow: TextOverflow.visible,
                                color: Colors.black,
                              ),
                              
                              
                            ),
                            SizedBox(height: 10,),
                            Text(
                              " Description",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                                color: Colors.blueAccent,
                              ),
                              
                              
                            ),
                            
                          ])
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
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
