import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Scaffold(
          appBar: const TabBar(
            tabs: [
              Tab(text: "Лаб. 3 (2+4)"),
              Tab(text: "Лаб. 4"),
              Tab(text: "Лаб. 6"),
              Tab(text: "Лаб. 7"),
              Tab(text: "Лаб. 8"),
            ],
          ),
          body: BlocProvider(
            create: (_) => TableBloc(),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Lab3TabBarView(),
                      Lab4TabBarView(),
                      Lab6TabBarView(),
                      Lab7TabBarView(),
                      Lab8TabBarView(),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<TableBloc, TableState>(
                    builder: (context, state) => switch (state) {
                      final TableInitial _ => const HelloView(),
                      final TableUpdated t => TableView(table: t.table),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
