import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';

class BackNavigationBar extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const BackNavigationBar(this.title, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: const SizedBox(
            child: Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        horizontalSpace(20),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50 - 48,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        )
      ],
    );
  }
}
