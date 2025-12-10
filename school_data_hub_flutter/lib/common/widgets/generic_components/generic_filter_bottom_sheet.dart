import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';

class GenericFilterBottomSheet extends StatelessWidget {
  final List<Widget> children;
  const GenericFilterBottomSheet({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          const FilterHeading(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [...children]),
            ),
          ),
        ],
      ),
    );
  }
}

showGenericFilterBottomSheet({
  required BuildContext context,
  required List<Widget> filterList,
}) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => GenericFilterBottomSheet(children: filterList),
  );
}
