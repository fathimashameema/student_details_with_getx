import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_details/functions/student_controller.dart';
import 'package:student_details/screens/add_student.dart';
import 'package:student_details/screens/student_details.dart';
import 'package:student_details/widgets/add_students_field.dart';
import 'package:student_details/widgets/search_form_field.dart';
import 'package:student_details/widgets/student_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Student Details 📝',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            CustomSearchFormField(
              onSearch: studentController.filterStudents,
            ),
            AddStudentsField(
              navigateTo: AddStudent(),
            ),
            Expanded(
              child: Obx(
                () {
                  if (studentController.isLoading.value) {
                    return ListView.builder(
                      itemCount: studentController.filteredStudents.length,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.3),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (studentController.students.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Students are added yet!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (studentController.filteredStudents.isEmpty) {
                    return const Center(
                      child: Text(
                        'No matches found!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: studentController.filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student =
                            studentController.filteredStudents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentDetails(
                                  profile: student.profileImagePath,
                                  name: student.name,
                                  batch: student.batch,
                                  age: student.age,
                                  phoneNo: student.phoneNo,
                                  email: student.email,
                                ),
                              ),
                            );
                          },
                          child: StudentCard(
                            index: index,
                            name: student.name,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
