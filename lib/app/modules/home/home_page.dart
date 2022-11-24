import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
              Obx(
                () => controller.scanning.value
                    ? const CircularProgressIndicator.adaptive()
                    : const SizedBox(),
              ),
              Obx(
                () => !controller.scanning.value && controller.imageFile == null
                    ? Container(
                        height: 75.0.wp,
                        width: 75.0.wp,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 20.0.sp,
                          ),
                        ),
                      )
                    : controller.imageFile != null
                        ? Image.file(
                            File(controller.imageFile!.path),
                            width: 75.0.wp,
                          )
                        : const SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquaredButton(
                    iconButton: Icons.image,
                    onPressed: () async =>
                        await controller.getImage(ImageSource.gallery),
                    textButton: 'Gallery',
                  ),
                  SquaredButton(
                    iconButton: Icons.camera_alt,
                    onPressed: () async =>
                        await controller.getImage(ImageSource.camera),
                    textButton: 'Camera',
                  ),
                ],
              ),
              SizedBox(height: 5.0.hp),
              SizedBox(
                child: Obx(() => Text(
                      controller.extractText.value,
                      style: TextStyle(fontSize: 20.0.sp),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SquaredButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final IconData iconButton;
  const SquaredButton({
    super.key,
    required this.onPressed,
    required this.textButton,
    required this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0.wp),
      padding: EdgeInsets.only(top: 3.0.hp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          shadowColor: Colors.grey.shade400,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          margin: EdgeInsets.all(3.0.wp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconButton,
                size: 15.0.sp,
              ),
              Text(
                textButton,
                style: TextStyle(
                  fontSize: 11.0.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
