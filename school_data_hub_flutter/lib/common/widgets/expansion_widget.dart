// import 'package:flutter/material.dart';

// class AnimatedExpansionWidget extends StatefulWidget {
//   final String title;
//   final Widget content;

//   const AnimatedExpansionWidget(
//       {super.key, required this.title, required this.content});

//   @override
//   AnimatedExpansionWidgetState createState() => AnimatedExpansionWidgetState();
// }

// class AnimatedExpansionWidgetState extends State<AnimatedExpansionWidget>
//     with SingleTickerProviderStateMixin {
//   bool _isExpanded = false;
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(
//           milliseconds: 300), // Duration of the expand/collapse animation
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handleExpansion() async {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });

//     if (_isExpanded) {
//       await _controller.forward(); // Expanding animation
//     } else {
//       await _controller.reverse(); // Collapsing animation
//       // Now you know the collapse is complete!
//       print('Collapse finished');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(widget.title),
//           trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
//           onTap: _handleExpansion, // Toggle the expansion
//         ),
//         SizeTransition(
//           sizeFactor: _animation, // Animate height changes
//           axisAlignment: -1.0, // Align from top
//           child: _isExpanded
//               ? widget.content
//               : Container(), // Only show content when expanded
//         ),
//       ],
//     );
//   }
// }
