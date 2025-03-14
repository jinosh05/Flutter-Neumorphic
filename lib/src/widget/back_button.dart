import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final NeumorphicStyle? style;
  final EdgeInsets? padding;
  final bool forward;

  const NeumorphicBackButton({
    super.key,
    this.onPressed,
    this.style,
    this.padding,
    this.forward = false,
  });

  @override
  Widget build(BuildContext context) {
    final nThemeIcons = NeumorphicTheme.of(context)!.current!.appBarTheme.icons;
    return NeumorphicButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      child: forward ? nThemeIcons.forwardIcon : nThemeIcons.backIcon,
    );
  }
}
