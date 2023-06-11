import 'package:dev_pace_task/presentation/bloc/items_bloc.dart';
import 'package:dev_pace_task/presentation/widgets/bloc_provider.dart';
import 'package:dev_pace_task/presentation/widgets/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TestTaskApp());
}

class TestTaskApp extends StatelessWidget {
  const TestTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Task',
      home: BlocProvider(
        bloc: ItemsBlocImpl(),
        child: const HomePage(),
      ),
    );
  }
}
