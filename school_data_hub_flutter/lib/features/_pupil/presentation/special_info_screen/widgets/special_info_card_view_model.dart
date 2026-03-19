import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

class SpecialInfoCardViewModel {
  final PupilProxy pupil;
  final PupilMutator _pupilMutator = PupilMutator();

  SpecialInfoCardViewModel(this.pupil);

  List<String> get _parts => pupil.specialInformation?.split('|') ?? [];

  String get info => _parts.isNotEmpty
      ? _parts[0]
      : (pupil.specialInformation ?? 'keine Infos');
  String? get createdBy => _parts.length > 1 ? _parts[1] : null;
  String? get createdAt => _parts.length > 2 ? _parts[2] : null;

  Future<void> updateMetadata({
    String? newCreatedBy,
    String? newCreatedAt,
  }) async {
    final currentInfo = info;
    final updatedCreatedBy = newCreatedBy ?? createdBy ?? '';
    final updatedCreatedAt = newCreatedAt ?? createdAt ?? '';

    final newSpecialInfo = '$currentInfo|$updatedCreatedBy|$updatedCreatedAt';

    await _pupilMutator.updateStringProperty(
      pupilId: pupil.pupilId,
      property: PupilStringProperty.specialInformation,
      propertyValue: (value: newSpecialInfo),
    );
  }
}
