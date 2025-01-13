import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details/functions/student_controller.dart';
import 'package:student_details/screens/edit_student.dart';
import 'package:student_details/widgets/custom_alert_dialogue.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int index;

  const StudentCard({
    super.key,
    required this.name,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    final student = studentController.students[index];

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: student.profileImagePath != null
                    ? MemoryImage(student.profileImagePath!)
                    : const AssetImage('assets/images/avatar-3814049_1280.webp')
                        as ImageProvider,
              ),
              const SizedBox(width: 20),
              Text(
                name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => EditStudent(
                        profile: student.profileImagePath,
                        name: student.name,
                        age: student.age,
                        email: student.email,
                        number: student.phoneNo,
                        batch: student.batch,
                        index: index,
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await Get.dialog(
                    CustomAlertDialogue(
                      title: const Text('Delete Student'),
                      content: const Text(
                          'Are you sure you want to delete this Student?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            studentController.deleteStudent(index);
                            Get.back();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
