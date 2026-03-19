import 'dart:typed_data';

import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class SchoolLogoCard extends StatelessWidget {
  final SchoolData schoolData;
  final ByteData? logoImage;
  final ByteData? officialSealImage;

  const SchoolLogoCard({
    super.key,
    required this.schoolData,
    this.logoImage,
    this.officialSealImage,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.image, color: style.colors.accent),
              const Gap(8),
              Text('Schul-Logo & Amtssiegel', style: context.typography.title),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              // Logo Section
              Expanded(
                child: Column(
                  children: [
                    Text('Schul-Logo', style: context.typography.body.bold),
                    const Gap(8),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: style.colors.border),
                        borderRadius: BorderRadius.circular(
                          Style.radii.small,
                        ),
                      ),
                      child: logoImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Style.radii.small,
                              ),
                              child: Image.memory(
                                logoImage!.buffer.asUint8List(),
                                fit: BoxFit.contain,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: style.colors.mutedForeground,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              // Official Seal Section
              Expanded(
                child: Column(
                  children: [
                    Text('Amtssiegel', style: context.typography.body.bold),
                    const Gap(8),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: style.colors.border),
                        borderRadius: BorderRadius.circular(
                          Style.radii.small,
                        ),
                      ),
                      child: officialSealImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Style.radii.small,
                              ),
                              child: Image.memory(
                                officialSealImage!.buffer.asUint8List(),
                                fit: BoxFit.contain,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: style.colors.mutedForeground,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
