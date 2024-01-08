import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final double height;
  final double width;
  final String? imageUrl;
  final BoxFit? fit;
  final double borderRadius;
  final VoidCallback? ontap;

  const NetworkImageCard(
      {super.key,
      this.height = 150,
      this.width = 228,
      this.imageUrl,
      this.fit,
      this.borderRadius = 10,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
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
