import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoCard extends StatelessWidget {
  final SchoolData schoolData;

  const ContactInfoCard({super.key, required this.schoolData});

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
                const Icon(
                  Icons.contact_phone,
                  color: AppColors.backgroundColor,
                ),
                const Gap(8),
                const Text('Kontaktinformationen', style: AppStyles.title),
              ],
            ),
            const Gap(16),
            _buildContactRow(
              'Telefon',
              schoolData.telephoneNumber,
              Icons.phone,
              () => _launchPhone(schoolData.telephoneNumber),
            ),
            const Gap(8),
            _buildContactRow(
              'E-Mail',
              schoolData.email,
              Icons.email,
              () => _launchEmail(schoolData.email),
            ),
            const Gap(8),
            _buildContactRow(
              'Website',
              schoolData.website,
              Icons.language,
              () => _launchWebsite(schoolData.website),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(
    String label,
    String value,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const Gap(8),
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.backgroundColor),
                const Gap(4),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: onTap != null ? AppColors.backgroundColor : null,
                      decoration:
                          onTap != null ? TextDecoration.underline : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchPhone(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchWebsite(String website) async {
    String url = website;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
