import 'package:flutter/material.dart';

extension ThemeColorContext on BuildContext {
  Color get themePrimary => Theme.of(this).colorScheme.primary;
  Color get themeSecondary => Theme.of(this).colorScheme.secondary;
  Color get themeSurface => Theme.of(this).colorScheme.surface;
  Color get themeOnSurface => Theme.of(this).colorScheme.onSurface;
  Color get themeCard => Theme.of(this).cardColor;
  Color get themeBg => Theme.of(this).scaffoldBackgroundColor;
  Color get themeError => Theme.of(this).colorScheme.error;
}
