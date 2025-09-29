import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

export 'theme.dart';

/// Immutable container for the current neumorphic theme.
/// Accessible to child widgets by an InheritedWidget.
class ThemeWrapper {
  final NeumorphicThemeData theme;
  final NeumorphicThemeData? darkTheme;
  final ThemeMode themeMode;

  const ThemeWrapper({
    required this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
  });

  bool getUseDark() {
    final brightness = PlatformDispatcher.instance.platformBrightness;

    return themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && brightness == Brightness.dark);
  }

  NeumorphicThemeData? getCurrentTheme() {
    if (getUseDark()) {
      return darkTheme;
    } else {
      return theme;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeWrapper &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          darkTheme == other.darkTheme &&
          themeMode == other.themeMode;

  @override
  int get hashCode => theme.hashCode ^ darkTheme.hashCode ^ themeMode.hashCode;

  ThemeWrapper copyWith({
    NeumorphicThemeData? theme,
    NeumorphicThemeData? darkTheme,
    ThemeMode? currentTheme,
  }) {
    return ThemeWrapper(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      themeMode: currentTheme ?? themeMode,
    );
  }
}
