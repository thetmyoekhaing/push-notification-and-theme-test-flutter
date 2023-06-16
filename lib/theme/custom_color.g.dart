import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const customcolor1 = Color(0xFFA5D6A7);


CustomColors lightCustomColors = const CustomColors(
  sourceCustomcolor1: Color(0xFFA5D6A7),
  customcolor1: Color(0xFF186C32),
  onCustomcolor1: Color(0xFFFFFFFF),
  customcolor1Container: Color(0xFFA2F6AB),
  onCustomcolor1Container: Color(0xFF002109),
);

CustomColors darkCustomColors = const CustomColors(
  sourceCustomcolor1: Color(0xFFA5D6A7),
  customcolor1: Color(0xFF87D991),
  onCustomcolor1: Color(0xFF003914),
  customcolor1Container: Color(0xFF005320),
  onCustomcolor1Container: Color(0xFFA2F6AB),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceCustomcolor1,
    required this.customcolor1,
    required this.onCustomcolor1,
    required this.customcolor1Container,
    required this.onCustomcolor1Container,
  });

  final Color? sourceCustomcolor1;
  final Color? customcolor1;
  final Color? onCustomcolor1;
  final Color? customcolor1Container;
  final Color? onCustomcolor1Container;

  @override
  CustomColors copyWith({
    Color? sourceCustomcolor1,
    Color? customcolor1,
    Color? onCustomcolor1,
    Color? customcolor1Container,
    Color? onCustomcolor1Container,
  }) {
    return CustomColors(
      sourceCustomcolor1: sourceCustomcolor1 ?? this.sourceCustomcolor1,
      customcolor1: customcolor1 ?? this.customcolor1,
      onCustomcolor1: onCustomcolor1 ?? this.onCustomcolor1,
      customcolor1Container: customcolor1Container ?? this.customcolor1Container,
      onCustomcolor1Container: onCustomcolor1Container ?? this.onCustomcolor1Container,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceCustomcolor1: Color.lerp(sourceCustomcolor1, other.sourceCustomcolor1, t),
      customcolor1: Color.lerp(customcolor1, other.customcolor1, t),
      onCustomcolor1: Color.lerp(onCustomcolor1, other.onCustomcolor1, t),
      customcolor1Container: Color.lerp(customcolor1Container, other.customcolor1Container, t),
      onCustomcolor1Container: Color.lerp(onCustomcolor1Container, other.onCustomcolor1Container, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceCustomcolor1]
  ///   * [CustomColors.customcolor1]
  ///   * [CustomColors.onCustomcolor1]
  ///   * [CustomColors.customcolor1Container]
  ///   * [CustomColors.onCustomcolor1Container]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceCustomcolor1: sourceCustomcolor1!.harmonizeWith(dynamic.primary),
      customcolor1: customcolor1!.harmonizeWith(dynamic.primary),
      onCustomcolor1: onCustomcolor1!.harmonizeWith(dynamic.primary),
      customcolor1Container: customcolor1Container!.harmonizeWith(dynamic.primary),
      onCustomcolor1Container: onCustomcolor1Container!.harmonizeWith(dynamic.primary),
    );
  }
}