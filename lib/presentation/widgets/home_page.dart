import 'package:dev_pace_task/presentation/bloc/items_bloc.dart';
import 'package:dev_pace_task/presentation/bloc/items_state.dart';
import 'package:dev_pace_task/presentation/common/image_constants.dart';
import 'package:dev_pace_task/presentation/widgets/bloc_provider.dart';
import 'package:dev_pace_task/presentation/widgets/items_content_widget.dart';
import 'package:flutter/material.dart';

import '../common/ui_constants.dart';
import 'calculate_size_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _logoContainerSize;

  late final ItemsBloc _itemsBloc;

  @override
  void initState() {
    _itemsBloc = BlocProvider.of<ItemsBlocImpl>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final minImageHeight = constraints.maxHeight * 0.2;
              final initialLogoContainerHeight = constraints.maxHeight * 0.9;
              return StreamBuilder<ItemsState>(
                  stream: _itemsBloc.items,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: UIConstants.animationDuration,
                            height: _logoContainerSize ??
                                initialLogoContainerHeight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Center(
                                child: Image.asset(
                                  ImageConstants.logoPath,
                                  height: minImageHeight,
                                ),
                              ),
                            ),
                          ),
                          CalculateSizeWidget(
                            onSizeChange: (itemContentSize) {
                              setState(() {
                                final remainingHeight = constraints.maxHeight -
                                    itemContentSize.height;
                                _logoContainerSize =
                                    remainingHeight > minImageHeight
                                        ? remainingHeight
                                        : minImageHeight;
                              });
                            },
                            child: ItemsContentWidget(
                              itemsState: snapshot.data,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              _itemsBloc.addItem();
            },
            tooltip: 'Add item',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              _itemsBloc.removeItem();
            },
            tooltip: 'Remove item',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _itemsBloc.dispose();
    super.dispose();
  }
}
