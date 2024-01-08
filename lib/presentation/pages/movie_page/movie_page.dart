import 'package:flix_id/presentation/pages/movie_page/methods/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionsImageFileNames = const ['asasas', 'asasas'];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          children: [userInfo(ref)],
        )
      ],
    );
  }
}
