import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'style.dart';

const double _defaultSize = 40.0;

/// A simple icon button with hover highlight, tap animation,
/// keyboard support, and semantics. No Material splash.
class TappableIcon extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final double size;
  final String? tooltip;
  final FocusNode? focusNode;

  /// Override the icon & hover colors. When null, uses `colors.foreground`
  /// (default) and `colors.surfaceContainer` (hover background).
  /// Set to a light color when placed on a dark/accent background (e.g. ActionBar).
  final Color? color;

  const TappableIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = _defaultSize,
    this.tooltip,
    this.focusNode,
    this.color,
  });

  @override
  State<TappableIcon> createState() {
    return _TappableIconState();
  }
}

class _TappableIconState extends State<TappableIcon>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFocused = false;

  late final AnimationController _tapController;
  late final Animation<double> _tapAnimation;

  @override
  void initState() {
    super.initState();

    _tapController = AnimationController(
      duration: Style.durations.fast,
      vsync: this,
    );

    _tapAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.92,
        ).animate(
          CurvedAnimation(
            parent: _tapController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.space)) {
      widget.onPressed?.call();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final ColorTokens colors = style.colors;
    final bool isDisabled = widget.onPressed == null;
    // Resolve icon color: explicit override > inherited IconTheme > foreground
    final Color resolvedColor = widget.color
        ?? IconTheme.of(context).color
        ?? colors.foreground;

    Widget result = Semantics(
      button: true,
      enabled: !isDisabled,
      label: widget.tooltip,
      excludeSemantics: true,
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (bool focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        onKeyEvent: isDisabled ? null : _handleKeyEvent,
        child: MouseRegion(
          cursor: isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) {
            if (!isDisabled) {
              setState(() {
                _isHovered = true;
              });
            }
          },
          onExit: (_) {
            if (!isDisabled) {
              setState(() {
                _isHovered = false;
              });
            }
          },
          child: GestureDetector(
            onTap: isDisabled ? null : widget.onPressed,
            onTapDown: isDisabled
                ? null
                : (_) {
                    _tapController.forward();
                  },
            onTapUp: isDisabled
                ? null
                : (_) {
                    _tapController.reverse();
                  },
            onTapCancel: isDisabled
                ? null
                : () {
                    _tapController.reverse();
                  },
            behavior: HitTestBehavior.opaque,
            child: AnimatedBuilder(
              animation: _tapAnimation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _tapAnimation.value,
                  child: child,
                );
              },
              child: Opacity(
                opacity: isDisabled ? 0.5 : 1.0,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? resolvedColor.withValues(alpha: 0.2)
                        : const Color(0x00000000),
                    shape: BoxShape.circle,
                    boxShadow: _isFocused && !isDisabled
                        ? [
                            BoxShadow(
                              color: resolvedColor.withValues(alpha: 0.2),
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: IconTheme(
                      data: IconThemeData(
                        color: isDisabled
                            ? colors.mutedForeground
                            : resolvedColor,
                      ),
                      child: widget.icon,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return result;
  }
}
