import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorization_pupils_page/authorization_pupils_page.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/widgets/authorization_list_stats_row.dart';
import 'package:watch_it/watch_it.dart';

final _authorizationManager = di<AuthorizationManager>();

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
            di<AuthorizationManager>().deleteAuthorization(authorization.id!);
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorization.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.interactiveColor),
                  ),
                  const Gap(5),
                  SizedBox(
                    width: 250,
                    child: Text(
                      authorization.description,
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
