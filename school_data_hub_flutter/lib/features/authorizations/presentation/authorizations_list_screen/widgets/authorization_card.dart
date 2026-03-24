import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_screen/widgets/authorization_list_stats_row.dart';

class AuthorizationCard extends WatchingWidget {
  final Authorization authorization;
  const AuthorizationCard({required this.authorization, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return CardBox(
      padding: EdgeInsets.all(Style.spacing.lg),
      onTap: () {
        context.push(RoutePaths.authorizationPupils, extra: authorization);
      },
      child: GestureDetector(
        onLongPress: () async {
          final confirm = await confirmationDialog(
            context: context,
            title: 'Nachweis-Liste löschen',
            message: 'Möchten Sie diese Nachweis-Liste löschen?',
          );
          if (confirm != true) {
            return;
          }
          di<AuthorizationManager>().deleteAuthorization(authorization.id!);
        },
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authorization.name,
                  style: context.typography.title.withColor(
                    style.colors.interactive,
                  ),
                ),
                const Gap(5),
                SizedBox(
                  width: 250,
                  child: Text(
                    authorization.description,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: context.typography.body,
                  ),
                ),
                const Gap(5),
                authorizationStatsRow(authorization),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
