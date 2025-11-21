import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:myflutter_nov2025/app/services/api.service.dart';
import 'package:myflutter_nov2025/app/services/sharedprefs.dart';
import 'package:myflutter_nov2025/app/views/add_report.screen.dart';
import 'package:myflutter_nov2025/app/views/login.screen.dart';
import '../models/reports.model.dart';

class ReportsController extends GetxController {
  var reportList = <Report>[
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

  Future<void> navigateToAddReport() async {
    await Get.to(() => AddReportScreen());
    getReports();
  }

  Future<void> onLogout() async {
    await SharedPrefs.removeLocalStorage('token');
    await SharedPrefs.removeLocalStorage('user');
    await Get.to(() => LoginScreen());
  }

  Future<void> getReports() async {
    log('Starting getReports()');
    try {
      var result = await api.getDio('/reports');
      log('API call successful, result: $result');
      if (result != null && result.statusCode == 200) {
        log('Status code is 200, processing data...');
        reportList.assignAll(
          (result.data['data'] as List).map((report) {
            return Report(
              id: report['id'],
              title: report['title'],
              date: report['date'].toString(),
              category: report['category'],
              imagePath: report['imagePath'] != null
                  ? '${api.baseurl}/${report['imagePath']}'
                  : '',
            );
          }).toList(),
        );
        log('Report list updated with ${reportList.length} items');
        log(
          'Reports loaded: ${reportList.length}, first image: ${reportList.isNotEmpty ? reportList.first.imagePath : 'none'}',
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
