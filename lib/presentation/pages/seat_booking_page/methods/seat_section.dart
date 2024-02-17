import 'package:flix_id/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';

Widget seatSection({
  required List<int> seatNumbers,
  required void Function(int seatNumber) onTap,
  required SeatStatus Function(int seatNumber) seatStatusChecker,
}) =>
    SizedBox(
      height: 390,
      width: 150,
      child: Wrap(
        spacing: 9,
        runAlignment: WrapAlignment.spaceBetween,
        direction: Axis.vertical,
        children: seatNumbers
            .map(
              (number) => Seat(
                number: number,
                status: seatStatusChecker(number),
                onTap: () => onTap(number),
              ),
            )
            .toList(),
      ),
    );
