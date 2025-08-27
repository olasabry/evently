import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;

  DefaultElevatedButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      child: Text(label, style: Theme.of(context).textTheme.titleLarge),

      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
      ),
    );
  }
}
