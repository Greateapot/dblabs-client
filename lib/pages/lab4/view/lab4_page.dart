import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:dblabs/pages/lab4/lab4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lab4Page extends StatelessWidget {
  final ApiRepository apiRepository;

  const Lab4Page({
    required this.apiRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => Lab4Bloc(apiRepository),
        child: const Lab4View(),
      );
}
