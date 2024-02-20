import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/pages/wallet_page/methods/card_content.dart';
import 'package:flix_id/presentation/pages/wallet_page/methods/membership_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget walletCard(WidgetRef ref) => Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          membershipTag(),
          cardContent(ref),
        ],
      ),
    );
