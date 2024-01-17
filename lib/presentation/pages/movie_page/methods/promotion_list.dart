import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<Widget> promotionList(List<String> promotionImageFileName) => [
      CarouselSlider.builder(
        itemCount: promotionImageFileName.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    promotionImageFileName[itemIndex],
                    width: double.infinity,
                    height: 160.0,
                    fit: BoxFit.cover,
                  ),
                )),
        options: CarouselOptions(
            height: 160,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 2.0,
            initialPage: 2,
            autoPlayInterval: const Duration(seconds: 3)),
      )
    ];
