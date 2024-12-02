import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;

  const ActionButton({
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.width =
        double.infinity, // Розширення на всю ширину контейнера за замовчуванням
    this.height = 50, // Висота кнопки за замовчуванням
    this.borderRadius = 24, // Радиус округлення кнопки за замовчуванням
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
          elevation: 5, // Додає ефект натискання
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.bold, // Може бути змінено на інші стилі
          ),
        ),
      ),
    );
  }
}
