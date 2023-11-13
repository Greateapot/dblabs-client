import 'package:dblabs/shared/shared.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'router.dart';

void main() {
  api.ApiRepositoryImpl(
    'localhost',
    port: kIsWeb ? 8080 : 9090,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      );
}
