import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/empty_state.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_screen/edit_school_data_screen.dart';
import 'package:school_data_hub_flutter/features/school/presentation/school_data_screen/widgets/contact_info_card.dart';
import 'package:school_data_hub_flutter/features/school/presentation/school_data_screen/widgets/school_info_card.dart';
import 'package:school_data_hub_flutter/features/school/presentation/school_data_screen/widgets/school_logo_card.dart';

class SchoolDataScreen extends WatchingWidget {
  const SchoolDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.school,
        title: 'Schulinformationen',
      ),
      body: isLoading
          ? Center(child: Spinner(color: style.colors.accent))
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
    return EmptyState(
      icon: Icon(
        Icons.school,
        size: 64,
        color: Style.of(context).colors.mutedForeground,
      ),
      title: 'Keine Schulinformationen verfügbar',
      description: 'Erstellen Sie die Schulinformationen',
      action: Button(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const EditSchoolDataScreen(),
            ),
          );
          // Refresh data when returning from edit page
          await schoolDataManager.refreshData();
        },
        label: 'Schulinformationen erstellen',
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
          padding: EdgeInsets.all(Style.spacing.lg),
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
              Gap(Style.spacing.xl),

              // Edit Button
              Center(
                child: Button(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const EditSchoolDataScreen(),
                      ),
                    );
                    // Refresh data when returning from edit page
                    await di<SchoolDataMainManager>().refreshData();
                  },
                  icon: const Icon(Icons.edit),
                  label: 'Schulinformationen bearbeiten',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
