import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

List<Widget> movieShortInfo(
        {required AsyncValue<MovieDetail?> asyncMovieDetail,
        required BuildContext context}) =>
    [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 48 - 152 - 15,
            child: Text(
              asyncMovieDetail.when(
                data: (movieDetail) =>
                    movieDetail != null ? movieDetail.title : '-',
                error: (error, stackTrace) => '-',
                loading: () => '-',
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          verticalSpace(5),
          Row(
            children: [
              const SizedBox(
                width: 67,
                child: Text(
                  'Duration',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              horizontalSpace(20),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width - 48 - 152 - 15 - 20 - 67,
                child: Text(
                  '${asyncMovieDetail.when(
                    data: (movieDetail) =>
                        movieDetail != null ? movieDetail.runTime : '-',
                    error: (error, stackTrace) => '-',
                    loading: () => '-',
                  )} minutes',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ],
          ),
          verticalSpace(2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 67,
                child: Text(
                  'Genres',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              horizontalSpace(20),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width - 48 - 152 - 15 - 20 - 67,
                child: asyncMovieDetail.when(
                  data: (movieDetail) {
                    String genres = movieDetail?.genres.join(', ') ?? '-';
                    return Text(
                      genres,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    );
                  },
                  error: (error, stackTrace) => const Text('-'),
                  loading: () => const Text('-'),
                ),
              ),
            ],
          ),
          verticalSpace(2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 67,
                child: Text(
                  'Rating',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              horizontalSpace(20),
              Text(
                (asyncMovieDetail.valueOrNull?.voteAvarage ?? 0)
                    .toStringAsFixed(1),
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ],
      )
    ];
