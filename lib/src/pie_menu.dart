import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pie_menu/src/pie_action.dart';
import 'package:pie_menu/src/pie_button.dart';
import 'package:pie_menu/src/pie_canvas.dart';
import 'package:pie_menu/src/pie_menu_controller.dart';
import 'package:pie_menu/src/pie_menu_core.dart';
import 'package:pie_menu/src/pie_provider.dart';
import 'package:pie_menu/src/pie_theme.dart';

/// Displays a radial menu on the canvas when tapped, long-pressed,
/// or right-clicked (depending on your [PieTheme] configuration).
/// When it is open, you can select an action either by dragging your finger
/// over it and releasing or by simply pressing on it.
///
/// A [PieCanvas] ancestor is required for this widget to function.
class PieMenu extends StatelessWidget {
  const PieMenu({
    super.key,
    this.theme,
    this.actions = const [],
    this.onToggle,
    this.onPressed,
    this.onPressedWithDevice,
    this.onPressedWithPosition,
    this.controller,
    required this.child,
  });

  /// Theme to use for this menu, overrides [PieCanvas] theme.
  final PieTheme? theme;

  /// Actions to display as [PieButton]s on the [PieCanvas].
  final List<PieAction> actions;

  /// Widget to be displayed when the menu is hidden.
  final Widget child;

  /// Functional callback triggered when this menu opens or closes.
  final Function(bool menuOpen)? onToggle;

  /// Functional callback triggered on press.
  ///
  /// You can also use [onPressedWithDevice] if you need [PointerDeviceKind].
  /// You can also use [onPressedWithPosition] if you need [Offset].
  final Function()? onPressed;

  /// Functional callback triggered on press.
  /// Provides [PointerDeviceKind] as a parameter.
  ///
  /// Can be useful to distinguish between mouse and touch events.
  final Function(PointerDeviceKind kind)? onPressedWithDevice;

  /// Functional callback triggered on press.
  /// Provides [Offset] as a parameter.
  ///
  /// Can be useful to get the position of the menu.
  final Function(Offset position)? onPressedWithPosition;

  /// Controller for programmatically emitting [PieMenu] events.
  final PieMenuController? controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: PieNotifier.of(context),
      builder: (context, _) {
        return PieMenuCore(
          theme: theme,
          actions: actions,
          onToggle: onToggle,
          onPressed: onPressed,
          onPressedWithDevice: onPressedWithDevice,
          onPressedWithPosition: onPressedWithPosition,
          controller: controller,
          child: child,
        );
      },
    );
  }
}
