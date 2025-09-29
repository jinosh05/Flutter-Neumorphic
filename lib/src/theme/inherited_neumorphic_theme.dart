import 'package:flutter_neumorphic/flutter_neumorphic.dart';

export 'theme.dart';
export 'theme_wrapper.dart';

typedef NeumorphicThemeUpdater =
    NeumorphicThemeData Function(NeumorphicThemeData? current);

class NeumorphicThemeInherited extends InheritedWidget {
  @override
  final Widget child;
  final ThemeWrapper value;
  final ValueChanged<ThemeWrapper> onChanged;

  const NeumorphicThemeInherited({
    super.key,
    required this.child,
    required this.value,
    required this.onChanged,
  }) : super(child: child);

  @override
  bool updateShouldNotify(NeumorphicThemeInherited old) => value != old.value;

  NeumorphicThemeData? get current {
    return value.theme;
  }

  bool get isUsingDark {
    return value.theme == value.darkTheme;
  }

  ThemeMode get themeMode => value.themeMode;

  set themeMode(ThemeMode currentTheme) {
    onChanged(value.copyWith(currentTheme: currentTheme));
  }

  void updateCurrentTheme(NeumorphicThemeData update) {
    if (value.getUseDark()) {
      final newValue = value.copyWith(darkTheme: update);
      //this.value = newValue;
      onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      //this.value = newValue;
      onChanged(newValue);
    }
  }

  void update(NeumorphicThemeUpdater themeUpdater) {
    final update = themeUpdater(value.theme);
    if (value.getUseDark()) {
      final newValue = value.copyWith(darkTheme: update);
      //this.value = newValue;
      onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      //this.value = newValue;
      onChanged(newValue);
    }
  }
}
