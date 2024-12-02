import 'package:flutter/material.dart';

class UserInfoBlock extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onEditName;
  final VoidCallback onEditEmail;
  final double avatarSize;
  final Color avatarColor;
  final Color textColor;
  final Color iconColor;

  const UserInfoBlock({
    required this.userName,
    required this.userEmail,
    required this.onEditName,
    required this.onEditEmail,
    this.avatarSize = 50,
    this.avatarColor = Colors.indigo,
    this.textColor = Colors.white,
    this.iconColor = Colors.white70,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: avatarSize,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: avatarSize - 5, // Для тоншого обрамлення
            backgroundColor: avatarColor,
            child: Text(
              userName.isNotEmpty ? userName[0].toUpperCase() : '?',
              style: TextStyle(
                color: textColor,
                fontSize:
                    avatarSize * 0.6, // Масштабування шрифта під розмір аватара
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: onEditName,
                  style: IconButton.styleFrom(
                    foregroundColor: iconColor, // Колір значка
                  ),
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 16,
                    color: iconColor,
                  ),
                ),
                IconButton(
                  onPressed: onEditEmail,
                  style: IconButton.styleFrom(
                    foregroundColor: iconColor, // Колір значка
                  ),
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
