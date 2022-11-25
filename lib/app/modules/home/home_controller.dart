import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final loading = true.obs;
  final scanning = false.obs;
  final extractText = ''.obs;
  XFile? imageFile;

  final cameraDescription = <CameraDescription>[].obs;

  late final CameraController cameraController;

  Future<String> _resizePhoto(String fileName) async {
    final propieties = await FlutterNativeImage.getImageProperties(fileName);
    final width = propieties.width!;
    final height = propieties.height!;
    // final centerHight = height / 2;
    // final offset = (height - width) / 2;

    final croppedFile = await FlutterNativeImage.cropImage(
      fileName,
      0,
      height - width,
      width,
      height - width,
    );

    return croppedFile.path;
  }

  Future<void> getImageCamera() async {
    loading.value = true;
    final tmpPhoto = await cameraController.takePicture();
    Get.back();
    imageFile = tmpPhoto;
    final ocrPhoto = await _resizePhoto(tmpPhoto.path);
    await getRecognisedText(ocrPhoto);

    loading.value = false;
  }

  Future<void> getImage(ImageSource source) async {
    scanning.value = true;
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        await getRecognisedText(pickedImage.path);
      }
    } catch (e) {
      extractText.value = 'Error ocurred while scanning\n\n $e';
      imageFile = null;
      scanning.value = false;
    }
  }

  Future<void> getRecognisedText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final recognisedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    extractText.value = '';
    for (var block in recognisedText.blocks) {
      for (var line in block.lines) {
        extractText.value = '${extractText.value}${line.text}\n';
      }
    }
    scanning.value = false;
  }

  Future<void> initCameraPlugin() async {
    cameraDescription.value = await availableCameras();
    cameraController =
        CameraController(cameraDescription[0], ResolutionPreset.medium);
    await cameraController.initialize();

    if (cameraController.value.hasError) {
      log('Error');
    }
  }

  @override
  void onInit() async {
    loading.value = true;
    await initCameraPlugin();
    loading.value = false;
    super.onInit();
  }

  @override
  void onClose() async {
    await cameraController.dispose();
    super.onClose();
  }
}
