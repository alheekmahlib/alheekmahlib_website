part of '../books.dart';

class ChangeThemeWidget extends StatelessWidget {
  final Color? svgColor;
  final Color? borderColor;
  const ChangeThemeWidget({
    super.key,
    this.svgColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: 40,
      backgroundColor: Colors.transparent,
      svgColor: svgColor ?? context.theme.colorScheme.secondary,
      borderColor: borderColor ??
          context.theme.colorScheme.secondary.withValues(alpha: .2),
      icon: context.isDark ? Icons.dark_mode : Icons.light_mode,
      onPressed: () {
        final theme = sl<ThemeController>();
        theme.setTheme(theme.themeId.value == 'dark' ? 'brown' : 'dark');
      },
    );
  }
}
