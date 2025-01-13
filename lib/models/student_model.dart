import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  int phoneNo;

  @HiveField(3)
  String email;

  @HiveField(4)
  String batch;

  @HiveField(5)
  Uint8List? profileImagePath;

  @HiveField(6)
  int? id;

  StudentModel(
      {required this.age,
      required this.batch,
      required this.name,
      required this.email,
      required this.phoneNo,
      this.id,
      this.profileImagePath});
}
