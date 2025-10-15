import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType { asset, svg, network }

class ImageWidget extends StatelessWidget {
  final ImageType type;
  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ImageWidget({
    super.key,
    required this.path,
    this.type = ImageType.asset,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget image;
    switch (type) {
      case ImageType.asset:
        image = Image.asset(
          path,
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (_, __, ___) => errorWidget ?? _defaultErrorWidget(),
        );
        break;

      case ImageType.svg:
        if (path.startsWith('http')) {
          image = SvgPicture.network(
            path,
            height: height,
            width: width,
            fit: fit,
            placeholderBuilder: (_) => placeholder ?? _defaultPlaceholder(),
          );
        } else {
          image = SvgPicture.asset(
            path,
            height: height,
            width: width,
            fit: fit,
          );
        }
        break;

      case ImageType.network:
        image = Image.network(
          path,
          height: height,
          width: width,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return placeholder ?? _defaultPlaceholder();
          },
          errorBuilder: (_, __, ___) => errorWidget ?? _defaultErrorWidget(),
        );
        break;
    }

    return image;
  }

  Widget _defaultPlaceholder() => Center(
    child: SizedBox(
      height: 24.w.clamp(20, 30),
      width: 24.w.clamp(20, 30),
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  );

  Widget _defaultErrorWidget() =>
      const Icon(Icons.broken_image, color: Colors.grey);
}
