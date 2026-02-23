import 'dart:convert';
import 'package:flutter/material.dart';

class ImageHelper {
  /// Returns an ImageProvider based on the image path/string.
  /// Handles:
  /// - Asset paths (starts with 'assets/') -> AssetImage
  /// - Network URL (starts with 'http') -> NetworkImage
  /// - Base64 strings (Everything else) -> MemoryImage
  static ImageProvider getImageProvider(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return const AssetImage('assets/images/avatar.jpg');
    }

    try {
      // 1. Asset Path
      if (imagePath.startsWith('assets/')) {
        return AssetImage(imagePath);
      }

      // 2. Network URL
      if (imagePath.startsWith('http')) {
        return NetworkImage(imagePath);
      }

      // 3. Base64 String (Web & Mobile user images)
      // We assume anything else is a base64 string.
      // Clean up if it's a data URI
      final base64String = imagePath.contains(',')
          ? imagePath.split(',').last
          : imagePath;

      return MemoryImage(base64Decode(base64String));
    } catch (e) {
      debugPrint('Error loading image, using fallback. Error: $e');
      return const AssetImage('assets/images/avatar.jpg');
    }
  }
}
