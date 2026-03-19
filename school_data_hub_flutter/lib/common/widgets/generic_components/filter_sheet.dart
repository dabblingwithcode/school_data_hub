import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_heading.dart';

class FilterSheet extends StatelessWidget {
  final List<Widget> children;
  final Widget? heading;
  const FilterSheet({
    required this.children,
    this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          const Gap(3),
          heading ?? const FilterHeading(),
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

Future<dynamic> showFilterSheet({
  required BuildContext context,
  required List<Widget> filterList,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => FilterSheet(children: filterList),
  );
}
