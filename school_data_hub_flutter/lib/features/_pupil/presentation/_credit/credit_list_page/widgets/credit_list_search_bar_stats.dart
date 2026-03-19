import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_helper_functions.dart';

/// Stats row for credit list search bar. Watches [filteredPupils] for list
/// changes and merges all individual [PupilProxy] listenables so the stats
/// rebuild when any pupil's credit changes.
class CreditListSearchBarStats extends WatchingWidget {
  final ValueListenable<List<PupilProxy>> filteredPupils;

  const CreditListSearchBarStats({super.key, required this.filteredPupils});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watch(filteredPupils).value;
    watch(Listenable.merge(pupils));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Style.spacing.md),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_alt_rounded, color: style.colors.accent),
            Gap(Style.spacing.md),
            Text(
              pupils.length.toString(),
              style: context.typography.title.withColor(
                style.colors.foreground,
              ),
            ),
            Gap(Style.spacing.md),
            Text(
              'BIP:',
              style: context.typography.caption.withColor(
                style.colors.accent,
              ).bold,
            ),
            Gap(Style.spacing.md),
            Text(
              CreditHelper.totalGeneratedCredit(pupils).toString(),
              style: context.typography.title.withColor(
                style.colors.foreground,
              ),
            ),
            Gap(Style.spacing.md),
            Text(
              'in Umlauf: ',
              style: context.typography.caption.withColor(
                style.colors.accent,
              ).bold,
            ),
            Gap(Style.spacing.md),
            Text(
              CreditHelper.totalFluidCredit(pupils).toString(),
              style: context.typography.title.withColor(
                style.colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
