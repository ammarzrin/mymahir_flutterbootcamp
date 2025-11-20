import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:myflutter_nov2025/app/services/api.service.dart';
import '../models/reports.model.dart';

class ReportsController extends GetxController {
  var reportsList = <Report>[
    // Report(
    //   id: 1,
    //   title: "Toilet Explosion",
    //   date: "10-05-2026",
    //   category: "Safety",
    //   imagePath: "",
    // ),
    // Report(
    //   id: 2,
    //   title: "Broken Door",
    //   date: "12-10-2025",
    //   category: "Property",
    //   imagePath: "",
    // ),
    // Report(
    //   id: 3,
    //   title: "House Theft",
    //   date: "06-09-2025",
    //   category: "Security",
    //   imagePath: "",
    // ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    getReports();
  }

  getReports() async {
    log('Starting getReports()');
    try {
      var result = await api.getDio('/products');
      log('API call successful, result: $result');
      if (result != null && result.statusCode == 200) {
        log('Status code is 200, processing data...');
        reportsList.assignAll(
          (result.data['products'] as List).map((report) {
            return Report(
              id: report['id'],
              title: report['title'],
              date: report['price'].toString(),
              category: report['category'],
              imagePath: report['thumbnail'] != null
                  ? report['thumbnail'].toString()
                  : '',
              // imagePath: (() {
              //   final img = report['thumbnail']?.toString();
              //   if (img == null || img.isEmpty) return '';
              //   if (img.startsWith('http://') || img.startsWith('https://')) {
              //     return img;
              //   }
              //   return Uri.parse(api.baseurl).resolve(img).toString();
              // })(),
            );
          }).toList(),
        );
        log('Report list updated with ${reportsList.length} items');
        log(
          'Reports loaded: ${reportsList.length}, first image: ${reportsList.isNotEmpty ? reportsList.first.imagePath : 'none'}',
        );
      } else {
        log('Unexpected status code: ${result?.statusCode}');
      }
    } catch (e) {
      log('Error in getReports: ${e.toString()}');
      if (e is DioException) {
        log('Dio Error: ${e.type} - ${e.message}');
      }
    }
  }
}
