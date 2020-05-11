import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

abstract class PictureWidget extends StatelessWidget {
  static PictureWidget fromUrl({@required String imageUrl, BoxFit fit}) {
    // TODO: Implement proper image caching and retrieval
    return _SimpleImageWidget(
      imageUrl: imageUrl,
      fit: fit,
    );
  }
}

class _SimpleImageWidget extends PictureWidget {
  final String imageUrl;
  final BoxFit fit;

  _SimpleImageWidget({@required this.imageUrl, this.fit});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      fit: fit ?? null,
      placeholder: kTransparentImage,
      image: imageUrl,
    );
  }
}
