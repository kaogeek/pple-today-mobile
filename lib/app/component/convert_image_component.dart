import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../data/models/base_64_model.dart';
import '../ui/utils/environment.dart';

class ConvertImageComponent {
  static Future<Base64Model> imageFileToBase64(File imageFile) async {
    /// get name from file
    String fileName = imageFile.path.split('/').last;

    /// get mime type from file
    String mimeType = 'image/${fileName.split('.').last}';

    /// get size from file
    int size = await imageFile.length();

    /// get image from file
    final _bytes = await imageFile.readAsBytes();

    /// convert to base64
    String base64 = base64Encode(_bytes);

    return Base64Model(
      asset: Asset(
        size: size,
        fileName: fileName,
        mimeType: mimeType,
        data: base64,
      ),
    );
  }

  static Future<String> imageNetworkToBase64(String imageUrl) async {
    /// get image from network
    Uri _uri = Uri.parse(imageUrl);
    http.Response response = await http.get(_uri);
    final _bytes = response.bodyBytes;

    /// convert to base64
    String base64 = base64Encode(_bytes);
    return base64;
  }

  static Future<File> imageNetworkToFile(String imageUrl) async {
    /// get image from network
    Uri _uri = Uri.parse(imageUrl);
    http.Response response = await http.get(_uri);
    final _bytes = response.bodyBytes;

    /// save to path
    final _buffer = _bytes.buffer;
    ByteData byteData = ByteData.view(_buffer);
    // final _tempDir = await getTemporaryDirectory();
    final _directory = await getApplicationDocumentsDirectory();
    String fileName = '${_directory.path}/${DateTime.now()}img';
    File _file = await File(fileName).writeAsBytes(
      _buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    return _file;
  }

  static String getImages({required String imageURL}) {
    if (imageURL.endsWith('/')) {
      imageURL = imageURL.substring(0, imageURL.length - 1);
    }

    if (imageURL.endsWith('/image')) {
      imageURL = imageURL.substring(0, imageURL.length - 6);
    }

    return '${Environment.apiURL}/api$imageURL/image';
  }
}
