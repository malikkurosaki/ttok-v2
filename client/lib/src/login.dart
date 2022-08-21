import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ttok/config.dart';
import 'package:ttok/val.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SafeArea(
        child: Center(
          child: Material(
            child: SizedBox(
              width: sizingInformation.isMobile ? Get.width : 360,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network("https://i.postimg.cc/J4wzpxn7/image.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _conEmail,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _conPassword,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final body = <String, String>{"email": _conEmail.text, "password": _conPassword.text};

                          if (body.values.contains("")) {
                            Get.snackbar("info", "isi semuanya");
                            return;
                          }

                          final lgn = await http.post(Uri.parse("${Config.host}/login"), body: body);

                          if(lgn.statusCode == 200){
                            Val.user.val = jsonDecode(lgn.body);
                            Get.offAllNamed('/home');
                            return;
                          }

                          Get.snackbar("ifo", "wrong email or password ");
                        },
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("OR"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/register');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
