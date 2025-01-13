import 'dart:typed_data';

import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final Uint8List? profile;
  final String name;
  final int age;
  final int phoneNo;
  final String email;
  final String batch;
  const StudentDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.phoneNo,
      required this.email,
      required this.batch,
      required this.profile});

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = [
      age,
      batch,
      phoneNo,
      email,
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 60,
              top: 150,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: profile != null
                        ? MemoryImage(profile!)
                        : const AssetImage(
                                'assets/images/avatar-3814049_1280.webp')
                            as ImageProvider,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 230,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: values.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      maxLines: 2,
                                      // softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      values[index].toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
