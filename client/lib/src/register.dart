import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ttok/config.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SafeArea(
        child: Center(
          child: SizedBox(
            width: sizingInformation.isMobile ? Get.width : 360,
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network("https://i.postimg.cc/W18pbP7t/image.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _conName,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'name',
                        ),
                      ),
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
                        color: Colors.pink,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: ()async {

                          final body = <String, String>{
                            "name": _conName.text,
                            "email": _conEmail.text,
                            "password": _conPassword.text
                          };

                          if(body.values.contains("")){
                            Get.snackbar("Info", "isi semuanya");
                            return;
                          }

                          final reg = await http.post(Uri.parse("${Config.host}/register"), body: body);
                          if(reg.statusCode == 201){
                            Get.snackbar("info", "register berhasil silahkan login");
                            Get.toNamed("/login");
                            return;
                          }

                          Get.snackbar("info", reg.body);

                        },
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("OR"),
                      ),
                    ),
                    MaterialButton(
                      child: Text("LOGIN", style: TextStyle(color: Colors.blue),),
                      onPressed: () => Get.toNamed("/login")
                    )
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
