import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> userInfo(WidgetRef ref) => [
      Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: grey, width: 1),
                image: DecorationImage(
                    image: ref.watch(userDataProvider).valueOrNull?.photoUrl !=
                            null
                        ? NetworkImage(ref
                            .watch(userDataProvider)
                            .valueOrNull!
                            .photoUrl!) as ImageProvider
                        : const AssetImage('assets/user-profile.png'),
                    fit: BoxFit.cover)),
          ),
          horizontalSpace(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ref.watch(userDataProvider).valueOrNull?.name ?? '',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                ref.watch(userDataProvider).valueOrNull?.email ?? '',
                style: const TextStyle(fontSize: 13, color: Colors.black),
              )
            ],
          )
        ],
      ),
    ];
