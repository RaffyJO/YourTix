import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/transaction.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/booking_confirmation_page/methods/booking_short_info.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecases/create_transaction_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({required this.transactionDetail, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: BackNavigationBar(
                    'Booking Confirmation',
                    onTap: () => ref.read(routerProvider).pop(),
                  ),
                ),
                verticalSpace(24),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NetworkImageCard(
                        height: 168,
                        width: 112,
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movieDetail.posterPath}',
                        fit: BoxFit.cover,
                      ),
                      horizontalSpace(15),
                      ...bookingShortInfo(
                        transactionDetail: transaction,
                        context: context,
                        movieDetail: movieDetail,
                      )
                    ],
                  ),
                ),
                verticalSpace(18),
                const Divider(
                  color: grey,
                  thickness: 0.5,
                ),
                verticalSpace(10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${transaction.seats.length} Ticket(s)',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            transaction.seats.join(', '),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      verticalSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ticket Price',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Rp${transaction.ticketPrice}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      verticalSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Admin Fee',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Rp${transaction.adminFee}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const Text(
                        'To help improve our services',
                        style: TextStyle(
                          color: grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                const Divider(
                  color: grey,
                  thickness: 0.5,
                ),
                verticalSpace(10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '* Ticket purchases cannot be changed/cancelled.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      verticalSpace(2),
                      const Text(
                        '* Children aged 2 years and over must purchase a ticket.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      verticalSpace(2),
                      const Text(
                        '* It is prohibited to bring food and drinks from outside.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/banner-popcorn.jpg',
                      width: double.infinity,
                      height: 160.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                verticalSpace(15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Rp${transaction.total}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: ElevatedButton(
              onPressed: () async {
                int transactionTime = DateTime.now().microsecondsSinceEpoch;

                transaction = transaction.copyWith(
                  transactionTime: transactionTime,
                  id: 'flx-$transactionTime-${transaction.uid}',
                );

                CreateTransaction createTransaction =
                    ref.read(createTransactionProvider);

                await createTransaction(
                        CreateTransactionParam(transaction: transaction))
                    .then((result) {
                  switch (result) {
                    case Success(value: _):
                      ref
                          .read(transactionDataProvider.notifier)
                          .refreshTransactionData();
                      ref.read(userDataProvider.notifier).refreshUserData();
                      ref.read(routerProvider).pushReplacementNamed('main');
                    case Failed(:final message):
                      context.showSnackBar(message);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: backgroundColor,
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'PAY NOW',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
