import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_page/edit_school_data_page.dart';
import 'package:school_data_hub_flutter/features/school/presentation/school_data_page/widgets/contact_info_card.dart';
import 'package:school_data_hub_flutter/features/school/presentation/school_data_page/widgets/school_info_card.dart';
import 'package:school_data_hub_flutter/features/school/presentation/school_data_page/widgets/school_logo_card.dart';
import 'package:watch_it/watch_it.dart';

class SchoolDataPage extends WatchingWidget {
  const SchoolDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolDataManager = di<SchoolDataMainManager>();

    // Watch the school data to make the page reactive
    final schoolData = watchValue((SchoolDataMainManager x) => x.schoolData);
    final isLoading = watchValue((SchoolDataMainManager x) => x.isLoading);
    final logoImage = watchValue((SchoolDataMainManager x) => x.logoImage);
    final officialSealImage = watchValue(
      (SchoolDataMainManager x) => x.officialSealImage,
    );

    // Load data on first build
    callOnce((context) async {
      await schoolDataManager.refreshData();
    });

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.school,
        title: 'Schulinformationen',
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : schoolData == null
              ? _buildEmptyState(context, schoolDataManager)
              : _buildSchoolDataContent(
                context,
                schoolData,
                logoImage,
                officialSealImage,
              ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    SchoolDataMainManager schoolDataManager,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.school, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Keine Schulinformationen verfügbar',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Erstellen Sie die Schulinformationen',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditSchoolDataPage(),
                ),
              );
              // Refresh data when returning from edit page
              await schoolDataManager.refreshData();
            },
            child: const Text('Schulinformationen erstellen'),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolDataContent(
    BuildContext context,
    SchoolData schoolData,
    ByteData? logoImage,
    ByteData? officialSealImage,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // School Logo Card
              SchoolLogoCard(
                schoolData: schoolData,
                logoImage: logoImage,
                officialSealImage: officialSealImage,
              ),
              const Gap(16),

              // School Info Card
              SchoolInfoCard(schoolData: schoolData),
              const Gap(16),

              // Contact Info Card
              ContactInfoCard(schoolData: schoolData),
              const Gap(24),

              // Edit Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditSchoolDataPage(),
                      ),
                    );
                    // Refresh data when returning from edit page
                    await di<SchoolDataMainManager>().refreshData();
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Schulinformationen bearbeiten'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
