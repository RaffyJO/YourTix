import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/time_booking_page/methods/option_time.dart';
import 'package:flix_id/presentation/pages/time_booking_page/methods/options.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;

  const TimeBookingPage(this.movieDetail, {super.key});

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'Bekasi Cyber Park CGV',
    'Blu Plaza Cinepolis',
    'Mega Bekasi XXI',
    'Pondok Gede XXI'
  ];

  final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  final List<int> hours = List.generate(6, (index) => index + 12);

  String? selectedTheater;
  DateTime? selectedDate;
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackNavigationBar(
                widget.movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              verticalSpace(24),
              NetworkImageCard(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.width - 48) * 0.6,
                borderRadius: 15,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${widget.movieDetail.backdropPath ?? widget.movieDetail.posterPath}',
                fit: BoxFit.cover,
              ),
              verticalSpace(24),
              ...options(
                title: 'Theater',
                options: theaters,
                selectedItem: selectedTheater,
                onTap: ((object) => setState(
                      () {
                        selectedTheater = object;
                      },
                    )),
              ),
              verticalSpace(20),
              ...options(
                title: 'Date',
                options: dates,
                selectedItem: selectedDate,
                converter: (date) => DateFormat('EEE, d MMM').format(date),
                onTap: ((object) => setState(
                      () {
                        selectedDate = object;
                      },
                    )),
              ),
              verticalSpace(20),
              ...optionTime(
                title: 'Show Time',
                options: hours,
                selectedItem: selectedHour,
                isOptionEnable: (hour) =>
                    selectedDate != null &&
                    DateTime(selectedDate!.year, selectedDate!.month,
                            selectedDate!.day, hour)
                        .isAfter(
                      DateTime.now(),
                    ),
                converter: (object) => '$object:00',
                onTap: ((object) => setState(
                      () {
                        selectedHour = object;
                      },
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: ElevatedButton(
            onPressed: () {
              if (selectedTheater == null ||
                  selectedDate == null ||
                  selectedHour == null) {
                context.showSnackBar('Please select all options');
              } else {
                Transaction transaction = Transaction(
                    uid: ref.read(userDataProvider).value!.uid,
                    title: widget.movieDetail.title,
                    adminFee: 3000,
                    total: 0,
                    watchingTime: DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedHour!)
                        .microsecondsSinceEpoch,
                    transactionImage: widget.movieDetail.posterPath,
                    theaterName: selectedTheater!);

                ref.read(routerProvider).pushNamed('seat-booking',
                    extra: (widget.movieDetail, transaction));
              }
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
          ),
        )
      ],
    ));
  }
}
