import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class MatrixUserRelationship {
  final PupilProxy? pupil;
  final List<PupilProxy> familyPupils;
  final bool isTeacher;

  MatrixUserRelationship({
    required this.pupil,
    required this.familyPupils,
    required this.isTeacher,
  });

  bool get isLinked => pupil != null;
  bool get isParent => familyPupils.isNotEmpty;
  bool get isFamily => familyPupils.length > 1;
}
