import 'dart:io';
import 'package:flutter/material.dart';

class ImageModel extends ChangeNotifier {
  File? _imageFile;
  File? _filteredImageFile;

  File? get imageFile => _imageFile;
  File? get filteredImageFile => _filteredImageFile;

  void setImageFile(File? file) {
    _imageFile = file;
    _filteredImageFile = null; 
    notifyListeners();
  }

  void setFilteredImageFile(File? file) {
    _filteredImageFile = file;
    notifyListeners();
  }
}