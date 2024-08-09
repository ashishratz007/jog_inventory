import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';


/// [viewImage] This widget will display image according to its given path will work for asset, svg and network image
void viewImage(BuildContext context, String, imagePath) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        return ImageViewer(imagePath: imagePath);
      });
}

/// [ImageType] defines the types of images you are dealing with
enum ImageType { asset, svg, network }

class ImageViewer extends StatelessWidget {
  final String imagePath;
  ImageViewer({required this.imagePath});

  /// get image type from its path
  ImageType get imageType {
    if (imagePath.startsWith('http')) {
      return ImageType.network;
    } else if (imagePath.endsWith('.svg')) {
      return ImageType.svg;
    } else {
      return ImageType.asset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        child: Center(
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    switch (imageType) {
      case ImageType.asset:
        return _buildAssetImage();
      case ImageType.svg:
        return _buildSvgImage();
      case ImageType.network:
        return _buildNetworkImage();
      default:
        return _buildErrorImage();
    }
  }

  Widget _buildAssetImage() {
    return PhotoView(
      backgroundDecoration:
          BoxDecoration(color: Colors.grey.shade50.withOpacity(0.7)),
      imageProvider: AssetImage(imagePath),
      errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  }

  Widget _buildSvgImage() {
    return PhotoView.customChild(
      backgroundDecoration:
          BoxDecoration(color: Colors.grey.shade50.withOpacity(0.7)),
      child: SvgPicture.asset(
        imagePath,
        placeholderBuilder: (context) =>
            Center(child: CircularProgressIndicator()),
        height: 300,
        width: 300,
      ),
      // errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  }

  Widget _buildNetworkImage() {
    return PhotoView(
      backgroundDecoration:
          BoxDecoration(color: Colors.grey.shade500.withOpacity(0.7)),
      imageProvider: CachedNetworkImageProvider(
        imagePath,
        // errorListener: () => print('Network image failed to load.'),
      ),
      loadingBuilder: (context, event) => Center(
        child: CircularProgressIndicator(),
      ),
      errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
    );
  }

  Widget _buildErrorImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red, size: 50),
        SizedBox(height: 10),
        Text(
          'Image loading failed',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      ],
    );
  }
}
