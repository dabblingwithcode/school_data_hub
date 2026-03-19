import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Shows icon + count for a listenable list of pupils. Use as [statsWidget] in [GenericListSearchBarWithStats].
class PupilCountSearchBarStats extends WatchingWidget {
  final ValueListenable<List<PupilProxy>> filteredPupils;

  const PupilCountSearchBarStats({
    required this.filteredPupils,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watch(filteredPupils).value;
    return Container(
      decoration: BoxDecoration(
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(Style.radii.small),
      ),
      child: Column(
        children: [
          const Gap(4),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_alt_rounded,
                  color: style.colors.accent,
                ),
                const Gap(4),
                Text(
                  pupils.length.toString(),
                  style: context.typography.title,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
