import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/core/theme/app_theme.dart';
import 'package:crypto_pulse/features/dashboard/presentation/screens/splash_screen.dart';
import 'package:crypto_pulse/features/dashboard/presentation/screens/dashboard_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CryptoPulseApp(),
    ),
  );
}

class CryptoPulseApp extends StatelessWidget {
  const CryptoPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoPulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
