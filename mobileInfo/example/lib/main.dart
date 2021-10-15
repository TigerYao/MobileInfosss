import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_info/getmobileinfo.dart';
import 'package:mobile_info/mobile_info_entity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold()
//   }
// }
//
class _MyHomePageState extends State<MyHomePage> {
  MobileInfoEntity? entity;
  late MobleInfoUtils utils;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   utils = MobleInfoUtils();
   utils.getMobileInfoEntity().then((value){
      entity = value;
      print("get...${entity?.app_version}");
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YH TEST PROGECT"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: entity == null? CircularProgressIndicator(
          color: Colors.white,
        ) :ListView(
          children: [
            ListTile(
              leading: Text("系统："),
              title: Text(entity?.os??""),
            ),
            ListTile(
              leading: Text("ios版本："),
              title: Text(entity?.ios_version??""),
            ),
            ListTile(
              leading: Text("app版本："),
              title: Text(entity?.app_version??""),
            ),
            ListTile(
              leading: Text("网络："),
              title: Text(entity?.net_type??""),
            ),
            ListTile(
              leading: Text("ip地址："),
              title: Text(entity?.ip??""),
            ),
            ListTile(
              title: Text("${json.encode(entity)}"),
            ),
            ElevatedButton(onPressed: (){
              utils.updateMobileInfo((data){

              }, (e){

              });
            }, child: Text("上传"))
          ],
        ),
      ),
    );
  }
}
