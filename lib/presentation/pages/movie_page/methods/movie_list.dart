import 'package:carousel_slider/carousel_slider.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> movieList({
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
      height: 328,
      child: movies.when(
        data: (data) => CarouselSlider.builder(
          itemCount: data.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            final Movie movie = data[itemIndex];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  NetworkImageCard(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                    fit: BoxFit.contain,
                    onTap: () => onTap?.call(movie),
                  ),
                  verticalSpace(8),
                  Center(
                    child: SizedBox(
                      width: 172,
                      child: Text(
                        truncateText(movie.title, 40),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 328,
            autoPlay: false,
            enlargeCenterPage: false,
            viewportFraction: 0.5, // Setel sesuai kebutuhan Anda
            aspectRatio: 2.0,
            initialPage: 2,
            scrollDirection: Axis.horizontal,
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
