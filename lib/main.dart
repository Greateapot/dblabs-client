import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart';

import 'pages/pages.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ApiRepository _apiRepository;

  @override
  void initState() {
    _apiRepository = ApiRepositoryImpl(
      'localhost',
      port: kIsWeb ? 8080 : 9090,
    );
    super.initState();
  }

  @override
  void dispose() {
    _apiRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFE630B2),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: const TabBar(
              tabs: <Tab>[
                Tab(text: "Лаб. 3 (2)"),
                Tab(text: "Лаб. 4 (WIP)"),
              ],
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Lab3Page(apiRepository: _apiRepository),
                const Lab4Page(),
              ],
            ),
          ),
        ),
      );
}
