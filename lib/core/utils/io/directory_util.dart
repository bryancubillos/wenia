import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryUtil {
  // [GET]
  static Future<Directory> getDirectory(String folderName) async {
    Directory currentDirectory = await getApplicationDocumentsDirectory();
    return Directory("${currentDirectory.path}/$folderName");
  }

  // [DELETE]
  static Future<bool> deleteDirectory(String folderName) async {
    bool result = false;

    try {
      Directory directoryToDelete = await DirectoryUtil.getDirectory(folderName);
      if(await directoryToDelete.exists()) {
        directoryToDelete.deleteSync(recursive: true);
      }
    }
    catch (error) {
      if(kDebugMode) {
        print("deleteDirectory catch, ERROR: $error");
      }
    }

    return result;
  }
}