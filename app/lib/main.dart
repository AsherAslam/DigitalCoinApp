import 'package:crypto_stats/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  // Run the app and pass its dependencies to it.
  runApp(const ProviderScope(child: App()));
}
