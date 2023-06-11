import 'package:dev_pace_task/presentation/bloc/items_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends ItemsBloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({
    Key? key,
    required this.bloc,
    required this.child,
  }) : super(key: key);

  static T of<T extends ItemsBloc>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
