import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:dblabs/pages/lab3/lab3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lab3Page extends StatelessWidget {
  final ApiRepository apiRepository;

  const Lab3Page({
    required this.apiRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => Lab3Bloc(apiRepository),
        child: const Lab3View(),
      );
}
