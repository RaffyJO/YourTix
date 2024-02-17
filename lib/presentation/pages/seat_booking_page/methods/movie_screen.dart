import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

Widget movieScreen(context) => Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.only(top: 24, bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [blue.withOpacity(0.23), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 3,
          color: blue,
        ),
      ),
    );
