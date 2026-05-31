import 'package:flutter/material.dart';

class MoodCard extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const MoodCard({
    super.key,
    required this.emoji,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(emoji, style: TextStyle(
            fontSize: 24,
            color: isSelected ? null : const Color(0x99FFFFFF),
          )),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 9,
              color: Colors.white.withValues(alpha: isSelected ? 0.8 : 0.35),
            ),
          ),
        ],
      ),
    );
  }
}
