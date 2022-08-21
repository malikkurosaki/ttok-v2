import 'package:firebase_dart/core.dart';
import 'package:firebase_dart/database.dart';
import 'package:firebase_dart/implementation/pure_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ttok/fdb.dart';
import 'package:ttok/src/game_kuis.dart';
import 'package:ttok/src/home.dart';
import 'package:ttok/src/login.dart';
import 'package:ttok/src/register.dart';
import 'package:ttok/src/root.dart';

final key = {
  "apiKey": "AIzaSyAfACNHRoyIvX4nct4juVabZDgwEDKQ6jY",
  "appId": "1:27222609089:web:bf85a0777451fb17da9840",
  "messagingSenderId": "27222609089",
  "projectId": "malikkurosaki1985",
  "name": "percobaan",
  "authDomain": "malikkurosaki1985.firebaseapp.com"
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await FirebaseDartFlutter.setup();
  // var app = await Firebase.initializeApp(
  //     options: FirebaseOptions.fromMap(key));

  FirebaseDart.setup();
  var options = FirebaseOptions(
      appId: 'my_app_id',
      apiKey: 'apiKey',
      projectId: 'my_project',
      messagingSenderId: 'ignore',
      authDomain: 'my_project.firebaseapp.com');

  var app = await Firebase.initializeApp(options: options);

  final database = FirebaseDatabase(app: app, databaseURL: "https://malikkurosaki1985.firebaseio.com");
  FDb.init(database);
  

  GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        defaultTransition: Transition.noTransition,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => Root(),
          ),
          GetPage(
            name: '/home',
            page: () => Home(),
          ),
          GetPage(
            name: '/login',
            page: () => Login(),
          ),
          GetPage(name: '/register', page: () => Register()),
          GetPage(name: '/game-kuis', page: () => GameKuis())
        ],
        builder: FlutterSmartDialog.init());
  }
}
