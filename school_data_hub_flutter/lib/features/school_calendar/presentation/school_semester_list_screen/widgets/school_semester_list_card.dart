import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

class SchoolSemesterListCard extends StatelessWidget {
  final SchoolSemester semester;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isCurrentSemester;

  const SchoolSemesterListCard({
    super.key,
    required this.semester,
    required this.onEdit,
    required this.onDelete,
    this.isCurrentSemester = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: Style.spacing.sm),
      child: CardBox(
        onTap: onEdit,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCurrentSemester
                    ? style.colors.success
                    : style.colors.accent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  semester.isFirst ? '1' : '2',
                  style: context.typography.subtitle.bold
                      .withColor(style.colors.background),
                ),
              ),
            ),
            SizedBox(width: Style.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        semester.schoolYear,
                        style: context.typography.body.w600,
                      ),
                      SizedBox(width: Style.spacing.sm),
                      Tag(
                        label: semester.isFirst ? '1. Halbjahr' : '2. Halbjahr',
                        color: semester.isFirst
                            ? const Color(0xFF1565C0)
                            : const Color(0xFFEF6C00),
                      ),
                      if (isCurrentSemester) ...[
                        SizedBox(width: Style.spacing.sm),
                        Tag(
                          label: 'Aktuell',
                          color: style.colors.success,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: Style.spacing.xs),
                  Text(
                    '${semester.startDate.formatDateForUser()} - ${semester.endDate.formatDateForUser()}',
                    style: context.typography.bodySmall.muted(context),
                  ),
                ],
              ),
            ),
            TappableIcon(
              icon: const Icon(Icons.edit),
              tooltip: 'Bearbeiten',
              onPressed: onEdit,
            ),
            TappableIcon(
              icon: Icon(Icons.delete, color: style.colors.error),
              tooltip: 'L\u00f6schen',
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
