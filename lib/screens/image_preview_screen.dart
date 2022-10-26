import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  final String? imageUrl;
  const ImagePreview({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: PhotoView(
        enableRotation: false,
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        imageProvider: NetworkImage(imageUrl!),
      ),
    );
  }
}
