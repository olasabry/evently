import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  String label;
  IconData icon;
  bool isSelected;
  Color selectedForegroundColor;
  Color unselectedForegroundColor;
  Color selectedbackgroundColor;

  TabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedForegroundColor,
    required this.unselectedForegroundColor,
    required this.selectedbackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? selectedbackgroundColor : Colors.transparent,
        border: isSelected
            ? null
            : Border.all(color: unselectedForegroundColor),
        borderRadius: BorderRadius.circular(46),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected
                ? selectedForegroundColor
                : unselectedForegroundColor,
          ),

          SizedBox(width: 8),

          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: isSelected
                  ? selectedForegroundColor
                  : unselectedForegroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
