import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../data/services/user_service.dart';
import '../ui/utils/storage_keys.dart';

class EditProfileController extends GetxController {
  final _service = UserService();
  final _box = GetStorage();

  File profileImage = File('');

  Future<bool> fetchEditProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? birthdate,
    String? province,
    int? gender,
  }) async {
    String uid = _box.read(StorageKeys.uid);
    String token = _box.read(StorageKeys.token);
    String mode = _box.read(StorageKeys.mode);

    final response = await _service.editProfile(
      uid: uid,
      token: token,
      mode: mode,
      displayName: displayName,
      firstName: firstName,
      lastName: lastName,
      birthdate: birthdate,
      province: province,
      gender: gender,
    );

    return response.isOk;
  }

  Future<bool> imagePicker(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(
      source: source,
      maxWidth: 400,
      maxHeight: 400,
    );

    if (image == null) return false;

    profileImage = File(image.path);
    update();

    await _box.write(StorageKeys.imagePath, profileImage.path);

    return true;
  }

  Future<bool> fetchEditImageProfile({
    String? displayName,
    String? firstName,
    String? lastName,
    String? birthdate,
    String? province,
    int? gender,
  }) async {
    String uid = _box.read(StorageKeys.uid);
    String token = _box.read(StorageKeys.token);
    String mode = _box.read(StorageKeys.mode);

    Uint8List? bytes = profileImage.path.isEmpty ? null : profileImage.readAsBytesSync();

    if (bytes == null) return false;

    int sizeImage = bytes.length;
    String base64 = base64Encode(bytes);
    String fileName = basename(profileImage.path);

    final response = await _service.editImageProfile(
      uid: uid,
      token: token,
      mode: mode,
      mimeType: 'image/jpeg',
      fileName: fileName,
      size: sizeImage,
      base64: base64,
    );

    return response.isOk;
  }
}
