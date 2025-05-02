import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorization_pupils_page/authorization_pupils_page.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorizations_list_page/widgets/authorization_list_stats_row.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationCard extends WatchingWidget {
  final Authorization authorization;
  const AuthorizationCard({required this.authorization, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AuthorizationPupilsPage(
                authorization,
              ),
            ));
          },
          onLongPress: () async {
            final confirm = await confirmationDialog(
                context: context,
                title: 'Nachweis-Liste löschen',
                message: 'Möchten Sie diese Nachweis-Liste löschen?');
            if (confirm != true) {
              return;
            }
            locator<AuthorizationManager>()
                .deleteAuthorization(authorization.authorizationId);
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorization.authorizationName,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.interactiveColor),
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 250,
                    child: Text(
                      authorization.authorizationDescription,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Gap(5),
                  authorizationStatsRow(authorization),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
