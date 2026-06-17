import 'package:flutter/material.dart';

sealed class AppColors {

  // Brand & Primary Colors
  static const Color primaryDark = Color(0xFF523DFB);   // deep indigo
  static const Color primaryLight = Color(0xFF8D82FB);  // soft violet
  /// Alias kept for backwards-compatibility across all widgets
  static const Color primary = primaryDark;
  static const Color secondary = primaryLight;

  // Surface & Backgrounds
  static const Color surface = Color(0xFF0A0B1E);
  static const Color surfaceDim = Color(0xFF10112A);
  static const Color surfaceBright = Color(0xFF2A2B50);
  static const Color surfaceContainerLowest = Color(0xFF080918);
  static const Color surfaceContainerLow = Color(0xFF14153A);

  // Overlays & Outlines
  static const Color outlineVariant = Color(0x4DFFFFFF); // 30% opacity
  static const Color onSurfaceVariant = Color(0xB3FFFFFF); // 70% opacity
  static const Color white = Color(0xFFFFFFFF);

  // Semantic & UI Colors
  static const Color success = Color(0xFF4CAF50);   // Green
  static const Color warning = Color(0xFFFFC107);   // Yellow
  static const Color error   = Color(0xFFE53935);   // Red
  static const Color cardBackground      = Color(0xFF1A1C45); // Deep indigo card
  static const Color cardBackgroundLight = Color(0xFF2D2F6B); // Lighter indigo card
}