import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoCard extends StatelessWidget {
  final SchoolData schoolData;

  const ContactInfoCard({super.key, required this.schoolData});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_phone, color: style.colors.accent),
              const Gap(8),
              Text('Kontaktinformationen', style: context.typography.title),
            ],
          ),
          const Gap(16),
          _buildContactRow(
            context,
            'Telefon',
            schoolData.telephoneNumber,
            Icons.phone,
            () => _launchPhone(schoolData.telephoneNumber),
          ),
          const Gap(8),
          _buildContactRow(
            context,
            'E-Mail',
            schoolData.email,
            Icons.email,
            () => _launchEmail(schoolData.email),
          ),
          const Gap(8),
          _buildContactRow(
            context,
            'Website',
            schoolData.website,
            Icons.language,
            () => _launchWebsite(schoolData.website),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    VoidCallback? onTap,
  ) {
    final style = Style.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text('$label:', style: context.typography.body.bold),
        ),
        const Gap(8),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: MouseRegion(
              cursor: onTap != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: Row(
                children: [
                  Icon(icon, size: 16, color: style.colors.accent),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      value,
                      style: context.typography.body
                          .withColor(
                            onTap != null
                                ? style.colors.accent
                                : style.colors.foreground,
                          )
                          .copyWith(
                            decoration: onTap != null
                                ? TextDecoration.underline
                                : null,
                          ),
                    ),
                  ),
                ],
              ),
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
