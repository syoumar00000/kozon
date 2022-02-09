import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String? initiales;
  final double? radius;
  const CustomImage({Key? key, this.imageUrl, this.initiales, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: radius ?? 0.0,
        backgroundColor: Colors.blue,
        child: Text(
          initiales ?? "",
          style: TextStyle(color: Colors.white, fontSize: radius),
        ),
      );
    } else {
      ImageProvider provider = CachedNetworkImageProvider(imageUrl!);
      if (radius == null) {
        //images dans le chat
        return InkWell(
          child: Image(
            image: provider,
            width: 250,
          ),
          onTap: () {
            // monter l'image en grand
          },
        );
      } else {
        //images dans profil
        return InkWell(
          child: CircleAvatar(
            radius: radius,
            backgroundImage: provider,
          ),
          onTap: () {
            // aggrandir l'image
          },
        );
      }
    }
  }
}
