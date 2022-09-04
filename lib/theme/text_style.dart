import 'package:flutter/material.dart';
import 'package:manga_app/theme/color_scheme.dart';

class MangaTextStyle {
  static TextStyle? get headerLarger => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  static TextStyle? get headerMedium => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  static TextStyle? get headerSmall => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  static TextStyle? get titleLarger => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle? get titleMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle? get titleSmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle? get bodyLarger => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle? get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle? get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle? get bodySuperSmall => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}

extension TextStyleExtension on BuildContext? {
  TextStyle? get headerLarger => MangaTextStyle.headerLarger;

  TextStyle? get headerMedium => MangaTextStyle.headerMedium;

  TextStyle? get headerSmall => MangaTextStyle.headerSmall;

  TextStyle? get titleLarger => MangaTextStyle.titleLarger;

  TextStyle? get titleMedium => MangaTextStyle.titleMedium;

  TextStyle? get titleSmall => MangaTextStyle.titleSmall;

  TextStyle? get bodyLarger => MangaTextStyle.bodyLarger;

  TextStyle? get bodyMedium => MangaTextStyle.bodyMedium;

  TextStyle? get bodySmall => MangaTextStyle.bodySmall;

  TextStyle? get bodySuperSmall => MangaTextStyle.bodySuperSmall;
}

extension ColorsExtentsion on TextStyle? {
  TextStyle? get black => this?.copyWith(
        color: MangaColors.black,
      );

  TextStyle? get white => this?.copyWith(
        color: MangaColors.white,
      );

  TextStyle? get red => this?.copyWith(
        color: MangaColors.red,
      );

  TextStyle? get lime => this?.copyWith(
        color: MangaColors.lime,
      );

  TextStyle? get blue => this?.copyWith(
        color: MangaColors.blue,
      );

  TextStyle? get yellow => this?.copyWith(
        color: MangaColors.yellow,
      );

  TextStyle? get cyan => this?.copyWith(
        color: MangaColors.cyan,
      );

  TextStyle? get magenta => this?.copyWith(
        color: MangaColors.magenta,
      );

  TextStyle? get silver => this?.copyWith(
        color: MangaColors.silver,
      );

  TextStyle? get gray => this?.copyWith(
        color: MangaColors.gray,
      );

  TextStyle? get maroon => this?.copyWith(
        color: MangaColors.maroon,
      );

  TextStyle? get olive => this?.copyWith(
        color: MangaColors.olive,
      );

  TextStyle? get green => this?.copyWith(
        color: MangaColors.green,
      );

  TextStyle? get purple => this?.copyWith(
        color: MangaColors.purple,
      );

  TextStyle? get teal => this?.copyWith(
        color: MangaColors.teal,
      );

  TextStyle? get navy => this?.copyWith(
        color: MangaColors.navy,
      );

  TextStyle? get textDarkGray => this?.copyWith(
        color: MangaColors.textDarkGray,
      );

  TextStyle? get textLightWhite => this?.copyWith(
        color: MangaColors.textLightWhite,
      );

  TextStyle? get divider => this?.copyWith(
        color: MangaColors.divider,
      );

  TextStyle? get textNotice => this?.copyWith(
        color: MangaColors.textNotice,
      );

  TextStyle? get darkBackground => this?.copyWith(
        color: MangaColors.darkBackground,
      );

  TextStyle? get lightBackground => this?.copyWith(
        color: MangaColors.lightBackground,
      );
}
