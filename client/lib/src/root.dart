import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:ttok/val.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  _onLoad() async {
    await 1.delay();
    if (Val.user.val.isEmpty) {
      Get.offNamed('/login');
    } else {
      Get.offAllNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
