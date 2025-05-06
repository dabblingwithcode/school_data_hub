import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/authorization_content/pupil_content_authorization_entry_card.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileAuthorizationContentList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileAuthorizationContentList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final authorizations =
        watchValue((AuthorizationManager x) => x.authorizations);
    List<PupilAuthorization> pupilAuthorizations = [];
    for (final authorization in authorizations) {
      for (final pupilAuthorization in authorization.authorizedPupils!) {
        if (pupilAuthorization.pupilId == pupil.pupilId) {
          pupilAuthorizations.add(pupilAuthorization);
        }
      }
    }
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pupilAuthorizations.length,
      itemBuilder: (BuildContext context, int index) {
        final Authorization authorization = di<AuthorizationManager>()
            .getAuthorization(pupilAuthorizations[index].authorizationId);
        final PupilAuthorization pupilAuthorization =
            pupilAuthorizations[index];
        return GestureDetector(
          onTap: () {},
          onLongPress: () async {},
          child: PupilContentAuthorizationEntryCard(
            pupil: pupil,
            pupilAuthorization: pupilAuthorization,
            authorization: authorization,
          ),
        );
      },
    );
  }
}
