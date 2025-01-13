import 'dart:io';
import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details/functions/student_controller.dart';
import 'package:student_details/models/batch.dart';
import 'package:student_details/models/student_model.dart';
import 'package:student_details/widgets/custom_text_form_field.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final batchController = SingleSelectController<String>(batches[0]);
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final studentController = Get.find<StudentController>();

  Future<void> pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      studentController.setImage(File(returnImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Obx(() => CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                        child: studentController.selectedImage.value != null
                            ? Image.file(
                                studentController.selectedImage.value!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/avatar-3814049_1280.webp',
                                fit: BoxFit.cover,
                              ),
                      ),
                    )),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                controller: nameController,
                hintText: 'Name',
              ),
              CustomTextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                hintText: 'Age',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomDropdown(
                  decoration: CustomDropdownDecoration(
                    closedFillColor: Colors.grey.withOpacity(0.2),
                    expandedFillColor: const Color.fromARGB(255, 43, 42, 42),
                  ),
                  onChanged: (v) {},
                  validator: (value) =>
                      value == null ? "Batch cannot be null" : null,
                  controller: batchController,
                  hintText: 'Batch',
                  items: batches,
                ),
              ),
              CustomTextFormField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                hintText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                validator: (value) {
                  final emailRegex =
                      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                  if (value == null || !emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.grey.withOpacity(0.3),
                  ),
                ),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  Uint8List? imageBytes;
                  if (studentController.selectedImage.value != null) {
                    imageBytes = await studentController.selectedImage.value!
                        .readAsBytes();
                  }

                  final student = StudentModel(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    batch: batchController.value!,
                    phoneNo: int.parse(numberController.text),
                    email: emailController.text,
                    profileImagePath: imageBytes,
                  );

                  await studentController.addStudent(student);
                  studentController.clearImage();

                  nameController.clear();
                  ageController.clear();
                  numberController.clear();
                  emailController.clear();
                  batchController.value = batches[0];

                  Get.back(); 
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
