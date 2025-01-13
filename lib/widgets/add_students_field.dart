import 'package:flutter/material.dart';

class AddStudentsField extends StatelessWidget {
  final Widget navigateTo;
  const AddStudentsField({super.key, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 270,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => navigateTo));
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              'Add Student',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
