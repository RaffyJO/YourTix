import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

List<Widget> options<T>({
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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(right: e == options.last ? 0 : 10),
                  child: SelectableCard(
                    text: converter != null ? converter(e) : e.toString(),
                    isSelected: e == selectedItem,
                    isEnable: isOptionEnable?.call(e) ?? true,
                    onTap: () => onTap(e),
                  ),
                ),
              )
              .toList(),
        ),
      )
    ];
