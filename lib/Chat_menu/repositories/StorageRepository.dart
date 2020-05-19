import 'dart:io';

import 'package:flutterapp/Chat_menu/providers/StorageProvider.dart';

class StorageRepository{
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadImage(File file, String path) => storageProvider.uploadImage(file, path);
}