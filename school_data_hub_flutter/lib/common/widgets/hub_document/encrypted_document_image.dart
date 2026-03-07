import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/get_cached_image_or_download_inage.dart';
import 'package:widget_zoom/widget_zoom.dart';

class EncryptedDocumentImage extends WatchingWidget {
  /// Document id to load; when null, shows the standard placeholder.
  final String? documentId;

  final double size;
  const EncryptedDocumentImage({
    super.key,
    required this.documentId,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final boxSize = (21 / 30) * size;
    if (documentId == null) {
      return SizedBox(
        height: size,
        width: boxSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            'assets/document_camera.png',
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    final randomPart = createOnce(
      () => UniqueKey().toString(),
      dispose: (randomPart) {},
    );
    return SizedBox(
      height: size,
      width: boxSize,
      child: Center(
        child: Column(
          children: [
            WidgetZoom(
              heroAnimationTag: '$documentId$randomPart',
              zoomWidget: FutureBuilder<Image>(
                future: getCachedImageOrDownloadImage(
                  documentId: documentId!,
                  decrypt: true,
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
          ],
        ),
      ),
    );
  }
}
