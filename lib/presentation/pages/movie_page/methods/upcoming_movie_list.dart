import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> upcomingMovieList({
  required String title,
  void Function(Movie movie)? onTap,
  required AsyncValue<List<Movie>> movies,
}) {
  return [
    Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
    SizedBox(
      height: 308,
      child: movies.when(
        data: (data) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: data
                .map((movie) => Padding(
                      padding: EdgeInsets.only(
                        left: movie == data.first ? 24 : 15,
                        right: movie == data.last ? 24 : 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NetworkImageCard(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            fit: BoxFit.contain,
                            onTap: () => onTap?.call(movie),
                          ),
                          verticalSpace(8),
                          SizedBox(
                            width: 172,
                            child: Text(
                              truncateText(movie.title, 40),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        error: (error, stackTrace) => const SizedBox(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  ];
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength).trim()}...';
}
