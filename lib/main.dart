import 'package:flutter/material.dart';

import 'package:ecommerce_clone/app_layer/app.dart';
import 'package:ecommerce_clone/app_layer/di_.dart';

void main() async {
  // Ensure that the Flutter widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the dependencies.
  initLocalDataSources();
  initRepositories();
  initUsecases();

  // Run the app with EasyLocalization.
  runApp(
    const App(),
  );
}
