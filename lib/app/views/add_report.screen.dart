import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter_nov2025/app/controllers/add_report.controller.dart';

class AddReportScreen extends StatelessWidget {
  AddReportScreen({super.key});

  final AddReportController controller = Get.put(AddReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Report")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                  hintText: 'Enter title',
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: controller.dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Date'),
                  hintText: 'Select date',
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                onTap: () => controller.selectDate(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  initialValue: controller.selectedCategory.value,
                  items: controller.categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Obx(
                () => GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                      image: controller.imagePath.value == ''
                          ? null
                          : DecorationImage(
                              image: FileImage(
                                File(controller.imagePath.value),
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: controller.imagePath.value == ''
                        ? const Icon(Icons.add_a_photo, size: 40)
                        : null,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: controller.submitReport,
                child: Text('Submit Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
