import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:sse_client/sse_client.dart';
import 'package:ttok/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ttok/fdb.dart';
import 'package:ttok/val.dart';
import 'package:http/http.dart' as http;

class GameKuis extends StatelessWidget {
  GameKuis({Key? key}) : super(key: key);
  final _listChat = [].obs;
  final _listJoin = [].obs;

  _load() {
    _loadChat();
    _loadJoin();

    FDb.db.reference().child('ttok').child(Val.user.val['id']).child("chat").onChildChanged.listen((event) async {
      // print(event.snapshot.value);
      // final chat =
      //     await http.get(Uri.parse("${Config.host}/member-chat?userId=${Val.user.val['id']}&roomId=${Val.roomId.val}"));
      // _listChat.assignAll(jsonDecode(chat.body));
      // profilePictureUrl
      _loadChat();
    });

    FDb.db.reference().child('ttok').child(Val.user.val['id']).child("join").onChildChanged.listen((event) async {
      // print(event.snapshot.value);
      // final chat =
      //     await http.get(Uri.parse("${Config.host}/member-join?userId=${Val.user.val['id']}&roomId=${Val.roomId.val}"));
      // _listJoin.assignAll(jsonDecode(chat.body));
      // profilePictureUrl
      _loadJoin();
    });
  }

  _loadChat() async {
    final chat =
        await http.get(Uri.parse("${Config.host}/member-chat?userId=${Val.user.val['id']}&roomId=${Val.roomId.val}"));
    _listChat.assignAll(jsonDecode(chat.body));
  }

  _loadJoin() async {
    final chat =
        await http.get(Uri.parse("${Config.host}/member-join?userId=${Val.user.val['id']}&roomId=${Val.roomId.val}"));
    _listJoin.assignAll(jsonDecode(chat.body));
  }

  @override
  Widget build(BuildContext context) {
    _load();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SafeArea(
        child: Center(
          child: SizedBox(
            width: sizingInformation.isMobile ? Get.width : 360,
            child: Material(
              child: ListView(
                controller: ScrollController(),
                children: [
                  Text(Val.tiktokUsername.val),
                  Text(Val.roomId.val),
                  Text("disini chatnya"),
                  
                  Row(
                    children: [
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Wellcome",
                                style: TextStyle(
                                  fontSize: 16

                                ),
                              ),
                            ),
                            Wrap(
                              children: [
                                
                                for (final join in _listJoin)
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      maxRadius: 16,
                                      backgroundImage: NetworkImage(
                                        join['Member']['profilePictureUrl'].toString(),
                                      ),
                                      // child:
                                      // SizedBox(
                                      //   width: 50,
                                      //   height: 50,
                                      //   child: Image.network(
                                      //     chat['Member']['profilePictureUrl'].toString(),
                                      //   ),
                                      // ),
                                    ),
                                  )
                                // Text(
                                //   chat['Member']['profilePictureUrl'].toString(),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Obx(
                    () => Column(
                      children: [
                        for (final chat in _listChat)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 16,
                                  backgroundImage: NetworkImage(
                                    chat['Member']['profilePictureUrl'].toString(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Expanded(child: Text(chat['comment'].toString())),
                                )
                              ],
                            ),
                          )
                        // SizedBox(
                        //   width: 70,
                        //   height: 70,
                        //   child: Image.network(
                        //     chat['Member']['profilePictureUrl'].toString(),
                        //   ),
                        // )
                        // Text(
                        //   chat['Member']['profilePictureUrl'].toString(),
                        // ),
                      ],
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
