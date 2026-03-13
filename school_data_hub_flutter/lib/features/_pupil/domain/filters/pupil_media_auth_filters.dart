import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

enum PublicMediaAuthFilter {
  groupPicturesOnWebsite,
  groupPicturesInPress,
  portraitPicturesOnWebsite,
  portraitPicturesInPress,
  nameOnWebsite,
  nameInPress,
  videoOnWebsite,
  videoInPress,
}

const Map<PublicMediaAuthFilter, bool> initialPublicMediaAuthFilterValues = {
  PublicMediaAuthFilter.groupPicturesOnWebsite: false,
  PublicMediaAuthFilter.groupPicturesInPress: false,
  PublicMediaAuthFilter.portraitPicturesOnWebsite: false,
  PublicMediaAuthFilter.portraitPicturesInPress: false,
  PublicMediaAuthFilter.nameOnWebsite: false,
  PublicMediaAuthFilter.nameInPress: false,
  PublicMediaAuthFilter.videoOnWebsite: false,
  PublicMediaAuthFilter.videoInPress: false,
};

extension PublicMediaAuthFilterX on PublicMediaAuthFilter {
  String get displayName {
    switch (this) {
      case PublicMediaAuthFilter.groupPicturesOnWebsite:
        return 'Gruppenbilder Webseite';
      case PublicMediaAuthFilter.groupPicturesInPress:
        return 'Gruppenbilder Presse';
      case PublicMediaAuthFilter.portraitPicturesOnWebsite:
        return 'Porträt Webseite';
      case PublicMediaAuthFilter.portraitPicturesInPress:
        return 'Porträt Presse';
      case PublicMediaAuthFilter.nameOnWebsite:
        return 'Name Webseite';
      case PublicMediaAuthFilter.nameInPress:
        return 'Name Presse';
      case PublicMediaAuthFilter.videoOnWebsite:
        return 'Video Webseite';
      case PublicMediaAuthFilter.videoInPress:
        return 'Video Presse';
    }
  }
}

class PupilMediaAuthFilterManager implements Resettable {
  FiltersStateManager get _filterStateManager => di<FiltersStateManager>();
  PupilsFilter get _pupilsFilter => di<PupilsFilter>();

  final _publicMediaAuthFilterState =
      ValueNotifier<Map<PublicMediaAuthFilter, bool>>({
        ...initialPublicMediaAuthFilterValues,
      });

  ValueListenable<Map<PublicMediaAuthFilter, bool>>
  get publicMediaAuthFilterState => _publicMediaAuthFilterState;

  void setPublicMediaAuthFilter({
    required PublicMediaAuthFilter filter,
    required bool value,
  }) {
    _publicMediaAuthFilterState.value = {
      ..._publicMediaAuthFilterState.value,
      filter: value,
    };

    final bool filterStateEqualsInitial =
        const MapEquality<PublicMediaAuthFilter, bool>().equals(
          _publicMediaAuthFilterState.value,
          initialPublicMediaAuthFilterValues,
        );

    _filterStateManager.setFilterState(
      filterState: FilterState.pupil,
      value: !filterStateEqualsInitial,
    );
    _pupilsFilter.refresh();
  }

  @override
  void resetFilters() {
    _publicMediaAuthFilterState.value = {...initialPublicMediaAuthFilterValues};
    _filterStateManager.setFilterState(
      filterState: FilterState.pupil,
      value: false,
    );
  }

  void dispose() {
    _publicMediaAuthFilterState.dispose();
  }

  /// Returns true if no filter is selected, or if the pupil's publicMediaAuth
  /// has all selected consent types set to true.
  bool isMatchedByPublicMediaAuthFilters(PupilProxy pupil) {
    final activeFilters = _publicMediaAuthFilterState.value;
    final selectedFilters = activeFilters.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedFilters.isEmpty) return true;

    final auth = pupil.publicMediaAuth;
    for (final filter in selectedFilters) {
      final bool consentValue;
      switch (filter) {
        case PublicMediaAuthFilter.groupPicturesOnWebsite:
          consentValue = auth.groupPicturesOnWebsite;
          break;
        case PublicMediaAuthFilter.groupPicturesInPress:
          consentValue = auth.groupPicturesInPress;
          break;
        case PublicMediaAuthFilter.portraitPicturesOnWebsite:
          consentValue = auth.portraitPicturesOnWebsite;
          break;
        case PublicMediaAuthFilter.portraitPicturesInPress:
          consentValue = auth.portraitPicturesInPress;
          break;
        case PublicMediaAuthFilter.nameOnWebsite:
          consentValue = auth.nameOnWebsite;
          break;
        case PublicMediaAuthFilter.nameInPress:
          consentValue = auth.nameInPress;
          break;
        case PublicMediaAuthFilter.videoOnWebsite:
          consentValue = auth.videoOnWebsite;
          break;
        case PublicMediaAuthFilter.videoInPress:
          consentValue = auth.videoInPress;
          break;
      }
      if (!consentValue) return false;
    }
    return true;
  }
}
