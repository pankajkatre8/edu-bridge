import 'package:flutter/material.dart';

enum CustomButtonStyle { filled, outline }

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final CustomButtonStyle style;
  final Widget? icon;
  final Color textColor;
  final Color backgroundColor;
  final double elevation;
  final double borderRadius;
  final Color borderColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.style = CustomButtonStyle.filled,
    this.icon,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.elevation = 0,
    this.borderRadius = 8,
    this.borderColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: style == CustomButtonStyle.filled
            ? backgroundColor
            : Colors.transparent,
        foregroundColor: style == CustomButtonStyle.filled
            ? textColor
            : borderColor,
        elevation: elevation,
        side: style == CustomButtonStyle.outline
            ? BorderSide(color: borderColor, width: 1)
            : null,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                if (icon != null) const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: style == CustomButtonStyle.filled
                        ? textColor
                        : borderColor,
                  ),
                ),
              ],
            ),
    );
  }
}