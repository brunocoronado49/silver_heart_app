import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(
      {Key? key,
      required this.text,
      required this.imagePath,
      required this.onTap,
      this.color = Colors.blueGrey,
      this.textColor = Colors.white})
      : super(key: key);

  final String text;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
