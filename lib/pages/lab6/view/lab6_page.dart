import 'package:dblabs_api_repo/dblabs_api_repo.dart';
import 'package:dblabs/pages/lab6/lab6.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lab6Page extends StatelessWidget {
  final ApiRepository apiRepository;

  const Lab6Page({
    required this.apiRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => Lab6Bloc(apiRepository),
        child: const Lab6View(),
      );
}
