import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double sizeText;
  final FontWeight fontWeight;
  const ButtonLogin({
    super.key, 
    required this.label, 
    required this.onPressed, 
    required this.backgroundColor, 
    required this.textColor, 
    required this.sizeText, required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Radio de los bordes
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(label,
        style: TextStyle(color: textColor,
          fontSize: sizeText,
          fontWeight: fontWeight
        ),
        
      ),
    );
  }
}
