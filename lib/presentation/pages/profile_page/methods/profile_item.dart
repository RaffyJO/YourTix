import 'package:flutter/material.dart';

Widget profileItem(String tittle, {VoidCallback? onTap}) => GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: const TextStyle(color: Colors.black),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
