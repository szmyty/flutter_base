/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow_left_disable.svg
  SvgGenImage get arrowLeftDisable =>
      const SvgGenImage('assets/icons/arrow_left_disable.svg');

  /// File path: assets/icons/arrow_left_enable.svg
  SvgGenImage get arrowLeftEnable =>
      const SvgGenImage('assets/icons/arrow_left_enable.svg');

  /// File path: assets/icons/arrow_right_disable.svg
  SvgGenImage get arrowRightDisable =>
      const SvgGenImage('assets/icons/arrow_right_disable.svg');

  /// File path: assets/icons/arrow_right_enable.svg
  SvgGenImage get arrowRightEnable =>
      const SvgGenImage('assets/icons/arrow_right_enable.svg');

  /// File path: assets/icons/play_icon.svg
  SvgGenImage get playIcon => const SvgGenImage('assets/icons/play_icon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        arrowLeftDisable,
        arrowLeftEnable,
        arrowRightDisable,
        arrowRightEnable,
        playIcon
      ];
}

class Assets {
  Assets._();

  static const String package = 'feed_blocks_ui';

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  static const String package = 'feed_blocks_ui';

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/feed_blocks_ui/$_assetName';
}
