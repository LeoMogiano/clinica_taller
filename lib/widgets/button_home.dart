import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const ButtonHome({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.width,
    required this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              spreadRadius: 20,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
