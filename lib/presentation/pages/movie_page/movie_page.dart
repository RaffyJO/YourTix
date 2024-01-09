import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/movie_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/promotion_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/search_bar.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/user_info.dart';
import 'package:flix_id/presentation/providers/movie/now_playing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionsImageFileNames = const [
    'https://www.qualads.com/wp-content/uploads/2019/05/free-printable-movie-tickets-free-printables.jpg',
    'https://thefilmstage.com/wp-content/uploads/2010/06/inception-20100608065705781.jpg'
  ];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          children: [
            userInfo(ref),
            verticalSpace(24),
            searchBar(context),
            verticalSpace(24),
            ...movieList(
                title: 'Now Showing', movies: ref.watch(nowPlayingProvider)),
            verticalSpace(30),
            ...promotionList(promotionsImageFileNames),
          ],
        )
      ],
    );
  }
}
