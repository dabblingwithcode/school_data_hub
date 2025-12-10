import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

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
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.image, color: AppColors.backgroundColor),
                const Gap(8),
                const Text('Schul-Logo & Amtssiegel', style: AppStyles.title),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                // Logo Section
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Schul-Logo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: logoImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  logoImage!.buffer.asUint8List(),
                                  fit: BoxFit.contain,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                  color: Colors.grey,
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
                      const Text(
                        'Amtssiegel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(8),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: officialSealImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  officialSealImage!.buffer.asUint8List(),
                                  fit: BoxFit.contain,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                  color: Colors.grey,
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
      ),
    );
  }
}
