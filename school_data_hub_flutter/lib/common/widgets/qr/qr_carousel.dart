import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCarousel extends StatefulWidget {
  final Map<String, String> qrMap;

  const QrCarousel({required this.qrMap, super.key});

  @override
  State<QrCarousel> createState() => _QrCarouselState();
}

class _QrCarouselState extends State<QrCarousel> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final HardwareKeyboard hardwareKeyboard = HardwareKeyboard.instance;

  bool keybardHandler(Object event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        carouselController.previousPage();
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        carouselController.nextPage();
      }
      if (event.logicalKey == LogicalKeyboardKey.space) {
        carouselController.nextPage();
      }
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        Navigator.of(context).pop();
      }
    }

    return true;
  }

  List<Map<String, String>> myListOfMaps = [];

  @override
  void initState() {
    hardwareKeyboard.addHandler(keybardHandler);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final qrMap = widget.qrMap;
    // Transforming myMap into a List<Map<String, String>>
    qrMap.forEach((key, value) {
      myListOfMaps.add({key: value});
    });
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final maxHeight = isLandscape
            ? constraints.maxHeight * 0.9
            : constraints.maxHeight * 0.6;
        final horizontalGap = constraints.maxWidth * 0.05;
        return CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            viewportFraction: isLandscape ? 0.6 : 0.9,
            enlargeCenterPage: true,
            height: maxHeight,
            autoPlay: false,
            pauseAutoPlayInFiniteScroll: true,
            pauseAutoPlayOnTouch: true,
            scrollPhysics: const PageScrollPhysics(),
          ),
          items: myListOfMaps.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Center(
                  child: Container(
                    width: maxWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            Gap(horizontalGap),
                            Text(
                              i.keys.first,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${myListOfMaps.indexOf(i) + 1}/${myListOfMaps.length}',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(horizontalGap),
                          ],
                        ),
                        Expanded(
                          child: QrImageView(
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            data: i.values.first,
                            version: QrVersions.auto,
                            size: (isLandscape || Platform.isWindows)
                                ? maxHeight * 0.9
                                : maxWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    hardwareKeyboard.removeHandler(keybardHandler);

    super.dispose();
  }
}

void showQrCarousel(
  Map<String, String> qrMap,
  BuildContext context,
) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: QrCarousel(qrMap: qrMap),
      );
    },
  );
}
