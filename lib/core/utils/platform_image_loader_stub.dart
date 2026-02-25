import 'package:flutter/widgets.dart';

Widget buildPlatformImage(
  String path, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  throw UnsupportedError('Cannot build image without platform implementation');
}
