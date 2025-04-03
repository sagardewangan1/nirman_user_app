import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class GetImageController extends ChangeNotifier {
  File? _fileSingle;
  File? get fileSingle => _fileSingle;

  final ImagePicker picker1 = ImagePicker();
  void chooseImage() async {
    final pickedFile = await picker1.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );
    if (pickedFile != null) {
      _fileSingle = File(pickedFile.path);
    }
    print("_files====> ${_fileSingle}");
    notifyListeners();
  }

  final List<File> _files = [];
  List<File> get files => _files;
  final ImagePicker picker2 = ImagePicker();

  void chooseMoreImage() async {
    final pickedFile = await picker2.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );
    if (pickedFile != null) {
      _files.add(File(pickedFile.path));
    }
    print("_files====> $_files");
    notifyListeners();
  }

  void removeFile2(File file) {
    print("file=== $file");
    if (_files.contains(file)) {
      _files.remove(file);
    }
    _fileSingle = null;
    print("removed files====> $_files");
    notifyListeners();
  }

  void removeFile() {
    if (_fileSingle != null) {
      _fileSingle = null;
      notifyListeners();
    }
  }

  final ImagePicker pickerForTopBanner = ImagePicker();
  final ImagePicker pickerForBottomBanner = ImagePicker();

  // Store images mapped to subscription IDs
  Map<String, File?> _fileForTopBannerMap = {};
  Map<String, File?> get fileForTopBannerMap => _fileForTopBannerMap;

  Map<String, File?> _fileForBottomBannerMap = {};
  Map<String, File?> get fileForBottomBannerMap => _fileForBottomBannerMap;

// Pick Image for Top Banner
  void chooseImageForTopBanner(String subscriptionId) async {
    final pickedFile = await pickerForTopBanner.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (pickedFile != null) {
      _fileForTopBannerMap[subscriptionId] = File(pickedFile.path);
    }

    // Corrected print statement
    print(
        "_fileForTopBannerMap: ${_fileForTopBannerMap.map((key, value) => MapEntry(key, value?.path))}");
    notifyListeners();
  }

// Pick Image for Bottom Banner
  void chooseImageForBottomBanner(String subscriptionId) async {
    final pickedFile = await pickerForBottomBanner.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (pickedFile != null) {
      _fileForBottomBannerMap[subscriptionId] = File(pickedFile.path);
    }

    // Corrected print statement
    print(
        "_fileForBottomBannerMap: ${_fileForBottomBannerMap.map((key, value) => MapEntry(key, value?.path))}");
    notifyListeners();
  }

  void removeBannerImages() {
    if (_fileForTopBannerMap.isNotEmpty || _fileForBottomBannerMap.isNotEmpty) {
      _fileForTopBannerMap.clear();
      _fileForBottomBannerMap.clear();
      notifyListeners();
    }
  }
}
