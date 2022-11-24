import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final scanning = false.obs;
  final extractText = ''.obs;

  XFile? imageFile;

  Future<void> getImage(ImageSource source) async {
    scanning.value = true;
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        await getRecognisedText(pickedImage);
      }
    } catch (e) {
      extractText.value = 'Error ocurred while scanning\n\n $e';
      imageFile = null;
      scanning.value = false;
    }
  }

  Future<void> getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
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
}
