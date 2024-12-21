import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_clone/app_layer/constants.dart';
import 'package:ecommerce_clone/presentation_layer/order_insights_screen/bloc/order_insights_bloc.dart';
import 'package:ecommerce_clone/presentation_layer/order_insights_screen/order_insights_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      home: BlocProvider(
        create: (context) => OrderInsightsBloc(),
        child: const OrderInsightsScreen(),
      ),
    );
  }
}
