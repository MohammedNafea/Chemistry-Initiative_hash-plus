import 'package:flutter/widgets.dart';

Widget buildPlatformImage(String path, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
  return Image.network(
    path,
    width: width,
    height: height,
    fit: fit,
  );
}
