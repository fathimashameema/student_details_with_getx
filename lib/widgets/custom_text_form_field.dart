// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final TextInputType? keybordType;
//   final String? Function(String?)? validator;
//   const CustomTextFormField(
//       {super.key,
//       required this.hintText,
//       required this.controller,
//       this.keybordType,
//       this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 30.0,
//         right: 30,
//         top: 20,
//         bottom: 10,
//       ),
//       child: TextFormField(
//         keyboardType: keybordType,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return " $hintText field can't be empty";
//           }

//           return null;
//         },
//         controller: controller,
//         // showCursor: false,
//         cursorColor: Colors.grey,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           fillColor: Colors.grey.withOpacity(0.2),
//           filled: true,
//           enabledBorder: OutlineInputBorder(
//             // borderSide: const BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide:
//                 const BorderSide(color: Color.fromARGB(255, 89, 88, 88)),
//           ),
//           hintText: (hintText),
//           hintStyle: TextStyle(
//             fontSize: 15,
//             color: Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "$hintText field can't be empty";
              }
              return null;
            },
        controller: controller,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 89, 88, 88)),
          ),
          enabledBorder: OutlineInputBorder(
            // borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
