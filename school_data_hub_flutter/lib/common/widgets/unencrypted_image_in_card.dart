import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/get_image_cached_or_download.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:widget_zoom/widget_zoom.dart';

enum UnencryptedImageType { book, workbook }

class UnencryptedImageInCard extends WatchingWidget {
  final String cacheKey;
  final String path;
  final double size;
  final UnencryptedImageType type;

  /// When false, the widget is display-only (no built-in long-press upload).
  /// Use this when the parent widget provides its own upload/delete gestures.
  final bool enableBuiltInUpload;

  const UnencryptedImageInCard({
    required this.cacheKey,
    required this.path,
    required this.size,
    required this.type,
    this.enableBuiltInUpload = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final refreshState = createOnce(() => ValueNotifier(0));
    final lastPath = createOnce(() => ValueNotifier(path));
    final randomPart = createOnce(
      () => UniqueKey().toString(),
      dispose: (randomPart) => (),
    );
    // Watch refreshState so rebuilds happen when it changes
    watch(refreshState);

    final imageFuture = createOnce(
      () => ValueNotifier(
        _loadImage(path, cacheKey),
      ),
    );

    // Re-fetch when path changes (e.g. after image upload updates the model)
    if (lastPath.value != path) {
      lastPath.value = path;
      imageFuture.value = _clearCacheAndReload(path, cacheKey);
    }

    // Update the future when refresh changes (for built-in upload path)
    registerHandler(
      target: refreshState,
      handler: (context, value, cancel) {
        imageFuture.value = _clearCacheAndReload(path, cacheKey);
      },
    );

    final imageWidget = WidgetZoom(
      heroAnimationTag: '$cacheKey$randomPart',
      zoomWidget: FutureBuilder<Image>(
        future: watch(imageFuture).value,
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.connectionState == ConnectionState.waiting) {
            child = SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: AppColors.backgroundColor,
              ),
            );
          } else if (snapshot.hasError) {
            child = Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.orange),
            );
          } else {
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
    );

    return SizedBox(
      height: size,
      width: (21 / 30) * size,
      child: Center(
        child: enableBuiltInUpload
            ? InkWell(
                onLongPress: () async {
                  final File? file = await createAndCropImageFile(context);
                  if (file == null) return;

                  await di<DefaultCacheManager>().removeFile(cacheKey);
                  if (type == UnencryptedImageType.book) {
                    await di<BookManager>().updateBookImage(
                      file: file,
                      isbn: int.tryParse(cacheKey)!,
                    );
                  }
                  if (type == UnencryptedImageType.workbook) {
                    await di<WorkbookManager>().postWorkbookFile(
                      file,
                      int.tryParse(cacheKey)!,
                    );
                  }
                  refreshState.value++;
                },
                child: imageWidget,
              )
            : imageWidget,
      ),
    );
  }

  /// Load image from cache or download.
  static Future<Image> _loadImage(String path, String cacheKey) {
    if (path.isEmpty) {
      return Future.value(Image.asset('assets/dummy-profile-pic.png'));
    }
    return cachedPublicImageOrDownloadPublicImage(
      path: path,
      cacheKey: cacheKey,
    );
  }

  /// Clear cached image and re-download.
  static Future<Image> _clearCacheAndReload(
    String path,
    String cacheKey,
  ) async {
    await di<DefaultCacheManager>().removeFile(cacheKey);
    return _loadImage(path, cacheKey);
  }
}
