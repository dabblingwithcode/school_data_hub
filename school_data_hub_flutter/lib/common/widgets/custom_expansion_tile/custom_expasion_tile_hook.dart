// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:schuldaten_hub/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';

// /// Creates a [CustomExpansionTileController] that will be disposed automatically.
// ///
// /// See also:
// /// - [ExpansionTileController]
// CustomExpansionTileController useCustomExpansionTileController(
//     {List<Object?>? keys}) {
//   return use(_CustomExpansionTileControllerHook(keys: keys));
// }

// class _CustomExpansionTileControllerHook
//     extends Hook<CustomExpansionTileController> {
//   const _CustomExpansionTileControllerHook({super.keys});

//   @override
//   HookState<CustomExpansionTileController, Hook<CustomExpansionTileController>>
//       createState() => _ExpansionTileControllerHookState();
// }

// class _ExpansionTileControllerHookState extends HookState<
//     CustomExpansionTileController, _CustomExpansionTileControllerHook> {
//   final controller = CustomExpansionTileController();

//   @override
//   String get debugLabel => 'useExpansionTileController';

//   @override
//   CustomExpansionTileController build(BuildContext context) => controller;
// }
