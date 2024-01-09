import 'package:carousel_slider/carousel_slider.dart';
import 'package:flix_id/domain/entities/movie.dart';
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
    // SizedBox(
    //   height: 228,
    //   child: movies.when(
    //     data: (data) => SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         children: data
    //             .map((movie) => Padding(
    //                   padding: EdgeInsets.only(
    //                     left: movie == data.first ? 24 : 10,
    //                     right: movie == data.last ? 24 : 0,
    //                   ),
    //                   child: NetworkImageCard(
    //                     imageUrl:
    //                         'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
    //                     fit: BoxFit.contain,
    //                     onTap: () => onTap?.call(movie),
    //                   ),
    //                 ))
    //             .toList(),
    //       ),
    //     ),
    //     error: (error, stackTrace) => const SizedBox(),
    //     loading: () => const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // ),
    SizedBox(
      height: 258,
      child: movies.when(
        data: (data) => CarouselSlider.builder(
          itemCount: data.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            final Movie movie = data[itemIndex];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: NetworkImageCard(
                imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                fit: BoxFit.contain,
                onTap: () => onTap?.call(movie),
              ),
            );
          },
          options: CarouselOptions(
            height: 258,
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
