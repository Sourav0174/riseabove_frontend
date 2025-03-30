import 'package:flutter/material.dart';

class FeelingButton extends StatelessWidget {
  final String label;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const FeelingButton({
    super.key,
    required this.label,
    required this.image,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(4, 4),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  offset: const Offset(-4, -4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Image.asset(image, height: 40, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
