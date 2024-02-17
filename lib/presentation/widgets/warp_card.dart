import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class WarpCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isEnable;

  Color colorCek(bool isSelected, bool isEnable) {
    if (isEnable == true) {
      if (isSelected == true) {
        return Colors.white;
      } else {
        return blue;
      }
    } else {
      return grey;
    }
  }

  const WarpCard(
      {super.key,
      required this.text,
      required this.onTap,
      this.isSelected = false,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? blue : null,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isEnable ? blue : grey),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorCek(isSelected, isEnable),
            ),
          ),
        ),
      ),
    );
  }
}
