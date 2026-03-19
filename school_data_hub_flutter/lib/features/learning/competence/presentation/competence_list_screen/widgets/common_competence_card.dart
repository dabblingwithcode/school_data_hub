import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class CommonCompetenceCard extends WatchingStatefulWidget {
  final Color competenceBackgroundColor;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;
  final Competence competence;
  final List<Widget> children;
  const CommonCompetenceCard({
    required this.competence,
    required this.competenceBackgroundColor,
    required this.navigateToNewOrPatchCompetencePage,
    required this.children,
    super.key,
  });

  @override
  State<CommonCompetenceCard> createState() => _CommonCompetenceCardState();
}

class _CommonCompetenceCardState extends State<CommonCompetenceCard> {
  @override
  Widget build(BuildContext context) {
    final childrenController = createOnce<ExpansionController>(
      () => ExpansionController(),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.competence.parentCompetence == null ? 3 : 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.competenceBackgroundColor,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Style.spacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(Style.spacing.sm),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => widget.navigateToNewOrPatchCompetencePage(
                        competence: widget.competence,
                      ),
                      onLongPress: () =>
                          widget.navigateToNewOrPatchCompetencePage(
                            competenceId: widget.competence.publicId,
                          ),
                      child: Text(
                        widget.competence.name,
                        maxLines: 4,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: (widget.competence.parentCompetence == null
                                ? context.typography.title
                                : context.typography.subtitle.bold)
                            .withColor(
                          AppColors.bestContrastCompetenceFontColor(
                            widget.competenceBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.children.isNotEmpty) ...<Widget>[
                    ExpansionHeader(expansionController: childrenController),
                    Gap(Style.spacing.sm),
                  ],
                ],
              ),
            ),
            ExpansionBody(
              tileController: childrenController,
              widgetList: [
                Padding(
                  padding: EdgeInsets.only(
                    top: Style.spacing.xs / 2,
                    bottom: Style.spacing.xs,
                  ),
                  child: Column(children: widget.children),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
