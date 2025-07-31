import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart,
              size: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
            SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}