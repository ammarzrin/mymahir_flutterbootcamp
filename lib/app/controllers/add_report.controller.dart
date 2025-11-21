import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:myflutter_nov2025/app/services/api.service.dart';
import 'package:myflutter_nov2025/app/services/sharedprefs.dart';

class AddReportController extends GetxController {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  MultipartFile? imageFile;

  final selectedCategory = RxnString();
  final imagePath = ''.obs;
  final categories = ['Safety', 'Property', 'Security'];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedTime = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedTime != null) {
      dateController.text =
          '${pickedTime.day}/${pickedTime.month}/${pickedTime.year}';
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
      imageFile = await MultipartFile.fromFile(
        image.path,
        filename: image.name,
      );
    }
  }

  Future<void> submitReport() async {
    String user = await SharedPrefs.getLocalStorage('user') ?? '';
    Map<String, dynamic> userData = jsonDecode(user);
    int userId = userData['id'] ?? 1;

    FormData formdata = FormData.fromMap({
      'user_id': userId,
      'title': titleController.text.trim(),
      'date': dateController.text.trim(),
      'category': selectedCategory.value,
      if (imageFile != null) 'image': imageFile,
    });

    try {
      var res = await api.postDio('/reports/add', formdata);
      if (res != null && res.statusCode! > 200) {
        Get.back();
        await Future.delayed(Duration(seconds: 1));
        Get.snackbar('Submit Report', res.data['message']);
        // Clear the form
        titleController.clear();
        dateController.clear();
        selectedCategory.value = null;
        imagePath.value = '';
      }
    } on DioException catch (dioError) {
      log('Dio Error: ${dioError.response?.data['errors']}');
      Get.snackbar('Submit Report failed', dioError.response?.data['message']);
    } catch (e) {
      Get.snackbar('Submit Report failed', e.toString());
    }
  }
}
