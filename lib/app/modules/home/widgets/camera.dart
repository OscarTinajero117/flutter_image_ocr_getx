import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_ocr_getx/app/core/values/responsive.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class CameraPage extends GetView<HomeController> {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(controller.cameraController),
          ),
          const FocusRectangle(
            color: Colors.cyan,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0.hp),
                child: Text(
                  'Place your water meter within the box',
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await controller.getImageCamera(),
        child: const Icon(Icons.camera),
      ),
    );
  }
}

class FocusRectangle extends StatelessWidget {
  final Color color;
  const FocusRectangle({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.all(1.5.hp),
                child: AspectRatio(
                  aspectRatio: (2.0 / 1),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        )
      ],
    );
  }
}
