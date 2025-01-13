import 'package:flutter/material.dart';

class CustomAlertDialogue extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final Color backgroundColor = const Color(0xFF3F3E3E);
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;

  const CustomAlertDialogue({
    super.key,
    this.title,
    this.content,
    this.titleTextStyle,
    this.contentTextStyle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      backgroundColor: backgroundColor,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.w400,
      ),
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }
}
