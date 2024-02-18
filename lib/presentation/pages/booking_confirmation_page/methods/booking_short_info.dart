import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Widget> bookingShortInfo(
        {required Transaction transactionDetail,
        required MovieDetail movieDetail,
        required BuildContext context}) =>
    [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 48 - 152 - 15,
            child: Text(
              transactionDetail.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          verticalSpace(3),
          Text(
            transactionDetail.theaterName.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          verticalSpace(5),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 20,
                color: Colors.yellow[700],
              ),
              horizontalSpace(2),
              Text(
                movieDetail.voteAvarage != 0
                    ? (movieDetail.voteAvarage).toStringAsFixed(1)
                    : 0.toString(),
                style: TextStyle(
                    color: Colors.yellow[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              )
            ],
          ),
          verticalSpace(5),
          SizedBox(
            width: MediaQuery.of(context).size.width - 48 - 152 - 15,
            child: Text(
              DateFormat('EEEE, d MMM y').format(
                DateTime.fromMicrosecondsSinceEpoch(
                    transactionDetail.watchingTime ?? 0),
              ),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          verticalSpace(5),
          SizedBox(
            width: MediaQuery.of(context).size.width - 48 - 152 - 15,
            child: Text(
              DateFormat('HH:00 WIB').format(
                DateTime.fromMicrosecondsSinceEpoch(
                    transactionDetail.watchingTime ?? 0),
              ),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      )
    ];
