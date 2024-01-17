import 'package:flutter/material.dart';

Widget searchBar(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width - 24 - 24,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(25),
          border: Border.all()),
      child: const TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Search for a movie',
            border: InputBorder.none,
            icon: Icon(Icons.search)),
      ),
    );
