import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(
      {Key? key,
      required this.text,
      required this.imagePath,
      this.onTap,
      this.color = Colors.blue,
      required this.textColor})
      : super(key: key);

  final String text;
  final String imagePath;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
