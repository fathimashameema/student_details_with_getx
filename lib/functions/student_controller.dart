import 'dart:io';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_details/models/student_model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;
  var isLoading = false.obs;
  Box<StudentModel>? _studentModelBox;
  var selectedImage = Rx<File?>(null);
  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  Future<void> openBox() async {
    if (_studentModelBox == null || !_studentModelBox!.isOpen) {
      _studentModelBox = await Hive.openBox<StudentModel>('student box');
    }
  }

  void setImage(File? image) {
    selectedImage.value = image;
    print('Image set');
    update(); 
  }

  void clearImage() {
    selectedImage.value = null;
    update();
  }

  Future<void> addStudent(StudentModel student) async {
    try {
      await openBox();
      await _studentModelBox!.add(student);
      print('student added ${student.name}');
      await getStudents();
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  Future<void> getStudents() async {
    try {
      await openBox();
      isLoading.value = true;
      update();
      students.value = _studentModelBox!.values.toList();
      filteredStudents.value = students;
      isLoading.value = false;
      update();
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  Future<void> editStudent(int index, StudentModel student) async {
    try {
      await openBox();
      await _studentModelBox!.putAt(index, student);
      await getStudents();
      update();
    } catch (e) {
      print("Error editing student: $e");
    }
  }

  Future<void> deleteStudent(int index) async {
    try {
      await openBox();
      await _studentModelBox!.deleteAt(index);
      await getStudents();
    } catch (e) {
      print("Error deleting student: $e");
    }
  }
}
