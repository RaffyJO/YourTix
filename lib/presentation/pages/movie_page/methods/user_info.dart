import 'package:flix_id/presentation/extensions/int_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget userInfo(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${getGreeting()}, ${ref.watch(userDataProvider).when(data: (user) => user?.name.split(' ').first ?? '', error: (error, stackTrace) => '', loading: () => 'Loading...')}!',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Text(
                "Let's book and watch a movie!",
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              verticalSpace(5),
              GestureDetector(
                onTap: () {
                  // Go to wallet page
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.wallet,
                      size: 18,
                      color: Colors.black,
                    ),
                    horizontalSpace(10),
                    Text(
                      ref.watch(userDataProvider).when(
                          data: (user) =>
                              (user?.balance ?? 0).toIdrCurrencyFormat(),
                          error: (error, stackTrace) => 'IDR 0',
                          loading: () => 'Loading...'),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                border: Border.all(color: grey, width: 1),
                shape: BoxShape.circle,
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
        ],
      ),
    );

String getGreeting() {
  var hour = DateTime.now().hour;

  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
