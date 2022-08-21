import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:ttok/config.dart';
import 'package:ttok/val.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final _conTiktokUsername = TextEditingController(text: Val.tiktokUsername.val);

  @override
  Widget build(BuildContext context) {
    debugPrint('home');
    return ResponsiveBuilder(
      
      builder: (context, sizingInformation) => SafeArea(
        child: Center(
          child: SizedBox(
            width: sizingInformation.isMobile? Get.width: 360,
            child: Material(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Val.user.val['name'].toString(),
                      style: TextStyle(
                      fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) => Val.tiktokUsername.val = value,
                      controller: _conTiktokUsername,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'live user name',
                        border: OutlineInputBorder(borderSide: BorderSide.none)
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
                          child: Text("MULAI", style: TextStyle(
                            color: Colors.white
                          ),),
                        ),
                      ),
                      onPressed: ()async{
                        SmartDialog.showLoading();
                        final mulai = await http.post(Uri.parse(Config.host+'/game-kuis'), body: {
                          "userId": Val.user.val['id'],
                          "tiktokUsername": _conTiktokUsername.text
                        });

                        debugPrint(mulai.statusCode.toString());

                        if(mulai.statusCode == 201){
                          SmartDialog.dismiss();
                          Val.roomId.val = mulai.body;
                          Get.toNamed('/game-kuis');
                        }else{
                          Get.snackbar("info", mulai.body);
                          SmartDialog.dismiss();
                        }
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
