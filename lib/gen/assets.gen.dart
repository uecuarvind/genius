/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFlagsGen {
  const $AssetsFlagsGen();

  /// File path: assets/flags/bd.png
  AssetGenImage get bd => const AssetGenImage('assets/flags/bd.png');

  /// File path: assets/flags/en.png
  AssetGenImage get en => const AssetGenImage('assets/flags/en.png');

  /// List of all assets
  List<AssetGenImage> get values => [bd, en];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/account_setting.png
  AssetGenImage get accountSetting =>
      const AssetGenImage('assets/icons/account_setting.png');

  /// File path: assets/icons/card.svg
  String get card => 'assets/icons/card.svg';

  /// File path: assets/icons/change_password.svg
  String get changePassword => 'assets/icons/change_password.svg';

  /// File path: assets/icons/deposit.svg
  String get deposit => 'assets/icons/deposit.svg';

  /// File path: assets/icons/edit.svg
  String get edit => 'assets/icons/edit.svg';

  /// File path: assets/icons/email.svg
  String get email => 'assets/icons/email.svg';

  /// File path: assets/icons/empty_image.svg
  String get emptyImage => 'assets/icons/empty_image.svg';

  /// File path: assets/icons/facebook.svg
  String get facebook => 'assets/icons/facebook.svg';

  /// File path: assets/icons/google.svg
  String get google => 'assets/icons/google.svg';

  /// File path: assets/icons/legals_support.png
  AssetGenImage get legalsSupport =>
      const AssetGenImage('assets/icons/legals_support.png');

  /// File path: assets/icons/logout.svg
  String get logout => 'assets/icons/logout.svg';

  /// File path: assets/icons/notification.png
  AssetGenImage get notification =>
      const AssetGenImage('assets/icons/notification.png');

  /// File path: assets/icons/person.svg
  String get person => 'assets/icons/person.svg';

  /// File path: assets/icons/reset-password.svg
  String get resetPassword => 'assets/icons/reset-password.svg';

  /// File path: assets/icons/settings.svg
  String get settings => 'assets/icons/settings.svg';

  /// File path: assets/icons/system_setting.png
  AssetGenImage get systemSetting =>
      const AssetGenImage('assets/icons/system_setting.png');

  /// File path: assets/icons/user.svg
  String get user => 'assets/icons/user.svg';

  /// File path: assets/icons/withdrawal.svg
  String get withdrawal => 'assets/icons/withdrawal.svg';

  /// List of all assets
  List<dynamic> get values => [
        accountSetting,
        card,
        changePassword,
        deposit,
        edit,
        email,
        emptyImage,
        facebook,
        google,
        legalsSupport,
        logout,
        notification,
        person,
        resetPassword,
        settings,
        systemSetting,
        user,
        withdrawal
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bookmark_tag.png
  AssetGenImage get bookmarkTag =>
      const AssetGenImage('assets/images/bookmark_tag.png');

  /// File path: assets/images/camera.png
  AssetGenImage get camera => const AssetGenImage('assets/images/camera.png');

  /// File path: assets/images/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/images/empty.png');

  /// File path: assets/images/gallery.png
  AssetGenImage get gallery => const AssetGenImage('assets/images/gallery.png');

  /// File path: assets/images/not_found.svg
  String get notFound => 'assets/images/not_found.svg';

  /// File path: assets/images/transactions.svg
  String get transactions => 'assets/images/transactions.svg';

  /// File path: assets/images/user.svg
  String get user => 'assets/images/user.svg';

  /// List of all assets
  List<dynamic> get values =>
      [bookmarkTag, camera, empty, gallery, notFound, transactions, user];
}

class Assets {
  Assets._();

  static const AssetGenImage banner = AssetGenImage('assets/banner.png');
  static const $AssetsFlagsGen flags = $AssetsFlagsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [banner, logo];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
