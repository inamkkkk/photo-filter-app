import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:photo_filter_app/models/image_model.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Provider.of<ImageModel>(context, listen: false).setImageFile(File(pickedFile.path));
    }
  }

  Future<void> applyGrayscale() async {
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    if (imageModel.imageFile != null) {
      final imageBytes = await imageModel.imageFile!.readAsBytes();
      final image = img.decodeImage(imageBytes);

      if (image != null) {
        final grayscaleImage = img.grayscale(image);
        final pngBytes = img.encodePng(grayscaleImage);
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/grayscale.png');
        await file.writeAsBytes(pngBytes);
        imageModel.setFilteredImageFile(file);
      }
    }
  }

  Future<void> applySepia() async {
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    if (imageModel.imageFile != null) {
      final imageBytes = await imageModel.imageFile!.readAsBytes();
      final image = img.decodeImage(imageBytes);

      if (image != null) {
        final sepiaImage = img.sepia(image);
        final pngBytes = img.encodePng(sepiaImage);
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/sepia.png');
        await file.writeAsBytes(pngBytes);
        imageModel.setFilteredImageFile(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Filter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ImageModel>(
              builder: (context, imageModel, child) {
                return imageModel.filteredImageFile != null
                    ? Image.file(imageModel.filteredImageFile!)
                    : (imageModel.imageFile != null
                        ? Image.file(imageModel.imageFile!)
                        : Text('No image selected.'));
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Pick Image'),
                ),
                ElevatedButton(
                  onPressed: applyGrayscale,
                  child: Text('Grayscale'),
                ),
                ElevatedButton(
                  onPressed: applySepia,
                  child: Text('Sepia'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}