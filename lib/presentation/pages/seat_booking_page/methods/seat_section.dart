import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';

Widget seatSection({
  required List<int> seatNumbers,
  required void Function(int seatNumber) onTap,
  required SeatStatus Function(int seatNumber) seatStatusChecker,
}) =>
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 200,
        child: Row(
          children: [
            horizontalSpace(5),
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
            ),
          ],
        ),
      ),
    );
