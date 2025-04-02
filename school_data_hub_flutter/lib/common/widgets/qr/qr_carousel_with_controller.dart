import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCarouselWithController extends StatefulWidget {
  final Map<String, String> qrMap;

  const QrCarouselWithController({required this.qrMap, super.key});

  @override
  State<QrCarouselWithController> createState() =>
      _QrCarouselWithControllerState();
}

class _QrCarouselWithControllerState extends State<QrCarouselWithController> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final HardwareKeyboard hardwareKeyboard = HardwareKeyboard.instance;

  bool keybardHandler(event) {
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
    final mediaQuery = MediaQuery.of(context);
    double maxHeight;
    final maxWidth = mediaQuery.size.width; // Adjust the multiplier as needed
    if (mediaQuery.orientation == Orientation.landscape) {
      maxHeight = mediaQuery.size.height * 0.9;
    } else {
      maxHeight = mediaQuery.size.height * 0.6;
    }
    final qrMap = widget.qrMap;
    // Transforming myMap into a List<Map<String, String>>
    qrMap.forEach((key, value) {
      myListOfMaps.add({key: value});
    });
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        viewportFraction:
            (mediaQuery.orientation == Orientation.landscape) ? 0.6 : 0.9,
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
                        Gap(mediaQuery.size.width * 0.05),
                        Text(i.keys.first,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(
                          '${myListOfMaps.indexOf(i) + 1}/${myListOfMaps.length}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Gap(mediaQuery.size.width * 0.05),
                      ],
                    ),
                    Expanded(
                      child: QrImageView(
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                        data: i.values.first,
                        version: QrVersions.auto,
                        size:
                            (mediaQuery.orientation == Orientation.landscape ||
                                    Platform.isWindows)
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
  }

  @override
  void dispose() {
    hardwareKeyboard.removeHandler(keybardHandler);
    debugPrint('QrCarouselWithController disposed');
    super.dispose();
  }
}

void showQrCarouselWithController(
    Map<String, String> qrMap, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: QrCarouselWithController(
          qrMap: qrMap,
        ),
      );
    },
  );
}
