import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/movie_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/promotion_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/search_bar.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/upcoming_movie_list.dart';
import 'package:flix_id/presentation/pages/movie_page/methods/user_info.dart';
import 'package:flix_id/presentation/providers/movie/now_playing_provider.dart';
import 'package:flix_id/presentation/providers/movie/upcoming_provider.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionsImageFileNames = const [
    'https://discountsales.ae/wp-content/uploads/2016/11/ADCB-voxcinema-discount-sales-ae.jpg',
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
                title: 'Now Showing',
                movies: ref.watch(nowPlayingProvider),
                onTap: (movie) {
                  ref.read(routerProvider).pushNamed('detail', extra: movie);
                }),
            verticalSpace(0),
            ...promotionList(promotionsImageFileNames),
            verticalSpace(24),
            ...upcomingMovieList(
                title: 'Coming Soon', movies: ref.watch(upcomingProvider)),
            verticalSpace(80)
          ],
        )
      ],
    );
  }
}
