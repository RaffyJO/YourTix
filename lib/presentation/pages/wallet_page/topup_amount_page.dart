import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/input_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TopUpAmountPage extends ConsumerStatefulWidget {
  const TopUpAmountPage({
    super.key,
  });

  @override
  ConsumerState<TopUpAmountPage> createState() => _TopUpAmountPageState();
}

class _TopUpAmountPageState extends ConsumerState<TopUpAmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();

    amountController.addListener(() {
      final text = amountController.text;

      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(
          locale: 'id',
          decimalDigits: 0,
          symbol: '',
        ).format(
          int.parse(
            text.replaceAll('.', ''),
          ),
        ),
      );
    });
  }

  addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
        if (amountController.text == '') {
          amountController.text = '0';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 58,
          ),
          children: [
            verticalSpace(70),
            const Center(
              child: Text(
                'Total Amount',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 62,
            ),
            Align(
              child: SizedBox(
                width: 240,
                child: TextFormField(
                  controller: amountController,
                  cursorColor: grey,
                  enabled: false,
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: const InputDecoration(
                    prefixIcon: Text(
                      'Rp ',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 66,
            ),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                spacing: 40,
                runSpacing: 40,
                children: [
                  CustomInputButton(
                    title: '1',
                    onTap: () {
                      addAmount('1');
                    },
                  ),
                  CustomInputButton(
                    title: '2',
                    onTap: () {
                      addAmount('2');
                    },
                  ),
                  CustomInputButton(
                    title: '3',
                    onTap: () {
                      addAmount('3');
                    },
                  ),
                  CustomInputButton(
                    title: '4',
                    onTap: () {
                      addAmount('4');
                    },
                  ),
                  CustomInputButton(
                    title: '5',
                    onTap: () {
                      addAmount('5');
                    },
                  ),
                  CustomInputButton(
                    title: '6',
                    onTap: () {
                      addAmount('6');
                    },
                  ),
                  CustomInputButton(
                    title: '7',
                    onTap: () {
                      addAmount('7');
                    },
                  ),
                  CustomInputButton(
                    title: '8',
                    onTap: () {
                      addAmount('8');
                    },
                  ),
                  CustomInputButton(
                    title: '9',
                    onTap: () {
                      addAmount('9');
                    },
                  ),
                  const SizedBox(
                    width: 60,
                    height: 60,
                  ),
                  CustomInputButton(
                    title: '0',
                    onTap: () {
                      addAmount('0');
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      deleteAmount();
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    var amount = int.tryParse(
                            amountController.text.replaceAll('.', '')) ??
                        0;

                    ref.read(userDataProvider.notifier).topup(amount: amount);
                    ref.read(routerProvider).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            verticalSpace(50)
          ],
        ));
  }
}
