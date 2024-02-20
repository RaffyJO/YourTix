import 'dart:math';

import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/seat_booking_page/methods/legend.dart';
import 'package:flix_id/presentation/pages/seat_booking_page/methods/movie_screen.dart';
import 'package:flix_id/presentation/pages/seat_booking_page/methods/seat_section.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();

    Random random = Random();
    int reservedNumber = random.nextInt(80) + 1;

    while (reservedSeats.length < 10) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(80) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              BackNavigationBar(
                transaction.theaterName!,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              movieScreen(context),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    seatSection(
                      seatNumbers: List.generate(40, (index) => index + 1),
                      onTap: onSeatTap,
                      seatStatusChecker: seatStatusChecker,
                    ),
                    seatSection(
                      seatNumbers: List.generate(40, (index) => index + 41),
                      onTap: onSeatTap,
                      seatStatusChecker: seatStatusChecker,
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              legend(),
              verticalSpace(40),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Column(
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          verticalSpace(2),
                          Text(
                            'Rp${selectedSeats.length * 35000}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: grey,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      width: 110,
                      child: Column(
                        children: [
                          const Text(
                            'Seats Selected',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          verticalSpace(2),
                          Text(
                            selectedSeats.length.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: (selectedSeats.isNotEmpty)
              ? ElevatedButton(
                  onPressed: () {
                    var updateTransaction = transaction.copyWith(
                      seats: (selectedSeats..sort()).map((e) => '$e').toList(),
                      ticketAmount: selectedSeats.length,
                      ticketPrice: 35000,
                    );

                    ref.read(routerProvider).pushNamed(
                      'booking-confirmation',
                      extra: (movieDetail, updateTransaction),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'BUY TICKET',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'BUY TICKET',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
        )
      ],
    ));
  }

  void onSeatTap(seatNumber) {
    if (!reservedSeats.contains(seatNumber)) {
      if (!selectedSeats.contains(seatNumber)) {
        setState(() {
          selectedSeats.add(seatNumber);
        });
      } else {
        setState(() {
          selectedSeats.remove(seatNumber);
        });
      }
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selected
          : SeatStatus.available;
}
