import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/values/responsive.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image OCR'),
        centerTitle: true,
        elevation: 2.0.wp,
      ),
      body: Container(
        margin: EdgeInsets.all(1.0.hp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 30.0.sp,
                // decoration: BoxDecoration(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
