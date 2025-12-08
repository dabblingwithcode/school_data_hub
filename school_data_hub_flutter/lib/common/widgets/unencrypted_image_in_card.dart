import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/cached_image_or_download_inage.dart';
import 'package:widget_zoom/widget_zoom.dart';

class UnencryptedImageInCard extends StatelessWidget {
  final String cacheKey;
  final String path;
  final double size;
  const UnencryptedImageInCard({
    required this.cacheKey,
    required this.path,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: (21 / 30) * size,
      child: Center(
        child: WidgetZoom(
          heroAnimationTag: cacheKey,
          zoomWidget: FutureBuilder<Image>(
            future: cachedPublicImageOrDownloadPublicImage(
              path: path,
              cacheKey: cacheKey,
            ),
            builder: (context, snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while the future is not complete
                child = SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: AppColors.backgroundColor,
                  ),
                );
              } else if (snapshot.hasError) {
                // Display an error message if the future encounters an error
                child = Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.orange),
                );
              } else {
                // Display the result when the future is complete
                child = ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: snapshot.data!,
                );
              }
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
