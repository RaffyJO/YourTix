import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/warp_card.dart';
import 'package:flutter/material.dart';

List<Widget> optionTime<T>({
  required String title,
  required List<T> options,
  required T? selectedItem,
  String Function(T object)? converter,
  bool Function(T object)? isOptionEnable,
  required void Function(T object) onTap,
}) =>
    [
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(10),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: options.map((e) {
          return WarpCard(
            text: converter != null ? converter(e) : e.toString(),
            isSelected: e == selectedItem,
            isEnable: isOptionEnable?.call(e) ?? true,
            onTap: () => onTap(e),
          );
        }).toList(),
      ),
    ];
