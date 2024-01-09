import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final double height;
  final double width;
  final String? imageUrl;
  final BoxFit? fit;
  final double borderRadius;
  final VoidCallback? onTap;

  const NetworkImageCard(
      {super.key,
      this.height = 258,
      this.width = 172,
      this.imageUrl,
      this.fit,
      this.borderRadius = 10,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.black54),
        child: Stack(
          children: [
            if (imageUrl != null)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (imageUrl != null)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl!), fit: fit)),
              )
          ],
        ),
      ),
    );
  }
}
